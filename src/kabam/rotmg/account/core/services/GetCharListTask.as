// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.core.services.GetCharListTask

package kabam.rotmg.account.core.services
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.core.signals.SetLoadingMessageSignal;
    import kabam.rotmg.account.core.signals.CharListDataSignal;
    import kabam.rotmg.core.signals.CharListLoadedSignal;
    import robotlegs.bender.framework.api.ILogger;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
    import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import flash.utils.Timer;
    import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventErrorPopup;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.util.MoreObjectUtil;
    import kabam.rotmg.account.web.view.MigrationDialog;
    import kabam.rotmg.account.web.WebAccount;
    import io.decagames.rotmg.unity.popup.UnitySignUpPopup;
    import kabam.rotmg.account.web.view.WebLoginDialog;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.fortune.components.TimerCallback;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
    import flash.events.TimerEvent;
    import kabam.rotmg.account.core.*;

    public class GetCharListTask extends BaseTask 
    {

        private static const ONE_SECOND_IN_MS:int = 1000;
        private static const MAX_RETRIES:int = 7;

        [Inject]
        public var account:Account;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var model:PlayerModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var setLoadingMessage:SetLoadingMessageSignal;
        [Inject]
        public var charListData:CharListDataSignal;
        [Inject]
        public var charListLoadedSignal:CharListLoadedSignal;
        [Inject]
        public var logger:ILogger;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var closeDialogs:CloseDialogsSignal;
        [Inject]
        public var securityQuestionsModel:SecurityQuestionsModel;
        [Inject]
        public var setScreenWithValidData:SetScreenWithValidDataSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        private var requestData:Object;
        private var retryTimer:Timer;
        private var numRetries:int = 0;
        private var fromMigration:Boolean = false;
        private var seasonalEventErrorPopUp:SeasonalEventErrorPopup;


        override protected function startTask():void
        {
            this.logger.info("GetUserDataTask start");
            this.requestData = this.makeRequestData();
            this.sendRequest();
            Parameters.sendLogin_ = false;
        }

        private function sendRequest():void
        {
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/char/list", this.requestData);
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.onListComplete(_arg_2);
            }
            else
            {
                this.onTextError(_arg_2);
            };
        }

        public function makeRequestData():Object
        {
            var _local_1:Object = {};
            _local_1.game_net_user_id = this.account.gameNetworkUserId();
            _local_1.game_net = this.account.gameNetwork();
            _local_1.play_platform = this.account.playPlatform();
            _local_1.do_login = Parameters.sendLogin_;
            _local_1.challenger = Boolean(this.seasonalEventModel.isChallenger);
            MoreObjectUtil.addToObject(_local_1, this.account.getCredentials());
            return (_local_1);
        }

        private function onListComplete(_arg_1:String):void
        {
            var _local_3:Number;
            var _local_4:MigrationDialog;
            var _local_5:XML;
            var _local_2:XML = new XML(_arg_1);
            if (_local_2.hasOwnProperty("MigrateStatus"))
            {
                _local_3 = _local_2.MigrateStatus;
                if (_local_3 == 5)
                {
                    this.sendRequest();
                };
                _local_4 = new MigrationDialog(this.account, _local_3);
                this.fromMigration = true;
                _local_4.done.addOnce(this.sendRequest);
                _local_4.cancel.addOnce(this.clearAccountAndReloadCharacters);
                this.openDialog.dispatch(_local_4);
            }
            else
            {
                if (_local_2.hasOwnProperty("Account"))
                {
                    if ((this.account is WebAccount))
                    {
                        WebAccount(this.account).userDisplayName = _local_2.Account[0].Name;
                        WebAccount(this.account).paymentProvider = _local_2.Account[0].PaymentProvider;
                        if (_local_2.Account[0].hasOwnProperty("PaymentData"))
                        {
                            WebAccount(this.account).paymentData = _local_2.Account[0].PaymentData;
                        };
                    };
                    this.account.creationDate = new Date((_local_2.Account[0].CreationTimestamp * 1000));
                    if (_local_2.Account[0].hasOwnProperty("SecurityQuestions"))
                    {
                        this.securityQuestionsModel.showSecurityQuestionsOnStartup = (_local_2.Account[0].SecurityQuestions[0].ShowSecurityQuestionsDialog[0] == "1");
                        this.securityQuestionsModel.clearQuestionsList();
                        for each (_local_5 in _local_2.Account[0].SecurityQuestions[0].SecurityQuestionsKeys[0].SecurityQuestionsKey)
                        {
                            this.securityQuestionsModel.addSecurityQuestion(_local_5.toString());
                        };
                    };
                };
                if ((((_local_2) && (Boolean(this.seasonalEventModel.isChallenger))) && (_local_2.Account[0].hasOwnProperty("RemainingLives"))))
                {
                    this.seasonalEventModel.remainingCharacters = _local_2.Account[0].RemainingLives;
                };
                this.charListData.dispatch(_local_2);
                if (!this.model.isLogOutLogIn)
                {
                    this.charListLoadedSignal.dispatch();
                };
                this.model.isLogOutLogIn = false;
                completeTask(true);
                if ((((!(this.model.hasShownUnitySignUp)) && (Parameters.data_.unitySignUp)) && (_local_2.hasOwnProperty("DecaSignupPopup"))))
                {
                    this.model.hasShownUnitySignUp = true;
                    this.showPopupSignal.dispatch(new UnitySignUpPopup());
                };
            };
            if (this.retryTimer != null)
            {
                this.stopRetryTimer();
            };
        }

        private function onTextError(_arg_1:String):void
        {
            var _local_2:WebLoginDialog;
            if (this.numRetries < MAX_RETRIES)
            {
                this.setLoadingMessage.dispatch("Loading.text");
            }
            else
            {
                this.setLoadingMessage.dispatch("error.loadError");
            };
            if (_arg_1 == "Account credentials not valid")
            {
                if (this.fromMigration)
                {
                    _local_2 = new WebLoginDialog();
                    _local_2.setError(TextKey.WEB_LOGIN_DIALOG_PASSWORD_INVALID);
                    _local_2.setEmail(this.account.getUserId());
                    StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(_local_2);
                };
                this.clearAccountAndReloadCharacters();
            }
            else
            {
                if (_arg_1 == "Account is under maintenance")
                {
                    this.setLoadingMessage.dispatch("This account has been banned");
                    new TimerCallback(5, this.clearAccountAndReloadCharacters);
                }
                else
                {
                    if (_arg_1 == "Account has fame lower than minimal for the season")
                    {
                        this.showSeasonalErrorPopUp(_arg_1);
                    }
                    else
                    {
                        if (_arg_1 == "No more live left for the current season.")
                        {
                            this.showSeasonalErrorPopUp(_arg_1);
                        }
                        else
                        {
                            this.waitForASecondThenRetryRequest();
                        };
                    };
                };
            };
        }

        private function showSeasonalErrorPopUp(_arg_1:String):void
        {
            this.seasonalEventErrorPopUp = new SeasonalEventErrorPopup(_arg_1);
            this.seasonalEventErrorPopUp.okButton.addEventListener(MouseEvent.CLICK, this.onSeasonalErrorPopUpClose);
            this.showPopupSignal.dispatch(this.seasonalEventErrorPopUp);
        }

        private function onSeasonalErrorPopUpClose(_arg_1:MouseEvent):void
        {
            this.seasonalEventErrorPopUp.okButton.removeEventListener(MouseEvent.CLICK, this.onSeasonalErrorPopUpClose);
            var _local_2:String = this.seasonalEventErrorPopUp.message;
            this.closePopupSignal.dispatch(this.seasonalEventErrorPopUp);
            this.seasonalEventModel.isChallenger = 0;
            ObjectLibrary.usePatchedData = false;
            if (((_local_2 == "Account has fame lower than minimal for the season") || (_local_2 == "No more live left for the current season.")))
            {
                this.setScreenWithValidData.dispatch(new CharacterSelectionAndNewsScreen());
            };
        }

        private function clearAccountAndReloadCharacters():void
        {
            this.logger.info("GetUserDataTask invalid credentials");
            this.account.clear();
            this.client.complete.addOnce(this.onComplete);
            this.requestData = this.makeRequestData();
            this.client.sendRequest("/char/list", this.requestData);
        }

        private function waitForASecondThenRetryRequest():void
        {
            this.logger.info("GetUserDataTask error - retrying");
            this.retryTimer = new Timer(ONE_SECOND_IN_MS, 1);
            this.retryTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onRetryTimer);
            this.retryTimer.start();
        }

        private function stopRetryTimer():void
        {
            this.retryTimer.stop();
            this.retryTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onRetryTimer);
            this.retryTimer = null;
        }

        private function onRetryTimer(_arg_1:TimerEvent):void
        {
            this.stopRetryTimer();
            if (this.numRetries < MAX_RETRIES)
            {
                this.sendRequest();
                this.numRetries++;
            }
            else
            {
                this.clearAccountAndReloadCharacters();
                this.setLoadingMessage.dispatch("LoginError.tooManyFails");
            };
        }


    }
}//package kabam.rotmg.account.core.services

