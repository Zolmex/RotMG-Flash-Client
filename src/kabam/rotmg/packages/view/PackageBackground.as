// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.packages.view.PackageBackground

package kabam.rotmg.packages.view
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;

    public class PackageBackground extends Sprite 
    {

        private static const Background:Class = PackageBackground_Background;

        private const asset:DisplayObject = makeBackground();


        private function makeBackground():DisplayObject
        {
            var _local_1:DisplayObject = new Background();
            addChild(_local_1);
            return (_local_1);
        }


    }
}//package kabam.rotmg.packages.view

