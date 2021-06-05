// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.arena.control.ClearCurrentRunCommand

package kabam.rotmg.arena.control
{
    import robotlegs.bender.bundles.mvcs.Command;
    import kabam.rotmg.arena.model.CurrentArenaRunModel;

    public class ClearCurrentRunCommand extends Command 
    {

        [Inject]
        public var currentRunModel:CurrentArenaRunModel;


        override public function execute():void
        {
            this.currentRunModel.clear();
        }


    }
}//package kabam.rotmg.arena.control

