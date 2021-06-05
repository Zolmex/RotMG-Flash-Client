// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.external.service.RequestPlayerCreditsTask

package kabam.rotmg.external.service
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.core.model.PlayerModel;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.company.util.MoreObjectUtil;

    public class RequestPlayerCreditsTask extends BaseTask 
    {

        private static const REQUEST:String = "account/getCredits";

        [Inject]
        public var account:Account;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        private var retryTimes:Array = [2, 5, 15];
        private var timer:Timer = new Timer(1000);
        private var retryCount:int = 0;


        override protected function startTask():void
        {
            this.timer.addEventListener(TimerEvent.TIMER, this.handleTimer);
            this.timer.start();
        }

        private function handleTimer(_arg_1:TimerEvent):void
        {
            this.retryTimes[this.retryCount]--;
            if (this.retryTimes[this.retryCount] <= 0)
            {
                this.timer.removeEventListener(TimerEvent.TIMER, this.handleTimer);
                this.makeRequest();
                this.retryCount++;
                this.timer.stop();
            }
        }

        private function makeRequest():void
        {
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest(REQUEST, this.makeRequestObject());
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            var _local_4:String;
            var _local_3:Boolean;
            if (_arg_1)
            {
                _local_4 = XML(_arg_2).toString();
                if (((!(_local_4 == "")) && (!(_local_4.search("Error") == -1))))
                {
                    this.setCredits(int(_local_4));
                }
            }
            else
            {
                if (this.retryCount < this.retryTimes.length)
                {
                    this.timer.addEventListener(TimerEvent.TIMER, this.handleTimer);
                    this.timer.start();
                    _local_3 = true;
                }
            }
            ((!(_local_3)) && (completeTask(_arg_1, _arg_2)));
        }

        private function setCredits(_arg_1:int):void
        {
            if (_arg_1 >= 0)
            {
                if ((((!(this.gameModel == null)) && (!(this.gameModel.player == null))) && (!(_arg_1 == this.gameModel.player.credits_))))
                {
                    this.gameModel.player.setCredits(_arg_1);
                }
                else
                {
                    if (((!(this.playerModel == null)) && (!(this.playerModel.getCredits() == _arg_1))))
                    {
                        this.playerModel.setCredits(_arg_1);
                    }
                }
            }
        }

        private function makeRequestObject():Object
        {
            var _local_1:Object = {}
            MoreObjectUtil.addToObject(_local_1, this.account.getCredentials());
            return (_local_1);
        }


    }
}//package kabam.rotmg.external.service

