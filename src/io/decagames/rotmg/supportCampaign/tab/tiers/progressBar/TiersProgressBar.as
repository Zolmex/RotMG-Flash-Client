// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.tab.tiers.progressBar.TiersProgressBar

package io.decagames.rotmg.supportCampaign.tab.tiers.progressBar
{
    import flash.display.Sprite;
    
    import io.decagames.rotmg.supportCampaign.data.vo.RankVO;
    import io.decagames.rotmg.supportCampaign.tab.tiers.button.TierButton;
    import io.decagames.rotmg.ui.ProgressBar;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.supportCampaign.tab.tiers.button.status.TierButtonStatus;
    

    public class TiersProgressBar extends Sprite 
    {

        private var _ranks:Vector.<RankVO>;
        private var _componentWidth:int;
        private var _currentRank:int;
        private var _claimed:int;
        private var buttonAreReady:Boolean;
        private var _buttons:Vector.<TierButton>;
        private var _progressBar:ProgressBar;
        private var _points:int;
        private var supportIcon:SliceScalingBitmap;

        public function TiersProgressBar(_arg_1:Vector.<RankVO>, _arg_2:int)
        {
            this._ranks = _arg_1;
            this._componentWidth = _arg_2;
            this._buttons = new Vector.<TierButton>();
            this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI", "campaign_Points");
        }

        public function show(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            this._currentRank = _arg_2;
            this._claimed = _arg_3;
            this._points = _arg_1;
            if (!this.buttonAreReady)
            {
                this.renderProgressBar();
                this.renderButtons();
            }
            this.updateProgressBar();
            this.updateButtons();
        }

        private function getStatusByTier(_arg_1:int):int
        {
            if (this._claimed >= _arg_1)
            {
                return (TierButtonStatus.CLAIMED);
            }
            if (this._currentRank >= _arg_1)
            {
                return (TierButtonStatus.UNLOCKED);
            }
            return (TierButtonStatus.LOCKED);
        }

        private function updateButtons():void
        {
            var _local_2:TierButton;
            var _local_1:Boolean;
            for each (_local_2 in this._buttons)
            {
                _local_2.updateStatus(this.getStatusByTier(_local_2.tier));
                if (((!(_local_1)) && (this.getStatusByTier(_local_2.tier) == TierButtonStatus.UNLOCKED)))
                {
                    _local_1 = true;
                    _local_2.selected = true;
                }
                else
                {
                    _local_2.selected = false;
                }
            }
            if (!_local_1)
            {
                if (this._currentRank != 0)
                {
                    for each (_local_2 in this._buttons)
                    {
                        if (this._currentRank == _local_2.tier)
                        {
                            _local_1 = true;
                            _local_2.selected = true;
                        }
                    }
                }
            }
            if (!_local_1)
            {
                this._buttons[0].selected = true;
            }
        }

        private function updateProgressBar():void
        {
            var _local_1:int = this._points;
            if (this._progressBar.value != _local_1)
            {
                if (_local_1 > (this._progressBar.maxValue - this._progressBar.minValue))
                {
                    this._progressBar.value = (this._progressBar.maxValue - this._progressBar.minValue);
                }
                else
                {
                    this._progressBar.value = _local_1;
                }
            }
        }

        private function renderProgressBar():void
        {
            this._progressBar = new ProgressBar(this._componentWidth, 4, "", "", 0, this._ranks[(this._ranks.length - 1)].points, 0, 0x545454, 1029573);
            this._progressBar.y = 7;
            this._progressBar.shouldAnimate = false;
            addChild(this._progressBar);
            this.supportIcon.x = -4;
            this.supportIcon.y = 5;
            addChild(this.supportIcon);
        }

        private function renderButtons():void
        {
            var _local_2:RankVO;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:TierButton;
            var _local_8:TierButton;
            var _local_1:int = 1;
            for each (_local_2 in this._ranks)
            {
                _local_7 = new TierButton(_local_1, this.getStatusByTier(_local_1));
                this._buttons.push(_local_7);
                _local_1++;
            }
            _local_3 = this._buttons.length;
            _local_4 = int((this._componentWidth / _local_3));
            _local_5 = 1;
            _local_6 = (_local_3 - 1);
            while (_local_6 >= 0)
            {
                _local_8 = this._buttons[_local_6];
                _local_8.x = (this._componentWidth - (_local_5 * _local_4));
                addChild(_local_8);
                _local_5++;
                _local_6--;
            }
            this.buttonAreReady = true;
        }


    }
}//package io.decagames.rotmg.supportCampaign.tab.tiers.progressBar

