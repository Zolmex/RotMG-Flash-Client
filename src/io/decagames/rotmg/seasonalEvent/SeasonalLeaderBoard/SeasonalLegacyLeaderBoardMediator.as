// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLegacyLeaderBoardMediator

package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import io.decagames.rotmg.seasonalEvent.signals.SeasonalLeaderBoardErrorSignal;
    import io.decagames.rotmg.seasonalEvent.signals.RequestLegacySeasonSignal;
    import kabam.rotmg.legends.control.FameListUpdateSignal;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import __AS3__.vec.Vector;
    import io.decagames.rotmg.seasonalEvent.data.LegacySeasonData;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import flash.events.Event;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import __AS3__.vec.*;

    public class SeasonalLegacyLeaderBoardMediator extends Mediator 
    {

        [Inject]
        public var view:SeasonalLegacyLeaderBoard;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var seasonalLeaderBoardErrorSignal:SeasonalLeaderBoardErrorSignal;
        [Inject]
        public var requestLegacySeasonSignal:RequestLegacySeasonSignal;
        [Inject]
        public var updateBoardSignal:FameListUpdateSignal;
        private var closeButton:SliceScalingButton;
        private var _currentSeasonId:String = "";
        private var _isActiveSeason:Boolean;
        private var _legacyLeaderBoardSeasons:Vector.<LegacySeasonData> = new Vector.<LegacySeasonData>(0);


        override public function initialize():void
        {
            this.seasonalLeaderBoardErrorSignal.add(this.onLeaderBoardError);
            this.view.header.setTitle("Seasons Leaderboard", 480, DefaultLabelFormat.defaultMediumPopupTitle);
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.view.tabs.tabSelectedSignal.add(this.onTabSelected);
            this.setSeasonData();
            this.updateBoardSignal.add(this.updateLeaderBoard);
        }

        private function setSeasonData():void
        {
            var _local_5:LegacySeasonData;
            var _local_1:Vector.<String> = new Vector.<String>(0);
            var _local_2:Vector.<LegacySeasonData> = this.seasonalEventModel.legacySeasons;
            var _local_3:int = _local_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = _local_2[_local_4];
                if (_local_5.hasLeaderBoard)
                {
                    this._legacyLeaderBoardSeasons.push(_local_5);
                    _local_1.push(_local_5.title);
                };
                _local_4++;
            };
            if (_local_1.length > 0)
            {
                this._currentSeasonId = "";
                _local_1.unshift("Click to choose a season!");
                this.view.setDropDownData(_local_1);
                this.view.dropDown.addEventListener(Event.CHANGE, this.onDropDownChanged);
            };
        }

        private function onDropDownChanged(_arg_1:Event):void
        {
            this.resetLeaderBoard();
            this.showSpinner();
            this._currentSeasonId = this.getSeasonId();
            if (this.isSeasonActive(this._currentSeasonId))
            {
                this.view.tabs.getTabButtonByLabel(SeasonalLeaderBoard.PLAYER_TAB_LABEL).visible = true;
            }
            else
            {
                this.view.tabs.getTabButtonByLabel(SeasonalLeaderBoard.PLAYER_TAB_LABEL).visible = false;
            };
            this.requestLegacySeasonSignal.dispatch(this._currentSeasonId, true);
        }

        private function isSeasonActive(_arg_1:String):Boolean
        {
            var _local_2:Boolean;
            var _local_5:LegacySeasonData;
            var _local_3:int = this._legacyLeaderBoardSeasons.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = this._legacyLeaderBoardSeasons[_local_4];
                if (((_arg_1 == _local_5.seasonId) && (_local_5.active)))
                {
                    _local_2 = true;
                    break;
                };
                _local_4++;
            };
            return (_local_2);
        }

        private function resetLeaderBoard():void
        {
            this.view.clearLeaderBoard();
            this.view.spinner.visible = false;
            this.view.spinner.pause();
            this.seasonalEventModel.leaderboardLegacyTop20ItemDatas = null;
            this.seasonalEventModel.leaderboardLegacyPlayerItemDatas = null;
            this._currentSeasonId = "";
            if (this.view.tabs.currentTabLabel == SeasonalLeaderBoard.PLAYER_TAB_LABEL)
            {
                this.view.tabs.tabSelectedSignal.dispatch(SeasonalLegacyLeaderBoard.TOP_20_TAB_LABEL);
            };
        }

        private function getSeasonId():String
        {
            var _local_1:String = this.view.dropDown.getValue();
            return (this.seasonalEventModel.getSeasonIdByTitle(_local_1));
        }

        private function onLeaderBoardError(_arg_1:String):void
        {
            this.view.clearLeaderBoard();
            this.view.spinner.visible = false;
            this.view.spinner.pause();
            this.view.setErrorMessage(_arg_1);
        }

        private function getTimeFormat(_arg_1:Number):String
        {
            var _local_2:Date = new Date(_arg_1);
            var _local_3:String = ((_local_2.getHours() > 9) ? _local_2.getHours().toString() : ("0" + _local_2.getHours()));
            var _local_4:String = ((_local_2.getMinutes() > 9) ? _local_2.getMinutes().toString() : ("0" + _local_2.getMinutes()));
            var _local_5:String = ((_local_2.getSeconds() > 9) ? _local_2.getSeconds().toString() : ("0" + _local_2.getSeconds()));
            return ((((_local_3 + ":") + _local_4) + ":") + _local_5);
        }

        private function onTabSelected(_arg_1:String):void
        {
            if (this._currentSeasonId != "")
            {
                this.showSpinner();
                this.updateLeaderBoard();
            };
        }

        private function showSpinner():void
        {
            this.view.spinner.resume();
            this.view.spinner.visible = true;
        }

        private function updateLeaderBoard():void
        {
            if (this.view.tabs.currentTabLabel == SeasonalLeaderBoard.TOP_20_TAB_LABEL)
            {
                if (this.seasonalEventModel.leaderboardLegacyTop20ItemDatas)
                {
                    this.upDateTop20();
                };
            }
            else
            {
                if (this.view.tabs.currentTabLabel == SeasonalLeaderBoard.PLAYER_TAB_LABEL)
                {
                    if (this.seasonalEventModel.leaderboardLegacyPlayerItemDatas)
                    {
                        this.upDatePlayerPosition();
                    }
                    else
                    {
                        this.requestLegacySeasonSignal.dispatch(((this._currentSeasonId != "") ? this._currentSeasonId : this.getSeasonId()), false);
                    };
                }
                else
                {
                    this.onTabSelected(this.view.tabs.currentTabLabel);
                };
            };
        }

        private function upDateTop20():void
        {
            var _local_2:SeasonalLeaderBoardItemData;
            this.view.clearLeaderBoard();
            this.view.spinner.visible = false;
            this.view.spinner.pause();
            var _local_1:Vector.<SeasonalLeaderBoardItemData> = this.seasonalEventModel.leaderboardLegacyTop20ItemDatas;
            for each (_local_2 in _local_1)
            {
                this.view.addTop20Item(_local_2);
            };
        }

        private function upDatePlayerPosition():void
        {
            var _local_2:SeasonalLeaderBoardItemData;
            this.view.clearLeaderBoard();
            this.view.spinner.visible = false;
            this.view.spinner.pause();
            var _local_1:Vector.<SeasonalLeaderBoardItemData> = this.seasonalEventModel.leaderboardLegacyPlayerItemDatas;
            for each (_local_2 in _local_1)
            {
                this.view.addPlayerListItem(_local_2);
            };
        }

        override public function destroy():void
        {
            this.view.dispose();
            this.closeButton.dispose();
            this.seasonalLeaderBoardErrorSignal.remove(this.onLeaderBoardError);
            this.updateBoardSignal.remove(this.updateLeaderBoard);
            if (this.view.dropDown)
            {
                this.view.dropDown.removeEventListener(Event.CHANGE, this.onDropDownChanged);
            };
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard

