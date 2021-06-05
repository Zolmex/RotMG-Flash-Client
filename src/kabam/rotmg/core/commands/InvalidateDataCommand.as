// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.core.commands.InvalidateDataCommand

package kabam.rotmg.core.commands
{
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.account.core.model.JSInitializedModel;

    public class InvalidateDataCommand 
    {

        [Inject]
        public var model:PlayerModel;
        [Inject]
        public var jsInitialized:JSInitializedModel;


        public function execute():void
        {
            this.model.isInvalidated = true;
            this.jsInitialized.isInitialized = false;
        }


    }
}//package kabam.rotmg.core.commands

