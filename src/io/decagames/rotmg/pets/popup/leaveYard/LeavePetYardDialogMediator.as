// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.popup.leaveYard.LeavePetYardDialogMediator

package io.decagames.rotmg.pets.popup.leaveYard
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.ui.model.HUDModel;
    import io.decagames.rotmg.ui.popups.signals.CloseAllPopupsSignal;
    import com.company.assembleegameclient.parameters.Parameters;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class LeavePetYardDialogMediator extends Mediator 
    {

        [Inject]
        public var view:LeavePetYardDialog;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var closeAll:CloseAllPopupsSignal;


        override public function initialize():void
        {
            this.view.leaveButton.clickSignal.add(this.onLeave);
        }

        override public function destroy():void
        {
            this.view.leaveButton.clickSignal.remove(this.onLeave);
        }

        private function onLeave(_arg_1:BaseButton):void
        {
            this.hudModel.gameSprite.gsc_.escape();
            Parameters.data_.needsRandomRealm = false;
            Parameters.save();
            this.closeAll.dispatch();
        }


    }
}//package io.decagames.rotmg.pets.popup.leaveYard

