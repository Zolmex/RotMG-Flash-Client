// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.web.services.WebSendVerificationEmailTask

package kabam.rotmg.account.web.services
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.services.SendConfirmEmailAddressTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.signals.TrackEventSignal;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.service.TrackingData;

    public class WebSendVerificationEmailTask extends BaseTask implements SendConfirmEmailAddressTask 
    {

        [Inject]
        public var account:Account;
        [Inject]
        public var track:TrackEventSignal;
        [Inject]
        public var client:AppEngineClient;


        override protected function startTask():void
        {
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/account/sendVerifyEmail", this.account.getCredentials());
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.onSent();
            }
            else
            {
                this.onError(_arg_2);
            };
        }

        private function onSent():void
        {
            this.trackEmailSent();
            completeTask(true);
        }

        private function trackEmailSent():void
        {
            var _local_1:TrackingData = new TrackingData();
            _local_1.category = "account";
            _local_1.action = "verifyEmailSent";
        }

        private function onError(_arg_1:String):void
        {
            this.account.clear();
            completeTask(false);
        }


    }
}//package kabam.rotmg.account.web.services

