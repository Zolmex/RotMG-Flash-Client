﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.NewAbilityMessage

package kabam.rotmg.messaging.impl.incoming
{
    import kabam.lib.net.impl.Message;
    import flash.utils.IDataInput;

    public class NewAbilityMessage extends Message 
    {

        public var type:int;

        public function NewAbilityMessage(_arg_1:uint, _arg_2:Function=null)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            this.type = _arg_1.readInt();
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

