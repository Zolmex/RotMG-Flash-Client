// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.panels.mediators.PartyPanelMediator

package com.company.assembleegameclient.ui.panels.mediators
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.ui.panels.PartyPanel;
    import kabam.rotmg.core.view.Layers;

    public class PartyPanelMediator extends Mediator 
    {

        [Inject]
        public var view:PartyPanel;
        [Inject]
        public var layers:Layers;


        override public function initialize():void
        {
            this.view.menuLayer = this.layers.top;
        }

        override public function destroy():void
        {
            super.destroy();
        }


    }
}//package com.company.assembleegameclient.ui.panels.mediators

