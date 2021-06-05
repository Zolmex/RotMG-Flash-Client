// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.servers.api.ServerModel

package kabam.rotmg.servers.api
{
    

    public interface ServerModel 
    {

        function setServers(_arg_1:Vector.<Server>):void;
        function getServer():Server;
        function isServerAvailable():Boolean;
        function getServers():Vector.<Server>;
        function setAvailableServers(_arg_1:int):void;
        function getAvailableServers():Vector.<Server>;

    }
}//package kabam.rotmg.servers.api

