// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.external.command.MapExternalCallbacksCommand

package kabam.rotmg.external.command
{
    import robotlegs.bender.bundles.mvcs.Command;
    import kabam.rotmg.external.service.ExternalServiceHelper;

    public class MapExternalCallbacksCommand extends Command 
    {

        [Inject]
        public var externalServiceHelper:ExternalServiceHelper;


        override public function execute():void
        {
            this.externalServiceHelper.mapExternalCallbacks();
        }


    }
}//package kabam.rotmg.external.command

