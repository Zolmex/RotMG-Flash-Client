// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardItemData

package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard
{
    import flash.display.BitmapData;
    import __AS3__.vec.Vector;

    public class SeasonalLeaderBoardItemData 
    {

        private var _accountId:String;
        private var _charId:int;
        private var _name:String;
        private var _isOwn:Boolean;
        private var _rank:int;
        private var _totalFame:int;
        private var _character:BitmapData;
        private var _equipmentSlots:Vector.<int>;
        private var _equipment:Vector.<int>;


        public function get accountId():String
        {
            return (this._accountId);
        }

        public function set accountId(_arg_1:String):void
        {
            this._accountId = _arg_1;
        }

        public function get charId():int
        {
            return (this._charId);
        }

        public function set charId(_arg_1:int):void
        {
            this._charId = _arg_1;
        }

        public function get isOwn():Boolean
        {
            return (this._isOwn);
        }

        public function set isOwn(_arg_1:Boolean):void
        {
            this._isOwn = _arg_1;
        }

        public function get rank():int
        {
            return (this._rank);
        }

        public function set rank(_arg_1:int):void
        {
            this._rank = _arg_1;
        }

        public function get totalFame():int
        {
            return (this._totalFame);
        }

        public function set totalFame(_arg_1:int):void
        {
            this._totalFame = _arg_1;
        }

        public function set character(_arg_1:BitmapData):void
        {
            this._character = _arg_1;
        }

        public function get equipmentSlots():Vector.<int>
        {
            return (this._equipmentSlots);
        }

        public function set equipmentSlots(_arg_1:Vector.<int>):void
        {
            this._equipmentSlots = _arg_1;
        }

        public function get equipment():Vector.<int>
        {
            return (this._equipment);
        }

        public function set equipment(_arg_1:Vector.<int>):void
        {
            this._equipment = _arg_1;
        }

        public function get character():BitmapData
        {
            return (this._character);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }


    }
}//package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard

