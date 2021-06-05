// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.signals.ChangePetSkinSignal

package io.decagames.rotmg.pets.signals
{
    import org.osflash.signals.Signal;
    import io.decagames.rotmg.pets.data.vo.IPetVO;

    public class ChangePetSkinSignal extends Signal 
    {

        public function ChangePetSkinSignal()
        {
            super(IPetVO);
        }

    }
}//package io.decagames.rotmg.pets.signals

