// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.panels.mediators.EquippedGridMediator

package com.company.assembleegameclient.ui.panels.mediators
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
    import kabam.rotmg.ui.signals.ToggleShowTierTagSignal;

    public class EquippedGridMediator extends Mediator 
    {

        [Inject]
        public var view:EquippedGrid;
        [Inject]
        public var toggleShowTierTag:ToggleShowTierTagSignal;


        override public function initialize():void
        {
            this.toggleShowTierTag.add(this.onToggleShowTierTag);
        }

        private function onToggleShowTierTag(_arg_1:Boolean):void
        {
            this.view.toggleTierTags(_arg_1);
        }


    }
}//package com.company.assembleegameclient.ui.panels.mediators

