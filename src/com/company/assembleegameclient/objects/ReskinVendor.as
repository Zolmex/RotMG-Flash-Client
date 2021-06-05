// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.ReskinVendor

package com.company.assembleegameclient.objects
{
    import kabam.rotmg.characters.reskin.view.ReskinPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class ReskinVendor extends GameObject implements IInteractiveObject 
    {

        public function ReskinVendor(_arg_1:XML)
        {
            super(_arg_1);
            isInteractive_ = true;
        }

        public function getPanel(_arg_1:GameSprite):Panel
        {
            return (new ReskinPanel(_arg_1));
        }


    }
}//package com.company.assembleegameclient.objects

