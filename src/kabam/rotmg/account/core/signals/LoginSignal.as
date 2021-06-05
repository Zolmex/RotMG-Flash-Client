// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.core.signals.LoginSignal

package kabam.rotmg.account.core.signals
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.account.web.model.AccountData;

    public class LoginSignal extends Signal 
    {

        public function LoginSignal()
        {
            super(AccountData);
        }

    }
}//package kabam.rotmg.account.core.signals

