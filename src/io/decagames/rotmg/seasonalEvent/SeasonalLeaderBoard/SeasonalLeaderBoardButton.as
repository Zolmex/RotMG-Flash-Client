// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardButton

package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard
{
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import com.company.util.AssetLibrary;
    import kabam.rotmg.ui.UIUtils;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.filters.DropShadowFilter;
    import flash.geom.Rectangle;

    public class SeasonalLeaderBoardButton extends Sprite 
    {

        public static const IMAGE_NAME:String = "lofiObj4";
        public static const IMAGE_ID:int = 240;
        public static const NOTIFICATION_BACKGROUND_WIDTH:Number = 120;
        public static const NOTIFICATION_BACKGROUND_HEIGHT:Number = 25;

        protected var _buttonMask:Sprite;
        private var bitmap:Bitmap;
        private var background:Sprite;
        private var icon:BitmapData;
        private var text:TextFieldDisplayConcrete;

        public function SeasonalLeaderBoardButton()
        {
            this.icon = TextureRedrawer.redraw(AssetLibrary.getImageFromSet(IMAGE_NAME, IMAGE_ID), 40, true, 0);
            this.background = UIUtils.makeHUDBackground(NOTIFICATION_BACKGROUND_WIDTH, NOTIFICATION_BACKGROUND_HEIGHT);
            this.bitmap = new Bitmap(this.icon);
            this.bitmap.x = -5;
            this.bitmap.y = -8;
            this.text = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF);
            this.text.setStringBuilder(new LineBuilder().setParams("Leaderboard"));
            this.text.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
            this.text.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
            var _local_1:Rectangle = this.bitmap.getBounds(this);
            var _local_2:int = 10;
            this.text.x = (_local_1.right - _local_2);
            this.text.y = ((_local_1.bottom - _local_2) - 3);
            this._buttonMask = new Sprite();
            this._buttonMask.graphics.beginFill(0xFF0000, 0);
            this._buttonMask.graphics.drawRect(0, 0, NOTIFICATION_BACKGROUND_WIDTH, NOTIFICATION_BACKGROUND_HEIGHT);
            this._buttonMask.graphics.endFill();
            addChild(this.background);
            addChild(this.text);
            addChild(this.bitmap);
            addChild(this._buttonMask);
            mouseEnabled = true;
        }

        public function get button():Sprite
        {
            return (this._buttonMask);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard

