// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.social.widgets.GuildListItemMediator

package io.decagames.rotmg.social.widgets
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.ui.signals.EnterGameSignal;
    import io.decagames.rotmg.social.model.SocialModel;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.game.signals.PlayGameSignal;
    import kabam.rotmg.chat.control.ShowChatInputSignal;
    import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
    import io.decagames.rotmg.social.signals.RefreshListSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.messaging.impl.GameServerConnection;
    import com.company.assembleegameclient.game.GameSprite;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.ui.dialogs.Dialog;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import com.company.assembleegameclient.game.events.GuildResultEvent;
    import flash.events.Event;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.game.model.GameInitData;
    import com.company.assembleegameclient.util.GuildUtil;

    public class GuildListItemMediator extends Mediator 
    {

        [Inject]
        public var view:GuildListItem;
        [Inject]
        public var enterGame:EnterGameSignal;
        [Inject]
        public var socialModel:SocialModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var playGame:PlayGameSignal;
        [Inject]
        public var chatSignal:ShowChatInputSignal;
        [Inject]
        public var closeCurrentPopup:CloseCurrentPopupSignal;
        [Inject]
        public var refreshSignal:RefreshListSignal;
        [Inject]
        public var openDialogSignal:OpenDialogSignal;
        [Inject]
        public var closeDialogsSignal:CloseDialogsSignal;
        [Inject]
        public var hudModel:HUDModel;
        private var _gameServerConnection:GameServerConnection;
        private var _gameSprite:GameSprite;


        override public function initialize():void
        {
            this._gameSprite = this.hudModel.gameSprite;
            this._gameServerConnection = this._gameSprite.gsc_;
            if (this.view.removeButton)
            {
                this.view.removeButton.addEventListener(MouseEvent.CLICK, this.onRemoveClick);
            };
            if (this.view.messageButton)
            {
                this.view.messageButton.addEventListener(MouseEvent.CLICK, this.onMessageClick);
            };
            if (this.view.teleportButton)
            {
                this.view.teleportButton.addEventListener(MouseEvent.CLICK, this.onTeleportClick);
            };
            if (this.view.promoteButton)
            {
                this.view.promoteButton.addEventListener(MouseEvent.CLICK, this.onPromoteClick);
            };
            if (this.view.demoteButton)
            {
                this.view.demoteButton.addEventListener(MouseEvent.CLICK, this.onDemoteClick);
            };
        }

        private function onRemoveClick(_arg_1:MouseEvent):void
        {
            var _local_2:Dialog = new Dialog("", "", TextKey.REMOVE_LEFT, TextKey.REMOVE_RIGHT, "/removeFromGuild");
            _local_2.setTextParams(TextKey.REMOVE_TEXT, {"name":this.view.getLabelText()});
            _local_2.setTitleStringBuilder(new LineBuilder().setParams(TextKey.REMOVE_TITLE, {"name":this.view.getLabelText()}));
            _local_2.addEventListener(Dialog.LEFT_BUTTON, this.onCancelDialog);
            _local_2.addEventListener(Dialog.RIGHT_BUTTON, this.onVerifiedRemove);
            this.openDialogSignal.dispatch(_local_2);
        }

        private function onVerifiedRemove(_arg_1:Event):void
        {
            this.closeDialogsSignal.dispatch();
            this._gameSprite.addEventListener(GuildResultEvent.EVENT, this.onRemoveResult);
            this._gameServerConnection.guildRemove(this.view.getLabelText());
        }

        private function onRemoveResult(_arg_1:GuildResultEvent):void
        {
            this._gameSprite.removeEventListener(GuildResultEvent.EVENT, this.onRemoveResult);
            if (_arg_1.success_)
            {
                this.socialModel.removeGuildMember(this.view.getLabelText());
                this.refreshSignal.dispatch(RefreshListSignal.CONTEXT_GUILD_LIST, _arg_1.success_);
            };
        }

        private function onCancelDialog(_arg_1:Event):void
        {
            this.closeDialogsSignal.dispatch();
        }

        private function onTeleportClick(_arg_1:MouseEvent):void
        {
            var _local_2:Boolean;
            var _local_3:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
            if (_local_3)
            {
                _local_2 = Boolean(int(_local_3.charXML_.IsChallenger));
            };
            if (_local_2)
            {
                Parameters.data_.preferredChallengerServer = this.view.guildMemberVO.serverName;
            }
            else
            {
                Parameters.data_.preferredServer = this.view.guildMemberVO.serverName;
            };
            Parameters.save();
            this.enterGame.dispatch();
            var _local_4:GameInitData = new GameInitData();
            _local_4.createCharacter = false;
            _local_4.charId = _local_3.charId();
            _local_4.isNewGame = true;
            this.playGame.dispatch(_local_4);
            this.closeCurrentPopup.dispatch();
        }

        private function onMessageClick(_arg_1:MouseEvent):void
        {
            this.chatSignal.dispatch(true, (("/tell " + this.view.getLabelText()) + " "));
            this.closeCurrentPopup.dispatch();
        }

        private function onPromoteClick(_arg_1:MouseEvent):void
        {
            var _local_2:String = GuildUtil.rankToString(GuildUtil.promotedRank(this.view.guildMemberVO.rank));
            var _local_3:Dialog = new Dialog("", "", TextKey.PROMOTE_LEFTBUTTON, TextKey.PROMOTE_RIGHTBUTTON, "/promote");
            _local_3.setTextParams(TextKey.PROMOTE_TEXT, {
                "name":this.view.getLabelText(),
                "rank":_local_2
            });
            _local_3.setTitleStringBuilder(new LineBuilder().setParams(TextKey.PROMOTE_TITLE, {"name":this.view.getLabelText()}));
            _local_3.addEventListener(Dialog.LEFT_BUTTON, this.onCancelDialog);
            _local_3.addEventListener(Dialog.RIGHT_BUTTON, this.onVerifiedPromote);
            this.openDialogSignal.dispatch(_local_3);
        }

        private function onVerifiedPromote(_arg_1:Event):void
        {
            this.closeDialogsSignal.dispatch();
            this._gameSprite.addEventListener(GuildResultEvent.EVENT, this.onSetRankResult);
            this._gameServerConnection.changeGuildRank(this.view.getLabelText(), GuildUtil.promotedRank(this.view.guildMemberVO.rank));
        }

        private function onSetRankResult(_arg_1:GuildResultEvent):void
        {
            this._gameSprite.removeEventListener(GuildResultEvent.EVENT, this.onSetRankResult);
            if (_arg_1.success_)
            {
                this.socialModel.loadGuildData();
            };
        }

        private function onDemoteClick(_arg_1:MouseEvent):void
        {
            var _local_2:String = GuildUtil.rankToString(GuildUtil.demotedRank(this.view.guildMemberVO.rank));
            var _local_3:Dialog = new Dialog("", "", TextKey.DEMOTE_LEFT, TextKey.DEMOTE_RIGHT, "/demote");
            _local_3.setTextParams(TextKey.DEMOTE_TEXT, {
                "name":this.view.getLabelText(),
                "rank":_local_2
            });
            _local_3.setTitleStringBuilder(new LineBuilder().setParams(TextKey.DEMOTE_TITLE, {"name":this.view.getLabelText()}));
            _local_3.addEventListener(Dialog.LEFT_BUTTON, this.onCancelDialog);
            _local_3.addEventListener(Dialog.RIGHT_BUTTON, this.onVerifiedDemote);
            this.openDialogSignal.dispatch(_local_3);
        }

        private function onVerifiedDemote(_arg_1:Event):void
        {
            this.closeDialogsSignal.dispatch();
            this._gameSprite.addEventListener(GuildResultEvent.EVENT, this.onSetRankResult);
            this._gameServerConnection.changeGuildRank(this.view.getLabelText(), GuildUtil.demotedRank(this.view.guildMemberVO.rank));
        }


    }
}//package io.decagames.rotmg.social.widgets

