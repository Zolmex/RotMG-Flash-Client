﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.panels.GuildBoardPanel

package com.company.assembleegameclient.ui.panels
{
    import kabam.rotmg.text.model.TextKey;
    import flash.events.Event;
    import com.company.assembleegameclient.game.GameSprite;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.ui.board.GuildBoardWindow;
    import com.company.assembleegameclient.util.GuildUtil;
    import flash.events.KeyboardEvent;
    import com.company.assembleegameclient.parameters.Parameters;

    public class GuildBoardPanel extends ButtonPanel 
    {

        public function GuildBoardPanel(_arg_1:GameSprite)
        {
            super(_arg_1, TextKey.GUILD_BOARD_TITLE, TextKey.PANEL_VIEW_BUTTON);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        override protected function onButtonClick(_arg_1:MouseEvent):void
        {
            this.openWindow();
        }

        private function openWindow():void
        {
            var _local_1:Player = gs_.map.player_;
            if (_local_1 == null)
            {
                return;
            };
            gs_.addChild(new GuildBoardWindow((_local_1.guildRank_ >= GuildUtil.OFFICER)));
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
                this.openWindow();
            };
        }


    }
}//package com.company.assembleegameclient.ui.panels

