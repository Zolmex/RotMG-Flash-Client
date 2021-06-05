﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.classes.view.CharacterSkinLimitedBanner

package kabam.rotmg.classes.view
{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import org.osflash.signals.Signal;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.model.TextKey;

    public class CharacterSkinLimitedBanner extends Sprite 
    {

        private var LimitedBanner:Class = CharacterSkinLimitedBanner_LimitedBanner;
        private const limitedText:TextFieldDisplayConcrete = makeText();
        private const limitedBanner:* = makeLimitedBanner();
        public const readyForPositioning:Signal = new Signal();


        private function makeText():TextFieldDisplayConcrete
        {
            var _local_1:TextFieldDisplayConcrete;
            _local_1 = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setBold(true);
            _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
            _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.CHARACTER_SKIN_LIMITED));
            _local_1.textChanged.addOnce(this.layout);
            addChild(_local_1);
            return (_local_1);
        }

        private function makeLimitedBanner():*
        {
            var _local_1:* = new this.LimitedBanner();
            addChild(_local_1);
            return (_local_1);
        }

        public function layout():void
        {
            this.limitedText.y = (((height / 2) - (this.limitedText.height / 2)) + 1);
            this.limitedBanner.x = (this.limitedText.x + this.limitedText.width);
            this.readyForPositioning.dispatch();
        }


    }
}//package kabam.rotmg.classes.view

