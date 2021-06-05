// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.model.DailyQuestsModel

package io.decagames.rotmg.dailyQuests.model
{
    import __AS3__.vec.Vector;
    import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.ui.signals.UpdateQuestSignal;
    import kabam.rotmg.constants.GeneralConstants;
    import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;
    import __AS3__.vec.*;

    public class DailyQuestsModel 
    {

        public var currentQuest:DailyQuest;
        public var isPopupOpened:Boolean;
        public var categoriesWeight:Array = [1, 0, 2, 3, 4];
        public var selectedItem:int = -1;
        private var _questsList:Vector.<DailyQuest>;
        private var _dailyQuestsList:Vector.<DailyQuest> = new Vector.<DailyQuest>(0);
        private var _eventQuestsList:Vector.<DailyQuest> = new Vector.<DailyQuest>(0);
        private var slots:Vector.<DailyQuestItemSlot> = new Vector.<DailyQuestItemSlot>(0);
        private var _nextRefreshPrice:int;
        private var _hasQuests:Boolean;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var updateQuestSignal:UpdateQuestSignal;


        public function registerSelectableSlot(_arg_1:DailyQuestItemSlot):void
        {
            this.slots.push(_arg_1);
        }

        public function unregisterSelectableSlot(_arg_1:DailyQuestItemSlot):void
        {
            var _local_2:int = this.slots.indexOf(_arg_1);
            if (_local_2 != -1)
            {
                this.slots.splice(_local_2, 1);
            };
        }

        public function unselectAllSlots(_arg_1:int):void
        {
            var _local_2:DailyQuestItemSlot;
            for each (_local_2 in this.slots)
            {
                if (_local_2.itemID != _arg_1)
                {
                    _local_2.selected = false;
                };
            };
        }

        public function clear():void
        {
            this._dailyQuestsList.length = 0;
            this._eventQuestsList.length = 0;
            if (this._questsList)
            {
                this._questsList.length = 0;
            };
        }

        public function addQuests(_arg_1:Vector.<DailyQuest>):void
        {
            var _local_2:DailyQuest;
            this._questsList = _arg_1;
            if (this._questsList.length > 0)
            {
                this._hasQuests = true;
            };
            for each (_local_2 in this._questsList)
            {
                this.addQuestToCategoryList(_local_2);
            };
            this.updateQuestSignal.dispatch(UpdateQuestSignal.QUEST_LIST_LOADED);
        }

        public function addQuestToCategoryList(_arg_1:DailyQuest):void
        {
            if (_arg_1.category == 7)
            {
                this._eventQuestsList.push(_arg_1);
            }
            else
            {
                this._dailyQuestsList.push(_arg_1);
            };
        }

        public function markAsCompleted(_arg_1:String):void
        {
            var _local_2:DailyQuest;
            for each (_local_2 in this._questsList)
            {
                if (((_local_2.id == _arg_1) && (!(_local_2.repeatable))))
                {
                    _local_2.completed = true;
                };
            };
        }

        public function get playerItemsFromInventory():Vector.<int>
        {
            return ((this.hud.gameSprite.map.player_) ? this.hud.gameSprite.map.player_.equipment_.slice((GeneralConstants.NUM_EQUIPMENT_SLOTS - 1), (GeneralConstants.NUM_EQUIPMENT_SLOTS + (GeneralConstants.NUM_INVENTORY_SLOTS * 2))) : new Vector.<int>());
        }

        public function get numberOfActiveQuests():int
        {
            return (this._questsList.length);
        }

        public function get numberOfCompletedQuests():int
        {
            var _local_2:DailyQuest;
            var _local_1:int;
            for each (_local_2 in this._questsList)
            {
                if (_local_2.completed)
                {
                    _local_1++;
                };
            };
            return (_local_1);
        }

        public function get questsList():Vector.<DailyQuest>
        {
            var _local_1:Vector.<DailyQuest> = this._questsList.concat();
            return (_local_1.sort(this.questsCompleteSort));
        }

        private function questsNameSort(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            if (_arg_1.name > _arg_2.name)
            {
                return (1);
            };
            return (-1);
        }

        private function sortByCategory(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            if (this.categoriesWeight[_arg_1.category] < this.categoriesWeight[_arg_2.category])
            {
                return (-1);
            };
            if (this.categoriesWeight[_arg_1.category] > this.categoriesWeight[_arg_2.category])
            {
                return (1);
            };
            return (this.questsNameSort(_arg_1, _arg_2));
        }

        private function questsReadySort(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            var _local_3:Boolean = DailyQuestInfo.hasAllItems(_arg_1.requirements, this.playerItemsFromInventory);
            var _local_4:Boolean = DailyQuestInfo.hasAllItems(_arg_2.requirements, this.playerItemsFromInventory);
            if (((_local_3) && (!(_local_4))))
            {
                return (-1);
            };
            if (((_local_3) && (_local_4)))
            {
                return (this.questsNameSort(_arg_1, _arg_2));
            };
            return (1);
        }

        private function questsCompleteSort(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            if (((_arg_1.completed) && (!(_arg_2.completed))))
            {
                return (1);
            };
            if (((_arg_1.completed) && (_arg_2.completed)))
            {
                return (this.sortByCategory(_arg_1, _arg_2));
            };
            if (((!(_arg_1.completed)) && (!(_arg_2.completed))))
            {
                return (this.sortByCategory(_arg_1, _arg_2));
            };
            return (-1);
        }

        public function getQuestById(_arg_1:String):DailyQuest
        {
            var _local_2:DailyQuest;
            for each (_local_2 in this._questsList)
            {
                if (_local_2.id == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function get first():DailyQuest
        {
            if (this._questsList.length > 0)
            {
                return (this.questsList[0]);
            };
            return (null);
        }

        public function get nextRefreshPrice():int
        {
            return (this._nextRefreshPrice);
        }

        public function set nextRefreshPrice(_arg_1:int):void
        {
            this._nextRefreshPrice = _arg_1;
        }

        public function get dailyQuestsList():Vector.<DailyQuest>
        {
            return (this._dailyQuestsList);
        }

        public function get eventQuestsList():Vector.<DailyQuest>
        {
            return (this._eventQuestsList);
        }

        public function removeQuestFromlist(_arg_1:DailyQuest):void
        {
            var _local_2:int;
            while (_local_2 < this._eventQuestsList.length)
            {
                if (_arg_1.id == this._eventQuestsList[_local_2].id)
                {
                    this._eventQuestsList.splice(_local_2, 1);
                };
                _local_2++;
            };
            var _local_3:int;
            while (_local_3 < this._questsList.length)
            {
                if (_arg_1.id == this._questsList[_local_3].id)
                {
                    this._questsList.splice(_local_3, 1);
                };
                _local_3++;
            };
        }

        public function get hasQuests():Boolean
        {
            return (this._hasQuests);
        }


    }
}//package io.decagames.rotmg.dailyQuests.model

