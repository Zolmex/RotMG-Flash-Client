// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.tasks.GetCampaignStatusTask

package io.decagames.rotmg.supportCampaign.tasks
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import robotlegs.bender.framework.api.ILogger;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;

    public class GetCampaignStatusTask extends BaseTask 
    {

        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var logger:ILogger;
        [Inject]
        public var model:SupporterCampaignModel;


        override protected function startTask():void
        {
            this.logger.info("GetCampaignStatus start");
            var _local_1:Object = this.account.getCredentials();
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/supportCampaign/status", _local_1);
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.onCampaignUpdate(_arg_2);
            }
            else
            {
                this.onTextError(_arg_2);
            }
        }

        private function onTextError(_arg_1:String):void
        {
            this.logger.info("GetCampaignStatus error");
            completeTask(true);
        }

        private function onCampaignUpdate(data:String):void
        {
            var xmlData:XML;
            try
            {
                xmlData = new XML(data);
            }
            catch(e:Error)
            {
                logger.error(("Error parsing campaign data: " + data));
                completeTask(true);
                return;
            }
            this.logger.info("GetCampaignStatus update");
            this.logger.info(xmlData);
            this.model.parseConfigData(xmlData);
            completeTask(true);
        }


    }
}//package io.decagames.rotmg.supportCampaign.tasks

