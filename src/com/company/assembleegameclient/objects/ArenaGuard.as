﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.ArenaGuard

package com.company.assembleegameclient.objects
{
    import kabam.rotmg.arena.view.ArenaQueryPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class ArenaGuard extends GameObject implements IInteractiveObject 
    {

        public function ArenaGuard(_arg_1:XML)
        {
            super(_arg_1);
            isInteractive_ = true;
        }

        public function getPanel(_arg_1:GameSprite):Panel
        {
            return (new ArenaQueryPanel(_arg_1, objectType_));
        }


    }
}//package com.company.assembleegameclient.objects

