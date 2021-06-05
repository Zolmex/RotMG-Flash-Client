// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.commands.UpdatePetYardCommand

package io.decagames.rotmg.pets.commands
{
    import robotlegs.bender.bundles.mvcs.Command;
    import io.decagames.rotmg.pets.data.PetsModel;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.pets.popup.leaveYard.LeavePetYardDialog;
    import io.decagames.rotmg.pets.data.yard.PetYardEnum;
    import com.company.assembleegameclient.objects.ObjectLibrary;

    public class UpdatePetYardCommand extends Command 
    {

        [Inject]
        public var type:int;
        [Inject]
        public var petModel:PetsModel;
        [Inject]
        public var openDialog:ShowPopupSignal;


        override public function execute():void
        {
            this.petModel.setPetYardType(this.getYardTypeFromEnum());
            this.openDialog.dispatch(new LeavePetYardDialog());
        }

        private function getYardTypeFromEnum():int
        {
            var _local_1:String = PetYardEnum.selectByOrdinal(this.type).value;
            return (ObjectLibrary.getXMLfromId(_local_1).@type);
        }


    }
}//package io.decagames.rotmg.pets.commands

