// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.tooltips.TooltipsConfig

package kabam.rotmg.tooltips
{
    import robotlegs.bender.framework.api.IConfig;
    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import kabam.rotmg.tooltips.view.TooltipsView;
    import kabam.rotmg.tooltips.view.TooltipsMediator;

    public class TooltipsConfig implements IConfig 
    {

        [Inject]
        public var context:IContext;
        [Inject]
        public var mediatorMap:IMediatorMap;


        public function configure():void
        {
            this.mediatorMap.map(TooltipsView).toMediator(TooltipsMediator);
        }


    }
}//package kabam.rotmg.tooltips

