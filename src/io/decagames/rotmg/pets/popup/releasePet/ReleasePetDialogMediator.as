// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.popup.releasePet.ReleasePetDialogMediator

package io.decagames.rotmg.pets.popup.releasePet
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.pets.signals.ReleasePetSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class ReleasePetDialogMediator extends Mediator 
    {

        [Inject]
        public var view:ReleasePetDialog;
        [Inject]
        public var release:ReleasePetSignal;
        [Inject]
        public var close:ClosePopupSignal;


        override public function initialize():void
        {
            this.view.releaseButton.clickSignal.add(this.onRelease);
        }

        override public function destroy():void
        {
            this.view.releaseButton.clickSignal.remove(this.onRelease);
        }

        private function onRelease(_arg_1:BaseButton):void
        {
            this.release.dispatch(this.view.petId);
            this.close.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.pets.popup.releasePet

