// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.menu.PlayerMenu

package com.company.assembleegameclient.ui.menu
{
    import com.company.assembleegameclient.game.AGameSprite;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.ui.GameObjectListItem;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.filters.DropShadowFilter;
    import com.company.util.AssetLibrary;
    import kabam.rotmg.text.model.TextKey;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.company.assembleegameclient.util.GuildUtil;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.chat.control.ShowChatInputSignal;
    import io.decagames.rotmg.social.signals.FriendActionSignal;
    import io.decagames.rotmg.social.model.FriendRequestVO;
    import io.decagames.rotmg.social.config.FriendsActions;

    public class PlayerMenu extends Menu 
    {

        public var gs_:AGameSprite;
        public var playerName_:String;
        public var player_:Player;
        public var playerPanel_:GameObjectListItem;
        public var namePlate_:TextFieldDisplayConcrete;

        public function PlayerMenu()
        {
            super(0x363636, 0xFFFFFF);
        }

        public function initDifferentServer(_arg_1:AGameSprite, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            var _local_5:MenuOption;
            this.gs_ = _arg_1;
            this.playerName_ = _arg_2;
            this.player_ = null;
            this.namePlate_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xFCDF00).setHTML(true);
            this.namePlate_.setStringBuilder(new LineBuilder().setParams(this.playerName_));
            this.namePlate_.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.namePlate_);
            this.yOffset = (this.yOffset - 13);
            _local_5 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 21), 0xFFFFFF, TextKey.PLAYERMENU_PM);
            _local_5.addEventListener(MouseEvent.CLICK, this.onPrivateMessage);
            addOption(_local_5);
            _local_5 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 8), 0xFFFFFF, TextKey.FRIEND_BLOCK_BUTTON);
            _local_5.addEventListener(MouseEvent.CLICK, this.onIgnoreDifferentServer);
            addOption(_local_5);
            _local_5 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 18), 0xFFFFFF, "Add Friend");
            _local_5.addEventListener(MouseEvent.CLICK, this.onAddFriend);
            addOption(_local_5);
        }

        private function onIgnoreDifferentServer(_arg_1:Event):void
        {
            this.gs_.gsc_.playerText(("/ignore " + this.playerName_));
            remove();
        }

        public function init(_arg_1:AGameSprite, _arg_2:Player):void
        {
            var _local_3:MenuOption;
            this.gs_ = _arg_1;
            this.playerName_ = _arg_2.name_;
            this.player_ = _arg_2;
            this.playerPanel_ = new GameObjectListItem(0xB3B3B3, true, this.player_, true);
            this.yOffset = (this.yOffset + 7);
            addChild(this.playerPanel_);
            if (((Player.isAdmin) || (Player.isMod)))
            {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 10), 0xFFFFFF, "Ban MultiBoxer");
                _local_3.addEventListener(MouseEvent.CLICK, this.onKickMultiBox);
                addOption(_local_3);
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 10), 0xFFFFFF, "Ban RWT");
                _local_3.addEventListener(MouseEvent.CLICK, this.onKickRWT);
                addOption(_local_3);
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 10), 0xFFFFFF, "Ban Cheat");
                _local_3.addEventListener(MouseEvent.CLICK, this.onKickCheat);
                addOption(_local_3);
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 4), 0xFFFFFF, TextKey.PLAYERMENU_MUTE);
                _local_3.addEventListener(MouseEvent.CLICK, this.onMute);
                addOption(_local_3);
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 3), 0xFFFFFF, TextKey.PLAYERMENU_UNMUTE);
                _local_3.addEventListener(MouseEvent.CLICK, this.onUnMute);
                addOption(_local_3);
            }
            if (((this.gs_.map.allowPlayerTeleport()) && (this.player_.isTeleportEligible(this.player_))))
            {
                _local_3 = new TeleportMenuOption(this.gs_.map.player_);
                _local_3.addEventListener(MouseEvent.CLICK, this.onTeleport);
                addOption(_local_3);
            }
            if (((this.gs_.map.player_.guildRank_ >= GuildUtil.OFFICER) && ((_arg_2.guildName_ == null) || (_arg_2.guildName_.length == 0))))
            {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 10), 0xFFFFFF, TextKey.PLAYERMENU_INVITE);
                _local_3.addEventListener(MouseEvent.CLICK, this.onInvite);
                addOption(_local_3);
            }
            if (!this.player_.starred_)
            {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterface2", 5), 0xFFFFFF, TextKey.PLAYERMENU_LOCK);
                _local_3.addEventListener(MouseEvent.CLICK, this.onLock);
                addOption(_local_3);
            }
            else
            {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterface2", 6), 0xFFFFFF, TextKey.PLAYERMENU_UNLOCK);
                _local_3.addEventListener(MouseEvent.CLICK, this.onUnlock);
                addOption(_local_3);
            }
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 7), 0xFFFFFF, TextKey.PLAYERMENU_TRADE);
            _local_3.addEventListener(MouseEvent.CLICK, this.onTrade);
            addOption(_local_3);
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 21), 0xFFFFFF, TextKey.PLAYERMENU_PM);
            _local_3.addEventListener(MouseEvent.CLICK, this.onPrivateMessage);
            addOption(_local_3);
            if (this.player_.isFellowGuild_)
            {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 21), 0xFFFFFF, TextKey.PLAYERMENU_GUILDCHAT);
                _local_3.addEventListener(MouseEvent.CLICK, this.onGuildMessage);
                addOption(_local_3);
            }
            if (!this.player_.ignored_)
            {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 8), 0xFFFFFF, TextKey.PLAYERMENU_IGNORE);
                _local_3.addEventListener(MouseEvent.CLICK, this.onIgnore);
                addOption(_local_3);
            }
            else
            {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 9), 0xFFFFFF, TextKey.PLAYERMENU_UNIGNORE);
                _local_3.addEventListener(MouseEvent.CLICK, this.onUnignore);
                addOption(_local_3);
            }
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 18), 0xFFFFFF, "Add Friend");
            _local_3.addEventListener(MouseEvent.CLICK, this.onAddFriend);
            addOption(_local_3);
        }

        private function onKickMultiBox(_arg_1:Event):void
        {
            this.gs_.gsc_.playerText((("/akick " + this.player_.name_) + " Multiboxing"));
            remove();
        }

        private function onKickRWT(_arg_1:Event):void
        {
            this.gs_.gsc_.playerText((("/akick " + this.player_.name_) + " RWT"));
            remove();
        }

        private function onKickCheat(_arg_1:Event):void
        {
            this.gs_.gsc_.playerText((("/akick " + this.player_.name_) + " Cheating"));
            remove();
        }

        private function onMute(_arg_1:Event):void
        {
            this.gs_.gsc_.playerText(("/mute " + this.player_.name_));
            remove();
        }

        private function onUnMute(_arg_1:Event):void
        {
            this.gs_.gsc_.playerText(("/unmute " + this.player_.name_));
            remove();
        }

        private function onPrivateMessage(_arg_1:Event):void
        {
            var _local_2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
            _local_2.dispatch(true, (("/tell " + this.playerName_) + " "));
            remove();
        }

        private function onAddFriend(_arg_1:Event):void
        {
            var _local_2:FriendActionSignal = StaticInjectorContext.getInjector().getInstance(FriendActionSignal);
            _local_2.dispatch(new FriendRequestVO(FriendsActions.INVITE, this.playerName_));
            remove();
        }

        private function onTradeMessage(_arg_1:Event):void
        {
            var _local_2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
            _local_2.dispatch(true, ("/trade " + this.playerName_));
            remove();
        }

        private function onGuildMessage(_arg_1:Event):void
        {
            var _local_2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
            _local_2.dispatch(true, "/g ");
            remove();
        }

        private function onTeleport(_arg_1:Event):void
        {
            this.gs_.map.player_.teleportTo(this.player_);
            remove();
        }

        private function onInvite(_arg_1:Event):void
        {
            this.gs_.gsc_.guildInvite(this.playerName_);
            remove();
        }

        private function onLock(_arg_1:Event):void
        {
            this.gs_.map.party_.lockPlayer(this.player_);
            remove();
        }

        private function onUnlock(_arg_1:Event):void
        {
            this.gs_.map.party_.unlockPlayer(this.player_);
            remove();
        }

        private function onTrade(_arg_1:Event):void
        {
            this.gs_.gsc_.requestTrade(this.playerName_);
            remove();
        }

        private function onIgnore(_arg_1:Event):void
        {
            this.gs_.map.party_.ignorePlayer(this.player_);
            remove();
        }

        private function onUnignore(_arg_1:Event):void
        {
            this.gs_.map.party_.unignorePlayer(this.player_);
            remove();
        }


    }
}//package com.company.assembleegameclient.ui.menu

