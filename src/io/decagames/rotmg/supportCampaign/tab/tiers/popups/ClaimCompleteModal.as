// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.tab.tiers.popups.ClaimCompleteModal

package io.decagames.rotmg.supportCampaign.tab.tiers.popups
{
    import io.decagames.rotmg.ui.popups.modal.TextModal;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import __AS3__.vec.Vector;
    import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;
    import __AS3__.vec.*;

    public class ClaimCompleteModal extends TextModal 
    {

        public function ClaimCompleteModal()
        {
            var _local_1:Vector.<BaseButton> = new Vector.<BaseButton>();
            _local_1.push(new ClosePopupButton("OK"));
            super(300, "Claim complete", "You will find your items in the Gift Chest.", _local_1);
        }

    }
}//package io.decagames.rotmg.supportCampaign.tab.tiers.popups

