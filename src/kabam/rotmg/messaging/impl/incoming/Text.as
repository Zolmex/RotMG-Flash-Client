﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.Text

package kabam.rotmg.messaging.impl.incoming
{
    import flash.utils.IDataInput;

    public class Text extends IncomingMessage 
    {

        public var name_:String = new String();
        public var objectId_:int;
        public var numStars_:int;
        public var bubbleTime_:uint;
        public var recipient_:String;
        public var text_:String = new String();
        public var cleanText_:String = new String();
        public var isSupporter:Boolean = false;
        public var starBg:int;

        public function Text(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            this.name_ = _arg_1.readUTF();
            this.objectId_ = _arg_1.readInt();
            this.numStars_ = _arg_1.readInt();
            this.bubbleTime_ = _arg_1.readUnsignedByte();
            this.recipient_ = _arg_1.readUTF();
            this.text_ = _arg_1.readUTF();
            this.cleanText_ = _arg_1.readUTF();
            this.isSupporter = _arg_1.readBoolean();
            this.starBg = _arg_1.readInt();
        }

        override public function toString():String
        {
            return (formatToString("TEXT", "name_", "objectId_", "numStars_", "bubbleTime_", "recipient_", "text_", "cleanText_", "isSupporter", "starBg"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

