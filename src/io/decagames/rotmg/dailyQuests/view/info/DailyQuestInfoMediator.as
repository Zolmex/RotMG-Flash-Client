// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfoMediator

package io.decagames.rotmg.dailyQuests.view.info
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.dailyQuests.signal.ShowQuestInfoSignal;
    import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
    import kabam.rotmg.ui.model.HUDModel;
    import io.decagames.rotmg.dailyQuests.signal.LockQuestScreenSignal;
    import io.decagames.rotmg.dailyQuests.signal.SelectedItemSlotsSignal;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import kabam.rotmg.dailyLogin.model.DailyLoginModel;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import io.decagames.rotmg.dailyQuests.view.list.DailyQuestsList;
    import kabam.rotmg.messaging.impl.data.SlotObjectData;
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;
    import io.decagames.rotmg.dailyQuests.view.popup.DailyQuestExpiredPopup;
    import __AS3__.vec.Vector;
    import kabam.rotmg.game.view.components.BackpackTabContent;
    import kabam.rotmg.game.view.components.InventoryTabContent;
    import io.decagames.rotmg.dailyQuests.model.DailyQuest;
    import __AS3__.vec.*;

    public class DailyQuestInfoMediator extends Mediator 
    {

        [Inject]
        public var showInfoSignal:ShowQuestInfoSignal;
        [Inject]
        public var view:DailyQuestInfo;
        [Inject]
        public var model:DailyQuestsModel;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var lockScreen:LockQuestScreenSignal;
        [Inject]
        public var selectedItemSlotsSignal:SelectedItemSlotsSignal;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipsSignal:HideTooltipsSignal;
        [Inject]
        public var dailyLoginModel:DailyLoginModel;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        private var tooltip:TextToolTip;
        private var hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();


        override public function initialize():void
        {
            this.showInfoSignal.add(this.showQuestInfo);
            this.tooltip = new TextToolTip(0x363636, 0x9B9B9B, "", "You must select a reward first!", 190, null);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipsSignal);
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.tooltip = this.tooltip;
            this.view.completeButton.addEventListener(MouseEvent.CLICK, this.onCompleteButtonClickHandler);
            this.selectedItemSlotsSignal.add(this.itemSelectedHandler);
        }

        private function itemSelectedHandler(_arg_1:int):void
        {
            this.view.completeButton.disabled = ((this.model.currentQuest.completed) ? true : ((this.model.selectedItem == -1) ? true : (!(DailyQuestInfo.hasAllItems(this.model.currentQuest.requirements, this.model.playerItemsFromInventory)))));
            if (this.model.selectedItem == -1)
            {
                this.hoverTooltipDelegate.setDisplayObject(this.view.completeButton);
            }
            else
            {
                this.hoverTooltipDelegate.removeDisplayObject();
            };
        }

        override public function destroy():void
        {
            this.view.completeButton.removeEventListener(MouseEvent.CLICK, this.onCompleteButtonClickHandler);
            this.showInfoSignal.remove(this.showQuestInfo);
            this.selectedItemSlotsSignal.remove(this.itemSelectedHandler);
        }

        private function showQuestInfo(_arg_1:String, _arg_2:int, _arg_3:String):void
        {
            if (((!(_arg_1 == "")) && (!(_arg_2 == -1))))
            {
                this.setupQuestInfo(_arg_1);
                if (this.view.hasEventListener(Event.ENTER_FRAME))
                {
                    this.view.removeEventListener(Event.ENTER_FRAME, this.updateQuestAvailable);
                };
            }
            else
            {
                if (_arg_3 == DailyQuestsList.QUEST_TAB_LABEL)
                {
                    this.view.dailyQuestsCompleted();
                    this.view.addEventListener(Event.ENTER_FRAME, this.updateQuestAvailable);
                }
                else
                {
                    this.view.eventQuestsCompleted();
                };
            };
        }

        private function updateQuestAvailable(_arg_1:Event):void
        {
            var _local_2:String = ("New quests available in " + this.dailyLoginModel.getFormatedQuestRefreshTime());
            this.view.setQuestAvailableTime(_local_2);
        }

        private function setupQuestInfo(_arg_1:String):void
        {
            this.model.selectedItem = -1;
            this.view.dailyQuestsCompleted();
            this.model.currentQuest = this.model.getQuestById(_arg_1);
            this.view.show(this.model.currentQuest, this.model.playerItemsFromInventory);
            if (((!(this.view.completeButton.completed)) && (this.model.currentQuest.itemOfChoice)))
            {
                this.view.completeButton.disabled = true;
                this.hoverTooltipDelegate.setDisplayObject(this.view.completeButton);
            };
        }

        private function tileToSlot(_arg_1:InventoryTile):SlotObjectData
        {
            var _local_2:SlotObjectData = new SlotObjectData();
            _local_2.objectId_ = _arg_1.ownerGrid.owner.objectId_;
            _local_2.objectType_ = _arg_1.getItemId();
            _local_2.slotId_ = _arg_1.tileId;
            return (_local_2);
        }

        private function onCompleteButtonClickHandler(_arg_1:MouseEvent):void
        {
            if (this.checkIfQuestHasExpired())
            {
                this.showPopupSignal.dispatch(new DailyQuestExpiredPopup());
            }
            else
            {
                this.completeQuest();
            };
        }

        private function completeQuest():void
        {
            var _local_1:Vector.<SlotObjectData>;
            var _local_2:BackpackTabContent;
            var _local_3:InventoryTabContent;
            var _local_4:Vector.<int>;
            var _local_5:Vector.<InventoryTile>;
            var _local_6:int;
            var _local_7:InventoryTile;
            if (((!(this.view.completeButton.disabled)) && (!(this.view.completeButton.completed))))
            {
                _local_1 = new Vector.<SlotObjectData>();
                _local_2 = this.hud.gameSprite.hudView.tabStrip.getTabView(BackpackTabContent);
                _local_3 = this.hud.gameSprite.hudView.tabStrip.getTabView(InventoryTabContent);
                _local_4 = this.model.currentQuest.requirements.concat();
                _local_5 = new Vector.<InventoryTile>();
                if (_local_2)
                {
                    _local_5 = _local_5.concat(_local_2.backpack.tiles);
                };
                if (_local_3)
                {
                    _local_5 = _local_5.concat(_local_3.storage.tiles);
                };
                for each (_local_6 in _local_4)
                {
                    for each (_local_7 in _local_5)
                    {
                        if (_local_7.getItemId() == _local_6)
                        {
                            _local_5.splice(_local_5.indexOf(_local_7), 1);
                            _local_1.push(this.tileToSlot(_local_7));
                            break;
                        };
                    };
                };
                this.lockScreen.dispatch();
                this.hud.gameSprite.gsc_.questRedeem(this.model.currentQuest.id, _local_1, this.model.selectedItem);
                if (!this.model.currentQuest.repeatable)
                {
                    this.model.currentQuest.completed = true;
                };
                this.view.completeButton.completed = true;
                this.view.completeButton.disabled = true;
            };
        }

        private function checkIfQuestHasExpired():Boolean
        {
            var _local_3:Boolean;
            var _local_1:DailyQuest = this.model.currentQuest;
            var _local_2:Date = new Date();
            if (_local_1.expiration != "")
            {
                _local_3 = ((Number(_local_1.expiration) - (_local_2.time / 1000)) < 0);
            };
            return (_local_3);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.info

