// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.panels.PetInteractionPanel

package io.decagames.rotmg.pets.panels
{
    import com.company.assembleegameclient.ui.panels.Panel;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.ui.DeprecatedTextButton;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import com.company.assembleegameclient.game.GameSprite;

    public class PetInteractionPanel extends Panel 
    {

        private const titleText:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 16, true);

        private var icon:Bitmap;
        private var title:String = "Console";
        private var wardrobeButtonString:String = "Wardrobe";
        private var objectType:int;
        internal var wardrobeButton:DeprecatedTextButton;

        public function PetInteractionPanel(_arg_1:GameSprite, _arg_2:int)
        {
            super(_arg_1);
            this.objectType = _arg_2;
            this.titleText.setStringBuilder(new LineBuilder().setParams(this.title));
            this.titleText.x = 48;
            this.titleText.y = 28;
            addChild(this.titleText);
            this.wardrobeButton = new DeprecatedTextButton(16, this.wardrobeButtonString);
            this.wardrobeButton.textChanged.addOnce(this.alignButton);
            addChild(this.wardrobeButton);
        }

        public function init():void
        {
            this.icon = PetsViewAssetFactory.returnBitmap(this.objectType);
            this.icon.x = -4;
            this.icon.y = -8;
            addChild(this.icon);
        }

        private function alignButton():void
        {
            this.wardrobeButton.x = (((WIDTH / 4) * 2) - (this.wardrobeButton.width / 2));
            this.wardrobeButton.y = ((HEIGHT - this.wardrobeButton.height) - 4);
        }


    }
}//package io.decagames.rotmg.pets.panels

