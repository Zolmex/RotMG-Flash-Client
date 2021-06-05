// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.signals.PlayGameSignal

package kabam.rotmg.game.signals
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.game.model.GameInitData;

    public class PlayGameSignal extends Signal 
    {

        public function PlayGameSignal()
        {
            super(GameInitData);
        }

    }
}//package kabam.rotmg.game.signals

