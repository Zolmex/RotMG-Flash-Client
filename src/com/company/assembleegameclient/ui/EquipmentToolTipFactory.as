﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.EquipmentToolTipFactory

package com.company.assembleegameclient.ui
{
    import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
    import com.company.assembleegameclient.objects.Player;
    import flash.display.Sprite;

    public class EquipmentToolTipFactory 
    {


        public function make(_arg_1:int, _arg_2:Player, _arg_3:int, _arg_4:String, _arg_5:uint):Sprite
        {
            return (new EquipmentToolTip(_arg_1, _arg_2, _arg_3, _arg_4));
        }


    }
}//package com.company.assembleegameclient.ui

