// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.OutstandingBuy

package kabam.rotmg.messaging.impl
{
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.core.service.GoogleAnalytics;

    internal class OutstandingBuy 
    {

        private var id_:String;
        private var price_:int;
        private var currency_:int;
        private var converted_:Boolean;

        public function OutstandingBuy(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean)
        {
            this.id_ = _arg_1;
            this.price_ = _arg_2;
            this.currency_ = _arg_3;
            this.converted_ = _arg_4;
        }

        public function record():void
        {
            var _local_1:GoogleAnalytics = StaticInjectorContext.getInjector().getInstance(GoogleAnalytics);
            if (_local_1)
            {
            };
        }


    }
}//package kabam.rotmg.messaging.impl

