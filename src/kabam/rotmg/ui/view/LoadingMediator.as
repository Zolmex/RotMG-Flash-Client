// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.view.LoadingMediator

package kabam.rotmg.ui.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.screens.LoadingScreen;
    import kabam.rotmg.core.signals.SetLoadingMessageSignal;

    public class LoadingMediator extends Mediator 
    {

        [Inject]
        public var view:LoadingScreen;
        [Inject]
        public var setMessage:SetLoadingMessageSignal;


        override public function initialize():void
        {
            this.setMessage.add(this.onSetMessage);
            this.view.setTextKey("Loading.text");
        }

        override public function destroy():void
        {
            this.setMessage.remove(this.onSetMessage);
        }

        private function onSetMessage(_arg_1:String):void
        {
            this.view.setTextKey(_arg_1);
        }


    }
}//package kabam.rotmg.ui.view

