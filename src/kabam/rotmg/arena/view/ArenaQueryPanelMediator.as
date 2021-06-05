// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.arena.view.ArenaQueryPanelMediator

package kabam.rotmg.arena.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import io.decagames.rotmg.pets.data.PetsModel;
    import kabam.rotmg.account.core.Account;
    import flash.events.MouseEvent;

    public class ArenaQueryPanelMediator extends Mediator 
    {

        [Inject]
        public var view:ArenaQueryPanel;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var petModel:PetsModel;
        [Inject]
        public var account:Account;


        override public function initialize():void
        {
            this.setEventListeners();
        }

        private function setEventListeners():void
        {
            if (this.view.enterButton)
            {
                this.view.enterButton.addEventListener(MouseEvent.CLICK, this.onButtonLeftClick);
                this.view.infoButton.addEventListener(MouseEvent.CLICK, this.onButtonRightClick);
            }
            else
            {
                this.view.infoButton.addEventListener(MouseEvent.CLICK, this.onButtonRightClick);
            }
        }

        override public function destroy():void
        {
            super.destroy();
        }

        protected function onButtonRightClick(_arg_1:MouseEvent):void
        {
            this.openDialog.dispatch(new HostQueryDialog());
        }

        protected function onButtonLeftClick(_arg_1:MouseEvent):void
        {
            this.openDialog.dispatch(new ArenaLeaderboard());
        }


    }
}//package kabam.rotmg.arena.view

