﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.map.partyoverlay.GameObjectArrow

package com.company.assembleegameclient.map.partyoverlay
{
    import flash.display.Sprite;
    import com.company.assembleegameclient.ui.menu.Menu;
    import flash.display.DisplayObjectContainer;
    import com.company.assembleegameclient.objects.GameObject;
    
    import com.company.assembleegameclient.map.Map;
    import flash.display.Shape;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.geom.Rectangle;
    import com.company.util.RectangleUtil;
    import com.company.util.Trig;
    import com.company.assembleegameclient.map.Camera;
    import flash.display.Graphics;
    

    public class GameObjectArrow extends Sprite 
    {

        public static const SMALL_SIZE:int = 8;
        public static const BIG_SIZE:int = 11;
        public static const DIST:int = 3;
        private static var menu_:Menu = null;

        public var menuLayer:DisplayObjectContainer;
        public var lineColor_:uint;
        public var fillColor_:uint;
        public var go_:GameObject = null;
        public var extraGOs_:Vector.<GameObject> = new Vector.<GameObject>();
        public var map_:Map;
        public var mouseOver_:Boolean = false;
        private var big_:Boolean;
        private var arrow_:Shape = new Shape();
        protected var tooltip_:ToolTip = null;
        private var tempPoint:Point = new Point();

        public function GameObjectArrow(_arg_1:uint, _arg_2:uint, _arg_3:Boolean)
        {
            this.lineColor_ = _arg_1;
            this.fillColor_ = _arg_2;
            this.big_ = _arg_3;
            addChild(this.arrow_);
            this.drawArrow();
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
            visible = false;
        }

        public static function removeMenu():void
        {
            if (menu_ != null)
            {
                if (menu_.parent != null)
                {
                    menu_.parent.removeChild(menu_);
                }
                menu_ = null;
            }
        }


        protected function onMouseOver(_arg_1:MouseEvent):void
        {
            this.mouseOver_ = true;
            this.drawArrow();
        }

        protected function onMouseOut(_arg_1:MouseEvent):void
        {
            this.mouseOver_ = false;
            this.drawArrow();
        }

        protected function onMouseDown(_arg_1:MouseEvent):void
        {
            if (Parameters.isGpuRender())
            {
                this.map_.mapHitArea.dispatchEvent(_arg_1);
            }
        }

        protected function setToolTip(_arg_1:ToolTip):void
        {
            this.removeTooltip();
            this.tooltip_ = _arg_1;
            if (this.tooltip_ != null)
            {
                addChild(this.tooltip_);
                this.positionTooltip(this.tooltip_);
            }
        }

        protected function removeTooltip():void
        {
            if (this.tooltip_ != null)
            {
                if (this.tooltip_.parent != null)
                {
                    this.tooltip_.parent.removeChild(this.tooltip_);
                }
                this.tooltip_ = null;
            }
        }

        protected function setMenu(_arg_1:Menu):void
        {
            this.removeTooltip();
            menu_ = _arg_1;
            this.menuLayer.addChild(menu_);
        }

        public function setGameObject(_arg_1:GameObject):void
        {
            if (this.go_ != _arg_1)
            {
                this.go_ = _arg_1;
            }
            this.extraGOs_.length = 0;
            if (this.go_ == null)
            {
                visible = false;
            }
        }

        public function addGameObject(_arg_1:GameObject):void
        {
            this.extraGOs_.push(_arg_1);
        }

        public function draw(_arg_1:int, _arg_2:Camera):void
        {
            var _local_3:Rectangle;
            var _local_4:Number;
            var _local_5:Number;
            if (this.go_ == null)
            {
                visible = false;
                return;
            }
            this.go_.computeSortVal(_arg_2);
            _local_3 = _arg_2.clipRect_;
            _local_4 = this.go_.posS_[0];
            _local_5 = this.go_.posS_[1];
            if (!RectangleUtil.lineSegmentIntersectXY(_arg_2.clipRect_, 0, 0, _local_4, _local_5, this.tempPoint))
            {
                this.go_ = null;
                visible = false;
                return;
            }
            x = this.tempPoint.x;
            y = this.tempPoint.y;
            var _local_6:Number = Trig.boundTo180((270 - (Trig.toDegrees * Math.atan2(_local_4, _local_5))));
            if (this.tempPoint.x < (_local_3.left + 5))
            {
                if (_local_6 > 45)
                {
                    _local_6 = 45;
                }
                if (_local_6 < -45)
                {
                    _local_6 = -45;
                }
            }
            else
            {
                if (this.tempPoint.x > (_local_3.right - 5))
                {
                    if (_local_6 > 0)
                    {
                        if (_local_6 < 135)
                        {
                            _local_6 = 135;
                        }
                    }
                    else
                    {
                        if (_local_6 > -135)
                        {
                            _local_6 = -135;
                        }
                    }
                }
            }
            if (this.tempPoint.y < (_local_3.top + 5))
            {
                if (_local_6 < 45)
                {
                    _local_6 = 45;
                }
                if (_local_6 > 135)
                {
                    _local_6 = 135;
                }
            }
            else
            {
                if (this.tempPoint.y > (_local_3.bottom - 5))
                {
                    if (_local_6 > -45)
                    {
                        _local_6 = -45;
                    }
                    if (_local_6 < -135)
                    {
                        _local_6 = -135;
                    }
                }
            }
            this.arrow_.rotation = _local_6;
            if (this.tooltip_ != null)
            {
                this.positionTooltip(this.tooltip_);
            }
            visible = true;
        }

        private function positionTooltip(_arg_1:ToolTip):void
        {
            var _local_5:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_2:Number = this.arrow_.rotation;
            var _local_3:int = ((DIST + BIG_SIZE) + 12);
            var _local_4:Number = (_local_3 * Math.cos((_local_2 * Trig.toRadians)));
            _local_5 = (_local_3 * Math.sin((_local_2 * Trig.toRadians)));
            var _local_6:Number = _arg_1.contentWidth_;
            var _local_7:Number = _arg_1.contentHeight_;
            if (((_local_2 >= 45) && (_local_2 <= 135)))
            {
                _local_8 = (_local_4 + (_local_6 / Math.tan((_local_2 * Trig.toRadians))));
                _arg_1.x = (((_local_4 + _local_8) / 2) - (_local_6 / 2));
                _arg_1.y = _local_5;
            }
            else
            {
                if (((_local_2 <= -45) && (_local_2 >= -135)))
                {
                    _local_8 = (_local_4 - (_local_6 / Math.tan((_local_2 * Trig.toRadians))));
                    _arg_1.x = (((_local_4 + _local_8) / 2) - (_local_6 / 2));
                    _arg_1.y = (_local_5 - _local_7);
                }
                else
                {
                    if (((_local_2 < 45) && (_local_2 > -45)))
                    {
                        _arg_1.x = _local_4;
                        _local_9 = (_local_5 + (_local_7 * Math.tan((_local_2 * Trig.toRadians))));
                        _arg_1.y = (((_local_5 + _local_9) / 2) - (_local_7 / 2));
                    }
                    else
                    {
                        _arg_1.x = (_local_4 - _local_6);
                        _local_9 = (_local_5 - (_local_7 * Math.tan((_local_2 * Trig.toRadians))));
                        _arg_1.y = (((_local_5 + _local_9) / 2) - (_local_7 / 2));
                    }
                }
            }
        }

        private function drawArrow():void
        {
            var _local_1:Graphics = this.arrow_.graphics;
            _local_1.clear();
            var _local_2:int = (((this.big_) || (this.mouseOver_)) ? BIG_SIZE : SMALL_SIZE);
            _local_1.lineStyle(1, this.lineColor_);
            _local_1.beginFill(this.fillColor_);
            _local_1.moveTo(DIST, 0);
            _local_1.lineTo((_local_2 + DIST), _local_2);
            _local_1.lineTo((_local_2 + DIST), -(_local_2));
            _local_1.lineTo(DIST, 0);
            _local_1.endFill();
            _local_1.lineStyle();
        }


    }
}//package com.company.assembleegameclient.map.partyoverlay

