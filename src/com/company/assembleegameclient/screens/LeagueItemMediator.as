// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.LeagueItemMediator

package com.company.assembleegameclient.screens
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.seasonalEvent.signals.ShowSeasonHasEndedPopupSignal;
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class LeagueItemMediator extends Mediator 
    {

        [Inject]
        public var view:LeagueItem;
        [Inject]
        public var showSeasonHasEndedPopupSignal:ShowSeasonHasEndedPopupSignal;
        private var _timer:Timer;


        override public function initialize():void
        {
            if (this.view.endDate)
            {
                this._timer = new Timer(1000);
                this._timer.addEventListener(TimerEvent.TIMER, this.onTime);
                this._timer.start();
            };
        }

        override public function destroy():void
        {
            super.destroy();
            if (this._timer)
            {
                this._timer.removeEventListener(TimerEvent.TIMER, this.onTime);
                this._timer = null;
            };
        }

        private function onTime(_arg_1:TimerEvent):void
        {
            var _local_2:Number = (this.view.endDate.time - new Date().time);
            this.view.updateTimeLabel(_local_2);
            if (_local_2 <= 0)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.onTime);
                this.showSeasonHasEndedPopupSignal.dispatch();
            };
        }


    }
}//package com.company.assembleegameclient.screens

