﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.Aoe

package kabam.rotmg.messaging.impl.incoming
{
    import kabam.rotmg.messaging.impl.data.WorldPosData;
    import flash.utils.IDataInput;

    public class Aoe extends IncomingMessage 
    {

        public var pos_:WorldPosData = new WorldPosData();
        public var radius_:Number;
        public var damage_:int;
        public var effect_:int;
        public var duration_:Number;
        public var origType_:int;
        public var color_:int;
        public var armorPierce_:Boolean;

        public function Aoe(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            this.pos_.parseFromInput(_arg_1);
            this.radius_ = _arg_1.readFloat();
            this.damage_ = _arg_1.readUnsignedShort();
            this.effect_ = _arg_1.readUnsignedByte();
            this.duration_ = _arg_1.readFloat();
            this.origType_ = _arg_1.readUnsignedShort();
            this.color_ = _arg_1.readInt();
            this.armorPierce_ = _arg_1.readBoolean();
        }

        override public function toString():String
        {
            return (formatToString("AOE", "pos_", "radius_", "damage_", "effect_", "duration_", "origType_", "color_", "armorPierce_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

