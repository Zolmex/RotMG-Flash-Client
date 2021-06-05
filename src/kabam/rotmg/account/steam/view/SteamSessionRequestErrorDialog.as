// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.steam.view.SteamSessionRequestErrorDialog

package kabam.rotmg.account.steam.view
{
    import com.company.assembleegameclient.ui.dialogs.DebugDialog;
    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.NativeMappedSignal;
    import com.company.assembleegameclient.ui.dialogs.Dialog;

    public class SteamSessionRequestErrorDialog extends DebugDialog 
    {

        public var ok:Signal;

        public function SteamSessionRequestErrorDialog()
        {
            super("Failed to retrieve valid Steam Credentials! Click to retry.");
            this.ok = new NativeMappedSignal(this, Dialog.LEFT_BUTTON);
        }

    }
}//package kabam.rotmg.account.steam.view

