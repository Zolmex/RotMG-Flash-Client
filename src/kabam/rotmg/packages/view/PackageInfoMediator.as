// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.packages.view.PackageInfoMediator

package kabam.rotmg.packages.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;

    public class PackageInfoMediator extends Mediator 
    {

        [Inject]
        public var view:PackageInfoDialog;
        [Inject]
        public var closeDialogs:CloseDialogsSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var flushStartupQueue:FlushPopupStartupQueueSignal;


        override public function initialize():void
        {
            this.view.closed.add(this.onClosed);
        }

        override public function destroy():void
        {
            this.view.closed.remove(this.onClosed);
        }

        private function onClosed():void
        {
            this.closeDialogs.dispatch();
            this.flushStartupQueue.dispatch();
        }


    }
}//package kabam.rotmg.packages.view

