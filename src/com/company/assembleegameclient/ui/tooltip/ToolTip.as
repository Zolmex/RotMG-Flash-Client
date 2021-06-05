﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.tooltip.ToolTip

package com.company.assembleegameclient.ui.tooltip
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsStroke;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.GraphicsPath;
    
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;
    import kabam.rotmg.ui.view.SignalWaiter;
    import flash.filters.DropShadowFilter;
    import flash.events.Event;
    import flash.events.MouseEvent;
    

    public class ToolTip extends Sprite 
    {

        private var background_:uint;
        private var backgroundAlpha_:Number;
        private var outline_:uint;
        private var outlineAlpha_:Number;
        private var _followMouse:Boolean;
        private var forcePositionLeft_:Boolean = false;
        private var forcePositionRight_:Boolean = false;
        public var contentWidth_:int;
        public var contentHeight_:int;
        private var targetObj:DisplayObject;

        private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0, 1);
        private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
        private var lineStyle_:GraphicsStroke = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_);
        private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        protected const waiter:SignalWaiter = new SignalWaiter();

        public function ToolTip(_arg_1:uint, _arg_2:Number, _arg_3:uint, _arg_4:Number, _arg_5:Boolean=true)
        {
            this.background_ = _arg_1;
            this.backgroundAlpha_ = _arg_2;
            this.outline_ = _arg_3;
            this.outlineAlpha_ = _arg_4;
            this._followMouse = _arg_5;
            mouseEnabled = false;
            mouseChildren = false;
            filters = [new DropShadowFilter(0, 0, 0, 1, 16, 16)];
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            this.waiter.complete.add(this.alignUIAndDraw);
        }

        private function alignUIAndDraw():void
        {
            this.alignUI();
            this.draw();
            this.position();
        }

        protected function alignUI():void
        {
        }

        public function attachToTarget(_arg_1:DisplayObject):void
        {
            if (_arg_1)
            {
                this.targetObj = _arg_1;
                this.targetObj.addEventListener(MouseEvent.ROLL_OUT, this.onLeaveTarget);
            }
        }

        public function detachFromTarget():void
        {
            if (this.targetObj)
            {
                this.targetObj.removeEventListener(MouseEvent.ROLL_OUT, this.onLeaveTarget);
                if (parent)
                {
                    parent.removeChild(this);
                }
                this.targetObj = null;
            }
        }

        public function forcePostionLeft():void
        {
            this.forcePositionLeft_ = true;
            this.forcePositionRight_ = false;
        }

        public function forcePostionRight():void
        {
            this.forcePositionRight_ = true;
            this.forcePositionLeft_ = false;
        }

        private function onLeaveTarget(_arg_1:MouseEvent):void
        {
            this.detachFromTarget();
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            if (this.waiter.isEmpty())
            {
                this.draw();
            }
            if (this._followMouse)
            {
                this.position();
                addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            }
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            if (this._followMouse)
            {
                removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            }
        }

        private function onEnterFrame(_arg_1:Event):void
        {
            this.position();
        }

        protected function position():void
        {
            if (stage == null)
            {
                return;
            }
            if ((((!(this.forcePositionLeft_)) && (stage.mouseX < (stage.stageWidth / 2))) || (this.forcePositionRight_)))
            {
                x = (stage.mouseX + 12);
            }
            else
            {
                x = ((stage.mouseX - width) - 1);
            }
            if (x < 12)
            {
                x = 12;
            }
            if ((((!(this.forcePositionLeft_)) && (stage.mouseY < (stage.stageHeight / 3))) || (this.forcePositionRight_)))
            {
                y = (stage.mouseY + 12);
            }
            else
            {
                y = ((stage.mouseY - height) - 1);
            }
            if (y < 12)
            {
                y = 12;
            }
        }

        public function draw():void
        {
            this.backgroundFill_.color = this.background_;
            this.backgroundFill_.alpha = this.backgroundAlpha_;
            this.outlineFill_.color = this.outline_;
            this.outlineFill_.alpha = this.outlineAlpha_;
            graphics.clear();
            this.contentWidth_ = width;
            this.contentHeight_ = height;
            GraphicsUtil.clearPath(this.path_);
            GraphicsUtil.drawCutEdgeRect(-6, -6, (this.contentWidth_ + 12), (this.contentHeight_ + 12), 4, [1, 1, 1, 1], this.path_);
            graphics.drawGraphicsData(this.graphicsData_);
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

