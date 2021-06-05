// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRefreshPopup

package io.decagames.rotmg.dailyQuests.view.popup
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;

    public class DailyQuestRefreshPopup extends ModalPopup 
    {

        private const TITLE:String = "Refresh Daily Quests";
        private const TEXT:String = "Do you want to refresh your Daily Quests? All Daily Quests will be refreshed!";
        private const WIDTH:int = 300;
        private const HEIGHT:int = 100;

        private var _refreshPrice:int;
        private var _buyQuestRefreshButton:BuyQuestRefreshButton;

        public function DailyQuestRefreshPopup(_arg_1:int)
        {
            super(this.WIDTH, this.HEIGHT, this.TITLE);
            this._refreshPrice = _arg_1;
            this.init();
        }

        private function init():void
        {
            var _local_1:UILabel = new UILabel();
            _local_1.width = 280;
            _local_1.multiline = true;
            _local_1.wordWrap = true;
            _local_1.text = this.TEXT;
            DefaultLabelFormat.defaultSmallPopupTitle(_local_1, TextFormatAlign.CENTER);
            _local_1.x = ((this.WIDTH - _local_1.width) / 2);
            _local_1.y = 10;
            addChild(_local_1);
            this._buyQuestRefreshButton = new BuyQuestRefreshButton(this._refreshPrice);
            this._buyQuestRefreshButton.x = ((this.WIDTH - this._buyQuestRefreshButton.width) / 2);
            this._buyQuestRefreshButton.y = 60;
            addChild(this._buyQuestRefreshButton);
        }

        public function get buyQuestRefreshButton():BuyQuestRefreshButton
        {
            return (this._buyQuestRefreshButton);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.popup

