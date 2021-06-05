// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.map.AbstractMap

package com.company.assembleegameclient.map
{
    import flash.display.Sprite;
    import flash.utils.Dictionary;
    import com.company.assembleegameclient.game.AGameSprite;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.background.Background;
    import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
    import com.company.assembleegameclient.map.partyoverlay.PartyOverlay;
    import __AS3__.vec.Vector;
    import com.company.assembleegameclient.objects.Party;
    import org.osflash.signals.Signal;
    import com.company.assembleegameclient.objects.BasicObject;
    import flash.geom.Point;
    import __AS3__.vec.*;

    public class AbstractMap extends Sprite 
    {

        public var goDict_:Dictionary = new Dictionary();
        public var gs_:AGameSprite;
        public var name_:String;
        public var player_:Player = null;
        public var showDisplays_:Boolean;
        public var width_:int;
        public var height_:int;
        public var back_:int;
        protected var allowPlayerTeleport_:Boolean;
        public var background_:Background = null;
        public var map_:Sprite = new Sprite();
        public var mapHitArea:Sprite;
        public var hurtOverlay_:HurtOverlay = null;
        public var gradientOverlay_:GradientOverlay = null;
        public var mapOverlay_:MapOverlay = null;
        public var partyOverlay_:PartyOverlay = null;
        public var squareList_:Vector.<Square> = new Vector.<Square>();
        public var squares_:Vector.<Square> = new Vector.<Square>();
        public var boDict_:Dictionary = new Dictionary();
        public var merchLookup_:Object = new Object();
        public var party_:Party = null;
        public var quest_:Quest = null;
        public var signalRenderSwitch:Signal = new Signal(Boolean);
        protected var wasLastFrameGpu:Boolean = false;
        public var isPetYard:Boolean = false;
        public var isQuestRoom:Boolean = false;


        public function setProps(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean):void
        {
        }

        public function setHitAreaProps(_arg_1:int, _arg_2:int):void
        {
        }

        public function addObj(_arg_1:BasicObject, _arg_2:Number, _arg_3:Number):void
        {
        }

        public function setGroundTile(_arg_1:int, _arg_2:int, _arg_3:uint):void
        {
        }

        public function initialize():void
        {
        }

        public function dispose():void
        {
        }

        public function update(_arg_1:int, _arg_2:int):void
        {
        }

        public function pSTopW(_arg_1:Number, _arg_2:Number):Point
        {
            return (null);
        }

        public function removeObj(_arg_1:int):void
        {
        }

        public function draw(_arg_1:Camera, _arg_2:int):void
        {
        }

        public function allowPlayerTeleport():Boolean
        {
            return ((!(this.name_ == Map.NEXUS)) && (this.allowPlayerTeleport_));
        }


    }
}//package com.company.assembleegameclient.map

