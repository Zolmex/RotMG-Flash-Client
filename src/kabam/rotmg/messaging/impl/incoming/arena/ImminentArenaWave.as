// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.arena.ImminentArenaWave

package kabam.rotmg.messaging.impl.incoming.arena
{
    import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import flash.utils.IDataInput;

    public class ImminentArenaWave extends IncomingMessage 
    {

        public var currentRuntime:int;

        public function ImminentArenaWave(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            this.currentRuntime = _arg_1.readInt();
        }

        override public function toString():String
        {
            return (formatToString("IMMINENTARENAWAVE", "currentRuntime"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming.arena

