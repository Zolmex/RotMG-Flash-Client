// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.view.AccountScreenMediator

package kabam.rotmg.ui.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.screens.AccountScreen;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import kabam.rotmg.account.core.view.AccountInfoView;
    import kabam.rotmg.account.web.view.WebAccountInfoView;
    import kabam.rotmg.account.web.WebAccount;
    import kabam.rotmg.account.kabam.view.KabamAccountInfoView;
    import kabam.rotmg.account.kabam.KabamAccount;
    import kabam.rotmg.account.kongregate.view.KongregateAccountInfoView;
    import kabam.rotmg.account.kongregate.KongregateAccount;
    import kabam.rotmg.account.steam.view.SteamAccountInfoView;
    import kabam.rotmg.account.steam.SteamAccount;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;

    public class AccountScreenMediator extends Mediator 
    {

        [Inject]
        public var view:AccountScreen;
        [Inject]
        public var account:Account;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var showTooltip:ShowTooltipSignal;
        [Inject]
        public var hideTooltips:HideTooltipsSignal;


        override public function initialize():void
        {
            this.view.tooltip.add(this.onTooltip);
            this.view.setRank(this.playerModel.getNumStars());
            this.view.setGuild(this.playerModel.getGuildName(), this.playerModel.getGuildRank());
            this.view.setAccountInfo(this.getInfoView());
        }

        private function getInfoView():AccountInfoView
        {
            var _local_1:AccountInfoView;
            switch (this.account.gameNetwork())
            {
                case WebAccount.NETWORK_NAME:
                    _local_1 = new WebAccountInfoView();
                    break;
                case KabamAccount.NETWORK_NAME:
                    _local_1 = new KabamAccountInfoView();
                    break;
                case KongregateAccount.NETWORK_NAME:
                    _local_1 = new KongregateAccountInfoView();
                    break;
                case SteamAccount.NETWORK_NAME:
                    _local_1 = new SteamAccountInfoView();
                    break;
            };
            return (_local_1);
        }

        override public function destroy():void
        {
            this.view.tooltip.remove(this.onTooltip);
            this.hideTooltips.dispatch();
        }

        private function onTooltip(_arg_1:ToolTip):void
        {
            this.showTooltip.dispatch(_arg_1);
        }


    }
}//package kabam.rotmg.ui.view

