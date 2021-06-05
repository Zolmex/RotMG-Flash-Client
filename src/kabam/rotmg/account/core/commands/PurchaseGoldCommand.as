// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.core.commands.PurchaseGoldCommand

package kabam.rotmg.account.core.commands
{
    import kabam.rotmg.account.core.services.PurchaseGoldTask;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import robotlegs.bender.framework.api.ILogger;
    import kabam.lib.tasks.TaskSequence;
    import kabam.lib.tasks.DispatchSignalTask;

    public class PurchaseGoldCommand 
    {

        [Inject]
        public var purchaseGold:PurchaseGoldTask;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var closeDialog:CloseDialogsSignal;
        [Inject]
        public var logger:ILogger;


        public function execute():void
        {
            this.logger.debug("execute");
            var _local_1:TaskSequence = new TaskSequence();
            _local_1.add(this.purchaseGold);
            _local_1.add(new DispatchSignalTask(this.closeDialog));
            this.monitor.add(_local_1);
            _local_1.start();
        }


    }
}//package kabam.rotmg.account.core.commands

