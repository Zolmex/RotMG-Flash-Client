// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.charrects.CharacterRectList

package com.company.assembleegameclient.screens.charrects
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.assets.services.CharacterFactory;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import kabam.rotmg.classes.model.CharacterClass;
    import com.company.assembleegameclient.appengine.CharacterStats;
    import __AS3__.vec.Vector;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.core.StaticInjectorContext;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.classes.model.CharacterSkin;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.events.Event;

    public class CharacterRectList extends Sprite 
    {

        public var newCharacter:Signal;
        public var buyCharacterSlot:Signal;
        private var classes:ClassesModel;
        private var model:PlayerModel;
        private var seasonalEventModel:SeasonalEventModel;
        private var assetFactory:CharacterFactory;
        private var yOffset:int;
        private var accountName:String;
        private var numberOfSavedCharacters:int;
        private var numberOfAvailableCharSlots:int;
        private var charactersAvailable:UILabel;
        private var isSeasonalEvent:Boolean;

        public function CharacterRectList()
        {
            this.init();
        }

        private function init():void
        {
            var _local_1:String;
            this.createInjections();
            this.createSignals();
            this.accountName = this.model.getName();
            this.yOffset = 4;
            this.createSavedCharacters();
            this.createAvailableCharSlots();
            if (this.canBuyCharSlot())
            {
                this.createBuyRect();
            };
            if (this.isSeasonalEvent)
            {
                this.charactersAvailable = new UILabel();
                DefaultLabelFormat.createLabelFormat(this.charactersAvailable, 18, 0xFFFF00, TextFormatAlign.CENTER, true);
                this.charactersAvailable.width = this.width;
                this.charactersAvailable.multiline = true;
                this.charactersAvailable.wordWrap = true;
                if ((((!(this.canBuyCharSlot())) && (this.numberOfAvailableCharSlots == 0)) && (this.numberOfSavedCharacters == 0)))
                {
                    _local_1 = "You have no more Characters left to play\n ...maybe one day you can buy some :-)";
                }
                else
                {
                    _local_1 = (("You can create " + this.seasonalEventModel.remainingCharacters) + " more characters");
                };
                this.charactersAvailable.text = _local_1;
                this.charactersAvailable.y = (this.yOffset + 120);
                addChild(this.charactersAvailable);
            };
        }

        private function canBuyCharSlot():Boolean
        {
            var _local_1:Boolean;
            if (this.seasonalEventModel.isChallenger)
            {
                _local_1 = ((this.seasonalEventModel.remainingCharacters - this.numberOfAvailableCharSlots) > 0);
            }
            else
            {
                _local_1 = true;
            };
            return (_local_1);
        }

        private function createAvailableCharSlots():void
        {
            var _local_2:int;
            var _local_3:CreateNewCharacterRect;
            var _local_1:Boolean = Boolean(this.seasonalEventModel.isChallenger);
            if (this.model.hasAvailableCharSlot())
            {
                this.numberOfAvailableCharSlots = this.model.getAvailableCharSlots();
                _local_2 = 0;
                while (_local_2 < this.numberOfAvailableCharSlots)
                {
                    _local_3 = new CreateNewCharacterRect(this.model);
                    if (_local_1)
                    {
                        _local_3.setSeasonalOverlay(true);
                    };
                    _local_3.addEventListener(MouseEvent.MOUSE_DOWN, this.onNewChar);
                    _local_3.y = this.yOffset;
                    addChild(_local_3);
                    this.yOffset = (this.yOffset + (CharacterRect.HEIGHT + 4));
                    _local_2++;
                };
            };
        }

        private function createSavedCharacters():void
        {
            var _local_2:SavedCharacter;
            var _local_3:CharacterClass;
            var _local_4:CharacterStats;
            var _local_5:CurrentCharacterRect;
            var _local_1:Vector.<SavedCharacter> = this.model.getSavedCharacters();
            this.numberOfSavedCharacters = _local_1.length;
            for each (_local_2 in _local_1)
            {
                _local_3 = this.classes.getCharacterClass(_local_2.objectType());
                _local_4 = this.model.getCharStats()[_local_2.objectType()];
                _local_5 = new CurrentCharacterRect(this.accountName, _local_3, _local_2, _local_4);
                if (Parameters.skinTypes16.indexOf(_local_2.skinType()) != -1)
                {
                    _local_5.setIcon(this.getIcon(_local_2, 50));
                }
                else
                {
                    _local_5.setIcon(this.getIcon(_local_2, 100));
                };
                _local_5.y = this.yOffset;
                addChild(_local_5);
                this.yOffset = (this.yOffset + (CharacterRect.HEIGHT + 4));
            };
        }

        private function createSignals():void
        {
            this.newCharacter = new Signal();
            this.buyCharacterSlot = new Signal();
        }

        private function createInjections():void
        {
            var _local_1:Injector = StaticInjectorContext.getInjector();
            this.classes = _local_1.getInstance(ClassesModel);
            this.model = _local_1.getInstance(PlayerModel);
            this.assetFactory = _local_1.getInstance(CharacterFactory);
            this.seasonalEventModel = _local_1.getInstance(SeasonalEventModel);
            this.isSeasonalEvent = Boolean(this.seasonalEventModel.isChallenger);
        }

        private function createBuyRect():void
        {
            var _local_1:BuyCharacterRect = new BuyCharacterRect(this.model);
            _local_1.addEventListener(MouseEvent.MOUSE_DOWN, this.onBuyCharSlot);
            _local_1.y = this.yOffset;
            addChild(_local_1);
        }

        private function getIcon(_arg_1:SavedCharacter, _arg_2:int=100):DisplayObject
        {
            var _local_3:CharacterClass = this.classes.getCharacterClass(_arg_1.objectType());
            var _local_4:CharacterSkin = ((_local_3.skins.getSkin(_arg_1.skinType())) || (_local_3.skins.getDefaultSkin()));
            var _local_5:BitmapData = this.assetFactory.makeIcon(_local_4.template, _arg_2, _arg_1.tex1(), _arg_1.tex2());
            return (new Bitmap(_local_5));
        }

        private function onNewChar(_arg_1:Event):void
        {
            this.newCharacter.dispatch();
        }

        private function onBuyCharSlot(_arg_1:Event):void
        {
            this.buyCharacterSlot.dispatch(this.model.getNextCharSlotPrice());
        }


    }
}//package com.company.assembleegameclient.screens.charrects

