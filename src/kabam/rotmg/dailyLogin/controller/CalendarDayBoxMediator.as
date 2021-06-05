﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.dailyLogin.controller.CalendarDayBoxMediator

package kabam.rotmg.dailyLogin.controller
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.dailyLogin.view.CalendarDayBox;
    import kabam.lib.net.impl.SocketServer;
    import kabam.lib.net.api.MessageProvider;
    import kabam.rotmg.core.model.MapModel;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.dailyLogin.model.DailyLoginModel;
    import flash.events.MouseEvent;
    import kabam.rotmg.dailyLogin.message.ClaimDailyRewardMessage;
    import com.company.assembleegameclient.map.Map;
    import kabam.rotmg.messaging.impl.GameServerConnection;

    public class CalendarDayBoxMediator extends Mediator 
    {

        [Inject]
        public var view:CalendarDayBox;
        [Inject]
        public var socketServer:SocketServer;
        [Inject]
        public var messages:MessageProvider;
        [Inject]
        public var mapModel:MapModel;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var model:DailyLoginModel;


        override public function initialize():void
        {
            this.view.addEventListener(MouseEvent.CLICK, this.onClickHandler);
        }

        override public function destroy():void
        {
            this.view.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
            super.destroy();
        }

        private function onClickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:ClaimDailyRewardMessage;
            this.view.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
            if ((((this.hudModel.gameSprite.map.name_ == Map.DAILY_QUEST_ROOM) && (!(this.view.day.claimKey == ""))) && (!(this.view.day.isClaimed))))
            {
                _local_2 = (this.messages.require(GameServerConnection.CLAIM_LOGIN_REWARD_MSG) as ClaimDailyRewardMessage);
                _local_2.claimKey = this.view.day.claimKey;
                _local_2.type = this.view.getDay().calendarType;
                this.socketServer.sendMessage(_local_2);
                this.view.markAsClaimed();
                this.model.markAsClaimed(this.view.getDay().dayNumber, this.view.getDay().calendarType);
            };
        }


    }
}//package kabam.rotmg.dailyLogin.controller

