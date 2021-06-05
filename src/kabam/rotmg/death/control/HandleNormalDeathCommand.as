// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.death.control.HandleNormalDeathCommand

package kabam.rotmg.death.control
{
    import kabam.rotmg.messaging.impl.incoming.Death;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.core.signals.TrackEventSignal;
    import kabam.rotmg.account.core.services.GetCharListTask;
    import kabam.rotmg.fame.control.ShowFameViewSignal;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.fame.model.FameVO;
    import kabam.rotmg.fame.model.SimpleFameVO;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import kabam.rotmg.core.service.TrackingData;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.lib.tasks.TaskSequence;
    import kabam.lib.tasks.DispatchSignalTask;

    public class HandleNormalDeathCommand 
    {

        [Inject]
        public var death:Death;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var track:TrackEventSignal;
        [Inject]
        public var task:GetCharListTask;
        [Inject]
        public var showFame:ShowFameViewSignal;
        [Inject]
        public var monitor:TaskMonitor;
        private var fameVO:FameVO;


        public function execute():void
        {
            this.fameVO = new SimpleFameVO(this.death.accountId_, this.death.charId_);
            this.trackDeath();
            this.updateParameters();
            this.gotoFameView();
        }

        private function trackDeath():void
        {
            var _local_1:SavedCharacter = this.player.getCharById(this.death.charId_);
            var _local_2:int = ((_local_1) ? _local_1.level() : 0);
            var _local_3:TrackingData = new TrackingData();
            _local_3.category = "killedBy";
            _local_3.action = this.death.killedBy_;
            _local_3.value = _local_2;
        }

        private function updateParameters():void
        {
            Parameters.data_.needsRandomRealm = false;
            Parameters.save();
        }

        private function gotoFameView():void
        {
            if (this.player.getAccountId() == "")
            {
                this.gotoFameViewOnceDataIsLoaded();
            }
            else
            {
                this.showFame.dispatch(this.fameVO);
            };
        }

        private function gotoFameViewOnceDataIsLoaded():void
        {
            var _local_1:TaskSequence = new TaskSequence();
            _local_1.add(this.task);
            _local_1.add(new DispatchSignalTask(this.showFame, this.fameVO));
            this.monitor.add(_local_1);
            _local_1.start();
        }


    }
}//package kabam.rotmg.death.control

