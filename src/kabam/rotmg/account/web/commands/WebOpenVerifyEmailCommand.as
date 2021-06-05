// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.web.commands.WebOpenVerifyEmailCommand

package kabam.rotmg.account.web.commands
{
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.ui.signals.PollVerifyEmailSignal;
    import kabam.rotmg.account.web.view.WebVerifyEmailDialog;

    public class WebOpenVerifyEmailCommand 
    {

        [Inject]
        public var account:Account;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var pollVerifyEmailSignal:PollVerifyEmailSignal;


        public function execute():void
        {
            if (!this.account.isVerified())
            {
                this.openDialog.dispatch(new WebVerifyEmailDialog());
                this.pollVerifyEmailSignal.dispatch();
            }
        }


    }
}//package kabam.rotmg.account.web.commands

