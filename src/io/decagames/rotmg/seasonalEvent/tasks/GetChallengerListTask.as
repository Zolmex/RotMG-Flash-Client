// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.tasks.GetChallengerListTask

package io.decagames.rotmg.seasonalEvent.tasks
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.legends.model.LegendsModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.legends.model.LegendFactory;
    import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalItemDataFactory;
    import kabam.rotmg.legends.model.Timespan;
    import io.decagames.rotmg.seasonalEvent.signals.SeasonalLeaderBoardErrorSignal;
    import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoard;
    
    import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardItemData;

    public class GetChallengerListTask extends BaseTask 
    {

        public static const REFRESH_INTERVAL_IN_MILLISECONDS:Number = ((5 * 60) * 1000);//300000

        [Inject]
        public var account:Account;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var model:LegendsModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var factory:LegendFactory;
        [Inject]
        public var seasonalItemDataFactory:SeasonalItemDataFactory;
        [Inject]
        public var timespan:Timespan;
        [Inject]
        public var listType:String;
        [Inject]
        public var seasonalLeaderBoardErrorSignal:SeasonalLeaderBoardErrorSignal;
        public var charId:int;


        override protected function startTask():void
        {
            this.client.complete.addOnce(this.onComplete);
            if (this.listType == SeasonalLeaderBoard.TOP_20_TAB_LABEL)
            {
                this.client.sendRequest("/fame/challengerLeaderboard", this.makeRequestObject());
            }
            else
            {
                if (this.listType == SeasonalLeaderBoard.PLAYER_TAB_LABEL)
                {
                    this.client.sendRequest(("/fame/challengerAccountLeaderboard?account=" + this.account.getUserName()), this.makeRequestObject());
                }
            }
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.updateFameListData(_arg_2);
            }
            else
            {
                this.onFameListError(_arg_2);
            }
        }

        private function onFameListError(_arg_1:String):void
        {
            this.seasonalLeaderBoardErrorSignal.dispatch(_arg_1);
            completeTask(true);
        }

        private function updateFameListData(_arg_1:String):void
        {
            var _local_2:XML = XML(_arg_1);
            var _local_3:Date = new Date((_local_2.GeneratedOn * 1000));
            var _local_4:Number = ((_local_3.getTimezoneOffset() * 60) * 1000);
            _local_3.setTime((_local_3.getTime() - _local_4));
            var _local_5:Date = new Date();
            _local_5.setTime((_local_5.getTime() + REFRESH_INTERVAL_IN_MILLISECONDS));
            var _local_6:Vector.<SeasonalLeaderBoardItemData> = this.seasonalItemDataFactory.createSeasonalLeaderBoardItemDatas(XML(_arg_1));
            if (this.listType == SeasonalLeaderBoard.TOP_20_TAB_LABEL)
            {
                this.seasonalEventModel.leaderboardTop20ItemDatas = _local_6;
                this.seasonalEventModel.leaderboardTop20RefreshTime = _local_5;
                this.seasonalEventModel.leaderboardTop20CreateTime = _local_3;
            }
            else
            {
                if (this.listType == SeasonalLeaderBoard.PLAYER_TAB_LABEL)
                {
                    _local_6.sort(this.fameSort);
                    this.seasonalEventModel.leaderboardPlayerItemDatas = _local_6;
                    this.seasonalEventModel.leaderboardPlayerRefreshTime = _local_5;
                    this.seasonalEventModel.leaderboardPlayerCreateTime = _local_3;
                }
            }
            completeTask(true);
        }

        private function fameSort(_arg_1:SeasonalLeaderBoardItemData, _arg_2:SeasonalLeaderBoardItemData):int
        {
            if (_arg_1.totalFame > _arg_2.totalFame)
            {
                return (-1);
            }
            if (_arg_1.totalFame < _arg_2.totalFame)
            {
                return (1);
            }
            return (0);
        }

        private function makeRequestObject():Object
        {
            var _local_1:Object = {}
            _local_1.timespan = this.timespan.getId();
            _local_1.accountId = this.player.getAccountId();
            _local_1.charId = this.charId;
            return (_local_1);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.tasks

