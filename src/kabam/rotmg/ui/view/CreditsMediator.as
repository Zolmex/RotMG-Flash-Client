// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.view.CreditsMediator

package kabam.rotmg.ui.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.screens.CreditsScreen;
    import kabam.rotmg.core.signals.SetScreenSignal;

    public class CreditsMediator extends Mediator 
    {

        [Inject]
        public var view:CreditsScreen;
        [Inject]
        public var setScreen:SetScreenSignal;


        override public function initialize():void
        {
            this.view.close.add(this.onCreditsScreenDone);
            this.view.initialize();
        }

        override public function destroy():void
        {
            this.view.close.remove(this.onCreditsScreenDone);
        }

        private function onCreditsScreenDone():void
        {
            this.setScreen.dispatch(new TitleView());
        }


    }
}//package kabam.rotmg.ui.view

