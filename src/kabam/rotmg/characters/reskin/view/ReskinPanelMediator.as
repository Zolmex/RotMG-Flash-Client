// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.characters.reskin.view.ReskinPanelMediator

package kabam.rotmg.characters.reskin.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.characters.reskin.control.OpenReskinDialogSignal;

    public class ReskinPanelMediator extends Mediator 
    {

        [Inject]
        public var view:ReskinPanel;
        [Inject]
        public var openReskinDialog:OpenReskinDialogSignal;


        override public function initialize():void
        {
            this.view.reskin.add(this.onReskin);
        }

        override public function destroy():void
        {
            this.view.reskin.remove(this.onReskin);
        }

        private function onReskin():void
        {
            this.openReskinDialog.dispatch();
        }


    }
}//package kabam.rotmg.characters.reskin.view

