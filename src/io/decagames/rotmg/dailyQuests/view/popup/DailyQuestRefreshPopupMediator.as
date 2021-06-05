// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRefreshPopupMediator

package io.decagames.rotmg.dailyQuests.view.popup
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.dailyQuests.signal.CloseRefreshPopupSignal;
    import kabam.rotmg.ui.model.HUDModel;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class DailyQuestRefreshPopupMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestRefreshPopup;
        [Inject]
        public var closeRefreshPopupSignal:CloseRefreshPopupSignal;
        [Inject]
        public var hudModel:HUDModel;
        private var closeButton:SliceScalingButton;


        override public function initialize():void
        {
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.view.buyQuestRefreshButton.clickSignal.add(this.onBuyRefresh);
        }

        private function onBuyRefresh(_arg_1:BaseButton):void
        {
            this.hudModel.gameSprite.gsc_.resetDailyQuests();
            this.closeRefreshPopupSignal.dispatch();
        }

        override public function destroy():void
        {
            this.closeButton.clickSignal.remove(this.onClose);
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closeRefreshPopupSignal.dispatch();
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.popup

