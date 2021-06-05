// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.lib.resizing.ResizeConfig

package kabam.lib.resizing
{
    import org.swiftsuspenders.Injector;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import kabam.lib.resizing.signals.Resize;
    import kabam.lib.resizing.view.Resizable;
    import kabam.lib.resizing.view.ResizableMediator;

    public class ResizeConfig 
    {

        [Inject]
        public var injector:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;


        [PostConstruct]
        public function setup():void
        {
            this.injector.map(Resize).asSingleton();
            this.mediatorMap.map(Resizable).toMediator(ResizableMediator);
        }


    }
}//package kabam.lib.resizing

