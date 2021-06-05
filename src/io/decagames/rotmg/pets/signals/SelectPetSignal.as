// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.signals.SelectPetSignal

package io.decagames.rotmg.pets.signals
{
    import org.osflash.signals.Signal;
    import io.decagames.rotmg.pets.data.vo.PetVO;

    public class SelectPetSignal extends Signal 
    {

        public function SelectPetSignal()
        {
            super(PetVO);
        }

    }
}//package io.decagames.rotmg.pets.signals

