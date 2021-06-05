// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.chat.control.ClearTellModelCommand

package kabam.rotmg.chat.control
{
    import robotlegs.bender.bundles.mvcs.Command;
    import kabam.rotmg.chat.model.TellModel;

    public class ClearTellModelCommand extends Command 
    {

        [Inject]
        public var tellModel:TellModel;


        override public function execute():void
        {
            this.tellModel.clearRecipients();
        }


    }
}//package kabam.rotmg.chat.control

