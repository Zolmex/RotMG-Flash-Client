// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.servers.model.LocalhostServerModel

package kabam.rotmg.servers.model
{
    import kabam.rotmg.servers.api.ServerModel;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.servers.api.Server;
    import __AS3__.vec.Vector;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import __AS3__.vec.*;

    public class LocalhostServerModel implements ServerModel 
    {

        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        private var localhost:Server;
        private var servers:Vector.<Server>;
        private var availableServers:Vector.<Server>;

        public function LocalhostServerModel()
        {
            var _local_2:String;
            var _local_3:Server;
            super();
            this.servers = new Vector.<Server>(0);
            var _local_1:int;
            while (_local_1 < 40)
            {
                _local_2 = (((_local_1 % 2) == 0) ? "localhost" : ("C_localhost" + _local_1));
                _local_3 = new Server().setName(_local_2).setAddress("localhost").setPort(Parameters.PORT);
                this.servers.push(_local_3);
                _local_1++;
            };
        }

        public function setAvailableServers(_arg_1:int):void
        {
            var _local_2:Server;
            var _local_3:Server;
            if (!this.availableServers)
            {
                this.availableServers = new Vector.<Server>(0);
            }
            else
            {
                this.availableServers.length = 0;
            };
            if (_arg_1 != 0)
            {
                for each (_local_2 in this.servers)
                {
                    if (_local_2.name.charAt(0) == "C")
                    {
                        this.availableServers.push(_local_2);
                    };
                };
            }
            else
            {
                for each (_local_3 in this.servers)
                {
                    if (_local_3.name.charAt(0) != "C")
                    {
                        this.availableServers.push(_local_3);
                    };
                };
            };
        }

        public function getAvailableServers():Vector.<Server>
        {
            return (this.availableServers);
        }

        public function getServer():Server
        {
            var _local_2:Boolean;
            var _local_6:Server;
            var _local_7:String;
            var _local_1:Boolean = this.playerModel.isAdmin();
            var _local_3:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
            if (_local_3)
            {
                _local_2 = Boolean(int(_local_3.charXML_.IsChallenger));
            }
            else
            {
                _local_2 = Boolean(this.seasonalEventModel.isChallenger);
            };
            var _local_4:int = ((_local_2) ? Server.CHALLENGER_SERVER : Server.NORMAL_SERVER);
            this.setAvailableServers(_local_4);
            var _local_5:Server;
            for each (_local_6 in this.availableServers)
            {
                if (!((_local_6.isFull()) && (!(_local_1))))
                {
                    _local_7 = ((_local_2) ? Parameters.data_.preferredChallengerServer : Parameters.data_.preferredServer);
                    if (_local_6.name == _local_7)
                    {
                        return (_local_6);
                    };
                    _local_5 = this.availableServers[0];
                    if (_local_2)
                    {
                        Parameters.data_.bestChallengerServer = _local_5.name;
                    }
                    else
                    {
                        Parameters.data_.bestServer = _local_5.name;
                    };
                    Parameters.save();
                };
            };
            return (_local_5);
        }

        public function isServerAvailable():Boolean
        {
            return (true);
        }

        public function setServers(_arg_1:Vector.<Server>):void
        {
        }

        public function getServers():Vector.<Server>
        {
            return (this.servers);
        }


    }
}//package kabam.rotmg.servers.model

