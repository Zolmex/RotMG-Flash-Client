// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.servers.model.FixedIPServerModel

package kabam.rotmg.servers.model
{
    import kabam.rotmg.servers.api.ServerModel;
    import kabam.rotmg.servers.api.Server;
    import com.company.assembleegameclient.parameters.Parameters;
    

    public class FixedIPServerModel implements ServerModel 
    {

        private var localhost:Server;

        public function FixedIPServerModel()
        {
            this.localhost = new Server().setName("localhost").setPort(Parameters.PORT);
        }

        public function setIP(_arg_1:String):FixedIPServerModel
        {
            this.localhost.setAddress(_arg_1);
            return (this);
        }

        public function getServers():Vector.<Server>
        {
            return (new <Server>[this.localhost]);
        }

        public function getServer():Server
        {
            return (this.localhost);
        }

        public function isServerAvailable():Boolean
        {
            return (true);
        }

        public function setServers(_arg_1:Vector.<Server>):void
        {
        }

        public function setAvailableServers(_arg_1:int):void
        {
        }

        public function getAvailableServers():Vector.<Server>
        {
            return (new <Server>[this.localhost]);
        }


    }
}//package kabam.rotmg.servers.model

