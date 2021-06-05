// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.maploading.signals.MapLoadedSignal

package kabam.rotmg.maploading.signals
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.messaging.impl.incoming.MapInfo;

    public class MapLoadedSignal extends Signal 
    {

        public function MapLoadedSignal()
        {
            super(MapInfo);
        }

    }
}//package kabam.rotmg.maploading.signals

