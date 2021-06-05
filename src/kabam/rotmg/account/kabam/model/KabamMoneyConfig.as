// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.kabam.model.KabamMoneyConfig

package kabam.rotmg.account.kabam.model
{
    import kabam.rotmg.account.core.model.MoneyConfig;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import com.company.assembleegameclient.util.offer.Offer;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;

    public class KabamMoneyConfig implements MoneyConfig 
    {


        public function showPaymentMethods():Boolean
        {
            return (true);
        }

        public function showBonuses():Boolean
        {
            return (false);
        }

        public function parseOfferPrice(_arg_1:Offer):StringBuilder
        {
            return (new LineBuilder());
        }

        public function jsInitializeFunction():String
        {
            return ("rotmg.KabamPayment.setupKabamAccount");
        }


    }
}//package kabam.rotmg.account.kabam.model

