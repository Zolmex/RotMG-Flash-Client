// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.commands.EvolvePetCommand

package io.decagames.rotmg.pets.commands
{
    import com.company.assembleegameclient.editor.Command;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import kabam.rotmg.messaging.impl.EvolvePetInfo;
    import io.decagames.rotmg.pets.data.PetsModel;
    import io.decagames.rotmg.pets.data.vo.SkinVO;
    import io.decagames.rotmg.pets.popup.evolving.PetEvolvingDialog;

    public class EvolvePetCommand extends Command 
    {

        [Inject]
        public var openDialog:ShowPopupSignal;
        [Inject]
        public var evolvePetInfo:EvolvePetInfo;
        [Inject]
        public var model:PetsModel;


        override public function execute():void
        {
            var _local_1:SkinVO = this.model.getSkinVOById(this.evolvePetInfo.finalPet.skinType);
            var _local_2:Boolean = _local_1.isOwned;
            this.model.unlockSkin(this.evolvePetInfo.finalPet.skinType);
            this.openDialog.dispatch(new PetEvolvingDialog(this.evolvePetInfo, _local_2));
        }


    }
}//package io.decagames.rotmg.pets.commands

