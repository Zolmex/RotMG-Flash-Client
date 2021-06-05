// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.commands.ParsePotionDataCommand

package kabam.rotmg.game.commands
{
    import kabam.rotmg.game.model.PotionInventoryModel;

    public class ParsePotionDataCommand 
    {

        [Inject]
        public var data:XML;
        [Inject]
        public var potionInventoryModel:PotionInventoryModel;


        public function execute():void
        {
            this.potionInventoryModel.initializePotionModels(this.data);
        }


    }
}//package kabam.rotmg.game.commands

