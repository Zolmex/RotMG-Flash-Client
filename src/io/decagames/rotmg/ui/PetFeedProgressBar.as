// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.ui.PetFeedProgressBar

package io.decagames.rotmg.ui
{
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Shape;
    import flash.text.TextFormat;
    import io.decagames.rotmg.pets.data.ability.AbilitiesUtil;
    import com.greensock.TweenMax;
    import com.gskinner.motion.easing.Linear;
    import com.greensock.easing.Expo;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

    public class PetFeedProgressBar extends UIGridElement 
    {

        private const MAX_COLOR:Number = 6538829;

        private var _componentWidth:int;
        private var _componentHeight:int;
        private var _abilityName:String;
        private var _maxValue:int;
        private var _currentValue:int;
        private var _currentLevel:int;
        private var _previousLevel:int;
        private var _maxLevel:int;
        private var _backgroundColor:uint;
        private var _progressBarColor:uint;
        private var _simulationColor:uint;
        private var _abilityLabel:UILabel;
        private var _levelLabel:UILabel;
        private var _maxLabel:UILabel;
        private var _backgroundShape:Shape;
        private var _progressShape:Shape;
        private var _simulationShape:Shape;
        private var _maxShape:Shape;
        private var _simulatedValue:int;
        private var _showMaxLabel:Boolean;
        private var _simulatedValueTextFormat:TextFormat;
        private var _useMaxColor:Boolean;
        private var _animateCurrentProgress:Boolean;
        private var _animateLevelProgress:Boolean;

        public function PetFeedProgressBar(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:uint, _arg_9:uint, _arg_10:uint=0)
        {
            this._componentWidth = _arg_1;
            this._componentHeight = _arg_2;
            this._abilityName = _arg_3;
            this._maxValue = _arg_4;
            this._currentValue = _arg_5;
            this._previousLevel = (this._currentLevel = _arg_6);
            this._maxLevel = _arg_7;
            this._backgroundColor = _arg_8;
            this._progressBarColor = _arg_9;
            this._simulationColor = _arg_10;
            this.init();
        }

        private function init():void
        {
            this._abilityLabel = new UILabel();
            addChild(this._abilityLabel);
            this._abilityLabel.text = this._abilityName;
            this._maxLabel = new UILabel();
            this.createBarShapes();
            this.setLevelLabel(this._currentLevel);
        }

        private function createBarShapes():void
        {
            var _local_1:int;
            _local_1 = 16;
            this._backgroundShape = new Shape();
            this._backgroundShape.graphics.clear();
            this._backgroundShape.graphics.beginFill(this._backgroundColor, 1);
            this._backgroundShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
            this._backgroundShape.y = _local_1;
            addChild(this._backgroundShape);
            this._simulationShape = new Shape();
            this._simulationShape.graphics.beginFill(this._simulationColor, 1);
            this._simulationShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
            this._simulationShape.scaleX = 0;
            this._simulationShape.y = _local_1;
            this._simulationShape.visible = false;
            addChild(this._simulationShape);
            this._progressShape = new Shape();
            this._progressShape.graphics.beginFill(this._progressBarColor, 1);
            this._progressShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
            this._progressShape.scaleX = 0;
            this._progressShape.y = _local_1;
            addChild(this._progressShape);
            this._maxShape = new Shape();
            this._maxShape.graphics.beginFill(this.MAX_COLOR, 1);
            this._maxShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
            this._maxShape.scaleX = 0;
            this._maxShape.y = _local_1;
            this._maxShape.visible = false;
            addChild(this._maxShape);
        }

        public function set value(_arg_1:int):void
        {
            if (!this._animateLevelProgress)
            {
                this._animateCurrentProgress = true;
                this.render(this._currentValue, this._currentValue);
                this._currentValue = _arg_1;
                this._simulatedValue = _arg_1;
            }
        }

        public function set simulatedValue(_arg_1:int):void
        {
            this._simulatedValue = _arg_1;
            this.render(this._currentValue, this._simulatedValue);
        }

        override public function resize(_arg_1:int, _arg_2:int=-1):void
        {
            this._componentWidth = _arg_1;
            this.render(this._currentValue, this._simulatedValue);
        }

        private function render(_arg_1:int, _arg_2:int):void
        {
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:Number;
            this._maxShape.visible = false;
            this._simulationShape.visible = false;
            this._progressShape.visible = true;
            this._animateLevelProgress = (this._previousLevel < this._currentLevel);
            var _local_3:* = (_arg_2 > _arg_1);
            var _local_4:int = (this._maxValue - AbilitiesUtil.abilityPowerToMinPoints(this._currentLevel));
            var _local_5:int = (_arg_1 - AbilitiesUtil.abilityPowerToMinPoints(this._currentLevel));
            var _local_6:Number = ((this._currentLevel == this._maxLevel) ? 1 : (_local_5 / _local_4));
            if (this._animateLevelProgress)
            {
                this.setLevelLabel(this._previousLevel);
                this.animateToCurrentLevel();
            }
            else
            {
                this.drawProgress(_local_6);
            }
            if (_local_3)
            {
                if (_arg_2 >= this._maxValue)
                {
                    _local_9 = AbilitiesUtil.abilityPointsToLevel(_arg_2);
                    if (_local_9 >= this._maxLevel)
                    {
                        _local_9 = this._maxLevel;
                        this.drawSimulatedProgress(this._componentWidth, this.MAX_COLOR);
                        this.setLevelLabel(_local_9);
                    }
                    else
                    {
                        _local_10 = AbilitiesUtil.abilityPowerToMinPoints((_local_9 + 1));
                        _local_11 = AbilitiesUtil.abilityPowerToMinPoints(_local_9);
                        _local_8 = (_local_10 - _local_11);
                        _local_7 = (_arg_2 - _local_11);
                        this.drawSimulatedProgress((_local_7 / _local_8));
                        this.setLevelLabel(_local_9);
                    }
                }
                else
                {
                    _local_7 = (_arg_2 - AbilitiesUtil.abilityPowerToMinPoints(this._currentLevel));
                    _local_12 = (_local_7 / _local_4);
                    this.drawSimulatedProgress(_local_12, _local_6);
                }
            }
            this._abilityLabel.x = -2;
        }

        private function animateToCurrentLevel():void
        {
            TweenMax.to(this._progressShape, 0.4, {
                "scaleX":1,
                "ease":Linear.easeNone,
                "onComplete":this.onLevelUpComplete
            });
        }

        private function onLevelUpComplete():void
        {
            this.setLevelLabel(++this._previousLevel);
            if (this._previousLevel < this._currentLevel)
            {
                this._progressShape.scaleX = 0;
                this.animateToCurrentLevel();
            }
            else
            {
                this._progressShape.scaleX = 0;
                this._animateCurrentProgress = true;
                this._animateLevelProgress = false;
                this.render(this._currentValue, this._currentValue);
            }
        }

        private function onLevelUpdateComplete():void
        {
            this._animateCurrentProgress = false;
            this.render(this._currentValue, this._currentValue);
        }

        private function drawProgress(_arg_1:Number):void
        {
            if (_arg_1 > 1)
            {
                _arg_1 = 1;
            }
            if (this._animateCurrentProgress)
            {
                TweenMax.to(this._progressShape, 0.6, {
                    "scaleX":_arg_1,
                    "ease":Expo.easeOut,
                    "onComplete":this.onLevelUpdateComplete
                });
            }
            else
            {
                this._progressShape.scaleX = _arg_1;
                this.setLevelLabel(this._currentLevel);
            }
        }

        private function drawSimulatedProgress(_arg_1:Number, _arg_2:Number=0):void
        {
            if (_arg_2 == 0)
            {
                this._progressShape.visible = false;
            }
            this._simulationShape.visible = true;
            this._simulationShape.scaleX = _arg_1;
        }

        private function setLevelLabel(_arg_1:int):void
        {
            if (this._levelLabel != null)
            {
                removeChild(this._levelLabel);
            }
            this._levelLabel = new UILabel();
            addChild(this._levelLabel);
            if (_arg_1 > this._currentLevel)
            {
                DefaultLabelFormat.petStatLabelRight(this._levelLabel, 6538829);
            }
            else
            {
                DefaultLabelFormat.petStatLabelRight(this._levelLabel, 0xFFFFFF);
            }
            if (_arg_1 < this._maxLevel)
            {
                this._levelLabel.text = _arg_1.toString();
            }
            else
            {
                this._levelLabel.text = "MAX";
                this._maxShape.scaleX = 1;
                this._maxShape.visible = true;
                this._simulationShape.visible = false;
                this._progressShape.visible = false;
            }
            this._levelLabel.x = ((this._componentWidth - this._levelLabel.width) + 2);
        }

        public function get abilityLabel():UILabel
        {
            return (this._abilityLabel);
        }

        public function get levelLabel():UILabel
        {
            return (this._levelLabel);
        }

        public function get value():int
        {
            return (this._currentValue);
        }

        public function get maxValue():int
        {
            return (this._maxValue);
        }

        public function set maxValue(_arg_1:int):void
        {
            this._maxValue = _arg_1;
        }

        public function set simulatedValueTextFormat(_arg_1:TextFormat):void
        {
            this._simulatedValueTextFormat = _arg_1;
        }

        public function set showMaxLabel(_arg_1:Boolean):void
        {
            if (((_arg_1) && (!(this._maxLabel.parent))))
            {
                addChild(this._maxLabel);
            }
            if (((!(_arg_1)) && (this._maxLabel.parent)))
            {
                removeChild(this._maxLabel);
            }
            this._showMaxLabel = _arg_1;
        }

        public function get maxLabel():UILabel
        {
            return (this._maxLabel);
        }

        public function set maxColor(_arg_1:uint):void
        {
            this._useMaxColor = true;
        }

        public function set currentLevel(_arg_1:int):void
        {
            this._previousLevel = this._currentLevel;
            this._currentLevel = _arg_1;
        }

        public function set maxLevel(_arg_1:int):void
        {
            this._maxLevel = _arg_1;
        }


    }
}//package io.decagames.rotmg.ui

