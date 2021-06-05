// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.view.RealmQuestItem

package kabam.rotmg.game.view
{
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.text.TextField;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import flash.text.TextFormat;
    import flash.filters.DropShadowFilter;

    public class RealmQuestItem extends Sprite 
    {

        private var _content:Sprite;
        private var _isComplete:Boolean;
        private var _diamond:Bitmap;
        private var _label:TextField;
        private var _description:String;

        public function RealmQuestItem(_arg_1:String, _arg_2:Boolean)
        {
            this._description = _arg_1;
            this._isComplete = _arg_2;
            this.init();
        }

        public function updateItemState(_arg_1:Boolean):void
        {
            this._isComplete = _arg_1;
            this.createDiamond();
        }

        public function updateItemText(_arg_1:String):void
        {
            this._description = _arg_1;
            this._label.htmlText = this._description;
        }

        private function init():void
        {
            this._content = new Sprite();
            addChild(this._content);
            this.createDiamond();
            this.createLabel();
        }

        private function createDiamond():void
        {
            if (this._diamond)
            {
                this._content.removeChild(this._diamond);
            };
            var _local_1:String = ((this._isComplete) ? "checkbox_filled" : "checkbox_empty");
            this._diamond = TextureParser.instance.getTexture("UI", _local_1);
            this._content.addChild(this._diamond);
        }

        private function createLabel():void
        {
            var _local_1:TextFormat = DefaultLabelFormat.createTextFormat(12, 0xFFFFFF, TextFormatAlign.LEFT, false);
            this._label = new TextField();
            this._label.defaultTextFormat = _local_1;
            this._label.width = 300;
            this._label.height = 15;
            this._label.wordWrap = true;
            this._label.multiline = true;
            this._label.embedFonts = true;
            this._label.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
            this._label.htmlText = this._description;
            if (this._label.numLines > 1)
            {
                this._label.height = 30;
            };
            this._label.x = (this._diamond.width + 5);
            this._content.addChild(this._label);
        }

        public function get label():TextField
        {
            return (this._label);
        }


    }
}//package kabam.rotmg.game.view

