// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.core.view.AccountInfoMediator

package kabam.rotmg.account.core.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.ui.signals.NameChangedSignal;
    import kabam.rotmg.account.web.WebAccount;

    public class AccountInfoMediator extends Mediator 
    {

        [Inject]
        public var account:Account;
        [Inject]
        public var view:AccountInfoView;
        [Inject]
        public var update:UpdateAccountInfoSignal;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var nameChanged:NameChangedSignal;


        override public function initialize():void
        {
            this.nameChanged.add(this.onNameChanged);
            this.view.setInfo(this.account.getUserName(), this.account.isRegistered());
            this.updateDisplayName();
            this.update.add(this.updateLogin);
        }

        private function onNameChanged(_arg_1:String):void
        {
            this.updateDisplayName();
        }

        private function updateDisplayName():void
        {
            var _local_1:String;
            var _local_2:WebAccount;
            if ((this.account is WebAccount))
            {
                _local_2 = (this.account as WebAccount);
                if (_local_2 == null)
                {
                    return;
                };
                _local_1 = this.playerModel.getName();
                if ((((!(_local_1)) && (!(_local_2.userDisplayName == null))) && (_local_2.userDisplayName.length > 0)))
                {
                    _local_1 = _local_2.userDisplayName;
                };
                this.view.setInfo(_local_1, this.account.isRegistered());
            };
        }

        override public function destroy():void
        {
            this.update.remove(this.updateLogin);
        }

        private function updateLogin():void
        {
            this.view.setInfo(this.account.getUserName(), this.account.isRegistered());
            this.updateDisplayName();
        }


    }
}//package kabam.rotmg.account.core.view

