// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.components.petStatsGrid.PetFeedStatsGrid

package io.decagames.rotmg.pets.components.petStatsGrid
{
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.pets.data.vo.IPetVO;
    
    import io.decagames.rotmg.ui.PetFeedProgressBar;
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.pets.components.petInfoSlot.PetInfoSlot;
    import io.decagames.rotmg.pets.data.vo.AbilityVO;
    import io.decagames.rotmg.pets.data.ability.AbilitiesUtil;
    import flash.text.TextFormatAlign;
    

    public class PetFeedStatsGrid extends UIGrid 
    {

        private var _petVO:IPetVO;
        private var abilityBars:Vector.<PetFeedProgressBar>;
        private var _labelContainer:Sprite;
        private var _plusLabels:Vector.<UILabel>;
        private var _currentLevels:Vector.<int>;
        private var _maxLevel:int;

        public function PetFeedStatsGrid(_arg_1:int, _arg_2:IPetVO)
        {
            super(_arg_1, 1, 3);
            this._petVO = _arg_2;
            this.init();
        }

        private function init():void
        {
            this.abilityBars = new Vector.<PetFeedProgressBar>();
            this._currentLevels = new Vector.<int>(0);
            this._labelContainer = new Sprite();
            this._labelContainer.x = -2;
            this._labelContainer.y = -13;
            this._labelContainer.visible = false;
            addChild(this._labelContainer);
            this.createLabels();
            this.createPlusLabels();
            if (this._petVO)
            {
                this._maxLevel = this._petVO.maxAbilityPower;
                this.refreshAbilities(this._petVO);
            }
        }

        private function createPlusLabels():void
        {
            var _local_1:int;
            var _local_2:UILabel;
            this._plusLabels = new Vector.<UILabel>(0);
            _local_1 = 0;
            while (_local_1 < 3)
            {
                _local_2 = new UILabel();
                DefaultLabelFormat.petStatLabelRight(_local_2, 6538829);
                _local_2.x = (PetInfoSlot.FEED_STATS_WIDTH + 8);
                _local_2.y = (_local_1 * 23);
                _local_2.visible = false;
                addChild(_local_2);
                this._plusLabels.push(_local_2);
                _local_1++;
            }
        }

        private function createLabels():void
        {
            var _local_2:UILabel;
            var _local_1:UILabel = new UILabel();
            DefaultLabelFormat.petStatLabelLeftSmall(_local_1, 0xA2A2A2);
            _local_1.text = "Ability";
            _local_1.y = -3;
            this._labelContainer.addChild(_local_1);
            _local_2 = new UILabel();
            DefaultLabelFormat.petStatLabelRightSmall(_local_2, 0xA2A2A2);
            _local_2.text = "Level";
            _local_2.x = ((195 - _local_2.width) + 4);
            _local_2.y = -3;
            this._labelContainer.addChild(_local_2);
        }

        public function renderSimulation(_arg_1:Array):void
        {
            var _local_3:AbilityVO;
            var _local_2:int;
            for each (_local_3 in _arg_1)
            {
                this.renderAbilitySimulation(_local_3, _local_2);
                _local_2++;
            }
        }

        private function refreshAbilities(_arg_1:IPetVO):void
        {
            var _local_2:int;
            var _local_3:AbilityVO;
            this._currentLevels.length = 0;
            this._maxLevel = this._petVO.maxAbilityPower;
            this._labelContainer.visible = true;
            _local_2 = 0;
            for each (_local_3 in _arg_1.abilityList)
            {
                this._currentLevels.push(_local_3.level);
                this._plusLabels[_local_2].text = "";
                this._plusLabels[_local_2].visible = false;
                this.renderAbility(_local_3, _local_2);
                _local_2++;
            }
        }

        private function renderAbilitySimulation(_arg_1:AbilityVO, _arg_2:int):void
        {
            var _local_3:PetFeedProgressBar;
            if (_arg_1.getUnlocked())
            {
                _local_3 = this.abilityBars[_arg_2];
                _local_3.maxLevel = this._maxLevel;
                _local_3.simulatedValue = _arg_1.points;
                if ((_arg_1.level - this._currentLevels[_arg_2]) > 0)
                {
                    this._plusLabels[_arg_2].text = ("+" + (_arg_1.level - this._currentLevels[_arg_2]));
                    this._plusLabels[_arg_2].visible = true;
                }
                else
                {
                    this._plusLabels[_arg_2].visible = false;
                }
            }
        }

        private function renderAbility(_arg_1:AbilityVO, _arg_2:int):void
        {
            var _local_3:PetFeedProgressBar;
            var _local_4:int = AbilitiesUtil.abilityPowerToMinPoints((_arg_1.level + 1));
            if (this.abilityBars.length > _arg_2)
            {
                _local_3 = this.abilityBars[_arg_2];
                if (_arg_1.getUnlocked())
                {
                    if (((!(_local_3.maxValue == _local_4)) || (!(_local_3.value == _arg_1.points))))
                    {
                        this.updateProgressBarValues(_local_3, _arg_1, _local_4);
                    }
                }
            }
            else
            {
                _local_3 = new PetFeedProgressBar(195, 4, _arg_1.name, _local_4, ((_arg_1.getUnlocked()) ? _arg_1.points : 0), _arg_1.level, this._maxLevel, 0x545454, 15306295, 6538829);
                _local_3.showMaxLabel = true;
                _local_3.maxColor = 6538829;
                DefaultLabelFormat.petStatLabelLeft(_local_3.abilityLabel, 0xFFFFFF);
                DefaultLabelFormat.petStatLabelRight(_local_3.levelLabel, 0xFFFFFF);
                DefaultLabelFormat.petStatLabelRight(_local_3.maxLabel, 6538829, true);
                _local_3.simulatedValueTextFormat = DefaultLabelFormat.createTextFormat(12, 6538829, TextFormatAlign.RIGHT, true);
                this.abilityBars.push(_local_3);
                addGridElement(_local_3);
            }
            if (!_arg_1.getUnlocked())
            {
                _local_3.alpha = 0.4;
            }
            else
            {
                if (_local_3.alpha != 1)
                {
                    _local_3.maxValue = _local_4;
                    _local_3.value = _arg_1.points;
                }
                _local_3.alpha = 1;
            }
        }

        private function updateProgressBarValues(_arg_1:PetFeedProgressBar, _arg_2:AbilityVO, _arg_3:int):void
        {
            _arg_1.maxLevel = this._maxLevel;
            _arg_1.currentLevel = _arg_2.level;
            _arg_1.maxValue = _arg_3;
            _arg_1.value = _arg_2.points;
        }

        public function updateVO(_arg_1:IPetVO):void
        {
            if (this._petVO != _arg_1)
            {
                this.abilityBars.length = 0;
                this._labelContainer.visible = false;
                clearGrid();
            }
            this._petVO = _arg_1;
            if (this._petVO != null)
            {
                this.refreshAbilities(_arg_1);
            }
        }

        public function get petVO():IPetVO
        {
            return (this._petVO);
        }


    }
}//package io.decagames.rotmg.pets.components.petStatsGrid

