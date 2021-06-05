// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.components.petSkinSlot.PetSkinSlotMediator

package io.decagames.rotmg.pets.components.petSkinSlot
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.pets.components.petIcon.PetIconFactory;
    import io.decagames.rotmg.pets.signals.SelectPetSkinSignal;
    import flash.events.MouseEvent;
    import io.decagames.rotmg.pets.data.vo.IPetVO;

    public class PetSkinSlotMediator extends Mediator 
    {

        [Inject]
        public var view:PetSkinSlot;
        [Inject]
        public var petIconFactory:PetIconFactory;
        [Inject]
        public var selectPetSkin:SelectPetSkinSignal;


        override public function initialize():void
        {
            if (this.view.skinVO)
            {
                this.view.addSkin(this.petIconFactory.getPetSkinTexture(this.view.skinVO, 40, this.view.skinVO.rarity.color));
            }
            if (this.view.isSkinSelectableSlot)
            {
                if (this.view.skinVO.isOwned)
                {
                    this.view.addEventListener(MouseEvent.CLICK, this.onSelectSkin);
                }
                this.selectPetSkin.add(this.onSkinSelected);
            }
            this.view.updatedVOSignal.add(this.onPetUpdated);
        }

        private function onPetUpdated():void
        {
            if (!this.view.manualUpdate)
            {
                this.view.addSkin(((this.view.skinVO == null) ? null : this.petIconFactory.getPetSkinTexture(this.view.skinVO, 40)));
            }
        }

        private function onSelectSkin(_arg_1:MouseEvent):void
        {
            this.view.skinVO.isNew = false;
            this.view.clearNewLabel();
            this.selectPetSkin.dispatch(this.view.skinVO);
        }

        private function onSkinSelected(_arg_1:IPetVO):void
        {
            this.view.selected = (_arg_1.skinType == this.view.skinVO.skinType);
        }

        override public function destroy():void
        {
            if (this.view.isSkinSelectableSlot)
            {
                this.view.removeEventListener(MouseEvent.CLICK, this.onSelectSkin);
                this.selectPetSkin.remove(this.onSkinSelected);
            }
            this.view.updatedVOSignal.remove(this.onPetUpdated);
        }


    }
}//package io.decagames.rotmg.pets.components.petSkinSlot

