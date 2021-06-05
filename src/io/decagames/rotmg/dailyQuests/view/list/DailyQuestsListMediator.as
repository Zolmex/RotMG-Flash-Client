// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestsListMediator

package io.decagames.rotmg.dailyQuests.view.list
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.ui.signals.UpdateQuestSignal;
    import io.decagames.rotmg.dailyQuests.signal.ShowQuestInfoSignal;
    import kabam.rotmg.constants.GeneralConstants;
    import __AS3__.vec.Vector;
    import io.decagames.rotmg.dailyQuests.model.DailyQuest;
    import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;
    import __AS3__.vec.*;

    public class DailyQuestsListMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestsList;
        [Inject]
        public var model:DailyQuestsModel;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var updateQuestSignal:UpdateQuestSignal;
        [Inject]
        public var showInfoSignal:ShowQuestInfoSignal;
        private var hasEvent:Boolean;


        override public function initialize():void
        {
            this.onQuestsUpdate(UpdateQuestSignal.QUEST_LIST_LOADED);
            this.updateQuestSignal.add(this.onQuestsUpdate);
            this.view.tabs.tabSelectedSignal.add(this.onTabSelected);
        }

        private function onTabSelected(_arg_1:String):void
        {
            var _local_2:DailyQuestListElement = this.view.getCurrentlySelected(_arg_1);
            if (_local_2)
            {
                this.showInfoSignal.dispatch(_local_2.id, _local_2.category, _arg_1);
            }
            else
            {
                this.showInfoSignal.dispatch("", -1, _arg_1);
            };
        }

        private function onQuestsUpdate(_arg_1:String):void
        {
            this.view.clearQuestLists();
            var _local_2:Vector.<int> = ((this.hud.gameSprite.map.player_) ? this.hud.gameSprite.map.player_.equipment_.slice((GeneralConstants.NUM_EQUIPMENT_SLOTS - 1), (GeneralConstants.NUM_EQUIPMENT_SLOTS + (GeneralConstants.NUM_INVENTORY_SLOTS * 2))) : new Vector.<int>());
            this.view.tabs.buttonsRenderedSignal.addOnce(this.onAddedHandler);
            this.addDailyQuests(_local_2);
            this.addEventQuests(_local_2);
        }

        private function addEventQuests(_arg_1:Vector.<int>):void
        {
            var _local_4:DailyQuest;
            var _local_5:Boolean;
            var _local_6:DailyQuestListElement;
            var _local_2:Boolean = true;
            var _local_3:Date = new Date();
            for each (_local_4 in this.model.eventQuestsList)
            {
                _local_5 = false;
                if (_local_4.expiration != "")
                {
                    _local_5 = ((Number(_local_4.expiration) - (_local_3.time / 1000)) < 0);
                };
                if (!((_local_4.completed) || (_local_5)))
                {
                    _local_6 = new DailyQuestListElement(_local_4.id, _local_4.name, _local_4.completed, DailyQuestInfo.hasAllItems(_local_4.requirements, _arg_1), _local_4.category);
                    if (_local_2)
                    {
                        _local_6.isSelected = true;
                    };
                    _local_2 = false;
                    this.view.addEventToList(_local_6);
                    this.hasEvent = true;
                };
            };
        }

        private function addDailyQuests(_arg_1:Vector.<int>):void
        {
            var _local_3:DailyQuest;
            var _local_4:DailyQuestListElement;
            var _local_2:Boolean = true;
            for each (_local_3 in this.model.dailyQuestsList)
            {
                if (!_local_3.completed)
                {
                    _local_4 = new DailyQuestListElement(_local_3.id, _local_3.name, _local_3.completed, DailyQuestInfo.hasAllItems(_local_3.requirements, _arg_1), _local_3.category);
                    if (_local_2)
                    {
                        _local_4.isSelected = true;
                    };
                    _local_2 = false;
                    this.view.addQuestToList(_local_4);
                };
            };
            this.onTabSelected(DailyQuestsList.QUEST_TAB_LABEL);
        }

        private function onAddedHandler():void
        {
            if (this.hasEvent)
            {
                this.view.addIndicator(this.hasEvent);
            };
        }

        override public function destroy():void
        {
            this.view.tabs.buttonsRenderedSignal.remove(this.onAddedHandler);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list

