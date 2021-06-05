// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.death.control.HandleNormalDeathSignal

package kabam.rotmg.death.control
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.messaging.impl.incoming.Death;

    public class HandleNormalDeathSignal extends Signal 
    {

        public function HandleNormalDeathSignal()
        {
            super(Death);
        }

    }
}//package kabam.rotmg.death.control

