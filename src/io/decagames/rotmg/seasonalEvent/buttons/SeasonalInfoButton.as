// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.buttons.SeasonalInfoButton

package io.decagames.rotmg.seasonalEvent.buttons
{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.buttons.InfoButton;

    public class SeasonalInfoButton extends Sprite 
    {

        private var _infoButton:InfoButton;

        public function SeasonalInfoButton()
        {
            this.init();
        }

        private function init():void
        {
            this.createInfoButton();
        }

        private function createInfoButton():void
        {
            this._infoButton = new InfoButton(10);
            addChild(this._infoButton);
        }

        public function get infoButton():InfoButton
        {
            return (this._infoButton);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.buttons

