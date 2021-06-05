// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.popup.DailyQuestExpirePopupMediator

package io.decagames.rotmg.dailyQuests.view.popup
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.dailyQuests.signal.CloseExpirePopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import flash.events.MouseEvent;

    public class DailyQuestExpirePopupMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestExpiredPopup;
        [Inject]
        public var closeExpirePopupSignal:CloseExpirePopupSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;


        override public function initialize():void
        {
            this.view.okButton.addEventListener(MouseEvent.CLICK, this.onOK);
        }

        override public function destroy():void
        {
            this.view.okButton.removeEventListener(MouseEvent.CLICK, this.onOK);
        }

        private function onOK(_arg_1:MouseEvent):void
        {
            this.view.okButton.removeEventListener(MouseEvent.CLICK, this.onOK);
            this.closeExpirePopupSignal.dispatch();
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.popup

