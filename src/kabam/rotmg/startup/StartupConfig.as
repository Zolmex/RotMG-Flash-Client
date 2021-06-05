// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.startup.StartupConfig

package kabam.rotmg.startup
{
    import robotlegs.bender.framework.api.IConfig;
    import org.swiftsuspenders.Injector;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import kabam.rotmg.startup.control.StartupSequence;
    import kabam.rotmg.startup.control.StartupSignal;
    import kabam.rotmg.startup.control.StartupCommand;

    public class StartupConfig implements IConfig 
    {

        [Inject]
        public var injector:Injector;
        [Inject]
        public var commandMap:ISignalCommandMap;


        public function configure():void
        {
            this.injector.map(StartupSequence).asSingleton();
            this.commandMap.map(StartupSignal).toCommand(StartupCommand);
        }


    }
}//package kabam.rotmg.startup

