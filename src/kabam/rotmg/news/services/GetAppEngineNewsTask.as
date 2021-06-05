// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.news.services.GetAppEngineNewsTask

package kabam.rotmg.news.services
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.news.model.NewsModel;
    import kabam.rotmg.language.model.LanguageModel;
    import flash.utils.getTimer;
    import kabam.rotmg.news.model.NewsCellVO;
    import __AS3__.vec.Vector;
    import kabam.rotmg.news.model.NewsCellLinkType;
    import __AS3__.vec.*;

    public class GetAppEngineNewsTask extends BaseTask implements GetNewsTask 
    {

        private static const TEN_MINUTES:int = 600;

        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var model:NewsModel;
        [Inject]
        public var languageModel:LanguageModel;
        private var lastRan:int = -1;
        private var numUpdateAttempts:int = 0;
        private var updateCooldown:int = 600;


        override protected function startTask():void
        {
            this.numUpdateAttempts++;
            if (((this.lastRan == -1) || ((this.lastRan + this.updateCooldown) < (getTimer() / 1000))))
            {
                this.lastRan = (getTimer() / 1000);
                this.client.complete.addOnce(this.onComplete);
                this.client.sendRequest("/app/globalNews", {"language":this.languageModel.getLanguage()});
            }
            else
            {
                completeTask(true);
                reset();
            };
            if ((((!("production".toLowerCase() == "dev")) && (!(this.updateCooldown == 0))) && (this.numUpdateAttempts >= 2)))
            {
                this.updateCooldown = 0;
            };
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.onNewsRequestDone(_arg_2);
            };
            completeTask(_arg_1, _arg_2);
            reset();
        }

        private function onNewsRequestDone(_arg_1:String):void
        {
            var _local_4:Object;
            var _local_2:Vector.<NewsCellVO> = new Vector.<NewsCellVO>();
            var _local_3:Object = JSON.parse(_arg_1);
            for each (_local_4 in _local_3)
            {
                _local_2.push(this.returnNewsCellVO(_local_4));
            };
            this.model.updateNews(_local_2);
        }

        private function returnNewsCellVO(_arg_1:Object):NewsCellVO
        {
            var _local_2:NewsCellVO = new NewsCellVO();
            _local_2.headline = _arg_1.title;
            _local_2.imageURL = _arg_1.image;
            _local_2.linkDetail = _arg_1.linkDetail;
            _local_2.startDate = Number(_arg_1.startTime);
            _local_2.endDate = Number(_arg_1.endTime);
            _local_2.linkType = NewsCellLinkType.parse(_arg_1.linkType);
            _local_2.networks = String(_arg_1.platform).split(",");
            _local_2.priority = uint(_arg_1.priority);
            _local_2.slot = uint(_arg_1.slot);
            return (_local_2);
        }


    }
}//package kabam.rotmg.news.services

