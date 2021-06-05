// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.panels.CharacterChangerPanel

package com.company.assembleegameclient.ui.panels
{
    import kabam.rotmg.text.model.TextKey;
    import flash.events.Event;
    import com.company.assembleegameclient.game.GameSprite;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import com.company.assembleegameclient.parameters.Parameters;

    public class CharacterChangerPanel extends ButtonPanel 
    {

        public function CharacterChangerPanel(_arg_1:GameSprite)
        {
            super(_arg_1, TextKey.CHARACTER_CHANGER_TITLE, TextKey.CHARACTER_CHANGER_BUTTON);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        override protected function onButtonClick(_arg_1:MouseEvent):void
        {
            gs_.closed.dispatch();
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        }

        private function onKeyDown(_arg_1:KeyboardEvent):void
        {
            if (((_arg_1.keyCode == Parameters.data_.interact) && (stage.focus == null)))
            {
                gs_.closed.dispatch();
            }
        }


    }
}//package com.company.assembleegameclient.ui.panels

