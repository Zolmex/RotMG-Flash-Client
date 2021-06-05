// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.kongregate.commands.KongregateRegisterAccountCommand

package kabam.rotmg.account.kongregate.commands
{
    import kabam.rotmg.account.web.model.AccountData;
    import kabam.rotmg.account.core.services.RegisterAccountTask;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.core.signals.TaskErrorSignal;
    import kabam.lib.tasks.BranchingTask;
    import kabam.lib.tasks.TaskSequence;
    import kabam.lib.tasks.DispatchSignalTask;
    import kabam.rotmg.account.kongregate.view.KongregateAccountDetailDialog;
    import kabam.lib.tasks.Task;

    public class KongregateRegisterAccountCommand 
    {

        [Inject]
        public var data:AccountData;
        [Inject]
        public var task:RegisterAccountTask;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var update:UpdateAccountInfoSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var taskError:TaskErrorSignal;


        public function execute():void
        {
            var _local_1:BranchingTask = new BranchingTask(this.task, this.onSuccess(), this.onFailure());
            this.monitor.add(_local_1);
            _local_1.start();
        }

        private function onSuccess():TaskSequence
        {
            var _local_1:TaskSequence = new TaskSequence();
            _local_1.add(new DispatchSignalTask(this.update));
            _local_1.add(new DispatchSignalTask(this.openDialog, new KongregateAccountDetailDialog()));
            return (_local_1);
        }

        private function onFailure():Task
        {
            return (new DispatchSignalTask(this.taskError, this.task));
        }


    }
}//package kabam.rotmg.account.kongregate.commands

