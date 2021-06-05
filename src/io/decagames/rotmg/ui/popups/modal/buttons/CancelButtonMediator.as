﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.buttons.CancelButtonMediator

package io.decagames.rotmg.ui.popups.modal.buttons
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class CancelButtonMediator extends Mediator 
    {

        [Inject]
        public var closeSignal:CloseCurrentPopupSignal;
        [Inject]
        public var view:ClosePopupButton;


        override public function initialize():void
        {
            this.view.clickSignal.addOnce(this.onCancelHandler);
        }

        override public function destroy():void
        {
            this.view.clickSignal.remove(this.onCancelHandler);
        }

        private function onCancelHandler(_arg_1:BaseButton):void
        {
            this.closeSignal.dispatch();
        }


    }
}//package io.decagames.rotmg.ui.popups.modal.buttons

