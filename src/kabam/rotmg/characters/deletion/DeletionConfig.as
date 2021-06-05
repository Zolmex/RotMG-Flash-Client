// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.characters.deletion.DeletionConfig

package kabam.rotmg.characters.deletion
{
    import robotlegs.bender.framework.api.IConfig;
    import org.swiftsuspenders.Injector;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import kabam.rotmg.characters.deletion.service.DeleteCharacterTask;
    import kabam.rotmg.characters.deletion.view.ConfirmDeleteCharacterDialog;
    import kabam.rotmg.characters.deletion.view.ConfirmDeleteCharacterMediator;
    import kabam.rotmg.characters.deletion.control.DeleteCharacterSignal;
    import kabam.rotmg.characters.deletion.control.DeleteCharacterCommand;

    public class DeletionConfig implements IConfig 
    {

        [Inject]
        public var injector:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:ISignalCommandMap;


        public function configure():void
        {
            this.injector.map(DeleteCharacterTask);
            this.mediatorMap.map(ConfirmDeleteCharacterDialog).toMediator(ConfirmDeleteCharacterMediator);
            this.commandMap.map(DeleteCharacterSignal).toCommand(DeleteCharacterCommand);
        }


    }
}//package kabam.rotmg.characters.deletion

