// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.controller.GameObjectArrowMediator

package kabam.rotmg.ui.controller
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.map.partyoverlay.GameObjectArrow;
    import kabam.rotmg.core.view.Layers;

    public class GameObjectArrowMediator extends Mediator 
    {

        [Inject]
        public var view:GameObjectArrow;
        [Inject]
        public var layers:Layers;


        override public function initialize():void
        {
            this.view.menuLayer = this.layers.top;
        }


    }
}//package kabam.rotmg.ui.controller

