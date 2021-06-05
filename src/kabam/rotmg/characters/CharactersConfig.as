// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.characters.CharactersConfig

package kabam.rotmg.characters
{
    import robotlegs.bender.framework.api.IConfig;
    import robotlegs.bender.framework.api.IContext;
    import org.swiftsuspenders.Injector;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import kabam.rotmg.characters.model.CharacterModel;
    import kabam.rotmg.characters.model.LegacyCharacterModel;
    import kabam.rotmg.characters.deletion.DeletionConfig;
    import kabam.rotmg.characters.reskin.ReskinConfig;

    public class CharactersConfig implements IConfig 
    {

        [Inject]
        public var context:IContext;
        [Inject]
        public var injector:Injector;
        [Inject]
        public var commandMap:ISignalCommandMap;


        public function configure():void
        {
            this.injector.map(CharacterModel).toSingleton(LegacyCharacterModel);
            this.context.configure(DeletionConfig);
            this.context.configure(ReskinConfig);
        }


    }
}//package kabam.rotmg.characters

