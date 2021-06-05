// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.tos.popups.buttons.AcceptButtonMediator

package io.decagames.rotmg.tos.popups.buttons
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class AcceptButtonMediator extends Mediator 
    {

        [Inject]
        public var view:AcceptButton;
        [Inject]
        public var appEngineClient:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var closePopupSignal:CloseCurrentPopupSignal;


        override public function initialize():void
        {
            this.view.clickSignal.add(this.onClickHandler);
        }

        override public function destroy():void
        {
            this.view.clickSignal.remove(this.onClickHandler);
        }

        private function onClickHandler(_arg_1:BaseButton):void
        {
            var _local_2:Object = this.account.getCredentials();
            this.appEngineClient.sendRequest("account/acceptTOS", _local_2);
            this.closePopupSignal.dispatch();
        }


    }
}//package io.decagames.rotmg.tos.popups.buttons

