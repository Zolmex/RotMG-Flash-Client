// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoard

package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard
{
    import io.decagames.rotmg.ui.popups.UIPopup;
    import io.decagames.rotmg.ui.tabs.UITabs;
    import flash.display.Sprite;
    import io.decagames.rotmg.shop.mysteryBox.rollModal.elements.Spinner;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import flash.text.TextFieldAutoSize;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.tabs.UITab;
    import io.decagames.rotmg.ui.scroll.UIScrollbar;

    public class SeasonalLeaderBoard extends UIPopup 
    {

        public static const TOP_20_TAB_LABEL:String = "Top 20";
        public static const PLAYER_TAB_LABEL:String = "Your Position";
        public static const SCROLL_Y_OFFSET:int = 155;
        public static const SCROLL_HEIGHT:int = 410;
        public static const WIDTH:int = 600;

        private var _tabs:UITabs;
        private var _tabContent:Sprite;
        private var _spinnersContainer:Sprite;
        private var _spinner:Spinner;
        private var _contentInset:SliceScalingBitmap;
        private var _contentTabs:SliceScalingBitmap;
        private var _top20Grid:UIGrid;
        private var _yourPositionGrid:UIGrid;
        private var _refreshTime:UILabel;
        private var _lastUpdatedTime:UILabel;
        private var _error:UILabel;

        public function SeasonalLeaderBoard()
        {
            super(WIDTH, WIDTH);
            this.init();
        }

        public function addTop20Item(_arg_1:SeasonalLeaderBoardItemData):void
        {
            var _local_2:SeasonalLeaderBoardItem = new SeasonalLeaderBoardItem(_arg_1);
            var _local_3:UIGridElement = new UIGridElement();
            _local_3.addChild(_local_2);
            this._top20Grid.addGridElement(_local_3);
        }

        public function addPlayerListItem(_arg_1:SeasonalLeaderBoardItemData):void
        {
            var _local_2:SeasonalLeaderBoardItem = new SeasonalLeaderBoardItem(_arg_1);
            var _local_3:UIGridElement = new UIGridElement();
            _local_3.addChild(_local_2);
            this._yourPositionGrid.addGridElement(_local_3);
        }

        public function clearLeaderBoard():void
        {
            this._error.visible = false;
            if (this._top20Grid)
            {
                this._top20Grid.clearGrid();
            };
            if (this._yourPositionGrid)
            {
                this._yourPositionGrid.clearGrid();
            };
        }

        public function setErrorMessage(_arg_1:String):void
        {
            this._error.text = _arg_1;
            this._error.y = ((this.height - this._error.height) / 2);
            this._error.visible = true;
        }

        private function init():void
        {
            this.createGrids();
            this.createContentInset();
            this.createContentTabs();
            this.addTabs();
            this.createRefreshTime();
            this.createLastUpdatedTime();
            this.createSpinner();
            this.createError();
        }

        private function createError():void
        {
            this._error = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._error, 14, 0xFF0000, TextFormatAlign.CENTER, true);
            this._error.autoSize = TextFieldAutoSize.NONE;
            this._error.width = WIDTH;
            this._error.multiline = true;
            this._error.wordWrap = true;
            this._error.visible = false;
            addChild(this._error);
        }

        private function createRefreshTime():void
        {
            this._refreshTime = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._refreshTime, 12, 0xFFFFFF, TextFormatAlign.CENTER, true);
            this._refreshTime.autoSize = TextFieldAutoSize.NONE;
            this._refreshTime.width = (WIDTH / 2);
            this._refreshTime.x = (WIDTH / 2);
            this._refreshTime.y = (this.height - 18);
        }

        private function createLastUpdatedTime():void
        {
            this._lastUpdatedTime = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._lastUpdatedTime, 12, 0xFFFFFF, TextFormatAlign.CENTER, true);
            this._lastUpdatedTime.autoSize = TextFieldAutoSize.NONE;
            this._lastUpdatedTime.width = WIDTH;
            this._lastUpdatedTime.y = (this.height - 18);
            addChild(this._lastUpdatedTime);
        }

        private function createSpinner():void
        {
            this._spinnersContainer = new Sprite();
            addChild(this._spinnersContainer);
            this._spinner = new Spinner(180);
            this._spinner.scaleX = (this._spinner.scaleY = 0.1);
            this._spinner.pause();
            this._spinner.x = (this._contentInset.x + (this._contentInset.width / 2));
            this._spinner.y = (this._contentInset.y + (this._contentInset.height / 2));
            this._spinnersContainer.addChild(this._spinner);
        }

        private function createGrids():void
        {
            this._top20Grid = new UIGrid((WIDTH - 20), 1, 3);
            this._yourPositionGrid = new UIGrid((WIDTH - 20), 1, 3);
        }

        private function createContentTabs():void
        {
            this._contentTabs = TextureParser.instance.getSliceScalingBitmap("UI", "tab_inset_content_background", (WIDTH - 32));
            this._contentTabs.height = 45;
            this._contentTabs.x = 16;
            this._contentTabs.y = ((SCROLL_Y_OFFSET - this._contentTabs.height) + 6);
            addChild(this._contentTabs);
        }

        private function createContentInset():void
        {
            this._contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", (WIDTH - 20));
            this._contentInset.height = SCROLL_HEIGHT;
            this._contentInset.x = 10;
            this._contentInset.y = SCROLL_Y_OFFSET;
            addChild(this._contentInset);
        }

        private function addTabs():void
        {
            this._tabs = new UITabs((WIDTH - 30), true);
            this._tabs.addTab(this.createTab(TOP_20_TAB_LABEL, new Sprite(), this._top20Grid), true);
            this._tabs.addTab(this.createTab(PLAYER_TAB_LABEL, new Sprite(), this._yourPositionGrid), false);
            this._tabs.x = 16;
            this._tabs.y = this._contentTabs.y;
            addChild(this._tabs);
        }

        private function createTab(_arg_1:String, _arg_2:Sprite, _arg_3:UIGrid):UITab
        {
            var _local_4:UITab;
            _local_4 = new UITab(_arg_1, true);
            this._tabContent = new Sprite();
            _arg_2.x = this._contentInset.x;
            this._tabContent.addChild(_arg_2);
            _arg_2.y = 16;
            _arg_2.addChild(_arg_3);
            var _local_5:* = 384;
            var _local_6:UIScrollbar = new UIScrollbar(_local_5);
            _local_6.mouseRollSpeedFactor = 1;
            _local_6.scrollObject = _local_4;
            _local_6.content = _arg_2;
            _local_6.x = (WIDTH - 46);
            _local_6.y = 16;
            this._tabContent.addChild(_local_6);
            var _local_7:Sprite = new Sprite();
            _local_7.graphics.beginFill(0);
            _local_7.graphics.drawRect(0, 0, WIDTH, _local_5);
            _local_7.x = _arg_2.x;
            _local_7.y = _arg_2.y;
            _arg_2.mask = _local_7;
            this._tabContent.addChild(_local_7);
            _local_4.addContent(this._tabContent);
            return (_local_4);
        }

        public function get tabs():UITabs
        {
            return (this._tabs);
        }

        public function get spinner():Spinner
        {
            return (this._spinner);
        }

        public function get refreshTime():UILabel
        {
            return (this._refreshTime);
        }

        public function get lastUpdatedTime():UILabel
        {
            return (this._lastUpdatedTime);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard

