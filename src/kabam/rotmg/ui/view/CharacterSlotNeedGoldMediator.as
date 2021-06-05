// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.view.CharacterSlotNeedGoldMediator

package kabam.rotmg.ui.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
    import kabam.rotmg.core.model.PlayerModel;

    public class CharacterSlotNeedGoldMediator extends Mediator 
    {

        [Inject]
        public var view:CharacterSlotNeedGoldDialog;
        [Inject]
        public var closeDialog:CloseDialogsSignal;
        [Inject]
        public var openMoneyWindow:OpenMoneyWindowSignal;
        [Inject]
        public var model:PlayerModel;


        override public function initialize():void
        {
            this.view.buyGold.add(this.onBuyGold);
            this.view.cancel.add(this.onCancel);
            this.view.setPrice(this.model.getNextCharSlotPrice());
        }

        override public function destroy():void
        {
            this.view.buyGold.remove(this.onBuyGold);
            this.view.cancel.remove(this.onCancel);
        }

        public function onCancel():void
        {
            this.closeDialog.dispatch();
        }

        public function onBuyGold():void
        {
            this.openMoneyWindow.dispatch();
        }


    }
}//package kabam.rotmg.ui.view

