// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.arena.ArenaDeath

package kabam.rotmg.messaging.impl.incoming.arena
{
    import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import flash.utils.IDataInput;

    public class ArenaDeath extends IncomingMessage 
    {

        public var cost:int;

        public function ArenaDeath(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            this.cost = _arg_1.readInt();
        }

        override public function toString():String
        {
            return (formatToString("ARENADEATH", "cost"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming.arena

