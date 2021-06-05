// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.panel.DailyQuestsPanelMediator

package io.decagames.rotmg.dailyQuests.view.panel
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupByClassSignal;
    import kabam.rotmg.ui.signals.UpdateQuestSignal;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import io.decagames.rotmg.dailyQuests.view.DailyQuestWindow;
    import com.company.assembleegameclient.parameters.Parameters;
    import io.decagames.rotmg.dailyQuests.view.*;

    public class DailyQuestsPanelMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestsPanel;
        [Inject]
        public var questModel:DailyQuestsModel;
        [Inject]
        public var openDialogSignal:ShowPopupSignal;
        [Inject]
        public var closePopupByClassSignal:ClosePopupByClassSignal;
        [Inject]
        public var updateQuestSignal:UpdateQuestSignal;


        override public function initialize():void
        {
            this.addSeeQuestsText();
        }

        private function addSeeQuestsText():void
        {
            this.view.addSeeOffersButton();
            this.view.feedButton.addEventListener(MouseEvent.CLICK, this.onButtonLeftClick);
            WebMain.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        }

        override public function destroy():void
        {
            if (this.view.feedButton)
            {
                this.view.feedButton.removeEventListener(MouseEvent.CLICK, this.onButtonLeftClick);
            };
            WebMain.STAGE.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            this.closePopupByClassSignal.dispatch(DailyQuestWindow);
        }

        protected function onButtonLeftClick(_arg_1:MouseEvent):void
        {
            if (!this.questModel.isPopupOpened)
            {
                this.openDialogSignal.dispatch(new DailyQuestWindow());
            };
        }

        private function onKeyDown(_arg_1:KeyboardEvent):void
        {
            if (((_arg_1.keyCode == Parameters.data_.interact) && (WebMain.STAGE.focus == null)))
            {
                this.onButtonLeftClick(null);
            };
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.panel

