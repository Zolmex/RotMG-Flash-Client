﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.outgoing.InvDrop

package kabam.rotmg.messaging.impl.outgoing
{
    import kabam.rotmg.messaging.impl.data.SlotObjectData;
    import flash.utils.IDataOutput;

    public class InvDrop extends OutgoingMessage 
    {

        public var slotObject_:SlotObjectData = new SlotObjectData();

        public function InvDrop(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function writeToOutput(_arg_1:IDataOutput):void
        {
            this.slotObject_.writeToOutput(_arg_1);
        }

        override public function toString():String
        {
            return (formatToString("INVDROP", "slotObject_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

