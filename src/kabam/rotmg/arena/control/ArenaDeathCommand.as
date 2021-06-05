// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.arena.control.ArenaDeathCommand

package kabam.rotmg.arena.control
{
    import robotlegs.bender.bundles.mvcs.Command;
    import kabam.rotmg.arena.model.CurrentArenaRunModel;
    import kabam.rotmg.game.model.GameModel;

    public class ArenaDeathCommand extends Command 
    {

        [Inject]
        public var model:CurrentArenaRunModel;
        [Inject]
        public var gameModel:GameModel;


        override public function execute():void
        {
            this.model.died = true;
        }


    }
}//package kabam.rotmg.arena.control

