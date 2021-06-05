// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.core.view.ScreensMediator

package kabam.rotmg.core.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.core.model.ScreenModel;
    import kabam.rotmg.core.signals.GotoPreviousScreenSignal;
    import flash.display.Sprite;

    public class ScreensMediator extends Mediator 
    {

        [Inject]
        public var view:ScreensView;
        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var model:ScreenModel;
        [Inject]
        public var gotoPrevious:GotoPreviousScreenSignal;


        override public function initialize():void
        {
            this.setScreen.add(this.onSetScreen);
            this.gotoPrevious.add(this.onGotoPrevious);
        }

        override public function destroy():void
        {
            this.setScreen.remove(this.onSetScreen);
            this.gotoPrevious.add(this.onGotoPrevious);
        }

        private function onSetScreen(_arg_1:Sprite):void
        {
            this.model.setCurrentScreenType((Object(_arg_1).constructor as Class));
            this.view.setScreen(_arg_1);
        }

        private function onGotoPrevious():void
        {
            this.view.setScreen(this.view.getPrevious());
        }


    }
}//package kabam.rotmg.core.view

