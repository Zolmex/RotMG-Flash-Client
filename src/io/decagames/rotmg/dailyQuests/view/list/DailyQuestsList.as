// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestsList

package io.decagames.rotmg.dailyQuests.view.list
{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.tabs.UITabs;
    import io.decagames.rotmg.ui.tabs.TabButton;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.tabs.UITab;
    import io.decagames.rotmg.ui.scroll.UIScrollbar;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    
    import io.decagames.rotmg.ui.tabs.*;

    public class DailyQuestsList extends Sprite 
    {

        public static const QUEST_TAB_LABEL:String = "Quests";
        public static const EVENT_TAB_LABEL:String = "Events";
        public static const SCROLL_BAR_HEIGHT:int = 345;

        private var questLinesPosition:int = 0;
        private var eventLinesPosition:int = 0;
        private var questsContainer:Sprite;
        private var eventsContainer:Sprite;
        private var _tabs:UITabs;
        private var eventsTab:TabButton;
        private var contentTabs:SliceScalingBitmap;
        private var contentInset:SliceScalingBitmap;
        private var _dailyQuestElements:Vector.<DailyQuestListElement>;
        private var _eventQuestElements:Vector.<DailyQuestListElement>;

        public function DailyQuestsList()
        {
            this.init();
        }

        private function init():void
        {
            this.createContentTabs();
            this.createContentInset();
            this.createTabs();
        }

        private function createTabs():void
        {
            this._tabs = new UITabs(230, true);
            this._tabs.addTab(this.createQuestsTab(), true);
            this._tabs.addTab(this.createEventsTab());
            this._tabs.y = 1;
            addChild(this._tabs);
        }

        private function createContentInset():void
        {
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 230);
            this.contentInset.height = 360;
            this.contentInset.y = 35;
            addChild(this.contentInset);
        }

        private function createContentTabs():void
        {
            this.contentTabs = TextureParser.instance.getSliceScalingBitmap("UI", "tab_inset_content_background", 230);
            this.contentTabs.height = 45;
            addChild(this.contentTabs);
        }

        private function createQuestsTab():UITab
        {
            var _local_4:Sprite;
            var _local_1:UITab = new UITab(QUEST_TAB_LABEL);
            var _local_2:Sprite = new Sprite();
            this.questsContainer = new Sprite();
            this.questsContainer.x = this.contentInset.x;
            this.questsContainer.y = 10;
            _local_2.addChild(this.questsContainer);
            var _local_3:UIScrollbar = new UIScrollbar(SCROLL_BAR_HEIGHT);
            _local_3.mouseRollSpeedFactor = 1;
            _local_3.scrollObject = _local_1;
            _local_3.content = this.questsContainer;
            _local_2.addChild(_local_3);
            _local_3.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local_3.y = 7;
            _local_4 = new Sprite();
            _local_4.graphics.beginFill(0);
            _local_4.graphics.drawRect(0, 0, 230, SCROLL_BAR_HEIGHT);
            _local_4.x = this.questsContainer.x;
            _local_4.y = this.questsContainer.y;
            this.questsContainer.mask = _local_4;
            _local_2.addChild(_local_4);
            _local_1.addContent(_local_2);
            return (_local_1);
        }

        private function createEventsTab():UITab
        {
            var _local_1:UITab;
            _local_1 = new UITab("Events");
            var _local_2:Sprite = new Sprite();
            this.eventsContainer = new Sprite();
            this.eventsContainer.x = this.contentInset.x;
            this.eventsContainer.y = 10;
            _local_2.addChild(this.eventsContainer);
            var _local_3:UIScrollbar = new UIScrollbar(SCROLL_BAR_HEIGHT);
            _local_3.mouseRollSpeedFactor = 1;
            _local_3.scrollObject = _local_1;
            _local_3.content = this.eventsContainer;
            _local_2.addChild(_local_3);
            _local_3.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local_3.y = 7;
            var _local_4:Sprite = new Sprite();
            _local_4.graphics.beginFill(0);
            _local_4.graphics.drawRect(0, 0, 230, SCROLL_BAR_HEIGHT);
            _local_4.x = this.eventsContainer.x;
            _local_4.y = this.eventsContainer.y;
            this.eventsContainer.mask = _local_4;
            _local_2.addChild(_local_4);
            _local_1.addContent(_local_2);
            return (_local_1);
        }

        public function addIndicator(_arg_1:Boolean):void
        {
            this.eventsTab = this._tabs.getTabButtonByLabel(EVENT_TAB_LABEL);
            if (this.eventsTab)
            {
                this.eventsTab.showIndicator = _arg_1;
                this.eventsTab.clickSignal.add(this.onEventsClick);
            }
        }

        private function onEventsClick(_arg_1:BaseButton):void
        {
            if (TabButton(_arg_1).hasIndicator)
            {
                TabButton(_arg_1).showIndicator = false;
            }
        }

        public function addQuestToList(_arg_1:DailyQuestListElement):void
        {
            if (!this._dailyQuestElements)
            {
                this._dailyQuestElements = new Vector.<DailyQuestListElement>(0);
            }
            _arg_1.x = 10;
            _arg_1.y = (this.questLinesPosition * 35);
            this.questsContainer.addChild(_arg_1);
            this.questLinesPosition++;
            this._dailyQuestElements.push(_arg_1);
        }

        public function addEventToList(_arg_1:DailyQuestListElement):void
        {
            if (!this._eventQuestElements)
            {
                this._eventQuestElements = new Vector.<DailyQuestListElement>(0);
            }
            _arg_1.x = 10;
            _arg_1.y = (this.eventLinesPosition * 35);
            this.eventsContainer.addChild(_arg_1);
            this.eventLinesPosition++;
            this._eventQuestElements.push(_arg_1);
        }

        public function get list():Sprite
        {
            return (this.questsContainer);
        }

        public function get tabs():UITabs
        {
            return (this._tabs);
        }

        public function clearQuestLists():void
        {
            var _local_1:DailyQuestListElement;
            while (this.questsContainer.numChildren > 0)
            {
                _local_1 = (this.questsContainer.removeChildAt(0) as DailyQuestListElement);
                _local_1 = null;
            }
            this.questLinesPosition = 0;
            ((this._dailyQuestElements) && (this._dailyQuestElements.length = 0));
            while (this.eventsContainer.numChildren > 0)
            {
                _local_1 = (this.eventsContainer.removeChildAt(0) as DailyQuestListElement);
                _local_1 = null;
            }
            this.eventLinesPosition = 0;
            ((this._eventQuestElements) && (this._eventQuestElements.length = 0));
        }

        public function getCurrentlySelected(_arg_1:String):DailyQuestListElement
        {
            var _local_2:DailyQuestListElement;
            var _local_3:DailyQuestListElement;
            var _local_4:DailyQuestListElement;
            if (_arg_1 == QUEST_TAB_LABEL)
            {
                for each (_local_3 in this._dailyQuestElements)
                {
                    if (_local_3.isSelected)
                    {
                        _local_2 = _local_3;
                        break;
                    }
                }
            }
            else
            {
                if (_arg_1 == EVENT_TAB_LABEL)
                {
                    for each (_local_4 in this._eventQuestElements)
                    {
                        if (_local_4.isSelected)
                        {
                            _local_2 = _local_4;
                            break;
                        }
                    }
                }
            }
            return (_local_2);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list

