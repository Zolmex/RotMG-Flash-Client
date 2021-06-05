// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.transfer.view.KabamLoginMediator

package kabam.rotmg.account.transfer.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.transfer.signals.CheckKabamAccountSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.core.signals.TaskErrorSignal;
    import kabam.rotmg.account.transfer.model.TransferAccountData;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import kabam.lib.tasks.Task;

    public class KabamLoginMediator extends Mediator 
    {

        [Inject]
        public var view:KabamLoginView;
        [Inject]
        public var login:CheckKabamAccountSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var closeDialog:CloseDialogsSignal;
        [Inject]
        public var loginError:TaskErrorSignal;


        override public function initialize():void
        {
            this.view.signIn.add(this.onSignIn);
            this.view.cancel.add(this.onCancel);
            this.view.forgot.add(this.onForgot);
            this.loginError.add(this.onLoginError);
        }

        override public function destroy():void
        {
            this.view.signIn.remove(this.onSignIn);
            this.view.cancel.remove(this.onCancel);
            this.view.forgot.remove(this.onForgot);
            this.loginError.remove(this.onLoginError);
        }

        private function onSignIn(_arg_1:TransferAccountData):void
        {
            this.view.disable();
            this.login.dispatch(_arg_1);
        }

        private function onCancel():void
        {
            this.closeDialog.dispatch();
        }

        private function onForgot():void
        {
            navigateToURL(new URLRequest("https://www.kabam.com/password_resets/new"), "_blank");
        }

        private function onLoginError(_arg_1:Task):void
        {
            this.view.setError(_arg_1.error);
            this.view.enable();
        }


    }
}//package kabam.rotmg.account.transfer.view

