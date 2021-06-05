// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.classes.services.BuySkinTask

package kabam.rotmg.classes.services
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.classes.model.CharacterSkin;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.classes.model.CharacterSkinState;
    import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

    public class BuySkinTask extends BaseTask 
    {

        [Inject]
        public var skin:CharacterSkin;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var openDialog:OpenDialogSignal;


        override protected function startTask():void
        {
            this.skin.setState(CharacterSkinState.PURCHASING);
            this.player.changeCredits(-(this.skin.cost));
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("account/purchaseSkin", this.makeCredentials());
        }

        private function makeCredentials():Object
        {
            var _local_1:Object = this.account.getCredentials();
            _local_1.skinType = this.skin.id;
            _local_1.isChallenger = this.seasonalEventModel.isChallenger;
            return (_local_1);
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.completePurchase();
            }
            else
            {
                this.abandonPurchase(_arg_2);
            }
            completeTask(_arg_1, _arg_2);
        }

        private function completePurchase():void
        {
            this.skin.setState(CharacterSkinState.OWNED);
            this.skin.setIsSelected(true);
        }

        private function abandonPurchase(_arg_1:String):void
        {
            var _local_2:ErrorDialog = new ErrorDialog(_arg_1);
            this.openDialog.dispatch(_local_2);
            this.skin.setState(CharacterSkinState.PURCHASABLE);
            this.player.changeCredits(this.skin.cost);
        }


    }
}//package kabam.rotmg.classes.services

