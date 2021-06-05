﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.PlayerGameObjectListItem

package com.company.assembleegameclient.ui
{
    import kabam.rotmg.tooltips.TooltipAble;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import com.company.assembleegameclient.objects.Player;
    import flash.events.Event;
    import com.company.assembleegameclient.objects.GameObject;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.ui.tooltip.PlayerToolTip;
    import com.company.util.MoreColorUtil;
    import flash.geom.ColorTransform;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;

    public class PlayerGameObjectListItem extends GameObjectListItem implements TooltipAble 
    {

        public const hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();

        private var enabled:Boolean = true;
        private var starred:Boolean = false;

        public function PlayerGameObjectListItem(_arg_1:uint, _arg_2:Boolean, _arg_3:GameObject)
        {
            super(_arg_1, _arg_2, _arg_3);
            var _local_4:Player = (_arg_3 as Player);
            if (_local_4)
            {
                this.starred = _local_4.starred_;
            };
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            this.hoverTooltipDelegate.setDisplayObject(this);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            this.hoverTooltipDelegate.tooltip = ((this.enabled) ? new PlayerToolTip(Player(go)) : null);
        }

        public function setEnabled(_arg_1:Boolean):void
        {
            if (((!(this.enabled == _arg_1)) && (!(Player(go) == null))))
            {
                this.enabled = _arg_1;
                this.hoverTooltipDelegate.tooltip = ((this.enabled) ? new PlayerToolTip(Player(go)) : null);
                if (!this.enabled)
                {
                    this.hoverTooltipDelegate.getShowToolTip().dispatch(this.hoverTooltipDelegate.tooltip);
                };
            };
        }

        override public function draw(_arg_1:GameObject, _arg_2:ColorTransform=null):void
        {
            var _local_3:Player = (_arg_1 as Player);
            if (((_local_3) && (!(this.starred == _local_3.starred_))))
            {
                transform.colorTransform = ((_arg_2) || (MoreColorUtil.identity));
                this.starred = _local_3.starred_;
            };
            super.draw(_arg_1, _arg_2);
        }

        public function setShowToolTipSignal(_arg_1:ShowTooltipSignal):void
        {
            this.hoverTooltipDelegate.setShowToolTipSignal(_arg_1);
        }

        public function getShowToolTip():ShowTooltipSignal
        {
            return (this.hoverTooltipDelegate.getShowToolTip());
        }

        public function setHideToolTipsSignal(_arg_1:HideTooltipsSignal):void
        {
            this.hoverTooltipDelegate.setHideToolTipsSignal(_arg_1);
        }

        public function getHideToolTips():HideTooltipsSignal
        {
            return (this.hoverTooltipDelegate.getHideToolTips());
        }


    }
}//package com.company.assembleegameclient.ui

