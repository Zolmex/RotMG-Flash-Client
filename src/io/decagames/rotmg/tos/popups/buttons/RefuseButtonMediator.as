// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.tos.popups.buttons.RefuseButtonMediator

package io.decagames.rotmg.tos.popups.buttons
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.tos.popups.RefusePopup;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class RefuseButtonMediator extends Mediator 
    {

        [Inject]
        public var view:RefuseButton;
        [Inject]
        public var closePopupSignal:CloseCurrentPopupSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;


        override public function initialize():void
        {
            this.view.clickSignal.add(this.clickHandler);
        }

        override public function destroy():void
        {
            this.view.clickSignal.remove(this.clickHandler);
        }

        private function clickHandler(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch();
            this.showPopupSignal.dispatch(new RefusePopup());
        }


    }
}//package io.decagames.rotmg.tos.popups.buttons

