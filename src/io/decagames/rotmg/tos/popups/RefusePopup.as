﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.tos.popups.RefusePopup

package io.decagames.rotmg.tos.popups
{
    import io.decagames.rotmg.ui.popups.modal.TextModal;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import __AS3__.vec.Vector;
    import io.decagames.rotmg.tos.popups.buttons.GoBackButton;
    import __AS3__.vec.*;

    public class RefusePopup extends TextModal 
    {

        public function RefusePopup()
        {
            var _local_1:Vector.<BaseButton> = new Vector.<BaseButton>();
            _local_1.push(new GoBackButton());
            super(400, "Update to Terms of Service and Privacy", "You need to accept our Terms of Service and Privacy Policy in order to play Realm of the Mad God.", _local_1, true);
        }

    }
}//package io.decagames.rotmg.tos.popups

