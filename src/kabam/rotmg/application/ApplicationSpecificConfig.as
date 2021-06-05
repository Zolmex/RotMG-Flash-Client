// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.application.ApplicationSpecificConfig

package kabam.rotmg.application
{
    import robotlegs.bender.framework.api.IConfig;
    import robotlegs.bender.framework.api.IContext;
    import kabam.rotmg.application.api.ApplicationSetup;
    import kabam.lib.console.ConsoleExtension;

    public class ApplicationSpecificConfig implements IConfig 
    {

        [Inject]
        public var context:IContext;
        [Inject]
        public var applicationSetup:ApplicationSetup;


        public function configure():void
        {
            if (this.applicationSetup.isDebug())
            {
                this.context.extend(ConsoleExtension);
            }
        }


    }
}//package kabam.rotmg.application

