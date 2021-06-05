// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.core.BuyCharacterSlotCommand

package kabam.rotmg.account.core
{
    import kabam.rotmg.account.core.services.BuyCharacterSlotTask;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.core.signals.TrackEventSignal;
    import kabam.rotmg.ui.view.CharacterSlotNeedGoldDialog;
    import kabam.rotmg.account.core.view.PurchaseConfirmationDialog;
    import kabam.rotmg.account.core.view.BuyingDialog;
    import kabam.lib.tasks.TaskSequence;
    import kabam.lib.tasks.BranchingTask;
    import kabam.lib.tasks.DispatchSignalTask;
    import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
    import kabam.lib.tasks.Task;
    import kabam.rotmg.core.service.TrackingData;
    import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

    public class BuyCharacterSlotCommand 
    {

        [Inject]
        public var price:int;
        [Inject]
        public var task:BuyCharacterSlotTask;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var closeDialog:CloseDialogsSignal;
        [Inject]
        public var model:PlayerModel;
        [Inject]
        public var account:Account;
        [Inject]
        public var track:TrackEventSignal;


        public function execute():void
        {
            if (this.isSlotUnaffordable())
            {
                this.promptToGetMoreGold();
            }
            else
            {
                this.purchaseSlot();
            }
        }

        private function isSlotUnaffordable():Boolean
        {
            return (this.model.getCredits() < this.model.getNextCharSlotPrice());
        }

        private function promptToGetMoreGold():void
        {
            this.openDialog.dispatch(new CharacterSlotNeedGoldDialog());
        }

        private function purchaseSlot():void
        {
            this.openDialog.dispatch(new PurchaseConfirmationDialog(this.purchaseConfirmed));
        }

        private function purchaseConfirmed():void
        {
            this.openDialog.dispatch(new BuyingDialog());
            var _local_1:TaskSequence = new TaskSequence();
            _local_1.add(new BranchingTask(this.task, this.makeSuccessTask(), this.makeFailureTask()));
            _local_1.add(new DispatchSignalTask(this.closeDialog));
            this.monitor.add(_local_1);
            _local_1.start();
        }

        private function makeSuccessTask():Task
        {
            var _local_1:TaskSequence = new TaskSequence();
            _local_1.add(new DispatchSignalTask(this.setScreen, new CharacterSelectionAndNewsScreen()));
            return (_local_1);
        }

        private function makeTrackingData():TrackingData
        {
            var _local_1:TrackingData = new TrackingData();
            _local_1.category = "credits";
            _local_1.action = "buyConverted";
            _local_1.label = "Character Slot";
            _local_1.value = this.price;
            return (_local_1);
        }

        private function makeFailureTask():Task
        {
            return (new DispatchSignalTask(this.openDialog, new ErrorDialog("Unable to complete character slot purchase")));
        }


    }
}//package kabam.rotmg.account.core

