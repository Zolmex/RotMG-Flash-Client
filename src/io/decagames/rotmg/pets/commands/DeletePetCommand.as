// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.commands.DeletePetCommand

package io.decagames.rotmg.pets.commands
{
    import com.company.assembleegameclient.editor.Command;
    import io.decagames.rotmg.pets.data.PetsModel;

    public class DeletePetCommand extends Command 
    {

        [Inject]
        public var petID:int;
        [Inject]
        public var petsModel:PetsModel;


        override public function execute():void
        {
            this.petsModel.deletePet(this.petID);
        }


    }
}//package io.decagames.rotmg.pets.commands

