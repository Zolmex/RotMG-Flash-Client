// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.core.service.PurchaseCharacterErrorTask

package kabam.rotmg.core.service
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import kabam.rotmg.ui.view.NotEnoughGoldDialog;
    import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

    public class PurchaseCharacterErrorTask extends BaseTask 
    {

        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        public var parentTask:PurchaseCharacterClassTask;


        override protected function startTask():void
        {
            if (this.parentTask.error == "Not enough Gold.")
            {
                this.showPopupSignal.dispatch(new NotEnoughGoldDialog());
            }
            else
            {
                this.openDialog.dispatch(new ErrorDialog(this.parentTask.error));
            }
        }


    }
}//package kabam.rotmg.core.service

