// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel

package io.decagames.rotmg.seasonalEvent.data
{
    import robotlegs.bender.framework.api.IContext;
    import __AS3__.vec.Vector;
    import com.company.assembleegameclient.screens.LeagueData;
    import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardItemData;
    import io.decagames.rotmg.seasonalEvent.config.SeasonalConfig;
    import __AS3__.vec.*;

    public class SeasonalEventModel 
    {

        [Inject]
        public var context:IContext;
        private var _isSeasonalMode:Boolean;
        private var _leagueDatas:Vector.<LeagueData>;
        private var _seasonTitle:String;
        private var _isChallenger:int;
        private var _rulesAndDescription:String;
        private var _scheduledSeasonalEvent:Date;
        private var _startTime:Date;
        private var _endTime:Date;
        private var _accountCreatedBefore:Date;
        private var _maxCharacters:int;
        private var _maxPetYardLevel:int;
        private var _remainingCharacters:int;
        private var _leaderboardTop20RefreshTime:Date;
        private var _leaderboardTop20CreateTime:Date;
        private var _leaderboardPlayerRefreshTime:Date;
        private var _leaderboardPlayerCreateTime:Date;
        private var _leaderboardTop20ItemDatas:Vector.<SeasonalLeaderBoardItemData>;
        private var _leaderboardLegacyTop20ItemDatas:Vector.<SeasonalLeaderBoardItemData>;
        private var _leaderboardPlayerItemDatas:Vector.<SeasonalLeaderBoardItemData>;
        private var _leaderboardLegacyPlayerItemDatas:Vector.<SeasonalLeaderBoardItemData>;
        private var _legacySeasons:Vector.<LegacySeasonData>;


        public function parseConfigData(_arg_1:XML):void
        {
            var _local_3:XML;
            var _local_4:LeagueData;
            var _local_2:XMLList = _arg_1.Season;
            if (_local_2.length() > 0)
            {
                this._leagueDatas = new Vector.<LeagueData>(0);
                for each (_local_3 in _local_2)
                {
                    this._startTime = new Date((int(_local_3.Start) * 1000));
                    this._endTime = new Date((int(_local_3.End) * 1000));
                    this._maxCharacters = _local_3.MaxLives;
                    this._maxPetYardLevel = _local_3.MaxPetYardLevel;
                    this._accountCreatedBefore = new Date((_local_3.AccountCreatedBefore * 1000));
                    if (((this.getSecondsToStart(this._startTime) <= 0) && (!(this.hasSeasonEnded(this._endTime)))))
                    {
                        this._rulesAndDescription = _local_3.Information;
                        _local_4 = new LeagueData();
                        _local_4.maxCharacters = this._maxCharacters;
                        _local_4.leagueType = SeasonalConstants.CHALLENGER_LEAGUE_TYPE;
                        _local_4.title = (this._seasonTitle = _local_3.@title);
                        _local_4.endDate = this._endTime;
                        _local_4.description = _local_3.Description;
                        _local_4.quote = "";
                        _local_4.panelBackgroundId = SeasonalConstants.CHALLENGER_PANEL_BACKGROUND_ID;
                        _local_4.characterId = SeasonalConstants.CHALLENGER_CHARACTER_ID;
                        this._leagueDatas.push(_local_4);
                        this._isSeasonalMode = true;
                    }
                    else
                    {
                        if (this.getSecondsToStart(this._startTime) > 0)
                        {
                            this._isSeasonalMode = false;
                            this.setScheduledStartTime(this._startTime);
                        }
                        else
                        {
                            this._isSeasonalMode = false;
                        };
                    };
                };
                if (this._leagueDatas.length > 0)
                {
                    this._leagueDatas.unshift(this.addLegacyLeagueData());
                };
            };
            if (this._isSeasonalMode)
            {
                this.context.configure(SeasonalConfig);
            };
        }

        public function parseLegacySeasonsData(_arg_1:XML):void
        {
            var _local_3:XML;
            var _local_4:LegacySeasonData;
            var _local_2:XMLList = _arg_1.Season;
            if (_local_2.length() > 0)
            {
                this._legacySeasons = new Vector.<LegacySeasonData>(0);
                for each (_local_3 in _local_2)
                {
                    _local_4 = new LegacySeasonData();
                    _local_4.seasonId = _local_3.@id;
                    _local_4.title = _local_3.Title;
                    _local_4.active = _local_3.hasOwnProperty("Active");
                    _local_4.timeValid = _local_3.hasOwnProperty("TimeValid");
                    _local_4.hasLeaderBoard = _local_3.hasOwnProperty("HasLeaderboard");
                    _local_4.startTime = new Date((int(_local_3.StartTime) * 1000));
                    _local_4.endTime = new Date((int(_local_3.EndTime) * 1000));
                    this._legacySeasons.push(_local_4);
                };
            };
        }

        public function getSeasonIdByTitle(_arg_1:String):String
        {
            var _local_5:LegacySeasonData;
            var _local_2:* = "";
            var _local_3:int = this._legacySeasons.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = this._legacySeasons[_local_4];
                if (_local_5.title == _arg_1)
                {
                    _local_2 = _local_5.seasonId;
                    break;
                };
                _local_4++;
            };
            return (_local_2);
        }

        private function setScheduledStartTime(_arg_1:Date):void
        {
            this._scheduledSeasonalEvent = _arg_1;
        }

        private function getSecondsToStart(_arg_1:Date):Number
        {
            var _local_2:Date = new Date();
            return ((_arg_1.time - _local_2.time) / 1000);
        }

        private function hasSeasonEnded(_arg_1:Date):Boolean
        {
            var _local_2:Date = new Date();
            return (((_arg_1.time - _local_2.time) / 1000) <= 0);
        }

        private function addLegacyLeagueData():LeagueData
        {
            var _local_1:LeagueData = new LeagueData();
            _local_1.maxCharacters = -1;
            _local_1.leagueType = SeasonalConstants.LEGACY_LEAGUE_TYPE;
            _local_1.title = "Original";
            _local_1.description = "The original Realm of the Mad God. This is a gathering place for every Hero in the Realm of the Mad God.";
            _local_1.quote = "The experience you have come to know, all your previous progress and achievements.";
            _local_1.panelBackgroundId = SeasonalConstants.LEGACY_PANEL_BACKGROUND_ID;
            _local_1.characterId = SeasonalConstants.LEGACY_CHARACTER_ID;
            return (_local_1);
        }

        public function get isSeasonalMode():Boolean
        {
            return (this._isSeasonalMode);
        }

        public function set isSeasonalMode(_arg_1:Boolean):void
        {
            this._isSeasonalMode = _arg_1;
        }

        public function get leagueDatas():Vector.<LeagueData>
        {
            return (this._leagueDatas);
        }

        public function get isChallenger():int
        {
            return (this._isChallenger);
        }

        public function set isChallenger(_arg_1:int):void
        {
            this._isChallenger = _arg_1;
        }

        public function get seasonTitle():String
        {
            return (this._seasonTitle);
        }

        public function get rulesAndDescription():String
        {
            return (this._rulesAndDescription);
        }

        public function get scheduledSeasonalEvent():Date
        {
            return (this._scheduledSeasonalEvent);
        }

        public function get maxCharacters():int
        {
            return (this._maxCharacters);
        }

        public function get remainingCharacters():int
        {
            return (this._remainingCharacters);
        }

        public function set remainingCharacters(_arg_1:int):void
        {
            this._remainingCharacters = _arg_1;
        }

        public function get accountCreatedBefore():Date
        {
            return (this._accountCreatedBefore);
        }

        public function get leaderboardTop20RefreshTime():Date
        {
            return (this._leaderboardTop20RefreshTime);
        }

        public function set leaderboardTop20RefreshTime(_arg_1:Date):void
        {
            this._leaderboardTop20RefreshTime = _arg_1;
        }

        public function get leaderboardPlayerRefreshTime():Date
        {
            return (this._leaderboardPlayerRefreshTime);
        }

        public function set leaderboardPlayerRefreshTime(_arg_1:Date):void
        {
            this._leaderboardPlayerRefreshTime = _arg_1;
        }

        public function get leaderboardTop20ItemDatas():Vector.<SeasonalLeaderBoardItemData>
        {
            return (this._leaderboardTop20ItemDatas);
        }

        public function set leaderboardTop20ItemDatas(_arg_1:Vector.<SeasonalLeaderBoardItemData>):void
        {
            this._leaderboardTop20ItemDatas = _arg_1;
        }

        public function get leaderboardPlayerItemDatas():Vector.<SeasonalLeaderBoardItemData>
        {
            return (this._leaderboardPlayerItemDatas);
        }

        public function set leaderboardPlayerItemDatas(_arg_1:Vector.<SeasonalLeaderBoardItemData>):void
        {
            this._leaderboardPlayerItemDatas = _arg_1;
        }

        public function get leaderboardTop20CreateTime():Date
        {
            return (this._leaderboardTop20CreateTime);
        }

        public function set leaderboardTop20CreateTime(_arg_1:Date):void
        {
            this._leaderboardTop20CreateTime = _arg_1;
        }

        public function get leaderboardPlayerCreateTime():Date
        {
            return (this._leaderboardPlayerCreateTime);
        }

        public function set leaderboardPlayerCreateTime(_arg_1:Date):void
        {
            this._leaderboardPlayerCreateTime = _arg_1;
        }

        public function get maxPetYardLevel():int
        {
            return (this._maxPetYardLevel);
        }

        public function get legacySeasons():Vector.<LegacySeasonData>
        {
            return (this._legacySeasons);
        }

        public function get leaderboardLegacyTop20ItemDatas():Vector.<SeasonalLeaderBoardItemData>
        {
            return (this._leaderboardLegacyTop20ItemDatas);
        }

        public function set leaderboardLegacyTop20ItemDatas(_arg_1:Vector.<SeasonalLeaderBoardItemData>):void
        {
            this._leaderboardLegacyTop20ItemDatas = _arg_1;
        }

        public function get leaderboardLegacyPlayerItemDatas():Vector.<SeasonalLeaderBoardItemData>
        {
            return (this._leaderboardLegacyPlayerItemDatas);
        }

        public function set leaderboardLegacyPlayerItemDatas(_arg_1:Vector.<SeasonalLeaderBoardItemData>):void
        {
            this._leaderboardLegacyPlayerItemDatas = _arg_1;
        }


    }
}//package io.decagames.rotmg.seasonalEvent.data

