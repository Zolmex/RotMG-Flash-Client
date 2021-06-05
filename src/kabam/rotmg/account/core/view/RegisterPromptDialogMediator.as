﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.core.view.RegisterPromptDialogMediator

package kabam.rotmg.account.core.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;

    public class RegisterPromptDialogMediator extends Mediator 
    {

        [Inject]
        public var view:RegisterPromptDialog;
        [Inject]
        public var openAccountManagement:OpenAccountInfoSignal;
        [Inject]
        public var close:CloseDialogsSignal;


        override public function initialize():void
        {
            this.view.cancel.add(this.onCancel);
            this.view.register.add(this.onRegister);
        }

        override public function destroy():void
        {
            this.view.cancel.remove(this.onCancel);
            this.view.register.remove(this.onRegister);
        }

        private function onRegister():void
        {
            this.onCancel();
            this.openAccountManagement.dispatch();
        }

        private function onCancel():void
        {
            this.close.dispatch();
        }


    }
}//package kabam.rotmg.account.core.view

