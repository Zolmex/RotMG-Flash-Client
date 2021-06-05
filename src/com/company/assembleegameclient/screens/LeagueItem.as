// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.LeagueItem

package com.company.assembleegameclient.screens
{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import com.greensock.TweenMax;
    import io.decagames.rotmg.utils.date.TimeSpan;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;

    public class LeagueItem extends Sprite 
    {

        private const GLOW_COLORS:Array = [0xFF00, 0xEE00FF];

        private var _leagueData:LeagueData;
        private var _leagueType:int;
        private var _container:Sprite;
        private var _panelBackground:SliceScalingBitmap;
        private var _character:SliceScalingBitmap;
        private var _titleLabel:UILabel;
        private var _timeLabel:UILabel;
        private var _descriptionLabel:UILabel;
        private var _quoteLabel:UILabel;
        private var _maxCharacters:UILabel;
        private var _endDate:Date;

        public function LeagueItem(_arg_1:LeagueData)
        {
            this._leagueData = _arg_1;
            this.init();
        }

        public function characterDance(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                TweenMax.to(this._character, 0.3, {
                    "yoyo":true,
                    "repeat":-1,
                    "glowFilter":{
                        "color":this.GLOW_COLORS[this._leagueType],
                        "blurX":10,
                        "blurY":10,
                        "strength":1,
                        "alpha":1
                    }
                });
            }
            else
            {
                TweenMax.killTweensOf(this._character);
                this._character.filters = [];
            };
        }

        public function updateTimeLabel(_arg_1:Number):void
        {
            var _local_2:TimeSpan = new TimeSpan(_arg_1);
            var _local_3:* = "Season will end in: ";
            if (_local_2.totalMilliseconds <= 0)
            {
                _local_3 = "Season has ended!";
            }
            else
            {
                if (_local_2.days == 0)
                {
                    _local_3 = (_local_3 + (((((((_local_2.hours > 9) ? _local_2.hours.toString() : ("0" + _local_2.hours.toString())) + "h ") + ((_local_2.minutes > 9) ? _local_2.minutes.toString() : ("0" + _local_2.minutes.toString()))) + "m ") + ((_local_2.seconds > 9) ? _local_2.seconds.toString() : ("0" + _local_2.seconds.toString()))) + "s"));
                }
                else
                {
                    _local_3 = (_local_3 + (((((((_local_2.days > 9) ? _local_2.days.toString() : ("0" + _local_2.days.toString())) + "d ") + ((_local_2.hours > 9) ? _local_2.hours.toString() : ("0" + _local_2.hours.toString()))) + "h ") + ((_local_2.minutes > 9) ? _local_2.minutes.toString() : ("0" + _local_2.minutes.toString()))) + "m"));
                };
            };
            this._timeLabel.text = _local_3;
            this._timeLabel.x = ((this._panelBackground.width - this._timeLabel.width) / 2);
            this._timeLabel.y = (this._titleLabel.y + this._titleLabel.height);
        }

        private function init():void
        {
            this._leagueType = this._leagueData.leagueType;
            if (this._leagueData.endDate)
            {
                this._endDate = this._leagueData.endDate;
            };
            this._container = new Sprite();
            addChild(this._container);
            this.createPanelBackground();
            this.createCharacter();
            this.createText();
        }

        private function createPanelBackground():void
        {
            this._panelBackground = TextureParser.instance.getSliceScalingBitmap("UI", this._leagueData.panelBackgroundId, 336);
            this._panelBackground.height = 417;
            this._container.addChild(this._panelBackground);
        }

        private function createCharacter():void
        {
            this._character = TextureParser.instance.getSliceScalingBitmap("UI", this._leagueData.characterId, 100);
            this._character.x = ((this._panelBackground.width / 2) - this._character.width);
            this._character.y = (((this._panelBackground.height - this._character.height) / 2) - 80);
            this._container.addChild(this._character);
        }

        private function createText():void
        {
            this._titleLabel = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._titleLabel, 24, 0xFFFFFF, TextFormatAlign.CENTER, true);
            this._titleLabel.text = this._leagueData.title;
            this._titleLabel.x = ((this._panelBackground.width - this._titleLabel.width) / 2);
            this._titleLabel.y = ((this._leagueData.endDate) ? (this._character.y + this._character.height) : ((this._character.y + this._character.height) + 10));
            addChild(this._titleLabel);
            if (this._endDate)
            {
                this._timeLabel = new UILabel();
                DefaultLabelFormat.createLabelFormat(this._timeLabel, 14, 0xFE9700, TextFormatAlign.CENTER);
                addChild(this._timeLabel);
            };
            if (this._leagueData.maxCharacters != -1)
            {
                this._maxCharacters = new UILabel();
                DefaultLabelFormat.createLabelFormat(this._maxCharacters, 16, 0xFE9700, TextFormatAlign.CENTER, true);
                this._maxCharacters.width = 330;
                this._maxCharacters.multiline = true;
                this._maxCharacters.wordWrap = true;
                this._maxCharacters.text = (("You can create " + this._leagueData.maxCharacters) + " characters in this season.");
                this._maxCharacters.x = ((this._panelBackground.width - this._maxCharacters.width) / 2);
                this._maxCharacters.y = (this._panelBackground.y - 8);
                addChild(this._maxCharacters);
            };
            this._descriptionLabel = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._descriptionLabel, 16, 0xFFFFFF, TextFormatAlign.CENTER);
            this._descriptionLabel.width = 280;
            this._descriptionLabel.multiline = true;
            this._descriptionLabel.wordWrap = true;
            this._descriptionLabel.text = this._leagueData.description;
            this._descriptionLabel.x = ((this._panelBackground.width - this._descriptionLabel.width) / 2);
            this._descriptionLabel.y = ((this._character.y + this._character.height) + 60);
            addChild(this._descriptionLabel);
            if (this._leagueData.quote != "")
            {
                this._quoteLabel = new UILabel();
                DefaultLabelFormat.createLabelFormat(this._quoteLabel, 14, 0xCCCCCC, TextFormatAlign.CENTER);
                this._quoteLabel.width = 280;
                this._quoteLabel.multiline = true;
                this._quoteLabel.wordWrap = true;
                this._quoteLabel.text = this._leagueData.quote;
                this._quoteLabel.x = ((this._panelBackground.width - this._quoteLabel.width) / 2);
                this._quoteLabel.y = (this._descriptionLabel.y + this._descriptionLabel.height);
                addChild(this._quoteLabel);
            };
        }

        public function get leagueType():int
        {
            return (this._leagueType);
        }

        public function get endDate():Date
        {
            return (this._endDate);
        }


    }
}//package com.company.assembleegameclient.screens

