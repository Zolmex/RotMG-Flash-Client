// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.fame.view.FameView

package kabam.rotmg.fame.view
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import flash.display.DisplayObjectContainer;
    import flash.display.Bitmap;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.screens.ScoringBox;
    import com.company.assembleegameclient.screens.ScoreTextLine;
    import com.company.assembleegameclient.screens.TitleMenuOption;
    import io.decagames.rotmg.ui.labels.UILabel;
    import kabam.rotmg.ui.view.components.ScreenBase;
    import kabam.rotmg.text.model.TextKey;
    import flash.text.TextFieldAutoSize;
    import org.osflash.signals.natives.NativeMappedSignal;
    import flash.events.MouseEvent;
    import com.gskinner.motion.GTween;
    import com.company.assembleegameclient.sound.SoundEffectLibrary;
    import flash.display.BitmapData;
    import flash.filters.DropShadowFilter;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import com.company.assembleegameclient.map.GroundLibrary;
    import com.company.rotmg.graphics.FameIconBackgroundDesign;
    import flash.geom.Rectangle;
    import com.company.assembleegameclient.util.FameUtil;
    import com.company.util.BitmapUtil;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import com.company.rotmg.graphics.ScreenGraphic;

    public class FameView extends Sprite 
    {

        public var closed:Signal;
        private var infoContainer:DisplayObjectContainer;
        private var overlayContainer:Bitmap;
        private var title:TextFieldDisplayConcrete;
        private var date:TextFieldDisplayConcrete;
        private var scoringBox:ScoringBox;
        private var finalLine:ScoreTextLine;
        private var continueBtn:TitleMenuOption;
        private var _remainingChallengerCharacters:UILabel;
        private var isAnimation:Boolean;
        private var isFadeComplete:Boolean;
        private var isDataPopulated:Boolean;

        public function FameView()
        {
            this.init();
        }

        private function init():void
        {
            addChild(new ScreenBase());
            addChild((this.infoContainer = new Sprite()));
            addChild((this.overlayContainer = new Bitmap()));
            this.continueBtn = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON, 36, false);
            this.continueBtn.setAutoSize(TextFieldAutoSize.CENTER);
            this.continueBtn.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.closed = new NativeMappedSignal(this.continueBtn, MouseEvent.CLICK);
        }

        public function setIsAnimation(_arg_1:Boolean):void
        {
            this.isAnimation = _arg_1;
        }

        public function setBackground(_arg_1:BitmapData):void
        {
            this.overlayContainer.bitmapData = _arg_1;
            var _local_2:GTween = new GTween(this.overlayContainer, 2, {"alpha":0});
            _local_2.onComplete = this.onFadeComplete;
            SoundEffectLibrary.play("death_screen");
        }

        public function clearBackground():void
        {
            this.overlayContainer.bitmapData = null;
        }

        private function onFadeComplete(_arg_1:GTween):void
        {
            removeChild(this.overlayContainer);
            this.isFadeComplete = true;
            if (this.isDataPopulated)
            {
                this.makeContinueButton();
            }
        }

        public function setCharacterInfo(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            this.title = new TextFieldDisplayConcrete().setSize(38).setColor(0xCCCCCC);
            this.title.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
            this.title.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            var _local_4:String = ObjectLibrary.typeToDisplayId_[_arg_3];
            this.title.setStringBuilder(new LineBuilder().setParams(TextKey.CHARACTER_INFO, {
                "name":_arg_1,
                "level":_arg_2,
                "type":_local_4
            }));
            this.title.x = (stage.stageWidth / 2);
            this.title.y = 225;
            this.infoContainer.addChild(this.title);
        }

        public function setDeathInfo(_arg_1:String, _arg_2:String):void
        {
            this.date = new TextFieldDisplayConcrete().setSize(24).setColor(0xCCCCCC);
            this.date.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
            this.date.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            var _local_3:LineBuilder = new LineBuilder();
            if (_arg_2)
            {
                _local_3.setParams(TextKey.DEATH_INFO_LONG, {
                    "date":_arg_1,
                    "killer":this.convertKillerString(_arg_2)
                });
            }
            else
            {
                _local_3.setParams(TextKey.DEATH_INFO_SHORT, {"date":_arg_1});
            }
            this.date.setStringBuilder(_local_3);
            this.date.x = (stage.stageWidth / 2);
            this.date.y = 272;
            this.infoContainer.addChild(this.date);
        }

        private function convertKillerString(_arg_1:String):String
        {
            var _local_2:Array = _arg_1.split(".");
            var _local_3:String = _local_2[0];
            var _local_4:String = _local_2[1];
            if (_local_4 == null)
            {
                _local_4 = _local_3;
                switch (_local_4)
                {
                    case "lava":
                        _local_4 = "Lava";
                        break;
                    case "lava blend":
                        _local_4 = "Lava Blend";
                        break;
                    case "liquid evil":
                        _local_4 = "Liquid Evil";
                        break;
                    case "evil water":
                        _local_4 = "Evil Water";
                        break;
                    case "puke water":
                        _local_4 = "Puke Water";
                        break;
                    case "hot lava":
                        _local_4 = "Hot Lava";
                        break;
                    case "pure evil":
                        _local_4 = "Pure Evil";
                        break;
                    case "lod red tile":
                        _local_4 = "lod Red Tile";
                        break;
                    case "lod purple tile":
                        _local_4 = "lod Purple Tile";
                        break;
                    case "lod blue tile":
                        _local_4 = "lod Blue Tile";
                        break;
                    case "lod green tile":
                        _local_4 = "lod Green Tile";
                        break;
                    case "lod cream tile":
                        _local_4 = "lod Cream Tile";
                        break;
                }
            }
            else
            {
                _local_4 = _local_4.substr(0, (_local_4.length - 1));
                _local_4 = _local_4.replace(/_/g, " ");
                _local_4 = _local_4.replace(/APOS/g, "'");
                _local_4 = _local_4.replace(/BANG/g, "!");
            }
            if (ObjectLibrary.getPropsFromId(_local_4) != null)
            {
                _local_4 = ObjectLibrary.getPropsFromId(_local_4).displayId_;
            }
            else
            {
                if (GroundLibrary.getPropsFromId(_local_4) != null)
                {
                    _local_4 = GroundLibrary.getPropsFromId(_local_4).displayId_;
                }
            }
            return (_local_4);
        }

        public function setIcon(_arg_1:BitmapData):void
        {
            var _local_2:Sprite;
            _local_2 = new Sprite();
            var _local_3:Sprite = new FameIconBackgroundDesign();
            _local_3.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            _local_2.addChild(_local_3);
            var _local_4:Bitmap = new Bitmap(_arg_1);
            _local_4.x = ((_local_2.width / 2) - (_local_4.width / 2));
            _local_4.y = ((_local_2.height / 2) - (_local_4.height / 2));
            _local_2.addChild(_local_4);
            _local_2.y = 20;
            _local_2.x = ((stage.stageWidth / 2) - (_local_2.width / 2));
            this.infoContainer.addChild(_local_2);
        }

        public function setScore(_arg_1:int, _arg_2:XML):void
        {
            this.scoringBox = new ScoringBox(new Rectangle(0, 0, 784, 150), _arg_2);
            this.scoringBox.x = 8;
            this.scoringBox.y = 316;
            addChild(this.scoringBox);
            this.infoContainer.addChild(this.scoringBox);
            var _local_3:BitmapData = FameUtil.getFameIcon();
            _local_3 = BitmapUtil.cropToBitmapData(_local_3, 6, 6, (_local_3.width - 12), (_local_3.height - 12));
            this.finalLine = new ScoreTextLine(24, 0xCCCCCC, 0xFFC800, TextKey.FAMEVIEW_TOTAL_FAME_EARNED, null, 0, _arg_1, "", "", new Bitmap(_local_3));
            this.finalLine.x = 10;
            this.finalLine.y = 470;
            this.infoContainer.addChild(this.finalLine);
            this.isDataPopulated = true;
            if (((!(this.isAnimation)) || (this.isFadeComplete)))
            {
                this.makeContinueButton();
            }
        }

        public function addRemainingChallengerCharacters(_arg_1:int):void
        {
            this._remainingChallengerCharacters = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._remainingChallengerCharacters, 18, 0xFF0000, TextFormatAlign.LEFT, true);
            this._remainingChallengerCharacters.autoSize = TextFieldAutoSize.LEFT;
            this._remainingChallengerCharacters.text = (("You can create " + _arg_1) + " more characters");
            this._remainingChallengerCharacters.x = ((this.width - this._remainingChallengerCharacters.width) / 2);
            this._remainingChallengerCharacters.y = ((this.finalLine.y + this.finalLine.height) - 10);
            this.infoContainer.addChild(this._remainingChallengerCharacters);
        }

        private function makeContinueButton():void
        {
            this.infoContainer.addChild(new ScreenGraphic());
            this.continueBtn.x = (stage.stageWidth / 2);
            this.continueBtn.y = 550;
            this.infoContainer.addChild(this.continueBtn);
            if (this.isAnimation)
            {
                this.scoringBox.animateScore();
            }
            else
            {
                this.scoringBox.showScore();
            }
        }

        public function get remainingChallengerCharacters():UILabel
        {
            return (this._remainingChallengerCharacters);
        }

        public function set remainingChallengerCharacters(_arg_1:UILabel):void
        {
            this._remainingChallengerCharacters = _arg_1;
        }


    }
}//package kabam.rotmg.fame.view

