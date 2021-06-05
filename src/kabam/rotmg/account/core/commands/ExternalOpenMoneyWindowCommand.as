// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.core.commands.ExternalOpenMoneyWindowCommand

package kabam.rotmg.account.core.commands
{
    import kabam.rotmg.account.core.model.JSInitializedModel;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.account.core.model.MoneyConfig;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import robotlegs.bender.framework.api.ILogger;
    import kabam.rotmg.build.api.BuildData;
    import kabam.rotmg.application.api.ApplicationSetup;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.promotions.model.BeginnersPackageModel;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.shop.PreparingPurchaseTransactionModal;
    import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
    import kabam.rotmg.account.web.WebAccount;
    import flash.net.URLVariables;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;
    import flash.external.ExternalInterface;
    import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
    import kabam.rotmg.build.api.BuildEnvironment;

    public class ExternalOpenMoneyWindowCommand 
    {

        private const TESTING_ERROR_MESSAGE:String = "You cannot purchase gold on the testing server";
        private const REGISTRATION_ERROR_MESSAGE:String = "You must be registered to buy gold";

        [Inject]
        public var moneyWindowModel:JSInitializedModel;
        [Inject]
        public var account:Account;
        [Inject]
        public var moneyConfig:MoneyConfig;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var logger:ILogger;
        [Inject]
        public var buildData:BuildData;
        [Inject]
        public var openDialogSignal:OpenDialogSignal;
        [Inject]
        public var applicationSetup:ApplicationSetup;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var beginnersPackageModel:BeginnersPackageModel;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var showPopup:ShowPopupSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        private var preparingModal:PreparingPurchaseTransactionModal;


        public function execute():void
        {
            if (((this.isGoldPurchaseEnabled()) && (this.account.isRegistered())))
            {
                this.handleValidMoneyWindowRequest();
            }
            else
            {
                this.handleInvalidMoneyWindowRequest();
            }
        }

        private function handleInvalidMoneyWindowRequest():void
        {
            if (!this.isGoldPurchaseEnabled())
            {
                this.openDialogSignal.dispatch(new ErrorDialog(this.TESTING_ERROR_MESSAGE));
            }
            else
            {
                if (!this.account.isRegistered())
                {
                    this.openDialogSignal.dispatch(new ErrorDialog(this.REGISTRATION_ERROR_MESSAGE));
                }
            }
        }

        private function handleValidMoneyWindowRequest():void
        {
            if (((this.account is WebAccount) && (WebAccount(this.account).paymentProvider == "paymentwall")))
            {
                this.requestPaymentToken();
            }
            else
            {
                try
                {
                    this.openKabamMoneyWindowFromBrowser();
                }
                catch(e:Error)
                {
                    openKabamMoneyWindowFromStandalonePlayer();
                }
            }
        }

        private function openKabamMoneyWindowFromStandalonePlayer():void
        {
            var _local_1:String = this.applicationSetup.getAppEngineUrl(true);
            var _local_2:URLVariables = new URLVariables();
            var _local_3:URLRequest = new URLRequest();
            _local_2.naid = this.account.getMoneyUserId();
            _local_2.signedRequest = this.account.getMoneyAccessToken();
            if (this.beginnersPackageModel.isBeginnerAvailable())
            {
                _local_2.createdat = this.beginnersPackageModel.getUserCreatedAt();
            }
            else
            {
                _local_2.createdat = 0;
            }
            _local_3.url = (_local_1 + "/credits/kabamadd");
            _local_3.method = URLRequestMethod.POST;
            _local_3.data = _local_2;
            navigateToURL(_local_3, "_blank");
            this.logger.debug("Opening window from standalone player");
        }

        private function openPaymentwallMoneyWindowFromStandalonePlayer(_arg_1:String):void
        {
            var _local_2:String = this.applicationSetup.getAppEngineUrl(true);
            var _local_3:URLVariables = new URLVariables();
            var _local_4:URLRequest = new URLRequest();
            _local_3.iframeUrl = _arg_1;
            _local_4.url = (_local_2 + "/credits/pwpurchase");
            _local_4.method = URLRequestMethod.POST;
            _local_4.data = _local_3;
            navigateToURL(_local_4, "_blank");
            this.logger.debug("Opening window from standalone player");
        }

        private function initializeMoneyWindow():void
        {
            var _local_1:Number;
            if (!this.moneyWindowModel.isInitialized)
            {
                if (this.beginnersPackageModel.isBeginnerAvailable())
                {
                    _local_1 = this.beginnersPackageModel.getUserCreatedAt();
                }
                else
                {
                    _local_1 = 0;
                }
                ExternalInterface.call(this.moneyConfig.jsInitializeFunction(), this.account.getMoneyUserId(), this.account.getMoneyAccessToken(), _local_1);
                this.moneyWindowModel.isInitialized = true;
            }
        }

        private function openKabamMoneyWindowFromBrowser():void
        {
            this.initializeMoneyWindow();
            this.logger.debug("Attempting External Payments via KabamPayment");
            ExternalInterface.call("rotmg.KabamPayment.displayPaymentWall");
        }

        private function requestPaymentToken():void
        {
            this.preparingModal = new PreparingPurchaseTransactionModal();
            this.showPopup.dispatch(this.preparingModal);
            var _local_1:Object = this.account.getCredentials();
            this.client.sendRequest("/credits/token", _local_1);
            this.client.complete.addOnce(this.onComplete);
        }

        private function onComplete(isOK:Boolean, data:*):void
        {
            var tokenInformation:String;
            this.closePopupSignal.dispatch(this.preparingModal);
            if (isOK)
            {
                tokenInformation = XML(data).toString();
                if (tokenInformation == "-1")
                {
                    this.showPopup.dispatch(new ErrorModal(350, "Payment Error", "Unable to process payment request. Try again later."));
                }
                else
                {
                    try
                    {
                        ExternalInterface.call("rotmg.Paymentwall.showPaymentwall", tokenInformation);
                    }
                    catch(e:Error)
                    {
                        openPaymentwallMoneyWindowFromStandalonePlayer(tokenInformation);
                    }
                }
            }
            else
            {
                this.showPopup.dispatch(new ErrorModal(350, "Payment Error", "Unable to fetch payment information. Try again later."));
            }
        }

        private function isGoldPurchaseEnabled():Boolean
        {
            return ((!(this.buildData.getEnvironment() == BuildEnvironment.TESTING)) || (this.playerModel.isAdmin()));
        }


    }
}//package kabam.rotmg.account.core.commands

