﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.ConfirmationModalMediator

package io.decagames.rotmg.ui.popups.modal
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class ConfirmationModalMediator extends Mediator 
    {

        [Inject]
        public var view:ConfirmationModal;
        [Inject]
        public var closeSignal:CloseCurrentPopupSignal;


        override public function initialize():void
        {
            this.view.confirmButton.clickSignal.addOnce(this.onConfirmClicked);
        }

        private function onConfirmClicked(_arg_1:BaseButton):void
        {
            this.closeSignal.dispatch();
        }

        override public function destroy():void
        {
            this.view.confirmButton.clickSignal.remove(this.onConfirmClicked);
        }


    }
}//package io.decagames.rotmg.ui.popups.modal

