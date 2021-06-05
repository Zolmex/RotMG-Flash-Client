// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.signals.HUDSetupStarted

package kabam.rotmg.ui.signals
{
    import org.osflash.signals.Signal;
    import com.company.assembleegameclient.game.GameSprite;

    public class HUDSetupStarted extends Signal 
    {

        public function HUDSetupStarted()
        {
            super(GameSprite);
        }

    }
}//package kabam.rotmg.ui.signals

