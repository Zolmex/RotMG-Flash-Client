﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.tos.popups.buttons.RefuseButton

package io.decagames.rotmg.tos.popups.buttons
{
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

    public class RefuseButton extends SliceScalingButton 
    {

        public function RefuseButton()
        {
            super(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            setLabel("Refuse", DefaultLabelFormat.defaultButtonLabel);
            width = 100;
        }

    }
}//package io.decagames.rotmg.tos.popups.buttons

