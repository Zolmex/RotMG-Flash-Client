// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.dailyLogin.controller.DailyLoginPanelMediator

package kabam.rotmg.dailyLogin.controller
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.dailyLogin.view.DailyLoginPanel;
    import kabam.rotmg.dialogs.control.OpenDialogNoModalSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dailyLogin.model.DailyLoginModel;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import kabam.rotmg.dailyLogin.view.DailyLoginModal;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.dailyLogin.view.*;

    public class DailyLoginPanelMediator extends Mediator 
    {

        [Inject]
        public var view:DailyLoginPanel;
        [Inject]
        public var openNoModalDialog:OpenDialogNoModalSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var model:DailyLoginModel;


        override public function initialize():void
        {
            this.view.init();
            if (this.model.initialized)
            {
                this.view.showCalendarButton();
                this.view.calendarButton.addEventListener(MouseEvent.CLICK, this.showCalendarModal);
                WebMain.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            }
            else
            {
                this.view.showNoCalendarButton();
            }
        }

        private function showCalendarModal(_arg_1:MouseEvent):void
        {
            this.openDialog.dispatch(new DailyLoginModal());
        }

        override public function destroy():void
        {
            this.view.calendarButton.removeEventListener(MouseEvent.CLICK, this.showCalendarModal);
            WebMain.STAGE.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            super.destroy();
        }

        private function onKeyDown(_arg_1:KeyboardEvent):void
        {
            if (((_arg_1.keyCode == Parameters.data_.interact) && (WebMain.STAGE.focus == null)))
            {
                this.showCalendarModal(null);
            }
        }


    }
}//package kabam.rotmg.dailyLogin.controller

