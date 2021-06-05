// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.packages.view.GoldDisplay

package kabam.rotmg.packages.view
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.util.AssetLibrary;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import flash.display.Bitmap;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

    public class GoldDisplay extends Sprite 
    {

        internal var graphic:DisplayObject;
        internal var text:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF);


        public function init():void
        {
            var _local_1:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 225);
            _local_1 = TextureRedrawer.redraw(_local_1, 40, true, 0);
            this.graphic = new Bitmap(_local_1);
            addChild(this.graphic);
            addChild(this.text);
            this.graphic.x = (-(this.graphic.width) - 8);
            this.graphic.y = ((-(this.graphic.height) / 2) - 6);
            this.text.textChanged.add(this.onTextChanged);
        }

        private function onTextChanged():void
        {
            this.text.x = ((this.graphic.x - this.text.width) + 4);
            this.text.y = ((-(this.text.height) / 2) - 6);
        }

        public function setGold(_arg_1:int):void
        {
            this.text.setStringBuilder(new StaticStringBuilder(String(_arg_1)));
        }


    }
}//package kabam.rotmg.packages.view

