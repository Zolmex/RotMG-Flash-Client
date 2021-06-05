// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.signals.HideKeySignal

package kabam.rotmg.ui.signals
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.ui.model.Key;

    public class HideKeySignal extends Signal 
    {

        public static var instance:HideKeySignal;

        public function HideKeySignal()
        {
            super(Key);
            instance = this;
        }

    }
}//package kabam.rotmg.ui.signals

