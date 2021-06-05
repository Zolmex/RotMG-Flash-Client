// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.data.LegacySeasonData

package io.decagames.rotmg.seasonalEvent.data
{
    public class LegacySeasonData 
    {

        private var _seasonId:String;
        private var _title:String;
        private var _active:Boolean;
        private var _timeValid:Boolean;
        private var _hasLeaderBoard:Boolean;
        private var _startTime:Date;
        private var _endTime:Date;


        public function get seasonId():String
        {
            return (this._seasonId);
        }

        public function set seasonId(_arg_1:String):void
        {
            this._seasonId = _arg_1;
        }

        public function get title():String
        {
            return (this._title);
        }

        public function set title(_arg_1:String):void
        {
            this._title = _arg_1;
        }

        public function get active():Boolean
        {
            return (this._active);
        }

        public function set active(_arg_1:Boolean):void
        {
            this._active = _arg_1;
        }

        public function get timeValid():Boolean
        {
            return (this._timeValid);
        }

        public function set timeValid(_arg_1:Boolean):void
        {
            this._timeValid = _arg_1;
        }

        public function get hasLeaderBoard():Boolean
        {
            return (this._hasLeaderBoard);
        }

        public function set hasLeaderBoard(_arg_1:Boolean):void
        {
            this._hasLeaderBoard = _arg_1;
        }

        public function get startTime():Date
        {
            return (this._startTime);
        }

        public function set startTime(_arg_1:Date):void
        {
            this._startTime = _arg_1;
        }

        public function get endTime():Date
        {
            return (this._endTime);
        }

        public function set endTime(_arg_1:Date):void
        {
            this._endTime = _arg_1;
        }


    }
}//package io.decagames.rotmg.seasonalEvent.data

