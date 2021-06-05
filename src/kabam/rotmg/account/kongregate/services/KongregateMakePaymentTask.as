﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.kongregate.services.KongregateMakePaymentTask

package kabam.rotmg.account.kongregate.services
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.services.MakePaymentTask;
    import kabam.rotmg.account.core.PaymentData;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.account.kongregate.view.KongregateApi;
    import com.company.assembleegameclient.util.offer.Offer;

    public class KongregateMakePaymentTask extends BaseTask implements MakePaymentTask 
    {

        [Inject]
        public var payment:PaymentData;
        [Inject]
        public var account:Account;
        [Inject]
        public var api:KongregateApi;


        override protected function startTask():void
        {
            var _local_1:Offer = this.payment.offer;
            var _local_2:Object = {
                "identifier":_local_1.id_,
                "data":_local_1.data_
            };
            this.api.purchaseResponse.addOnce(this.onPurchaseResult);
            this.api.purchaseItems(_local_2);
        }

        private function onPurchaseResult(_arg_1:Object):void
        {
            completeTask(true);
        }


    }
}//package kabam.rotmg.account.kongregate.services

