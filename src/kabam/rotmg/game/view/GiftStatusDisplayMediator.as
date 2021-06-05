// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.view.GiftStatusDisplayMediator

package kabam.rotmg.game.view
{
    import kabam.rotmg.game.signals.UpdateGiftStatusDisplaySignal;
    import com.company.assembleegameclient.game.GiftStatusModel;
    import com.company.assembleegameclient.game.events.DisplayAreaChangedSignal;

    public class GiftStatusDisplayMediator 
    {

        [Inject]
        public var updateGiftStatusDisplay:UpdateGiftStatusDisplaySignal;
        [Inject]
        public var view:GiftStatusDisplay;
        [Inject]
        public var giftStatusModel:GiftStatusModel;
        [Inject]
        public var displayAreaChangedSignal:DisplayAreaChangedSignal;


        public function initialize():void
        {
            this.updateGiftStatusDisplay.add(this.onGiftChestUpdate);
            this.onGiftChestUpdate();
        }

        private function onGiftChestUpdate():void
        {
            if (this.giftStatusModel.hasGift)
            {
                this.view.drawAsOpen();
            }
            else
            {
                this.view.drawAsClosed();
            }
            this.displayAreaChangedSignal.dispatch();
        }


    }
}//package kabam.rotmg.game.view

