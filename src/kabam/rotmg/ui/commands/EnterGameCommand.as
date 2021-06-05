// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.commands.EnterGameCommand

package kabam.rotmg.ui.commands
{
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
    import kabam.rotmg.game.signals.PlayGameSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.servers.api.ServerModel;
    import kabam.rotmg.ui.noservers.NoServersDialogFactory;
    import com.company.assembleegameclient.screens.CharacterTypeSelectionScreen;
    import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
    import kabam.rotmg.game.model.GameInitData;
    import kabam.rotmg.ui.view.AgeVerificationDialog;

    public class EnterGameCommand 
    {

        private const DEFAULT_CHARACTER:int = 782;

        [Inject]
        public var account:Account;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var setScreenWithValidData:SetScreenWithValidDataSignal;
        [Inject]
        public var playGame:PlayGameSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var servers:ServerModel;
        [Inject]
        public var noServersDialogFactory:NoServersDialogFactory;


        public function execute():void
        {
            if (!this.servers.isServerAvailable())
            {
                this.showNoServersDialog();
            }
            else
            {
                if (!this.account.isRegistered())
                {
                    this.launchGame();
                }
                else
                {
                    if (!this.playerModel.getIsAgeVerified())
                    {
                        this.showAgeVerificationDialog();
                    }
                    else
                    {
                        if (this.seasonalEventModel.isSeasonalMode)
                        {
                            this.showCharacterTypeSelectionScreen();
                        }
                        else
                        {
                            this.showCurrentCharacterScreen();
                        }
                    }
                }
            }
        }

        private function showCharacterTypeSelectionScreen():void
        {
            this.setScreenWithValidData.dispatch(new CharacterTypeSelectionScreen());
        }

        private function showCurrentCharacterScreen():void
        {
            this.setScreenWithValidData.dispatch(new CharacterSelectionAndNewsScreen());
        }

        private function launchGame():void
        {
            this.playGame.dispatch(this.makeGameInitData());
        }

        private function makeGameInitData():GameInitData
        {
            var _local_1:GameInitData = new GameInitData();
            _local_1.createCharacter = true;
            _local_1.charId = this.playerModel.getNextCharId();
            _local_1.keyTime = -1;
            _local_1.isNewGame = true;
            return (_local_1);
        }

        private function showAgeVerificationDialog():void
        {
            this.openDialog.dispatch(new AgeVerificationDialog());
        }

        private function showNoServersDialog():void
        {
            this.openDialog.dispatch(this.noServersDialogFactory.makeDialog());
        }


    }
}//package kabam.rotmg.ui.commands

