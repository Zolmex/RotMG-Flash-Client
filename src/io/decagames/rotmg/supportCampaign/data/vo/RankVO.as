// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.data.vo.RankVO

package io.decagames.rotmg.supportCampaign.data.vo
{
    public class RankVO 
    {

        private var _points:int;
        private var _name:String;

        public function RankVO(_arg_1:int, _arg_2:String)
        {
            this._points = _arg_1;
            this._name = _arg_2;
        }

        public function get points():int
        {
            return (this._points);
        }

        public function get name():String
        {
            return (this._name);
        }


    }
}//package io.decagames.rotmg.supportCampaign.data.vo

