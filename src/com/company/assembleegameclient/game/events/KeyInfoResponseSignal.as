// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.game.events.KeyInfoResponseSignal

package com.company.assembleegameclient.game.events
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.messaging.impl.incoming.KeyInfoResponse;

    public class KeyInfoResponseSignal extends Signal 
    {

        public function KeyInfoResponseSignal()
        {
            super(KeyInfoResponse);
        }

    }
}//package com.company.assembleegameclient.game.events

