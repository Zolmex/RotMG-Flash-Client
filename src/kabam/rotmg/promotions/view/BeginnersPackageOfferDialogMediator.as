// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.promotions.view.BeginnersPackageOfferDialogMediator

package kabam.rotmg.promotions.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.promotions.model.BeginnersPackageModel;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.promotions.signals.BuyBeginnersPackageSignal;
    import kabam.rotmg.game.signals.SetWorldInteractionSignal;
    import kabam.rotmg.dailyLogin.model.DailyLoginModel;
    import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;

    public class BeginnersPackageOfferDialogMediator extends Mediator 
    {

        [Inject]
        public var view:BeginnersPackageOfferDialog;
        [Inject]
        public var model:BeginnersPackageModel;
        [Inject]
        public var closeDialog:CloseDialogsSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var buyPackage:BuyBeginnersPackageSignal;
        [Inject]
        public var setWorldInteraction:SetWorldInteractionSignal;
        [Inject]
        public var dailyLoginModel:DailyLoginModel;
        [Inject]
        public var flushStartupQueue:FlushPopupStartupQueueSignal;


        override public function initialize():void
        {
            this.view.buy.add(this.onBuy);
            this.view.close.add(this.onClose);
            this.view.centerOnScreen();
            this.setWorldInteraction.dispatch(false);
        }

        override public function destroy():void
        {
            this.view.buy.remove(this.onBuy);
            this.view.close.remove(this.onClose);
            this.setWorldInteraction.dispatch(true);
        }

        private function onBuy():void
        {
            this.closeDialog.dispatch();
            this.buyPackage.dispatch();
        }

        private function onClose():void
        {
            this.closeDialog.dispatch();
            this.flushStartupQueue.dispatch();
        }


    }
}//package kabam.rotmg.promotions.view

