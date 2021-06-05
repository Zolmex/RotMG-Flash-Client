// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.tab.tiers.button.TierButton

package io.decagames.rotmg.supportCampaign.tab.tiers.button
{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import com.greensock.TimelineMax;
    import org.osflash.signals.Signal;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.text.TextFieldAutoSize;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import io.decagames.rotmg.supportCampaign.tab.tiers.button.status.TierButtonStatus;
    import com.greensock.TweenMax;
    import com.greensock.easing.Expo;

    public class TierButton extends Sprite 
    {

        private var background:SliceScalingBitmap;
        private var _tier:int;
        private var _status:int;
        private var _selected:Boolean;
        private var tierLabel:UILabel;
        private var tierTween:TimelineMax;
        private var claimTween:TimelineMax;

        private var _removeToolTipSignal:Signal = new Signal();
        private const OUTLINE_FILTER:GlowFilter = new GlowFilter(0xFFFFFF, 1, 3, 3, 16, BitmapFilterQuality.HIGH, false, false);
        private const GLOW_FILTER:GlowFilter = new GlowFilter(409669, 0.4, 2, 2, 16, BitmapFilterQuality.HIGH, false, false);

        public function TierButton(_arg_1:int, _arg_2:int)
        {
            this._tier = _arg_1;
            this._status = _arg_2;
            this.tierLabel = new UILabel();
            this.tierLabel.autoSize = TextFieldAutoSize.NONE;
            this.tierLabel.multiline = false;
            this.tierLabel.wordWrap = false;
            this.tierLabel.mouseEnabled = false;
            this.updateStatus(_arg_2);
        }

        public function updateStatus(_arg_1:int):void
        {
            if (((this.background) && (this.background.parent)))
            {
                removeChild(this.background);
            };
            switch (_arg_1)
            {
                case TierButtonStatus.LOCKED:
                    this.background = TextureParser.instance.getSliceScalingBitmap("UI", "tier_locked");
                    this.background.y = 2;
                    addChildAt(this.background, 0);
                    DefaultLabelFormat.createLabelFormat(this.tierLabel, 12, 0x353535, TextFormatAlign.CENTER, true);
                    this.tierLabel.width = this.background.width;
                    this.tierLabel.height = this.background.height;
                    this.tierLabel.text = this._tier.toString();
                    this.tierLabel.y = 6;
                    break;
                case TierButtonStatus.UNLOCKED:
                    this.background = TextureParser.instance.getSliceScalingBitmap("UI", "tier_unlocked");
                    this.background.y = 2;
                    addChildAt(this.background, 0);
                    DefaultLabelFormat.createLabelFormat(this.tierLabel, 14, 0xFFFFFF, TextFormatAlign.CENTER, true);
                    this.tierLabel.width = this.background.width;
                    this.tierLabel.height = this.background.height;
                    this.tierLabel.text = this._tier.toString();
                    this.tierLabel.y = 5;
                    this.tierLabel.filters = [this.GLOW_FILTER];
                    if (!this.claimTween)
                    {
                        this.claimTween = new TimelineMax({"repeat":-1});
                        this.claimTween.add(TweenMax.to(this, 0.2, {
                            "tint":null,
                            "ease":Expo.easeIn
                        }));
                        this.claimTween.add(TweenMax.to(this, 0.2, {
                            "delay":0.5,
                            "tint":0xFFFFFF
                        }));
                        this.claimTween.add(TweenMax.to(this, 0.5, {
                            "tint":null,
                            "ease":Expo.easeOut
                        }));
                    }
                    else
                    {
                        this.claimTween.play(0);
                    };
                    break;
                case TierButtonStatus.CLAIMED:
                    this.tierLabel.visible = false;
                    this.background = TextureParser.instance.getSliceScalingBitmap("UI", "tier_claimed");
                    this.background.y = 2;
                    addChildAt(this.background, 0);
                    if (this.claimTween)
                    {
                        this.claimTween.pause(0);
                    };
                    this._removeToolTipSignal.dispatch();
                    break;
            };
            addChild(this.tierLabel);
            this.applySelectFilter();
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function set selected(_arg_1:Boolean):void
        {
            this._selected = _arg_1;
            this.applySelectFilter();
        }

        private function applySelectFilter():void
        {
            if (this._selected)
            {
                this.background.filters = [this.OUTLINE_FILTER];
                if (!this.tierTween)
                {
                    this.tierTween = new TimelineMax();
                    this.tierTween.add(TweenMax.to(this, 0.05, {
                        "scaleX":0.9,
                        "scaleY":0.9,
                        "x":(this.x + ((this.width * 0.1) / 2)),
                        "y":(this.y + ((this.height * 0.1) / 2)),
                        "tint":0xFFFFFF
                    }));
                    this.tierTween.add(TweenMax.to(this, 0.3, {
                        "scaleX":1,
                        "scaleY":1,
                        "x":this.x,
                        "y":this.y,
                        "tint":null,
                        "ease":Expo.easeOut
                    }));
                }
                else
                {
                    this.tierTween.play(0);
                };
            }
            else
            {
                this.background.filters = [];
            };
        }

        public function get label():UILabel
        {
            return (this.tierLabel);
        }

        public function get tier():int
        {
            return (this._tier);
        }

        public function get status():int
        {
            return (this._status);
        }

        public function get removeToolTipSignal():Signal
        {
            return (this._removeToolTipSignal);
        }


    }
}//package io.decagames.rotmg.supportCampaign.tab.tiers.button

