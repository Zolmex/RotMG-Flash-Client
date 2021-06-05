// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.startup.model.api.StartupDelegate

package kabam.rotmg.startup.model.api
{
    import kabam.lib.tasks.Task;

    public interface StartupDelegate 
    {

        function getPriority():int;
        function make():Task;

    }
}//package kabam.rotmg.startup.model.api

