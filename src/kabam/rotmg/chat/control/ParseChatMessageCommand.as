// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.chat.control.ParseChatMessageCommand

package kabam.rotmg.chat.control
{
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.game.signals.AddTextLineSignal;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.build.api.BuildData;
    import kabam.rotmg.dailyLogin.model.DailyLoginModel;
    import kabam.rotmg.core.model.PlayerModel;
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.util.MoreObjectUtil;
    import kabam.rotmg.chat.model.ChatMessage;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.dialogs.model.PopupNamesConfig;
    import kabam.rotmg.text.model.TextKey;
    import com.company.assembleegameclient.objects.ObjectLibrary;

    public class ParseChatMessageCommand 
    {

        [Inject]
        public var data:String;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var addTextLine:AddTextLineSignal;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var buildData:BuildData;
        [Inject]
        public var dailyLoginModel:DailyLoginModel;
        [Inject]
        public var player:PlayerModel;


        public function execute():void
        {
            var _local_1:Object;
            var _local_2:Object;
            var _local_3:uint;
            var _local_4:GameObject;
            var _local_5:String;
            var _local_6:String;
            switch (this.data)
            {
                case "/resetDailyQuests":
                    if (this.player.isAdmin())
                    {
                        _local_1 = {}
                        MoreObjectUtil.addToObject(_local_1, this.account.getCredentials());
                        this.client.sendRequest("/dailyquest/resetDailyQuestsAdmin", _local_1);
                        this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Restarting daily quests. Please refresh game."));
                    }
                    return;
                case "/resetPackagePopup":
                    Parameters.data_[PopupNamesConfig.PACKAGES_OFFER_POPUP] = null;
                    return;
                case "/h":
                case "/help":
                    this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, TextKey.HELP_COMMAND));
                    return;
                case "/c":
                case "/class":
                case "/classes":
                    _local_2 = {}
                    _local_3 = 0;
                    for each (_local_4 in this.hudModel.gameSprite.map.goDict_)
                    {
                        if (_local_4.props_.isPlayer_)
                        {
                            _local_2[_local_4.objectType_] = ((_local_2[_local_4.objectType_] != undefined) ? (_local_2[_local_4.objectType_] + 1) : uint(1));
                            _local_3++;
                        }
                    }
                    _local_5 = "";
                    for (_local_6 in _local_2)
                    {
                        _local_5 = (_local_5 + (((" " + ObjectLibrary.typeToDisplayId_[_local_6]) + ": ") + _local_2[_local_6]));
                    }
                    this.addTextLine.dispatch(ChatMessage.make("", ((("Classes online (" + _local_3) + "):") + _local_5)));
                    return;
                default:
                    this.hudModel.gameSprite.gsc_.playerText(this.data);
            }
        }


    }
}//package kabam.rotmg.chat.control

