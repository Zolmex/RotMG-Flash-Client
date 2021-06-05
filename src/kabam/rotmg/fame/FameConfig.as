// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.fame.FameConfig

package kabam.rotmg.fame
{
    import robotlegs.bender.framework.api.IConfig;
    import org.swiftsuspenders.Injector;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import kabam.rotmg.fame.model.FameModel;
    import kabam.rotmg.fame.service.RequestCharacterFameTask;
    import kabam.rotmg.fame.control.ShowFameViewSignal;
    import kabam.rotmg.fame.control.ShowFameViewCommand;
    import kabam.rotmg.fame.view.FameView;
    import kabam.rotmg.fame.view.FameMediator;

    public class FameConfig implements IConfig 
    {

        [Inject]
        public var injector:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:ISignalCommandMap;


        public function configure():void
        {
            this.injector.map(FameModel).asSingleton();
            this.injector.map(RequestCharacterFameTask);
            this.commandMap.map(ShowFameViewSignal).toCommand(ShowFameViewCommand);
            this.mediatorMap.map(FameView).toMediator(FameMediator);
        }


    }
}//package kabam.rotmg.fame

