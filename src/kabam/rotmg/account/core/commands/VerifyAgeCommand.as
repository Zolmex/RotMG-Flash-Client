// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.core.commands.VerifyAgeCommand

package kabam.rotmg.account.core.commands
{
    import kabam.rotmg.account.core.services.VerifyAgeTask;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.lib.tasks.BranchingTask;
    import kabam.lib.tasks.DispatchSignalTask;
    import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
    import kabam.lib.tasks.Task;
    import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

    public class VerifyAgeCommand 
    {

        private const UNABLE_TO_VERIFY:String = "Unable to verify age";

        [Inject]
        public var task:VerifyAgeTask;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var setScreen:SetScreenWithValidDataSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;


        public function execute():void
        {
            var _local_1:BranchingTask = new BranchingTask(this.task);
            _local_1.addSuccessTask(this.makeSuccessTask());
            _local_1.addFailureTask(this.makeFailureTask());
            this.monitor.add(_local_1);
            _local_1.start();
        }

        private function makeSuccessTask():Task
        {
            return (new DispatchSignalTask(this.setScreen, new CharacterSelectionAndNewsScreen()));
        }

        private function makeFailureTask():Task
        {
            return (new DispatchSignalTask(this.openDialog, new ErrorDialog(this.UNABLE_TO_VERIFY)));
        }


    }
}//package kabam.rotmg.account.core.commands

