// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.commands.PollVerifyEmailCommand

package kabam.rotmg.ui.commands
{
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import flash.utils.Timer;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.StaticInjectorContext;
    import com.company.util.MoreObjectUtil;
    import flash.events.TimerEvent;

    public class PollVerifyEmailCommand 
    {

        [Inject]
        public var account:Account;
        [Inject]
        public var closeDialog:CloseDialogsSignal;
        private var _pollTimer:Timer;
        private var _params:Object;
        private var _aeClient:AppEngineClient;


        public function execute():void
        {
            this._aeClient = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
            this._params = {};
            MoreObjectUtil.addToObject(this._params, this.account.getCredentials());
            this.setupTimer();
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            var _local_3:XML = new XML(_arg_2);
            var _local_4:* = (_local_3 == "True");
            if (((_arg_1) && (_local_4)))
            {
                this._pollTimer.stop();
                this.removeTimerListeners();
                this.account.verify(_local_4);
                this.closeDialog.dispatch();
            };
        }

        private function setupTimer():void
        {
            this._pollTimer = new Timer(30000, 10);
            this._pollTimer.addEventListener(TimerEvent.TIMER, this.onTimer);
            this._pollTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this._pollTimer.start();
        }

        private function onTimerComplete(_arg_1:TimerEvent):void
        {
            this.removeTimerListeners();
        }

        private function removeTimerListeners():void
        {
            this._pollTimer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this._pollTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
        }

        private function onTimer(_arg_1:TimerEvent):void
        {
            this._aeClient.complete.addOnce(this.onComplete);
            this._aeClient.sendRequest("account/isEmailVerified", this._params);
        }


    }
}//package kabam.rotmg.ui.commands

