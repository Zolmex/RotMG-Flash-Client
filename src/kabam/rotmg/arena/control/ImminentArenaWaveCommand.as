// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.arena.control.ImminentArenaWaveCommand

package kabam.rotmg.arena.control
{
    import robotlegs.bender.bundles.mvcs.Command;
    import kabam.rotmg.arena.model.CurrentArenaRunModel;
    import kabam.rotmg.core.view.Layers;
    import kabam.rotmg.arena.view.ImminentWaveCountdownClock;

    public class ImminentArenaWaveCommand extends Command 
    {

        [Inject]
        public var runtime:int;
        [Inject]
        public var model:CurrentArenaRunModel;
        [Inject]
        public var layers:Layers;


        override public function execute():void
        {
            this.model.incrementWave();
            this.model.entry.runtime = this.runtime;
            this.layers.mouseDisabledTop.addChild(new ImminentWaveCountdownClock());
        }


    }
}//package kabam.rotmg.arena.control

