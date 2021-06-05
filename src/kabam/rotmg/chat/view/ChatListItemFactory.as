// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.chat.view.ChatListItemFactory

package kabam.rotmg.chat.view
{
    import flash.geom.Matrix;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.text.TextField;
    import kabam.rotmg.text.view.BitmapTextFactory;
    import kabam.rotmg.chat.model.ChatModel;
    import kabam.rotmg.text.model.FontModel;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import com.company.assembleegameclient.util.StageProxy;
    import kabam.rotmg.chat.model.ChatMessage;
    import __AS3__.vec.Vector;
    import flash.display.DisplayObject;
    import flash.text.TextFormat;
    import com.company.assembleegameclient.util.FameUtil;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import flash.display.BitmapData;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import flash.display.Bitmap;
    import flash.display.StageQuality;
    import __AS3__.vec.*;

    public class ChatListItemFactory 
    {

        private static const IDENTITY_MATRIX:Matrix = new Matrix();
        private static const SERVER:String = Parameters.SERVER_CHAT_NAME;
        private static const CLIENT:String = Parameters.CLIENT_CHAT_NAME;
        private static const HELP:String = Parameters.HELP_CHAT_NAME;
        private static const ERROR:String = Parameters.ERROR_CHAT_NAME;
        private static const GUILD:String = Parameters.GUILD_CHAT_NAME;
        private static const testField:TextField = makeTestTextField();

        [Inject]
        public var factory:BitmapTextFactory;
        [Inject]
        public var model:ChatModel;
        [Inject]
        public var fontModel:FontModel;
        [Inject]
        public var supporterCampaignModel:SupporterCampaignModel;
        [Inject]
        public var stageProxy:StageProxy;
        private var message:ChatMessage;
        private var buffer:Vector.<DisplayObject>;


        public static function isTradeMessage(_arg_1:int, _arg_2:int, _arg_3:String):Boolean
        {
            return (((_arg_1 == -1) || (_arg_2 == -1)) && (!(_arg_3.search("/trade") == -1)));
        }

        public static function isGuildMessage(_arg_1:String):Boolean
        {
            return (_arg_1 == GUILD);
        }

        private static function makeTestTextField():TextField
        {
            var _local_1:TextField = new TextField();
            var _local_2:TextFormat = new TextFormat();
            _local_2.size = 15;
            _local_2.bold = true;
            _local_1.defaultTextFormat = _local_2;
            return (_local_1);
        }


        public function make(_arg_1:ChatMessage, _arg_2:Boolean=false):ChatListItem
        {
            var _local_5:int;
            var _local_7:String;
            var _local_8:int;
            this.message = _arg_1;
            this.buffer = new Vector.<DisplayObject>();
            this.setTFonTestField();
            this.makeStarsIcon();
            this.makeWhisperText();
            this.makeNameText();
            this.makeMessageText();
            var _local_3:Boolean = ((_arg_1.numStars == -1) || (_arg_1.objectId == -1));
            var _local_4:Boolean;
            var _local_6:String = _arg_1.name;
            if (((_local_3) && (!((_local_5 = _arg_1.text.search("/trade ")) == -1))))
            {
                _local_5 = (_local_5 + 7);
                _local_7 = "";
                _local_8 = _local_5;
                while (_local_8 < (_local_5 + 10))
                {
                    if (_arg_1.text.charAt(_local_8) == '"') break;
                    _local_7 = (_local_7 + _arg_1.text.charAt(_local_8));
                    _local_8++;
                };
                _local_6 = _local_7;
                _local_4 = true;
            };
            return (new ChatListItem(this.buffer, this.model.bounds.width, this.model.lineHeight, _arg_2, _arg_1.objectId, _local_6, (_arg_1.recipient == GUILD), _local_4));
        }

        private function makeStarsIcon():void
        {
            var _local_1:int = this.message.numStars;
            var _local_2:int = this.message.starBg;
            if (_local_1 >= 0)
            {
                this.buffer.push(FameUtil.numStarsToIcon(_local_1, _local_2));
            };
        }

        private function makeWhisperText():void
        {
            var _local_1:StringBuilder;
            var _local_2:BitmapData;
            if (((this.message.isWhisper) && (!(this.message.isToMe))))
            {
                _local_1 = new StaticStringBuilder("To: ");
                _local_2 = this.getBitmapData(_local_1, 61695);
                this.buffer.push(new Bitmap(_local_2));
            };
        }

        private function makeNameText():void
        {
            if (!this.isSpecialMessageType())
            {
                this.bufferNameText();
            };
        }

        private function isSpecialMessageType():Boolean
        {
            var _local_1:String = this.message.name;
            return (((((_local_1 == SERVER) || (_local_1 == CLIENT)) || (_local_1 == HELP)) || (_local_1 == ERROR)) || (_local_1 == GUILD));
        }

        private function bufferNameText():void
        {
            var _local_1:StringBuilder = new StaticStringBuilder(this.processName());
            var _local_2:BitmapData = this.getBitmapData(_local_1, this.getNameColor());
            this.buffer.push(new Bitmap(_local_2));
        }

        private function processName():String
        {
            var _local_1:String = (((this.message.isWhisper) && (!(this.message.isToMe))) ? this.message.recipient : this.message.name);
            if (((_local_1.charAt(0) == "#") || (_local_1.charAt(0) == "@")))
            {
                _local_1 = _local_1.substr(1);
            };
            return (("<" + _local_1) + ">");
        }

        private function makeMessageText():void
        {
            var _local_2:int;
            var _local_1:Array = this.message.text.split("\n");
            if (_local_1.length > 0)
            {
                this.makeNewLineFreeMessageText(_local_1[0], true);
                _local_2 = 1;
                while (_local_2 < _local_1.length)
                {
                    this.makeNewLineFreeMessageText(_local_1[_local_2], false);
                    _local_2++;
                };
            };
        }

        private function makeNewLineFreeMessageText(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_7:DisplayObject;
            var _local_8:int;
            var _local_9:uint;
            var _local_10:int;
            var _local_11:int;
            var _local_3:String = _arg_1;
            var _local_4:int;
            var _local_5:int;
            if (_arg_2)
            {
                for each (_local_7 in this.buffer)
                {
                    _local_4 = (_local_4 + _local_7.width);
                };
                _local_5 = _local_3.length;
                testField.text = _local_3;
                while (testField.textWidth >= (this.model.bounds.width - _local_4))
                {
                    _local_5 = (_local_5 - 10);
                    testField.text = _local_3.substr(0, _local_5);
                };
                if (_local_5 < _local_3.length)
                {
                    _local_8 = _local_3.substr(0, _local_5).lastIndexOf(" ");
                    _local_5 = (((_local_8 == 0) || (_local_8 == -1)) ? _local_5 : (_local_8 + 1));
                };
                this.makeMessageLine(_local_3.substr(0, _local_5));
            };
            var _local_6:int = _local_3.length;
            if (_local_6 > _local_5)
            {
                _local_9 = _local_3.length;
                _local_10 = _local_5;
                while (_local_10 < _local_3.length)
                {
                    testField.text = _local_3.substr(_local_10, _local_9);
                    while (testField.textWidth >= this.model.bounds.width)
                    {
                        _local_9 = (_local_9 - 2);
                        testField.text = _local_3.substr(_local_10, _local_9);
                    };
                    _local_11 = _local_9;
                    if (_local_3.length > (_local_10 + _local_9))
                    {
                        _local_11 = _local_3.substr(_local_10, _local_9).lastIndexOf(" ");
                        _local_11 = (((_local_11 == 0) || (_local_11 == -1)) ? _local_9 : (_local_11 + 1));
                    };
                    this.makeMessageLine(_local_3.substr(_local_10, _local_11));
                    _local_10 = (_local_10 + _local_11);
                };
            };
        }

        private function makeMessageLine(_arg_1:String):void
        {
            var _local_2:StringBuilder = new StaticStringBuilder(_arg_1);
            var _local_3:BitmapData = this.getBitmapData(_local_2, this.getTextColor());
            this.buffer.push(new Bitmap(_local_3));
        }

        private function getNameColor():uint
        {
            if (this.message.name.charAt(0) == "#")
            {
                return (0xFFA800);
            };
            if (this.message.name.charAt(0) == "@")
            {
                return (0xFFFF00);
            };
            if (this.message.recipient == GUILD)
            {
                return (10944349);
            };
            if (this.message.recipient != "")
            {
                return (61695);
            };
            if (this.message.isFromSupporter)
            {
                return (SupporterCampaignModel.SUPPORT_COLOR);
            };
            return (0xFF00);
        }

        private function getTextColor():uint
        {
            var _local_1:String = this.message.name;
            if (_local_1 == SERVER)
            {
                return (0xFFFF00);
            };
            if (_local_1 == CLIENT)
            {
                return (0xFF);
            };
            if (_local_1 == HELP)
            {
                return (16734981);
            };
            if (_local_1 == ERROR)
            {
                return (0xFF0000);
            };
            if (_local_1.charAt(0) == "@")
            {
                return (0xFFFF00);
            };
            if (this.message.recipient == GUILD)
            {
                return (10944349);
            };
            if (this.message.recipient != "")
            {
                return (61695);
            };
            return (0xFFFFFF);
        }

        private function getBitmapData(_arg_1:StringBuilder, _arg_2:uint):BitmapData
        {
            var _local_3:String = this.stageProxy.getQuality();
            var _local_4:Boolean = Parameters.data_["forceChatQuality"];
            ((_local_4) && (this.stageProxy.setQuality(StageQuality.HIGH)));
            var _local_5:BitmapData = this.factory.make(_arg_1, 14, _arg_2, true, IDENTITY_MATRIX, true);
            ((_local_4) && (this.stageProxy.setQuality(_local_3)));
            return (_local_5);
        }

        private function setTFonTestField():void
        {
            var _local_1:TextFormat = testField.getTextFormat();
            _local_1.font = this.fontModel.getFont().getName();
            testField.defaultTextFormat = _local_1;
        }


    }
}//package kabam.rotmg.chat.view

