// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.RealmHeroesResponse

package kabam.rotmg.messaging.impl.incoming
{
    import flash.utils.IDataInput;

    public class RealmHeroesResponse extends IncomingMessage 
    {

        public var numberOfRealmHeroes:int;

        public function RealmHeroesResponse(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            this.numberOfRealmHeroes = _arg_1.readInt();
        }

        override public function toString():String
        {
            return (formatToString("REALMHEROESRESPONSE", "numberOfRealmHeroes"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

