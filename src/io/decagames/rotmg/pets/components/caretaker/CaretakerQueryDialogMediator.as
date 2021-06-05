// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.components.caretaker.CaretakerQueryDialogMediator

package io.decagames.rotmg.pets.components.caretaker
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.pets.data.PetsModel;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
    import flash.display.BitmapData;

    public class CaretakerQueryDialogMediator extends Mediator 
    {

        [Inject]
        public var view:CaretakerQueryDialog;
        [Inject]
        public var model:PetsModel;
        [Inject]
        public var closeDialogs:CloseDialogsSignal;


        override public function initialize():void
        {
            this.view.closed.addOnce(this.onClosed);
            this.view.setCaretakerIcon(this.makeCaretakerIcon());
        }

        private function makeCaretakerIcon():BitmapData
        {
            var _local_1:int = this.model.getPetYardObjectID();
            return (PetsViewAssetFactory.returnCaretakerBitmap(_local_1).bitmapData);
        }

        override public function destroy():void
        {
            this.view.closed.removeAll();
        }

        private function onClosed():void
        {
            this.closeDialogs.dispatch();
        }


    }
}//package io.decagames.rotmg.pets.components.caretaker

