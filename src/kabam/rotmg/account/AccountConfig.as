﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.AccountConfig

package kabam.rotmg.account
{
    import robotlegs.bender.framework.api.IConfig;
    import flash.display.DisplayObjectContainer;
    import org.swiftsuspenders.Injector;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.framework.api.IContext;
    import flash.display.LoaderInfo;
    import robotlegs.bender.framework.api.ILogger;
    import kabam.rotmg.core.signals.TaskErrorSignal;
    import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
    import kabam.rotmg.account.core.services.VerifyAgeTask;
    import kabam.rotmg.account.core.services.GetCharListTask;
    import kabam.rotmg.core.signals.MoneyFrameEnableCancelSignal;
    import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
    import kabam.rotmg.account.core.model.OfferModel;
    import kabam.rotmg.account.securityQuestions.tasks.SaveSecurityQuestionsTask;
    import kabam.rotmg.account.core.view.MoneyFrame;
    import com.company.assembleegameclient.account.ui.MoneyFrameMediator;
    import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsDialog;
    import kabam.rotmg.account.securityQuestions.mediators.SecurityQuestionsMediator;
    import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
    import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsConfirmDialog;
    import kabam.rotmg.account.core.view.PurchaseConfirmationDialog;
    import kabam.rotmg.account.core.view.PurchaseConfirmationMediator;
    import kabam.rotmg.ui.signals.BuyCharacterSlotSignal;
    import kabam.rotmg.account.core.BuyCharacterSlotCommand;
    import kabam.rotmg.account.core.control.IsAccountRegisteredToBuyGoldGuard;
    import kabam.rotmg.account.core.signals.PurchaseGoldSignal;
    import kabam.rotmg.account.core.commands.PurchaseGoldCommand;
    import kabam.rotmg.account.core.signals.VerifyAgeSignal;
    import kabam.rotmg.account.core.commands.VerifyAgeCommand;
    import kabam.rotmg.account.securityQuestions.signals.SaveSecurityQuestionsSignal;
    import kabam.rotmg.account.securityQuestions.commands.SaveSecurityQuestionsCommand;
    import kabam.rotmg.account.kongregate.KongregateAccountConfig;
    import kabam.rotmg.account.steam.SteamAccountConfig;
    import kabam.rotmg.account.kabam.KabamAccountConfig;
    import kabam.rotmg.account.web.WebAccountConfig;
    import kabam.rotmg.account.transfer.TransferAccountConfig;

    public class AccountConfig implements IConfig 
    {

        [Inject]
        public var root:DisplayObjectContainer;
        [Inject]
        public var injector:Injector;
        [Inject]
        public var commandMap:ISignalCommandMap;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var context:IContext;
        [Inject]
        public var info:LoaderInfo;
        [Inject]
        public var logger:ILogger;


        public function configure():void
        {
            this.configureCommonFunctionality();
            this.configureAccountSpecificFunctionality();
            this.context.lifecycle.afterInitializing(this.init);
        }

        private function configureCommonFunctionality():void
        {
            this.injector.map(TaskErrorSignal).asSingleton();
            this.injector.map(UpdateAccountInfoSignal).asSingleton();
            this.injector.map(VerifyAgeTask);
            this.injector.map(GetCharListTask);
            this.injector.map(MoneyFrameEnableCancelSignal).asSingleton();
            this.injector.map(SecurityQuestionsModel).asSingleton();
            this.injector.map(OfferModel).asSingleton();
            this.injector.map(SaveSecurityQuestionsTask);
            this.mediatorMap.map(MoneyFrame).toMediator(MoneyFrameMediator);
            this.mediatorMap.map(SecurityQuestionsDialog).toMediator(SecurityQuestionsMediator);
            this.mediatorMap.map(SecurityQuestionsInfoDialog).toMediator(SecurityQuestionsMediator);
            this.mediatorMap.map(SecurityQuestionsConfirmDialog).toMediator(SecurityQuestionsMediator);
            this.mediatorMap.map(PurchaseConfirmationDialog).toMediator(PurchaseConfirmationMediator);
            this.commandMap.map(BuyCharacterSlotSignal).toCommand(BuyCharacterSlotCommand).withGuards(IsAccountRegisteredToBuyGoldGuard);
            this.commandMap.map(PurchaseGoldSignal).toCommand(PurchaseGoldCommand);
            this.commandMap.map(VerifyAgeSignal).toCommand(VerifyAgeCommand);
            this.commandMap.map(SaveSecurityQuestionsSignal).toCommand(SaveSecurityQuestionsCommand);
        }

        private function configureAccountSpecificFunctionality():void
        {
            if (this.isKongregate())
            {
                this.context.configure(KongregateAccountConfig);
            }
            else
            {
                if (this.isSteam())
                {
                    this.context.configure(SteamAccountConfig);
                }
                else
                {
                    if (this.isKabam())
                    {
                        this.context.configure(KabamAccountConfig);
                    }
                    else
                    {
                        this.context.configure(WebAccountConfig);
                    }
                }
            }
            this.context.configure(TransferAccountConfig);
        }

        private function isKongregate():Boolean
        {
            return (!(this.info.parameters.kongregate_api_path == null));
        }

        private function isSteam():Boolean
        {
            return (!(this.info.parameters.steam_api_path == null));
        }

        private function isKabam():Boolean
        {
            return (!(this.info.parameters.kabam_signed_request == null));
        }

        private function init():void
        {
            this.logger.info("isKongregate {0}", [this.isKongregate()]);
            this.logger.info("isSteam {0}", [this.isSteam()]);
            this.logger.info("isKabam {0}", [this.isKabam()]);
        }


    }
}//package kabam.rotmg.account

