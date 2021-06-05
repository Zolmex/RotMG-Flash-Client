// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.dailyLogin.commands.ShowDailyCalendarPopupCommand

package kabam.rotmg.dailyLogin.commands
{
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
    import kabam.rotmg.dailyLogin.model.DailyLoginModel;
    import kabam.rotmg.dailyLogin.view.DailyLoginModal;

    public class ShowDailyCalendarPopupCommand 
    {

        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var flushStartupQueue:FlushPopupStartupQueueSignal;
        [Inject]
        public var dailyLoginModel:DailyLoginModel;


        public function execute():void
        {
            if (((this.dailyLoginModel.shouldDisplayCalendarAtStartup) && (this.dailyLoginModel.initialized)))
            {
                this.openDialog.dispatch(new DailyLoginModal());
            }
            else
            {
                this.flushStartupQueue.dispatch();
            };
        }


    }
}//package kabam.rotmg.dailyLogin.commands

