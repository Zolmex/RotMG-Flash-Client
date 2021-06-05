// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.kabam.view.KabamAccountDetailMediator

package kabam.rotmg.account.kabam.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;

    public class KabamAccountDetailMediator extends Mediator 
    {

        [Inject]
        public var account:Account;
        [Inject]
        public var view:KabamAccountDetailDialog;
        [Inject]
        public var closeDialog:CloseDialogsSignal;


        override public function initialize():void
        {
            this.view.done.add(this.onDone);
            this.view.setInfo(this.account.getUserName());
        }

        override public function destroy():void
        {
            this.view.done.remove(this.onDone);
        }

        private function onDone():void
        {
            this.closeDialog.dispatch();
        }


    }
}//package kabam.rotmg.account.kabam.view

