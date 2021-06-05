// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.core.signals.TrackEventSignal

package kabam.rotmg.core.signals
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.core.service.TrackingData;

    public class TrackEventSignal extends Signal 
    {

        public function TrackEventSignal()
        {
            super(TrackingData);
        }

    }
}//package kabam.rotmg.core.signals

