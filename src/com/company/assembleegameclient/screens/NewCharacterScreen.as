// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.NewCharacterScreen

package com.company.assembleegameclient.screens
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import kabam.rotmg.game.view.CreditDisplay;
    import kabam.rotmg.ui.view.components.ScreenBase;
    import com.company.rotmg.graphics.ScreenGraphic;
    import com.company.assembleegameclient.constants.ScreenTypes;
    import flash.events.MouseEvent;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.appengine.SavedCharactersList;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.core.service.GoogleAnalytics;
    import kabam.rotmg.core.model.PlayerModel;
    import flash.events.Event;

    public class NewCharacterScreen extends Sprite 
    {

        public var tooltip:Signal;
        public var close:Signal;
        public var selected:Signal;
        private var backButton_:TitleMenuOption;
        private var creditDisplay_:CreditDisplay;
        private var boxes_:Object = {};
        private var isInitialized:Boolean = false;

        public function NewCharacterScreen()
        {
            this.tooltip = new Signal(Sprite);
            this.selected = new Signal(int);
            this.close = new Signal();
            addChild(new ScreenBase());
            addChild(new AccountScreen());
            addChild(new ScreenGraphic());
        }

        public function initialize(_arg_1:PlayerModel):void
        {
            var _local_2:int;
            var _local_4:XML;
            var _local_5:int;
            var _local_6:String;
            var _local_7:Boolean;
            var _local_8:CharacterBox;
            if (this.isInitialized)
            {
                return;
            };
            this.isInitialized = true;
            this.backButton_ = new TitleMenuOption(ScreenTypes.BACK, 36, false);
            this.backButton_.addEventListener(MouseEvent.CLICK, this.onBackClick);
            this.backButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            addChild(this.backButton_);
            this.creditDisplay_ = new CreditDisplay();
            this.creditDisplay_.draw(_arg_1.getCredits(), _arg_1.getFame());
            addChild(this.creditDisplay_);
            _local_2 = 0;
            while (_local_2 < ObjectLibrary.playerChars_.length)
            {
                _local_4 = ObjectLibrary.playerChars_[_local_2];
                _local_5 = int(_local_4.@type);
                _local_6 = _local_4.@id;
                if (!_arg_1.isClassAvailability(_local_6, SavedCharactersList.UNAVAILABLE))
                {
                    if (_local_6 != "Bard")
                    {
                        _local_7 = _arg_1.isClassAvailability(_local_6, SavedCharactersList.UNRESTRICTED);
                        _local_8 = new CharacterBox(_local_4, _arg_1.getCharStats()[_local_5], _arg_1, _local_7);
                        _local_8.x = (((50 + (140 * int((_local_2 % 5)))) + 70) - (_local_8.width / 2));
                        _local_8.y = (88 + (140 * int((_local_2 / 5))));
                        this.boxes_[_local_5] = _local_8;
                        _local_8.addEventListener(MouseEvent.ROLL_OVER, this.onCharBoxOver);
                        _local_8.addEventListener(MouseEvent.ROLL_OUT, this.onCharBoxOut);
                        _local_8.characterSelectClicked_.add(this.onCharBoxClick);
                        addChild(_local_8);
                    };
                };
                _local_2++;
            };
            this.backButton_.x = ((stage.stageWidth / 2) - (this.backButton_.width / 2));
            this.backButton_.y = 550;
            this.creditDisplay_.x = stage.stageWidth;
            this.creditDisplay_.y = 20;
            var _local_3:GoogleAnalytics = StaticInjectorContext.getInjector().getInstance(GoogleAnalytics);
            if (_local_3)
            {
                _local_3.trackPageView("/newCharScreen");
            };
        }

        private function onBackClick(_arg_1:Event):void
        {
            this.close.dispatch();
        }

        private function onCharBoxOver(_arg_1:MouseEvent):void
        {
            var _local_2:CharacterBox = (_arg_1.currentTarget as CharacterBox);
            _local_2.setOver(true);
            this.tooltip.dispatch(_local_2.getTooltip());
        }

        private function onCharBoxOut(_arg_1:MouseEvent):void
        {
            var _local_2:CharacterBox = (_arg_1.currentTarget as CharacterBox);
            _local_2.setOver(false);
            this.tooltip.dispatch(null);
        }

        private function onCharBoxClick(_arg_1:MouseEvent):void
        {
            this.tooltip.dispatch(null);
            var _local_2:CharacterBox = (_arg_1.currentTarget.parent as CharacterBox);
            if (!_local_2.available_)
            {
                return;
            };
            var _local_3:int = _local_2.objectType();
            var _local_4:String = ObjectLibrary.typeToDisplayId_[_local_3];
            var _local_5:GoogleAnalytics = StaticInjectorContext.getInjector().getInstance(GoogleAnalytics);
            if (_local_5)
            {
            };
            this.selected.dispatch(_local_3);
        }

        public function updateCreditsAndFame(_arg_1:int, _arg_2:int):void
        {
            this.creditDisplay_.draw(_arg_1, _arg_2);
        }

        public function update(_arg_1:PlayerModel):void
        {
            var _local_3:XML;
            var _local_4:int;
            var _local_5:String;
            var _local_6:Boolean;
            var _local_7:CharacterBox;
            var _local_2:int;
            while (_local_2 < ObjectLibrary.playerChars_.length)
            {
                _local_3 = ObjectLibrary.playerChars_[_local_2];
                _local_4 = int(_local_3.@type);
                _local_5 = String(_local_3.@id);
                if (!_arg_1.isClassAvailability(_local_5, SavedCharactersList.UNAVAILABLE))
                {
                    _local_6 = _arg_1.isClassAvailability(_local_5, SavedCharactersList.UNRESTRICTED);
                    _local_7 = this.boxes_[_local_4];
                    if (_local_7)
                    {
                        if (((_local_6) || (_arg_1.isLevelRequirementsMet(_local_4))))
                        {
                            _local_7.unlock();
                        };
                    };
                };
                _local_2++;
            };
        }


    }
}//package com.company.assembleegameclient.screens

