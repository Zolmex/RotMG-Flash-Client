// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.view.NewsLineMediator

package kabam.rotmg.ui.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.screens.GraveyardLine;
    import kabam.rotmg.fame.control.ShowFameViewSignal;
    import kabam.rotmg.fame.model.SimpleFameVO;

    public class NewsLineMediator extends Mediator 
    {

        [Inject]
        public var view:GraveyardLine;
        [Inject]
        public var showFameView:ShowFameViewSignal;


        override public function initialize():void
        {
            this.view.viewCharacterFame.add(this.onViewFame);
        }

        override public function destroy():void
        {
            this.view.viewCharacterFame.remove(this.onViewFame);
        }

        private function onViewFame(_arg_1:int):void
        {
            this.showFameView.dispatch(new SimpleFameVO(this.view.accountId, _arg_1));
        }


    }
}//package kabam.rotmg.ui.view

