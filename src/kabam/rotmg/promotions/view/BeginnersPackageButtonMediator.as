﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.promotions.view.BeginnersPackageButtonMediator

package kabam.rotmg.promotions.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.promotions.model.BeginnersPackageModel;
    import kabam.rotmg.promotions.signals.ShowBeginnersPackageSignal;

    public class BeginnersPackageButtonMediator extends Mediator 
    {

        [Inject]
        public var view:BeginnersPackageButton;
        [Inject]
        public var model:BeginnersPackageModel;
        [Inject]
        public var showBeginnersPackage:ShowBeginnersPackageSignal;


        override public function initialize():void
        {
            this.model.markedAsPurchased.addOnce(this.onMarkedAsPurchased);
            this.view.clicked.add(this.onButtonClick);
            this.view.setDaysRemaining(this.model.getDaysRemaining());
        }

        override public function destroy():void
        {
            this.model.markedAsPurchased.remove(this.onMarkedAsPurchased);
            this.view.clicked.remove(this.onButtonClick);
        }

        private function onButtonClick():void
        {
            this.showBeginnersPackage.dispatch();
        }

        private function onMarkedAsPurchased():void
        {
            this.view.destroy();
        }


    }
}//package kabam.rotmg.promotions.view

