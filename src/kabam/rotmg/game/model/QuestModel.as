// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.model.QuestModel

package kabam.rotmg.game.model
{
    import __AS3__.vec.Vector;

    public class QuestModel 
    {

        public static const LEVEL_REQUIREMENT:int = 0;
        public static const REMAINING_HEROES_REQUIREMENT:int = 1;
        public static const ORYX_KILLED:int = 2;
        public static const ORYX_THE_MAD_GOD:String = "Oryx the Mad God";

        private var _previousRealm:String = "";
        private var _currentQuestHero:String;
        private var _remainingHeroes:int = -1;
        private var _requirementsStates:Vector.<Boolean> = new <Boolean>[false, false, false];
        private var _hasOryxBeenKilled:Boolean;


        public function get currentQuestHero():String
        {
            return (this._currentQuestHero);
        }

        public function set currentQuestHero(_arg_1:String):void
        {
            this._currentQuestHero = _arg_1;
        }

        public function get remainingHeroes():int
        {
            return (this._remainingHeroes);
        }

        public function set remainingHeroes(_arg_1:int):void
        {
            this._remainingHeroes = _arg_1;
        }

        public function get previousRealm():String
        {
            return (this._previousRealm);
        }

        public function set previousRealm(_arg_1:String):void
        {
            this._previousRealm = _arg_1;
        }

        public function get requirementsStates():Vector.<Boolean>
        {
            return (this._requirementsStates);
        }

        public function set requirementsStates(_arg_1:Vector.<Boolean>):void
        {
            this._requirementsStates = _arg_1;
        }

        public function get hasOryxBeenKilled():Boolean
        {
            return (this._hasOryxBeenKilled);
        }

        public function set hasOryxBeenKilled(_arg_1:Boolean):void
        {
            this._hasOryxBeenKilled = _arg_1;
        }

        public function resetRequirementsStates():void
        {
            var _local_1:int = this._requirementsStates.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                this._requirementsStates[_local_2] = false;
                _local_2++;
            };
        }


    }
}//package kabam.rotmg.game.model

