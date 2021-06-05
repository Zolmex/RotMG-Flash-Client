// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.pets.windows.yard.feed.items.FeedItemMediator

package io.decagames.rotmg.pets.windows.yard.feed.items
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import kabam.rotmg.ui.model.HUDModel;
    import io.decagames.rotmg.pets.signals.SelectFeedItemSignal;
    import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.constants.InventoryOwnerTypes;
    import flash.events.MouseEvent;

    public class FeedItemMediator extends Mediator 
    {

        [Inject]
        public var view:FeedItem;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipsSignal:HideTooltipsSignal;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var selectFeedItemSignal:SelectFeedItemSignal;
        private var tooltip:EquipmentToolTip;


        override public function initialize():void
        {
            var _local_1:Player = (((this.hud.gameSprite) && (this.hud.gameSprite.map)) ? this.hud.gameSprite.map.player_ : null);
            var _local_2:int = ObjectLibrary.idToType_[this.view.itemId];
            this.tooltip = new EquipmentToolTip(this.view.itemId, _local_1, _local_2, InventoryOwnerTypes.CURRENT_PLAYER);
            this.view.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
            this.view.addEventListener(MouseEvent.CLICK, this.onClickHandler);
        }

        private function onClickHandler(_arg_1:MouseEvent):void
        {
            this.view.selected = (!(this.view.selected));
            this.selectFeedItemSignal.dispatch();
            this.hideTooltipsSignal.dispatch();
        }

        private function onRollOverHandler(_arg_1:MouseEvent):void
        {
            this.tooltip.attachToTarget(this.view);
            this.showTooltipSignal.dispatch(this.tooltip);
        }

        override public function destroy():void
        {
            this.view.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
            this.view.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
            this.view.dispose();
        }


    }
}//package io.decagames.rotmg.pets.windows.yard.feed.items

