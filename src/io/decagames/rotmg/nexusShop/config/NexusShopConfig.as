// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.nexusShop.config.NexusShopConfig

package io.decagames.rotmg.nexusShop.config
{
    import robotlegs.bender.framework.api.IConfig;
    import org.swiftsuspenders.Injector;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import io.decagames.rotmg.nexusShop.NexusShopPopupView;
    import io.decagames.rotmg.nexusShop.NexusShopPopupMediator;

    public class NexusShopConfig implements IConfig 
    {

        [Inject]
        public var injector:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:ISignalCommandMap;


        public function configure():void
        {
            this.mediatorMap.map(NexusShopPopupView).toMediator(NexusShopPopupMediator);
        }


    }
}//package io.decagames.rotmg.nexusShop.config

