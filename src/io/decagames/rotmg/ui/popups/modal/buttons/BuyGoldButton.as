﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.buttons.BuyGoldButton

package io.decagames.rotmg.ui.popups.modal.buttons
{
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

    public class BuyGoldButton extends SliceScalingButton 
    {

        public function BuyGoldButton()
        {
            super(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            setLabel("Buy Gold", DefaultLabelFormat.defaultButtonLabel);
            width = 100;
        }

    }
}//package io.decagames.rotmg.ui.popups.modal.buttons

