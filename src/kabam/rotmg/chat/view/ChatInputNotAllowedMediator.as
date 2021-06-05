// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.chat.view.ChatInputNotAllowedMediator

package kabam.rotmg.chat.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.chat.model.ChatModel;
    import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.ui.signals.HUDModelInitialized;
    import flash.events.MouseEvent;

    public class ChatInputNotAllowedMediator extends Mediator 
    {

        [Inject]
        public var view:ChatInputNotAllowed;
        [Inject]
        public var model:ChatModel;
        [Inject]
        public var openAccountManagement:OpenAccountInfoSignal;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var hudModelInitialized:HUDModelInitialized;


        override public function initialize():void
        {
            this.view.setup(this.model);
            this.hudModelInitialized.add(this.onHUDModelInitialized);
        }

        private function onHUDModelInitialized():void
        {
            if (((this.hudModel.gameSprite) && (this.hudModel.gameSprite.evalIsNotInCombatMapArea())))
            {
                this.view.addEventListener(MouseEvent.CLICK, this.onClick);
            }
            else
            {
                this.view.mouseEnabled = false;
                this.view.mouseChildren = false;
            };
        }

        override public function destroy():void
        {
            this.view.removeEventListener(MouseEvent.CLICK, this.onClick);
        }

        private function onClick(_arg_1:MouseEvent):void
        {
            this.openAccountManagement.dispatch();
        }


    }
}//package kabam.rotmg.chat.view

