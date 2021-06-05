// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.commands.RequestLegacyChallengerListCommand

package io.decagames.rotmg.seasonalEvent.commands
{
    import io.decagames.rotmg.seasonalEvent.tasks.GetLegacyChallengerListTask;
    import kabam.rotmg.legends.control.FameListUpdateSignal;
    import kabam.rotmg.core.signals.TaskErrorSignal;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.death.model.DeathModel;
    import kabam.rotmg.fame.model.FameModel;
    import kabam.lib.tasks.BranchingTask;
    import kabam.lib.tasks.DispatchSignalTask;
    import kabam.lib.tasks.Task;

    public class RequestLegacyChallengerListCommand 
    {

        [Inject]
        public var task:GetLegacyChallengerListTask;
        [Inject]
        public var update:FameListUpdateSignal;
        [Inject]
        public var error:TaskErrorSignal;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var death:DeathModel;
        [Inject]
        public var model:FameModel;


        public function execute():void
        {
            this.task.charId = this.getCharId();
            var _local_1:BranchingTask = new BranchingTask(this.task, this.makeSuccess(), this.makeFailure());
            this.monitor.add(_local_1);
            _local_1.start();
        }

        private function getCharId():int
        {
            if (((this.player.hasAccount()) && (this.death.getIsDeathViewPending())))
            {
                return (this.death.getLastDeath().charId_);
            };
            return (-1);
        }

        private function makeSuccess():Task
        {
            return (new DispatchSignalTask(this.update));
        }

        private function makeFailure():Task
        {
            return (new DispatchSignalTask(this.error, this.task));
        }


    }
}//package io.decagames.rotmg.seasonalEvent.commands

