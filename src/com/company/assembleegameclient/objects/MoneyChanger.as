// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.MoneyChanger

package com.company.assembleegameclient.objects
{
    import kabam.rotmg.game.view.MoneyChangerPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class MoneyChanger extends GameObject implements IInteractiveObject 
    {

        public function MoneyChanger(_arg_1:XML)
        {
            super(_arg_1);
            isInteractive_ = true;
        }

        public function getPanel(_arg_1:GameSprite):Panel
        {
            return (new MoneyChangerPanel(_arg_1));
        }


    }
}//package com.company.assembleegameclient.objects

