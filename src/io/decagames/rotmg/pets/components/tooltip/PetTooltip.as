// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.components.tooltip.PetTooltip

package io.decagames.rotmg.pets.components.tooltip
{
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import flash.display.Sprite;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
    import com.company.assembleegameclient.ui.LineBreakDesign;
    import flash.display.Bitmap;
    import io.decagames.rotmg.pets.data.vo.IPetVO;
    import kabam.rotmg.ui.model.TabStripModel;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import io.decagames.rotmg.pets.data.family.PetFamilyKeys;
    import io.decagames.rotmg.pets.data.family.PetFamilyColors;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
    import io.decagames.rotmg.pets.utils.PetsConstants;
    import io.decagames.rotmg.pets.data.vo.AbilityVO;
    import io.decagames.rotmg.pets.components.petStatsGrid.PetStatsGrid;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;

    public class PetTooltip extends ToolTip 
    {

        private const petsContent:Sprite = new Sprite();
        private const titleTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 16, true);
        private const petRarityTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 12, false);
        private const petFamilyTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 12, false);
        private const petProbabilityInfoField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 12, false);
        private const lineBreak:LineBreakDesign = PetsViewAssetFactory.returnTooltipLineBreak();

        private var petBitmap:Bitmap;
        private var petVO:IPetVO;

        public function PetTooltip(_arg_1:IPetVO)
        {
            this.petVO = _arg_1;
            super(0x363636, 1, 0xFFFFFF, 1, true);
            this.petsContent.name = TabStripModel.PETS;
        }

        public function init():void
        {
            this.petBitmap = this.petVO.getSkinBitmap();
            this.addChildren();
            if (this.hasAbilities)
            {
                this.addAbilities();
            };
            this.positionChildren();
            this.updateTextFields();
        }

        private function updateTextFields():void
        {
            this.titleTextField.setColor(this.petVO.rarity.color);
            this.titleTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.name));
            this.petRarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.rarity.rarityKey));
            this.petFamilyTextField.setStringBuilder(new LineBuilder().setParams(PetFamilyKeys.getTranslationKey(this.petVO.family))).setColor(PetFamilyColors.getColorByFamilyKey(this.petVO.family));
            this.petProbabilityInfoField.setHTML(true).setText(this.getProbabilityTip());
        }

        private function getProbabilityTip():String
        {
            var _local_1:XML = ObjectLibrary.xmlLibrary_[this.petVO.getType()];
            if (_local_1 == null)
            {
                return ("");
            };
            if (_local_1.hasOwnProperty("NoHatchOrFuse"))
            {
                return (this.makeProbabilityTipLine("not", TooltipHelper.WORSE_COLOR));
            };
            if (_local_1.hasOwnProperty("BasicPet"))
            {
                return (this.makeProbabilityTipLine("commonly", TooltipHelper.BETTER_COLOR));
            };
            return (this.makeProbabilityTipLine("rarely", TooltipHelper.NO_DIFF_COLOR));
        }

        private function makeProbabilityTipLine(_arg_1:String, _arg_2:uint):String
        {
            return (("Can " + TooltipHelper.wrapInFontTag(_arg_1, ("#" + _arg_2.toString(16)))) + " be obtained\nthrough hatching or fusion.");
        }

        private function addChildren():void
        {
            this.clearChildren();
            this.petsContent.graphics.beginFill(0, 0);
            this.petsContent.graphics.drawRect(0, 0, PetsConstants.TOOLTIP_WIDTH, ((this.hasAbilities) ? PetsConstants.TOOLTIP_HEIGHT : PetsConstants.TOOLTIP_HEIGHT_NO_ABILITIES));
            this.petsContent.addChild(this.petBitmap);
            this.petsContent.addChild(this.titleTextField);
            this.petsContent.addChild(this.petRarityTextField);
            this.petsContent.addChild(this.petFamilyTextField);
            this.petsContent.addChild(this.petProbabilityInfoField);
            if (this.hasAbilities)
            {
                this.petsContent.addChild(this.lineBreak);
            };
            if (!contains(this.petsContent))
            {
                addChild(this.petsContent);
            };
        }

        private function clearChildren():void
        {
            this.petsContent.graphics.clear();
            while (this.petsContent.numChildren > 0)
            {
                this.petsContent.removeChildAt(0);
            };
        }

        private function get hasAbilities():Boolean
        {
            var _local_1:AbilityVO;
            for each (_local_1 in this.petVO.abilityList)
            {
                if (((_local_1.getUnlocked()) && (_local_1.level > 0)))
                {
                    return (true);
                };
            };
            return (false);
        }

        private function addAbilities():void
        {
            var _local_1:UIGrid = new PetStatsGrid(178, this.petVO);
            this.petsContent.addChild(_local_1);
            _local_1.y = 104;
            _local_1.x = 2;
        }

        private function getNumAbilities():uint
        {
            var _local_1:Boolean = ((this.petVO.rarity.rarityKey == PetRarityEnum.DIVINE.rarityKey) || (this.petVO.rarity.rarityKey == PetRarityEnum.LEGENDARY.rarityKey));
            if (_local_1)
            {
                return (2);
            };
            return (3);
        }

        private function positionChildren():void
        {
            this.titleTextField.x = 55;
            this.titleTextField.y = 21;
            this.petRarityTextField.x = 55;
            this.petRarityTextField.y = 35;
            this.petFamilyTextField.x = 55;
            this.petFamilyTextField.y = 48;
            this.petProbabilityInfoField.x = 0;
            this.petProbabilityInfoField.y = 54;
        }


    }
}//package io.decagames.rotmg.pets.components.tooltip

