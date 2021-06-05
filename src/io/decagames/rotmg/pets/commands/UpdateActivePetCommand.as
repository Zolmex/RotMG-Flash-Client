// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.commands.UpdateActivePetCommand

package io.decagames.rotmg.pets.commands
{
    import robotlegs.bender.bundles.mvcs.Command;
    import io.decagames.rotmg.pets.data.PetsModel;
    import io.decagames.rotmg.pets.signals.NotifyActivePetUpdated;

    public class UpdateActivePetCommand extends Command 
    {

        [Inject]
        public var instanceID:int;
        [Inject]
        public var petsModel:PetsModel;
        [Inject]
        public var notifyActivePetUpdated:NotifyActivePetUpdated;


        override public function execute():void
        {
            if (this.instanceID < 0)
            {
                this.petsModel.removeActivePet();
            }
            else
            {
                this.petsModel.setActivePet(this.petsModel.getPet(this.instanceID));
            };
        }


    }
}//package io.decagames.rotmg.pets.commands

