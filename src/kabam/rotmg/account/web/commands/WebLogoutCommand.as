// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.web.commands.WebLogoutCommand

package kabam.rotmg.account.web.commands
{
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.signals.InvalidateDataSignal;
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.core.model.ScreenModel;
    import kabam.rotmg.packages.services.GetPackagesTask;
    import io.decagames.rotmg.pets.data.PetsModel;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.ui.view.TitleView;
    import kabam.lib.tasks.BaseTask;

    public class WebLogoutCommand 
    {

        [Inject]
        public var account:Account;
        [Inject]
        public var invalidate:InvalidateDataSignal;
        [Inject]
        public var setScreenSignal:SetScreenSignal;
        [Inject]
        public var screenModel:ScreenModel;
        [Inject]
        public var getPackageTask:GetPackagesTask;
        [Inject]
        public var petsModel:PetsModel;
        [Inject]
        public var playerModel:PlayerModel;


        public function execute():void
        {
            this.account.clear();
            this.invalidate.dispatch();
            this.petsModel.clearPets();
            this.getPackageTask.finished.addOnce(this.onFinished);
            this.getPackageTask.start();
        }

        private function onFinished(_arg_1:BaseTask, _arg_2:Boolean, _arg_3:String):void
        {
            this.playerModel.isLogOutLogIn = true;
            this.setScreenSignal.dispatch(new TitleView());
        }


    }
}//package kabam.rotmg.account.web.commands

