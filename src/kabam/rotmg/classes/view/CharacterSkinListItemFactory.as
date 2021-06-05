// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.classes.view.CharacterSkinListItemFactory

package kabam.rotmg.classes.view
{
    import kabam.rotmg.assets.services.CharacterFactory;
    import __AS3__.vec.Vector;
    import kabam.rotmg.classes.model.CharacterSkin;
    import flash.display.DisplayObject;
    import kabam.rotmg.classes.model.CharacterSkins;
    import com.company.util.AssetLibrary;
    import kabam.rotmg.util.components.LegacyBuyButton;
    import com.company.assembleegameclient.util.Currency;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import __AS3__.vec.*;

    public class CharacterSkinListItemFactory 
    {

        [Inject]
        public var characters:CharacterFactory;


        public function make(_arg_1:CharacterSkins):Vector.<DisplayObject>
        {
            var _local_2:Vector.<CharacterSkin>;
            var _local_3:int;
            _local_2 = _arg_1.getListedSkins();
            _local_3 = _local_2.length;
            var _local_4:Vector.<DisplayObject> = new Vector.<DisplayObject>(_local_3, true);
            var _local_5:int;
            while (_local_5 < _local_3)
            {
                _local_4[_local_5] = this.makeCharacterSkinTile(_local_2[_local_5]);
                _local_5++;
            };
            return (_local_4);
        }

        private function makeCharacterSkinTile(_arg_1:CharacterSkin):CharacterSkinListItem
        {
            var _local_2:CharacterSkinListItem = new CharacterSkinListItem();
            _local_2.setSkin(this.makeIcon(_arg_1));
            _local_2.setModel(_arg_1);
            _local_2.setLockIcon(AssetLibrary.getImageFromSet("lofiInterface2", 5));
            _local_2.setBuyButton(this.makeBuyButton());
            return (_local_2);
        }

        private function makeBuyButton():LegacyBuyButton
        {
            return (new LegacyBuyButton("", 16, 0, Currency.GOLD));
        }

        private function makeIcon(_arg_1:CharacterSkin):Bitmap
        {
            var _local_2:int = ((Parameters.skinTypes16.indexOf(_arg_1.id) != -1) ? 50 : 100);
            var _local_3:BitmapData = this.characters.makeIcon(_arg_1.template, _local_2);
            return (new Bitmap(_local_3));
        }


    }
}//package kabam.rotmg.classes.view

