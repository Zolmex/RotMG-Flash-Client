// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.view.components.StatsMediator

package kabam.rotmg.game.view.components
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.ui.signals.UpdateHUDSignal;
    import kabam.rotmg.ui.view.StatsDockedSignal;
    import com.company.assembleegameclient.objects.Player;
    import flash.events.MouseEvent;

    public class StatsMediator extends Mediator 
    {

        [Inject]
        public var view:StatsView;
        [Inject]
        public var updateHUD:UpdateHUDSignal;
        [Inject]
        public var statsUndocked:StatsUndockedSignal;
        [Inject]
        public var statsDocked:StatsDockedSignal;


        override public function initialize():void
        {
            this.view.mouseDown.add(this.onStatsDrag);
            this.updateHUD.add(this.onUpdateHUD);
            this.statsDocked.add(this.onStatsDock);
        }

        override public function destroy():void
        {
            this.view.mouseDown.remove(this.onStatsDrag);
            this.updateHUD.remove(this.onUpdateHUD);
        }

        private function onUpdateHUD(_arg_1:Player):void
        {
            this.view.draw(_arg_1);
        }

        private function onStatsDrag(_arg_1:MouseEvent):void
        {
            if (this.view.currentState == StatsView.STATE_DOCKED)
            {
                this.view.undock();
                this.statsUndocked.dispatch(this.view);
            }
        }

        private function onStatsDock():void
        {
            this.view.dock();
        }


    }
}//package kabam.rotmg.game.view.components

