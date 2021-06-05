﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.commands.UseBuyPotionCommand

package kabam.rotmg.game.commands
{
    import kabam.rotmg.game.model.UseBuyPotionVO;
    import kabam.rotmg.game.model.PotionInventoryModel;
    import kabam.rotmg.ui.model.HUDModel;
    import robotlegs.bender.framework.api.ILogger;
    import kabam.rotmg.messaging.impl.GameServerConnection;
    import com.company.assembleegameclient.objects.Player;
    import kabam.rotmg.ui.model.PotionModel;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.sound.SoundEffectLibrary;
    import flash.utils.getTimer;

    public class UseBuyPotionCommand 
    {

        [Inject]
        public var vo:UseBuyPotionVO;
        [Inject]
        public var potInventoryModel:PotionInventoryModel;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var logger:ILogger;
        private var gsc:GameServerConnection = GameServerConnection.instance;
        private var player:Player;
        private var potionId:int;
        private var count:int;
        private var potion:PotionModel;


        public function execute():void
        {
            this.player = this.hudModel.gameSprite.map.player_;
            if (this.player == null)
            {
                return;
            };
            this.potionId = this.vo.objectId;
            this.count = this.player.getPotionCount(this.potionId);
            this.potion = this.potInventoryModel.getPotionModel(this.potionId);
            if (((this.count > 0) || (this.canPurchasePotion())))
            {
                this.usePotionIfEffective();
            }
            else
            {
                this.logger.info("Not safe to purchase potion");
            };
        }

        private function canPurchasePotion():Boolean
        {
            var _local_1:* = (this.player.credits_ >= this.potion.currentCost(this.player.getPotionCount(this.potionId)));
            var _local_2:Boolean = Parameters.data_.contextualPotionBuy;
            return ((_local_1) && (_local_2));
        }

        private function usePotionIfEffective():void
        {
            if (this.isPlayerStatMaxed())
            {
                this.logger.info("UseBuyPotionCommand.execute: User has MAX of that attribute, not requesting a use/buy from server.");
            }
            else
            {
                this.sendServerRequest();
                SoundEffectLibrary.play("use_potion");
            };
        }

        private function isPlayerStatMaxed():Boolean
        {
            if (this.potionId == PotionInventoryModel.HEALTH_POTION_ID)
            {
                return (this.player.hp_ >= this.player.maxHP_);
            };
            if (this.potionId == PotionInventoryModel.MAGIC_POTION_ID)
            {
                return (this.player.mp_ >= this.player.maxMP_);
            };
            return (false);
        }

        private function sendServerRequest():void
        {
            var _local_1:int = PotionInventoryModel.getPotionSlot(this.vo.objectId);
            var _local_2:int = Parameters.data_.contextualPotionBuy;
            this.gsc.useItem(getTimer(), this.player.objectId_, _local_1, this.potionId, this.player.x_, this.player.y_, _local_2);
            if (this.player.getPotionCount(this.vo.objectId) == 0)
            {
                this.potInventoryModel.getPotionModel(this.vo.objectId).purchasedPot();
            };
        }


    }
}//package kabam.rotmg.game.commands

