// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.panels.mediators.InteractPanelMediator

package com.company.assembleegameclient.ui.panels.mediators
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.ui.panels.InteractPanel;
    import kabam.rotmg.core.model.MapModel;
    import io.decagames.rotmg.pets.data.PetsModel;
    import com.company.assembleegameclient.objects.IInteractiveObject;
    import com.company.assembleegameclient.objects.Pet;

    public class InteractPanelMediator extends Mediator 
    {

        [Inject]
        public var view:InteractPanel;
        [Inject]
        public var mapModel:MapModel;
        [Inject]
        public var petsModel:PetsModel;
        private var currentInteractive:IInteractiveObject;


        override public function initialize():void
        {
            this.view.requestInteractive = this.provideInteractive;
        }

        override public function destroy():void
        {
            super.destroy();
        }

        public function provideInteractive():IInteractiveObject
        {
            if (!this.isMapNameYardName())
            {
                return (this.mapModel.currentInteractiveTarget);
            }
            if (this.doesNewPanelOverrideOld())
            {
                this.currentInteractive = this.mapModel.currentInteractiveTarget;
            }
            return (this.currentInteractive);
        }

        private function doesNewPanelOverrideOld():Boolean
        {
            return ((this.mapModel.currentInteractiveTarget is Pet) ? this.doShowPet() : true);
        }

        private function doShowPet():Boolean
        {
            if (((!(this.currentInteractive)) && (this.isMapNameYardName())))
            {
                return (true);
            }
            if ((((this.currentInteractive is Pet) && (this.isMapNameYardName())) && (!(Pet(this.mapModel.currentInteractiveTarget).vo.getID() == Pet(this.currentInteractive).vo.getID()))))
            {
                return (true);
            }
            return (false);
        }

        private function isMapNameYardName():Boolean
        {
            return (this.view.gs_.map.isPetYard);
        }


    }
}//package com.company.assembleegameclient.ui.panels.mediators

