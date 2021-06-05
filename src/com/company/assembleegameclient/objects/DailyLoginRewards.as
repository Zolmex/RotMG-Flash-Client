// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.DailyLoginRewards

package com.company.assembleegameclient.objects
{
    import kabam.rotmg.dailyLogin.view.DailyLoginPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class DailyLoginRewards extends GameObject implements IInteractiveObject 
    {

        public function DailyLoginRewards(_arg_1:XML)
        {
            super(_arg_1);
            isInteractive_ = true;
        }

        public function getPanel(_arg_1:GameSprite):Panel
        {
            return (new DailyLoginPanel(_arg_1));
        }


    }
}//package com.company.assembleegameclient.objects

