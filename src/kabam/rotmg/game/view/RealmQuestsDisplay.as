// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.view.RealmQuestsDisplay

package kabam.rotmg.game.view
{
    import flash.display.Sprite;
    import __AS3__.vec.Vector;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Graphics;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.map.AbstractMap;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.utils.getTimer;
    import com.company.assembleegameclient.objects.GameObject;
    import flash.events.MouseEvent;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import flash.filters.DropShadowFilter;
    import com.greensock.TweenMax;
    import kabam.rotmg.game.model.QuestModel;
    import __AS3__.vec.*;

    public class RealmQuestsDisplay extends Sprite 
    {

        public static const NUMBER_OF_QUESTS:int = 3;

        private const CONTENT_ALPHA:Number = 0.7;
        private const QUEST_DESCRIPTION:String = "Free %s from Oryx's Minions!";
        private const REQUIREMENT_TEXT_01:String = "Reach <font color='#00FF00'><b>Level 20</b></font> and become stronger.";
        private const REQUIREMENT_TEXT_02:String = "Defeat <font color='#00FF00'><b>%d remaining</b></font> Heroes of Oryx.";
        private const REQUIREMENT_TEXT_03:String = "Defeat <font color='#00FF00'><b>Oryx the Mad God</b></font> in his Castle.";
        private const REQUIREMENTS_TEXTS:Vector.<String> = new <String>[REQUIREMENT_TEXT_01, REQUIREMENT_TEXT_02, REQUIREMENT_TEXT_03];

        private var _realmLabel:UILabel;
        private var _realmName:String;
        private var _isOpen:Boolean;
        private var _content:Sprite;
        private var _buttonContainer:Sprite;
        private var _buttonContainerGraphics:Graphics;
        private var _buttonDiamondContainer:Sprite;
        private var _buttonNameContainer:Sprite;
        private var _buttonContent:Sprite;
        private var _arrow:Bitmap;
        private var _realmQuestDiamonds:Vector.<Bitmap>;
        private var _realmQuestItems:Vector.<RealmQuestItem>;
        private var _map:AbstractMap;
        private var _requirementsStates:Vector.<Boolean>;
        private var _currentQuestHero:String;

        public function RealmQuestsDisplay(_arg_1:AbstractMap)
        {
            this.tabChildren = false;
            this._map = _arg_1;
        }

        public function toggleOpenState():void
        {
            this._isOpen = (!(this._isOpen));
            this.alphaTweenContent(this.CONTENT_ALPHA);
            this._arrow.scaleY = ((this._isOpen) ? 1 : -1);
            this._arrow.y = ((this._isOpen) ? 3 : (this._arrow.height + 2));
            this._buttonDiamondContainer.visible = (!(this._isOpen));
            this._buttonNameContainer.visible = this._isOpen;
            this._buttonContent.visible = this._isOpen;
            Parameters.data_.expandRealmQuestsDisplay = this._isOpen;
        }

        public function init():void
        {
            var _local_1:GameObject = this._map.quest_.getObject(int(getTimer()));
            if (_local_1)
            {
                this._currentQuestHero = this._map.quest_.getObject(int(getTimer())).name_;
            };
            this.createContainers();
            this.createArrow();
            this.createRealmLabel();
            this.createDiamonds();
            this.createRealmQuestItems();
            if (Parameters.data_.expandRealmQuestsDisplay)
            {
                this.toggleOpenState();
            };
        }

        private function createContainers():void
        {
            this._content = new Sprite();
            this._content.alpha = this.CONTENT_ALPHA;
            this._content.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this._content.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addChild(this._content);
            this._buttonContainer = new Sprite();
            this._buttonContainerGraphics = this._buttonContainer.graphics;
            this._buttonContainer.buttonMode = true;
            this._buttonContainer.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this._content.addChild(this._buttonContainer);
            this._buttonDiamondContainer = new Sprite();
            this._buttonDiamondContainer.mouseEnabled = false;
            this._buttonContainer.addChild(this._buttonDiamondContainer);
            this._buttonNameContainer = new Sprite();
            this._buttonNameContainer.mouseEnabled = false;
            this._buttonNameContainer.visible = this._isOpen;
            this._buttonContainer.addChild(this._buttonNameContainer);
            this._buttonContent = new Sprite();
            this._buttonContent.mouseEnabled = false;
            this._buttonContent.mouseChildren = false;
            this._buttonContent.visible = this._isOpen;
            this._content.addChild(this._buttonContent);
            this._realmQuestDiamonds = new Vector.<Bitmap>(0);
        }

        private function createArrow():void
        {
            this._arrow = TextureParser.instance.getTexture("UI", "spinner_up_arrow");
            this._buttonContainer.addChild(this._arrow);
        }

        private function createRealmLabel():void
        {
            this._realmLabel = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._realmLabel, 16, 0xFFFFFF, TextFormatAlign.LEFT, true);
            this._realmLabel.x = 20;
            this._realmLabel.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
            this._buttonNameContainer.addChild(this._realmLabel);
        }

        private function createDiamonds():void
        {
            var _local_2:String;
            var _local_3:Bitmap;
            var _local_1:int;
            while (_local_1 < NUMBER_OF_QUESTS)
            {
                _local_2 = ((this._requirementsStates[_local_1]) ? "checkbox_filled" : "checkbox_empty");
                _local_3 = TextureParser.instance.getTexture("UI", _local_2);
                _local_3.x = (((_local_1 * (_local_3.width + 5)) + this._arrow.width) + 5);
                this._buttonDiamondContainer.addChild(_local_3);
                this.setHitArea(this._buttonContainer);
                this._realmQuestDiamonds.push(_local_3);
                _local_1++;
            };
        }

        private function disposeDiamonds():void
        {
            var _local_2:Bitmap;
            var _local_1:int = (NUMBER_OF_QUESTS - 1);
            while (_local_1 >= 0)
            {
                _local_2 = this._realmQuestDiamonds.pop();
                _local_2.bitmapData.dispose();
                this._buttonDiamondContainer.removeChild(_local_2);
                _local_2 = null;
                _local_1--;
            };
        }

        private function createRealmQuestItems():void
        {
            var _local_3:RealmQuestItem;
            var _local_1:int = 28;
            this._realmQuestItems = new Vector.<RealmQuestItem>(0);
            var _local_2:int;
            while (_local_2 < NUMBER_OF_QUESTS)
            {
                _local_3 = new RealmQuestItem(this.REQUIREMENTS_TEXTS[_local_2], this._requirementsStates[_local_2]);
                _local_3.updateItemState(false);
                _local_3.x = 20;
                _local_3.y = (_local_1 + 5);
                _local_1 = (_local_3.y + _local_3.height);
                this._buttonContent.addChild(_local_3);
                this._realmQuestItems.push(_local_3);
                _local_2++;
            };
        }

        private function createQuestDescription():void
        {
            var _local_1:UILabel = new UILabel();
            _local_1.x = 20;
            _local_1.y = 15;
            _local_1.text = this.QUEST_DESCRIPTION.replace("%s", this._realmName);
            DefaultLabelFormat.createLabelFormat(_local_1, 12, 0xFFCC00);
            _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
            this._buttonContent.addChild(_local_1);
        }

        private function alphaTweenContent(_arg_1:Number):void
        {
            if (TweenMax.isTweening(this._content))
            {
                TweenMax.killTweensOf(this._content);
            };
            TweenMax.to(this._content, 0.3, {"alpha":_arg_1});
        }

        private function setHitArea(_arg_1:Sprite):void
        {
            var _local_2:Sprite = new Sprite();
            _local_2.graphics.clear();
            _local_2.graphics.beginFill(0xFFCC00, 0);
            _local_2.graphics.drawRect(0, 0, _arg_1.width, _arg_1.height);
            _arg_1.addChild(_local_2);
        }

        private function updateDiamonds():void
        {
            this.disposeDiamonds();
            this.createDiamonds();
        }

        private function completeRealmQuestItem(_arg_1:RealmQuestItem):void
        {
            _arg_1.updateItemState(true);
            _arg_1.updateItemText((("<font color='#a8a8a8'>" + _arg_1.label.text) + "</font>"));
        }

        private function onMouseClick(_arg_1:MouseEvent):void
        {
            this.toggleOpenState();
        }

        private function onRollOver(_arg_1:MouseEvent):void
        {
            if (TweenMax.isTweening(this._content))
            {
                TweenMax.killTweensOf(this._content);
            };
            TweenMax.to(this._content, 0.3, {"alpha":1});
        }

        private function onRollOut(_arg_1:MouseEvent):void
        {
            this.alphaTweenContent(this.CONTENT_ALPHA);
        }

        private function onMouseUp(_arg_1:MouseEvent):void
        {
            if (Parameters.isGpuRender())
            {
                this._map.mapHitArea.dispatchEvent(_arg_1);
            }
            else
            {
                this._map.dispatchEvent(_arg_1);
            };
        }

        private function onMouseDown(_arg_1:MouseEvent):void
        {
            if (Parameters.isGpuRender())
            {
                this._map.mapHitArea.dispatchEvent(_arg_1);
            }
            else
            {
                this._map.dispatchEvent(_arg_1);
            };
        }

        public function set realmName(_arg_1:String):void
        {
            this._realmName = _arg_1;
            this._realmLabel.text = this._realmName;
            this.setHitArea(this._buttonNameContainer);
            this.createQuestDescription();
        }

        public function set level(_arg_1:int):void
        {
            var _local_2:RealmQuestItem = this._realmQuestItems[QuestModel.LEVEL_REQUIREMENT];
            var _local_3:* = (_arg_1 == 20);
            this._requirementsStates[QuestModel.LEVEL_REQUIREMENT] = _local_3;
            if (_local_3)
            {
                this.completeRealmQuestItem(_local_2);
            }
            else
            {
                _local_2.updateItemState(false);
            };
            this.updateDiamonds();
        }

        public function set remainingHeroes(_arg_1:int):void
        {
            var _local_2:RealmQuestItem = this._realmQuestItems[QuestModel.REMAINING_HEROES_REQUIREMENT];
            _local_2.updateItemText(this.REQUIREMENT_TEXT_02.replace("%d", _arg_1));
            var _local_3:* = (_arg_1 == 0);
            this._requirementsStates[QuestModel.REMAINING_HEROES_REQUIREMENT] = _local_3;
            if (_local_3)
            {
                this.completeRealmQuestItem(_local_2);
            }
            else
            {
                _local_2.updateItemState(false);
            };
            this.updateDiamonds();
        }

        public function setOryxCompleted():void
        {
            this._requirementsStates[QuestModel.ORYX_KILLED] = true;
            var _local_1:RealmQuestItem = this._realmQuestItems[QuestModel.ORYX_KILLED];
            this.completeRealmQuestItem(_local_1);
            this.updateDiamonds();
        }

        public function set requirementsStates(_arg_1:Vector.<Boolean>):void
        {
            this._requirementsStates = _arg_1;
        }

        public function get requirementsStates():Vector.<Boolean>
        {
            return (this._requirementsStates);
        }


    }
}//package kabam.rotmg.game.view

