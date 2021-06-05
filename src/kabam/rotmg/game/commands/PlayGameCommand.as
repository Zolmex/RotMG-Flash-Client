// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.commands.PlayGameCommand

package kabam.rotmg.game.commands
{
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.game.model.GameInitData;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.pets.data.PetsModel;
    import kabam.rotmg.servers.api.ServerModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.lib.net.impl.SocketServerModel;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.servers.api.Server;
    import flash.utils.ByteArray;
    import com.company.assembleegameclient.game.GameSprite;

    public class PlayGameCommand 
    {

        public static const RECONNECT_DELAY:int = 2000;

        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var data:GameInitData;
        [Inject]
        public var model:PlayerModel;
        [Inject]
        public var petsModel:PetsModel;
        [Inject]
        public var serverModel:ServerModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var socketServerModel:SocketServerModel;


        public function execute():void
        {
            if (!this.data.isNewGame)
            {
                this.socketServerModel.connectDelayMS = PlayGameCommand.RECONNECT_DELAY;
            }
            this.recordCharacterUseInSharedObject();
            this.makeGameView();
            this.updatePet();
        }

        private function updatePet():void
        {
            var _local_1:SavedCharacter = this.model.getCharacterById(this.model.currentCharId);
            if (_local_1)
            {
                this.petsModel.setActivePet(_local_1.getPetVO());
            }
            else
            {
                if ((((this.model.currentCharId) && (this.petsModel.getActivePet())) && (!(this.data.isNewGame))))
                {
                    return;
                }
                this.petsModel.setActivePet(null);
            }
        }

        private function recordCharacterUseInSharedObject():void
        {
            Parameters.data_.charIdUseMap[this.data.charId] = new Date().getTime();
            Parameters.save();
        }

        private function makeGameView():void
        {
            var _local_1:Boolean;
            var _local_2:SavedCharacter = this.model.getCharacterById(this.data.charId);
            if (_local_2)
            {
                _local_1 = Boolean(int(_local_2.charXML_.IsChallenger));
            }
            else
            {
                _local_1 = Boolean(this.seasonalEventModel.isChallenger);
            }
            var _local_3:int = ((_local_1) ? Server.CHALLENGER_SERVER : Server.NORMAL_SERVER);
            this.serverModel.setAvailableServers(_local_3);
            var _local_4:Server = ((this.data.server) || (this.serverModel.getServer()));
            var _local_5:int = ((this.data.isNewGame) ? this.getInitialGameId() : this.data.gameId);
            var _local_6:Boolean = this.data.createCharacter;
            var _local_7:int = this.data.charId;
            var _local_8:int = ((this.data.isNewGame) ? -1 : this.data.keyTime);
            var _local_9:ByteArray = this.data.key;
            this.model.currentCharId = _local_7;
            this.setScreen.dispatch(new GameSprite(_local_4, _local_5, _local_6, _local_7, _local_8, _local_9, this.model, null, this.data.isFromArena));
        }

        private function getInitialGameId():int
        {
            var _local_1:int;
            if (Parameters.data_.needsTutorial)
            {
                _local_1 = Parameters.TUTORIAL_GAMEID;
            }
            else
            {
                if (Parameters.data_.needsRandomRealm)
                {
                    _local_1 = Parameters.RANDOM_REALM_GAMEID;
                }
                else
                {
                    _local_1 = Parameters.NEXUS_GAMEID;
                }
            }
            return (_local_1);
        }


    }
}//package kabam.rotmg.game.commands

