// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.CharacterTypeSelectionMediator

package com.company.assembleegameclient.screens
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import io.decagames.rotmg.pets.data.PetsModel;
    import kabam.rotmg.news.model.NewsModel;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
    import kabam.rotmg.core.signals.CharListLoadedSignal;
    import kabam.rotmg.account.core.services.GetCharListTask;
    import io.decagames.rotmg.pets.tasks.GetOwnedPetSkinsTask;
    import kabam.rotmg.news.services.GetInGameNewsTask;
    import io.decagames.rotmg.seasonalEvent.signals.ShowSeasonHasEndedPopupSignal;
    import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventErrorPopup;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.parameters.Parameters;
    import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventInfoPopup;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.classes.model.ClassesModel;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.ui.view.TitleView;
    import kabam.rotmg.ui.view.*;

    public class CharacterTypeSelectionMediator extends Mediator 
    {

        [Inject]
        public var view:CharacterTypeSelectionScreen;
        [Inject]
        public var account:Account;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var petsModel:PetsModel;
        [Inject]
        public var newsModel:NewsModel;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var setScreenWithValidData:SetScreenWithValidDataSignal;
        [Inject]
        public var charListLoadedSignal:CharListLoadedSignal;
        [Inject]
        public var getCharListTask:GetCharListTask;
        [Inject]
        public var getOwnedPetSkinsTask:GetOwnedPetSkinsTask;
        [Inject]
        public var getInGameNewsTask:GetInGameNewsTask;
        [Inject]
        public var showSeasonHasEndedPopupSignal:ShowSeasonHasEndedPopupSignal;
        private var seasonalEventErrorPopUp:SeasonalEventErrorPopup;
        private var seasonEndedPopUp:SeasonalEventErrorPopup;


        override public function initialize():void
        {
            this.charListLoadedSignal.add(this.onListComplete);
            this.showSeasonHasEndedPopupSignal.add(this.onSeasonEnded);
            this.view.setName(this.playerModel.getName());
            this.view.leagueDatas = this.seasonalEventModel.leagueDatas;
            this.view.leagueItemSignal.add(this.onLeagueChosen);
            this.view.close.add(this.onClose);
            this.view.infoButton.addEventListener(MouseEvent.CLICK, this.onInfoClicked);
            if (Parameters.data_.showChallengerInfo)
            {
                this.showInfo();
                Parameters.data_.showChallengerInfo = false;
            };
        }

        private function onSeasonEnded():void
        {
            this.showSeasonEndedPopUp("Season has ended!");
        }

        private function onInfoClicked(_arg_1:MouseEvent):void
        {
            this.showInfo();
        }

        private function showInfo():void
        {
            this.showPopupSignal.dispatch(new SeasonalEventInfoPopup(this.seasonalEventModel.rulesAndDescription));
        }

        private function resetCharacterSkins():void
        {
            var _local_1:ClassesModel = StaticInjectorContext.getInjector().getInstance(ClassesModel);
            _local_1.resetCharacterSkinsSelection();
        }

        private function onLeagueChosen(_arg_1:int):void
        {
            this.resetCharacterSkins();
            if (_arg_1 == 0)
            {
                this.seasonalEventModel.isChallenger = 0;
                ObjectLibrary.usePatchedData = false;
                this.runTasks();
            }
            else
            {
                if (_arg_1 == 1)
                {
                    if (this.isAccountCreationDateValid())
                    {
                        this.seasonalEventModel.isChallenger = 1;
                        ObjectLibrary.usePatchedData = true;
                        this.runTasks();
                    }
                    else
                    {
                        this.showSeasonalErrorPopUp((("Your account must be created before: " + this.seasonalEventModel.accountCreatedBefore.toString()) + " to play a Seasonal Event!"));
                    };
                };
            };
        }

        private function runTasks():void
        {
            this.logGameMode();
            this.getCharListTask.start();
            this.petsModel.clearPets();
            this.getOwnedPetSkinsTask.start();
            this.newsModel.clearNews();
            this.getInGameNewsTask.start();
        }

        private function isAccountCreationDateValid():Boolean
        {
            var _local_1:Boolean;
            if ((this.seasonalEventModel.accountCreatedBefore.getTime() - this.account.creationDate.getTime()) > 0)
            {
                _local_1 = true;
            };
            return (_local_1);
        }

        private function logGameMode():void
        {
            var _local_1:AppEngineClient = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
            var _local_2:Object = this.account.getCredentials();
            _local_2.gameMode = ((this.seasonalEventModel.isChallenger) ? "Challenger" : "Legacy");
            _local_2.seasonID = this.seasonalEventModel.seasonTitle;
            _local_1.sendRequest("/log/logGameModePlayed", _local_2);
        }

        private function onListComplete():void
        {
            this.setScreenWithValidData.dispatch(new CharacterSelectionAndNewsScreen());
        }

        override public function destroy():void
        {
            this.view.close.remove(this.onClose);
            this.view.leagueItemSignal.remove(this.onLeagueChosen);
        }

        private function onClose():void
        {
            this.setScreen.dispatch(new TitleView());
        }

        private function showSeasonalErrorPopUp(_arg_1:String):void
        {
            this.seasonalEventErrorPopUp = new SeasonalEventErrorPopup(_arg_1);
            this.seasonalEventErrorPopUp.okButton.addEventListener(MouseEvent.CLICK, this.onSeasonalErrorPopUpClose);
            this.showPopupSignal.dispatch(this.seasonalEventErrorPopUp);
        }

        private function onSeasonalErrorPopUpClose(_arg_1:MouseEvent):void
        {
            this.seasonalEventModel.isChallenger = 0;
            this.seasonalEventErrorPopUp.okButton.removeEventListener(MouseEvent.CLICK, this.onSeasonalErrorPopUpClose);
            this.closePopupSignal.dispatch(this.seasonalEventErrorPopUp);
            this.setScreenWithValidData.dispatch(new CharacterSelectionAndNewsScreen());
        }

        private function showSeasonEndedPopUp(_arg_1:String):void
        {
            this.seasonEndedPopUp = new SeasonalEventErrorPopup(_arg_1);
            this.seasonEndedPopUp.okButton.addEventListener(MouseEvent.CLICK, this.onSeasonEndedPopUpClose);
            this.showPopupSignal.dispatch(this.seasonEndedPopUp);
        }

        private function onSeasonEndedPopUpClose(_arg_1:MouseEvent):void
        {
            this.view.leagueItemSignal.remove(this.onLeagueChosen);
            this.seasonalEventModel.isSeasonalMode = false;
            this.onLeagueChosen(0);
            this.seasonEndedPopUp.okButton.removeEventListener(MouseEvent.CLICK, this.onSeasonalErrorPopUpClose);
            this.closePopupSignal.dispatch(this.seasonEndedPopUp);
        }


    }
}//package com.company.assembleegameclient.screens

