// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardMediator

package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.legends.model.LegendsModel;
    import io.decagames.rotmg.seasonalEvent.signals.RequestChallengerListSignal;
    import kabam.rotmg.legends.control.FameListUpdateSignal;
    import io.decagames.rotmg.seasonalEvent.signals.SeasonalLeaderBoardErrorSignal;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import __AS3__.vec.Vector;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class SeasonalLeaderBoardMediator extends Mediator 
    {

        public static const REFRESH_TIME:String = " The list will be refreshed in: ";
        public static const REFRESH_INTERVAL_IN_MILLISECONDS:Number = ((5 * 60) * 1000);//300000

        [Inject]
        public var view:SeasonalLeaderBoard;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var legendsModel:LegendsModel;
        [Inject]
        public var requestChallengerListSignal:RequestChallengerListSignal;
        [Inject]
        public var updateBoardSignal:FameListUpdateSignal;
        [Inject]
        public var seasonalLeaderBoardErrorSignal:SeasonalLeaderBoardErrorSignal;
        private var closeButton:SliceScalingButton;
        private var _refreshTimer:Timer;


        override public function initialize():void
        {
            this._refreshTimer = new Timer(1000);
            this._refreshTimer.addEventListener(TimerEvent.TIMER, this.onTime);
            this.updateBoardSignal.add(this.updateLeaderBoard);
            this.seasonalLeaderBoardErrorSignal.add(this.onLeaderBoardError);
            this.view.header.setTitle("RIFTS Leaderboard", 480, DefaultLabelFormat.defaultMediumPopupTitle);
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.view.tabs.tabSelectedSignal.add(this.onTabSelected);
        }

        private function setGeneratedTime():void
        {
            var _local_1:Date = ((this.view.tabs.currentTabLabel == SeasonalLeaderBoard.TOP_20_TAB_LABEL) ? this.seasonalEventModel.leaderboardTop20CreateTime : this.seasonalEventModel.leaderboardPlayerCreateTime);
            this.view.lastUpdatedTime.text = ("Last updated at: " + this.getTimeFormat(_local_1.time));
        }

        private function onLeaderBoardError(_arg_1:String):void
        {
            this.view.clearLeaderBoard();
            this.view.spinner.visible = false;
            this.view.spinner.pause();
            this.view.setErrorMessage(_arg_1);
        }

        private function onTime(_arg_1:TimerEvent):void
        {
            if (this.timeToRefresh() <= 0)
            {
                this.onTabSelected(this.view.tabs.currentTabLabel);
            }
            else
            {
                this.updateRefreshTime();
            };
        }

        private function updateRefreshTime():void
        {
            var _local_1:String = this.getTimeFormat(this.timeToRefresh());
            this.view.refreshTime.text = (REFRESH_TIME + _local_1);
        }

        private function getTimeFormat(_arg_1:Number):String
        {
            var _local_2:Date = new Date(_arg_1);
            var _local_3:String = ((_local_2.getUTCHours() > 9) ? _local_2.getUTCHours().toString() : ("0" + _local_2.getUTCHours()));
            var _local_4:String = ((_local_2.getUTCMinutes() > 9) ? _local_2.getUTCMinutes().toString() : ("0" + _local_2.getUTCMinutes()));
            var _local_5:String = ((_local_2.getUTCSeconds() > 9) ? _local_2.getUTCSeconds().toString() : ("0" + _local_2.getUTCSeconds()));
            return ((((_local_3 + ":") + _local_4) + ":") + _local_5);
        }

        private function onTabSelected(_arg_1:String):void
        {
            this.view.refreshTime.visible = false;
            this.view.lastUpdatedTime.visible = false;
            this._refreshTimer.stop();
            this.showSpinner();
            if (this.timeToRefresh() <= 0)
            {
                this.requestChallengerListSignal.dispatch(this.legendsModel.getTimespan(), _arg_1);
            }
            else
            {
                if (_arg_1 == SeasonalLeaderBoard.TOP_20_TAB_LABEL)
                {
                    this.upDateTop20();
                }
                else
                {
                    if (_arg_1 == SeasonalLeaderBoard.PLAYER_TAB_LABEL)
                    {
                        this.upDatePlayerPosition();
                    };
                };
            };
        }

        private function timeToRefresh():Number
        {
            var _local_2:Date;
            var _local_1:Date = ((this.view.tabs.currentTabLabel == SeasonalLeaderBoard.TOP_20_TAB_LABEL) ? this.seasonalEventModel.leaderboardTop20RefreshTime : this.seasonalEventModel.leaderboardPlayerRefreshTime);
            if (_local_1)
            {
                _local_2 = new Date();
                return (_local_1.time - _local_2.time);
            };
            return (0);
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
                if (this.seasonalEventModel.leaderboardTop20ItemDatas)
                {
                    this.upDateTop20();
                };
            }
            else
            {
                if (this.view.tabs.currentTabLabel == SeasonalLeaderBoard.PLAYER_TAB_LABEL)
                {
                    if (this.seasonalEventModel.leaderboardPlayerItemDatas)
                    {
                        this.upDatePlayerPosition();
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
            var _local_1:Vector.<SeasonalLeaderBoardItemData> = this.seasonalEventModel.leaderboardTop20ItemDatas;
            for each (_local_2 in _local_1)
            {
                this.view.addTop20Item(_local_2);
            };
            this.view.refreshTime.visible = true;
            this.setGeneratedTime();
            this.view.lastUpdatedTime.visible = true;
            this._refreshTimer.start();
        }

        private function upDatePlayerPosition():void
        {
            var _local_2:SeasonalLeaderBoardItemData;
            this.view.clearLeaderBoard();
            this.view.spinner.visible = false;
            this.view.spinner.pause();
            var _local_1:Vector.<SeasonalLeaderBoardItemData> = this.seasonalEventModel.leaderboardPlayerItemDatas;
            for each (_local_2 in _local_1)
            {
                this.view.addPlayerListItem(_local_2);
            };
            this.view.refreshTime.visible = true;
            this.setGeneratedTime();
            this.view.lastUpdatedTime.visible = true;
            this._refreshTimer.start();
        }

        override public function destroy():void
        {
            this.view.dispose();
            this.closeButton.dispose();
            this._refreshTimer.stop();
            this._refreshTimer.removeEventListener(TimerEvent.TIMER, this.onTime);
            this._refreshTimer = null;
            this.seasonalLeaderBoardErrorSignal.remove(this.onLeaderBoardError);
            this.updateBoardSignal.remove(this.updateLeaderBoard);
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard

