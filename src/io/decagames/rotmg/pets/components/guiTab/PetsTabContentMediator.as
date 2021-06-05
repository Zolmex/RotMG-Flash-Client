// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.components.guiTab.PetsTabContentMediator

package io.decagames.rotmg.pets.components.guiTab
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.pets.data.PetsModel;

    public class PetsTabContentMediator extends Mediator 
    {

        [Inject]
        public var view:PetsTabContentView;
        [Inject]
        public var model:PetsModel;


        override public function initialize():void
        {
            this.view.init(this.model.getActivePet());
        }

        override public function destroy():void
        {
        }


    }
}//package io.decagames.rotmg.pets.components.guiTab

