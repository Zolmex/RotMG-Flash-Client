// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.web.services.WebSendPasswordReminderTask

package kabam.rotmg.account.web.services
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.services.SendPasswordReminderTask;
    import kabam.rotmg.core.signals.TrackEventSignal;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.service.TrackingData;

    public class WebSendPasswordReminderTask extends BaseTask implements SendPasswordReminderTask 
    {

        [Inject]
        public var email:String;
        [Inject]
        public var track:TrackEventSignal;
        [Inject]
        public var client:AppEngineClient;


        override protected function startTask():void
        {
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/account/forgotPassword", {"guid":this.email});
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.onForgotDone();
            }
            else
            {
                this.onForgotError(_arg_2);
            }
        }

        private function onForgotDone():void
        {
            this.trackPasswordReminder();
            completeTask(true);
        }

        private function trackPasswordReminder():void
        {
            var _local_1:TrackingData = new TrackingData();
            _local_1.category = "account";
            _local_1.action = "passwordSent";
        }

        private function onForgotError(_arg_1:String):void
        {
            completeTask(false, _arg_1);
        }


    }
}//package kabam.rotmg.account.web.services

