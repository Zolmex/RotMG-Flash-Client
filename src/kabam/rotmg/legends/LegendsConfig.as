// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.legends.LegendsConfig

package kabam.rotmg.legends
{
    import robotlegs.bender.framework.api.IConfig;
    import org.swiftsuspenders.Injector;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import kabam.rotmg.legends.model.LegendFactory;
    import kabam.rotmg.legends.model.LegendsModel;
    import kabam.rotmg.legends.control.FameListUpdateSignal;
    import kabam.rotmg.legends.view.LegendsView;
    import kabam.rotmg.legends.view.LegendsMediator;
    import kabam.rotmg.legends.control.RequestFameListSignal;
    import kabam.rotmg.legends.control.RequestFameListCommand;
    import kabam.rotmg.legends.control.ExitLegendsSignal;
    import kabam.rotmg.legends.control.ExitLegendsCommand;

    public class LegendsConfig implements IConfig 
    {

        [Inject]
        public var injector:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:ISignalCommandMap;


        public function configure():void
        {
            this.injector.map(LegendFactory).asSingleton();
            this.injector.map(LegendsModel).asSingleton();
            this.injector.map(FameListUpdateSignal).asSingleton();
            this.mediatorMap.map(LegendsView).toMediator(LegendsMediator);
            this.commandMap.map(RequestFameListSignal).toCommand(RequestFameListCommand);
            this.commandMap.map(ExitLegendsSignal).toCommand(ExitLegendsCommand);
        }


    }
}//package kabam.rotmg.legends

