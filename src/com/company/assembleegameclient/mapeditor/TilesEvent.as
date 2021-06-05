// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.TilesEvent

package com.company.assembleegameclient.mapeditor
{
    import flash.events.Event;
    import __AS3__.vec.Vector;
    import com.company.util.IntPoint;

    internal class TilesEvent extends Event 
    {

        public static const TILES_EVENT:String = "TILES_EVENT";

        public var tiles_:Vector.<IntPoint>;

        public function TilesEvent(_arg_1:Vector.<IntPoint>)
        {
            super(TILES_EVENT);
            this.tiles_ = _arg_1;
        }

    }
}//package com.company.assembleegameclient.mapeditor

