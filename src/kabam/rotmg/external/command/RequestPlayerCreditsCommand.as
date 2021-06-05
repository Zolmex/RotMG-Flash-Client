﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.external.command.RequestPlayerCreditsCommand

package kabam.rotmg.external.command
{
    import robotlegs.bender.bundles.mvcs.Command;
    import kabam.lib.tasks.TaskMonitor;
    import org.swiftsuspenders.Injector;
    import kabam.lib.tasks.TaskSequence;
    import kabam.rotmg.external.service.RequestPlayerCreditsTask;
    import kabam.lib.tasks.DispatchSignalTask;

    public class RequestPlayerCreditsCommand extends Command 
    {

        [Inject]
        public var taskMonitor:TaskMonitor;
        [Inject]
        public var injector:Injector;
        [Inject]
        public var requestPlayerCreditsComplete:RequestPlayerCreditsCompleteSignal;


        override public function execute():void
        {
            var _local_1:TaskSequence = new TaskSequence();
            _local_1.add(this.injector.getInstance(RequestPlayerCreditsTask));
            _local_1.add(new DispatchSignalTask(this.requestPlayerCreditsComplete));
            this.taskMonitor.add(_local_1);
            _local_1.start();
        }


    }
}//package kabam.rotmg.external.command

