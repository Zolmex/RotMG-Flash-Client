// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.core.commands.InternalOpenMoneyWindowCommand

package kabam.rotmg.account.core.commands
{
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.account.core.view.MoneyFrame;

    public class InternalOpenMoneyWindowCommand 
    {

        [Inject]
        public var openDialog:OpenDialogSignal;


        public function execute():void
        {
            this.openDialog.dispatch(new MoneyFrame());
        }


    }
}//package kabam.rotmg.account.core.commands

