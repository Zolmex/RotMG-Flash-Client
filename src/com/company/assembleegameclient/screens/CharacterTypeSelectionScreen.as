// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.CharacterTypeSelectionScreen

package com.company.assembleegameclient.screens
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import __AS3__.vec.Vector;
    import io.decagames.rotmg.ui.buttons.InfoButton;
    import kabam.rotmg.ui.view.ButtonFactory;
    import kabam.rotmg.core.signals.LeagueItemSignal;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.ui.view.components.ScreenBase;
    import kabam.rotmg.ui.view.components.MenuOptionsBar;
    import flash.text.TextFieldAutoSize;
    import flash.geom.Rectangle;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.util.FilterUtil;
    import __AS3__.vec.*;

    public class CharacterTypeSelectionScreen extends Sprite 
    {

        public var close:Signal;
        private var nameText:TextFieldDisplayConcrete;
        private var backButton:TitleMenuOption;
        private var _leagueDatas:Vector.<LeagueData>;
        private var _leagueItems:Vector.<LeagueItem>;
        private var _leagueContainer:Sprite;
        private var _infoButton:InfoButton;
        private var _buttonFactory:ButtonFactory;

        public var leagueItemSignal:LeagueItemSignal = new LeagueItemSignal();
        private const DROP_SHADOW:DropShadowFilter = new DropShadowFilter(0, 0, 0, 1, 8, 8);

        public function CharacterTypeSelectionScreen()
        {
            this.init();
        }

        private function init():void
        {
            this._buttonFactory = new ButtonFactory();
            addChild(new ScreenBase());
            addChild(new AccountScreen());
            this.createDisplayAssets();
        }

        private function createDisplayAssets():void
        {
            this.createNameText();
            this.makeMenuOptionsBar();
            this._leagueContainer = new Sprite();
            addChild(this._leagueContainer);
        }

        private function makeMenuOptionsBar():void
        {
            this.backButton = this._buttonFactory.getBackButton();
            this.close = this.backButton.clicked;
            var _local_1:MenuOptionsBar = new MenuOptionsBar();
            _local_1.addButton(this.backButton, MenuOptionsBar.CENTER);
            addChild(_local_1);
        }

        private function createNameText():void
        {
            this.nameText = new TextFieldDisplayConcrete().setSize(22).setColor(0xB3B3B3);
            this.nameText.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
            this.nameText.filters = [this.DROP_SHADOW];
            this.nameText.y = 24;
            this.nameText.x = ((this.getReferenceRectangle().width - this.nameText.width) / 2);
            addChild(this.nameText);
        }

        internal function getReferenceRectangle():Rectangle
        {
            var _local_1:Rectangle = new Rectangle();
            if (stage)
            {
                _local_1 = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            };
            return (_local_1);
        }

        public function setName(_arg_1:String):void
        {
            this.nameText.setStringBuilder(new StaticStringBuilder(_arg_1));
            this.nameText.x = ((this.getReferenceRectangle().width - this.nameText.width) * 0.5);
        }

        public function set leagueDatas(_arg_1:Vector.<LeagueData>):void
        {
            this._leagueDatas = _arg_1;
            this.createLeagues();
            this.createInfoButton();
        }

        private function createInfoButton():void
        {
            this._infoButton = new InfoButton(10);
            this._infoButton.x = ((this._leagueContainer.width - this._infoButton.width) - 18);
            this._infoButton.y = (this._infoButton.height + 16);
            this._leagueContainer.addChild(this._infoButton);
        }

        private function createLeagues():void
        {
            var _local_3:LeagueItem;
            if (!this._leagueItems)
            {
                this._leagueItems = new Vector.<LeagueItem>(0);
            }
            else
            {
                this._leagueItems.length = 0;
            };
            var _local_1:int = this._leagueDatas.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _local_3 = new LeagueItem(this._leagueDatas[_local_2]);
                _local_3.x = (_local_2 * (_local_3.width + 20));
                _local_3.buttonMode = true;
                _local_3.addEventListener(MouseEvent.CLICK, this.onLeagueItemClick);
                _local_3.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
                _local_3.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
                this._leagueItems.push(_local_3);
                this._leagueContainer.addChild(_local_3);
                _local_2++;
            };
            this._leagueContainer.x = ((this.width - this._leagueContainer.width) / 2);
            this._leagueContainer.y = ((this.height - this._leagueContainer.height) / 2);
        }

        private function onOut(_arg_1:MouseEvent):void
        {
            var _local_2:LeagueItem = (_arg_1.currentTarget as LeagueItem);
            if (_local_2)
            {
                _local_2.filters = [];
                _local_2.characterDance(false);
            }
            else
            {
                _arg_1.currentTarget.filters = [];
            };
        }

        private function onOver(_arg_1:MouseEvent):void
        {
            var _local_2:LeagueItem = (_arg_1.currentTarget as LeagueItem);
            if (_local_2)
            {
                _local_2.characterDance(true);
            }
            else
            {
                _arg_1.currentTarget.filters = FilterUtil.getLargeGlowFilter();
            };
        }

        private function onLeagueItemClick(_arg_1:MouseEvent):void
        {
            this.removeLeagueItemListeners();
            this.leagueItemSignal.dispatch((_arg_1.currentTarget as LeagueItem).leagueType);
        }

        private function removeLeagueItemListeners():void
        {
            var _local_1:int = this._leagueItems.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                this._leagueItems[_local_2].removeEventListener(MouseEvent.CLICK, this.onLeagueItemClick);
                this._leagueItems[_local_2].removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
                this._leagueItems[_local_2].removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
                _local_2++;
            };
        }

        public function get infoButton():InfoButton
        {
            return (this._infoButton);
        }


    }
}//package com.company.assembleegameclient.screens

