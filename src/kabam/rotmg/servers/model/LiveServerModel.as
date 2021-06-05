// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.servers.model.LiveServerModel

package kabam.rotmg.servers.model
{
    import kabam.rotmg.servers.api.ServerModel;
    
    import kabam.rotmg.servers.api.Server;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import kabam.rotmg.servers.api.LatLong;
    import com.company.assembleegameclient.parameters.Parameters;
    

    public class LiveServerModel implements ServerModel 
    {

        private const servers:Vector.<Server> = new Vector.<Server>(0);

        [Inject]
        public var model:PlayerModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        private var _descendingFlag:Boolean;
        private var availableServers:Vector.<Server>;


        public function setServers(_arg_1:Vector.<Server>):void
        {
            var _local_2:Server;
            this.servers.length = 0;
            for each (_local_2 in _arg_1)
            {
                this.servers.push(_local_2);
            }
            this._descendingFlag = false;
            this.servers.sort(this.compareServerName);
        }

        public function getServers():Vector.<Server>
        {
            return (this.servers);
        }

        public function getServer():Server
        {
            var _local_2:Boolean;
            var _local_10:Server;
            var _local_11:int;
            var _local_12:Number;
            var _local_1:Boolean = this.model.isAdmin();
            var _local_3:SavedCharacter = this.model.getCharacterById(this.model.currentCharId);
            if (_local_3)
            {
                _local_2 = Boolean(int(_local_3.charXML_.IsChallenger));
            }
            else
            {
                _local_2 = Boolean(this.seasonalEventModel.isChallenger);
            }
            var _local_4:int = ((_local_2) ? Server.CHALLENGER_SERVER : Server.NORMAL_SERVER);
            this.setAvailableServers(_local_4);
            var _local_5:LatLong = this.model.getMyPos();
            var _local_6:Server;
            var _local_7:Number = Number.MAX_VALUE;
            var _local_8:int = int.MAX_VALUE;
            var _local_9:String = ((_local_2) ? Parameters.data_.preferredChallengerServer : Parameters.data_.preferredServer);
            for each (_local_10 in this.availableServers)
            {
                if (!((_local_10.isFull()) && (!(_local_1))))
                {
                    if (_local_10.name == _local_9)
                    {
                        return (_local_10);
                    }
                    _local_11 = _local_10.priority();
                    _local_12 = LatLong.distance(_local_5, _local_10.latLong);
                    if (((_local_11 < _local_8) || ((_local_11 == _local_8) && (_local_12 < _local_7))))
                    {
                        _local_6 = _local_10;
                        _local_7 = _local_12;
                        _local_8 = _local_11;
                        if (_local_2)
                        {
                            Parameters.data_.bestChallengerServer = _local_6.name;
                        }
                        else
                        {
                            Parameters.data_.bestServer = _local_6.name;
                        }
                        Parameters.save();
                    }
                }
            }
            return (_local_6);
        }

        public function getServerNameByAddress(_arg_1:String):String
        {
            var _local_2:Server;
            for each (_local_2 in this.servers)
            {
                if (_local_2.address == _arg_1)
                {
                    return (_local_2.name);
                }
            }
            return ("");
        }

        public function isServerAvailable():Boolean
        {
            return (this.servers.length > 0);
        }

        private function compareServerName(_arg_1:Server, _arg_2:Server):int
        {
            if (_arg_1.name < _arg_2.name)
            {
                return ((this._descendingFlag) ? -1 : 1);
            }
            if (_arg_1.name > _arg_2.name)
            {
                return ((this._descendingFlag) ? 1 : -1);
            }
            return (0);
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
            }
            if (_arg_1 != 0)
            {
                for each (_local_2 in this.servers)
                {
                    if (_local_2.name.charAt(0) == "C")
                    {
                        this.availableServers.push(_local_2);
                    }
                }
            }
            else
            {
                for each (_local_3 in this.servers)
                {
                    if (_local_3.name.charAt(0) != "C")
                    {
                        this.availableServers.push(_local_3);
                    }
                }
            }
        }

        public function getAvailableServers():Vector.<Server>
        {
            return (this.availableServers);
        }


    }
}//package kabam.rotmg.servers.model

