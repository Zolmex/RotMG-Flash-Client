// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.DailyQuestWindowMediator

package io.decagames.rotmg.dailyQuests.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.dailyQuests.signal.LockQuestScreenSignal;
    import io.decagames.rotmg.dailyQuests.signal.QuestRedeemCompleteSignal;
    import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
    import io.decagames.rotmg.dailyQuests.signal.CloseRedeemPopupSignal;
    import io.decagames.rotmg.dailyQuests.signal.CloseExpirePopupSignal;
    import kabam.rotmg.dailyLogin.model.DailyLoginModel;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.dailyQuests.signal.CloseRefreshPopupSignal;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.ui.signals.UpdateQuestSignal;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRedeemPopup;
    import io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRefreshPopup;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import flash.events.Event;
    import io.decagames.rotmg.dailyQuests.view.list.DailyQuestsList;
    import kabam.rotmg.ui.view.NotEnoughGoldDialog;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import com.company.assembleegameclient.ui.tooltip.IconToolTip;
    import flash.display.Bitmap;
    import kabam.rotmg.assets.services.IconFactory;
    import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
    import kabam.rotmg.messaging.impl.incoming.QuestRedeemResponse;

    public class DailyQuestWindowMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestWindow;
        [Inject]
        public var lockScreen:LockQuestScreenSignal;
        [Inject]
        public var redeemCompleteSignal:QuestRedeemCompleteSignal;
        [Inject]
        public var dailyQuestsModel:DailyQuestsModel;
        [Inject]
        public var closeRedeem:CloseRedeemPopupSignal;
        [Inject]
        public var closeExpire:CloseExpirePopupSignal;
        [Inject]
        public var dailyLoginModel:DailyLoginModel;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipsSignal:HideTooltipsSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var closeRefreshPopupSignal:CloseRefreshPopupSignal;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var updateQuestSignal:UpdateQuestSignal;
        private var toolTip:TextToolTip;
        private var hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();
        private var closeButton:SliceScalingButton;
        private var infoButton:SliceScalingButton;
        private var contentBackground:SliceScalingBitmap;
        private var redeemPopup:DailyQuestRedeemPopup;
        private var dailyQuestRefreshPopup:DailyQuestRefreshPopup;
        private var refreshTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void
        {
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.infoButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "info_button"));
            this.view.header.setTitle("The Tinkerer", 450, DefaultLabelFormat.defaultPopupTitle);
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.view.header.addButton(this.infoButton, PopupHeader.LEFT_BUTTON);
            this.view.refreshButton.clickSignal.add(this.onRefreshClick);
            this.view.questList.tabs.tabSelectedSignal.add(this.onTabSelected);
            this.contentBackground = TextureParser.instance.getSliceScalingBitmap("UI", "tab_cointainer_background_filled");
            this.contentBackground.width = 580;
            this.contentBackground.height = 445;
            this.view.contentContainer.addChildAt(this.contentBackground, 0);
            this.lockScreen.add(this.onLockScreen);
            this.redeemCompleteSignal.add(this.onRedeemComplete);
            this.closeRedeem.add(this.onRedeemClose);
            this.closeExpire.add(this.onExpireClose);
            this.closeRefreshPopupSignal.add(this.onRefreshPopupClosed);
            this.updateQuestSignal.add(this.onQuestsUpdate);
            this.view.addEventListener(Event.ENTER_FRAME, this.updateTimeHandler);
            this.setToolTipTitle("The Tinkerer", (((("Complete the quests to earn great rewards!\n\n" + "You can select a quest from the list to display the quest requirements. ") + "Bring the items back to me to complete the quest and rewards will be sent directly to your Gift Chest.") + '\n\nItems will be directly consumed from your inventory or backpack when you press "Complete!".') + "\n\nYou can complete each quest only once per day, refresh to get new Quests up to 2 times per day in addition to the Tinkerer offering you new quests everyday!"));
            this.setRefreshQuestsState();
        }

        private function setRefreshQuestsState():void
        {
            this.destroyRefreshTooltip();
            if (this.dailyQuestsModel.dailyQuestsList.length == 0)
            {
                this.createBuyQuestRefreshToolTip(this.noMoreQuestsToolTip());
                this.view.refreshButton.clickSignal.remove(this.onRefreshClick);
                this.setRefreshButtonState(true);
            }
            else
            {
                if (this.dailyQuestsModel.nextRefreshPrice != -1)
                {
                    this.createBuyQuestRefreshToolTip(this.buyRefreshToolTip());
                    this.view.refreshButton.clickSignal.remove(this.onRefreshClick);
                    this.view.refreshButton.clickSignal.add(this.onRefreshClick);
                    this.setRefreshButtonState(false);
                }
                else
                {
                    this.createBuyQuestRefreshToolTip(this.noMoreRefreshToolTip());
                    this.view.refreshButton.clickSignal.remove(this.onRefreshClick);
                    this.setRefreshButtonState(true);
                };
            };
        }

        private function setRefreshButtonState(_arg_1:Boolean):void
        {
            this.view.refreshButton.disabled = _arg_1;
        }

        private function onQuestsUpdate(_arg_1:String):void
        {
            this.setRefreshQuestsState();
        }

        private function onTabSelected(_arg_1:String):void
        {
            if (_arg_1 == DailyQuestsList.EVENT_TAB_LABEL)
            {
                this.view.refreshButton.visible = false;
            }
            else
            {
                this.view.refreshButton.visible = true;
                this.setRefreshQuestsState();
            };
        }

        private function onRefreshClick(_arg_1:BaseButton):void
        {
            if (!this.hasEnoughGold(this.dailyQuestsModel.nextRefreshPrice))
            {
                this.showPopupSignal.dispatch(new NotEnoughGoldDialog());
            }
            else
            {
                this.dailyQuestRefreshPopup = new DailyQuestRefreshPopup(this.dailyQuestsModel.nextRefreshPrice);
                this.view.hideFade();
                this.view.showFade(0x151515);
                this.showPopupSignal.dispatch(this.dailyQuestRefreshPopup);
            };
        }

        private function setToolTipTitle(_arg_1:String, _arg_2:String):void
        {
            this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, _arg_1, _arg_2, 300, null);
            this.hoverTooltipDelegate.setDisplayObject(this.infoButton);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipsSignal);
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.tooltip = this.toolTip;
        }

        private function updateTimeHandler(_arg_1:Event):void
        {
            var _local_2:String = ("Quests refresh in " + this.dailyLoginModel.getFormatedQuestRefreshTime());
            this.view.setQuestRefreshHeader(_local_2);
        }

        override public function destroy():void
        {
            this.lockScreen.remove(this.onLockScreen);
            this.redeemCompleteSignal.remove(this.onRedeemComplete);
            this.closeRedeem.remove(this.onRedeemClose);
            this.closeExpire.remove(this.onExpireClose);
            this.view.removeEventListener(Event.ENTER_FRAME, this.updateTimeHandler);
            this.dailyQuestsModel.isPopupOpened = false;
            this.toolTip = null;
            this.hoverTooltipDelegate.removeDisplayObject();
            this.hoverTooltipDelegate = null;
            this.view.refreshButton.clickSignal.remove(this.onRefreshClick);
            this.destroyRefreshTooltip();
        }

        private function destroyRefreshTooltip():void
        {
            ((this.refreshTooltipDelegate) && (this.refreshTooltipDelegate.removeDisplayObject()));
            this.refreshTooltipDelegate = null;
        }

        private function buyRefreshToolTip():IconToolTip
        {
            var _local_1:String = ("Refresh your Daily Quests for " + this.dailyQuestsModel.nextRefreshPrice);
            return (new IconToolTip("Refresh Daily Quests", _local_1, 0x363636, 1, 0x9B9B9B, 1, true, new Bitmap(IconFactory.makeCoin())));
        }

        private function noMoreRefreshToolTip():IconToolTip
        {
            return (new IconToolTip("Refresh Daily Quests", "You have no more Daily Quest Refreshes left", 0x363636, 1, 0x9B9B9B, 1, true));
        }

        private function noMoreQuestsToolTip():IconToolTip
        {
            return (new IconToolTip("Refresh Daily Quests", "There are no Daily Quests available", 0x363636, 1, 0x9B9B9B, 1, true));
        }

        private function createBuyQuestRefreshToolTip(_arg_1:IconToolTip):void
        {
            this.refreshTooltipDelegate = new HoverTooltipDelegate();
            this.refreshTooltipDelegate.setHideToolTipsSignal(this.hideTooltipsSignal);
            this.refreshTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.refreshTooltipDelegate.setDisplayObject((this.view.refreshButton as SliceScalingButton));
            this.refreshTooltipDelegate.tooltip = _arg_1;
        }

        private function onRedeemComplete(message:QuestRedeemResponse):void
        {
            var questId:String;
            var completedQuests:int;
            try
            {
                if (message.ok)
                {
                    questId = this.dailyQuestsModel.currentQuest.id;
                    this.redeemPopup = new DailyQuestRedeemPopup(this.dailyQuestsModel.getQuestById(questId), this.dailyQuestsModel.selectedItem);
                    this.dailyQuestsModel.markAsCompleted(this.dailyQuestsModel.currentQuest.id);
                    completedQuests = this.dailyQuestsModel.numberOfCompletedQuests;
                    if (!this.dailyQuestsModel.currentQuest.repeatable)
                    {
                        this.dailyQuestsModel.currentQuest.completed = true;
                    };
                    completedQuests = (completedQuests + 1);
                    this.view.hideFade();
                    this.view.showFade(0x151515, (completedQuests == this.dailyQuestsModel.numberOfActiveQuests));
                    this.showPopupSignal.dispatch(this.redeemPopup);
                }
                else
                {
                    this.view.hideFade();
                    this.showPopupSignal.dispatch(new ErrorModal(300, "Quest Error", message.message));
                    this.dailyQuestsModel.removeQuestFromlist(this.dailyQuestsModel.getQuestById(this.dailyQuestsModel.currentQuest.id));
                    this.onRedeemClose();
                };
            }
            catch(error:Error)
            {
                view.hideFade();
                showPopupSignal.dispatch(new ErrorModal(300, "Quest Error", error.message));
                onRedeemClose();
            };
        }

        private function onLockScreen():void
        {
            this.view.showFade();
        }

        private function onRedeemClose():void
        {
            this.reloadQuestList();
            this.closePopupSignal.dispatch(this.redeemPopup);
        }

        private function onExpireClose():void
        {
            this.reloadQuestList();
        }

        private function reloadQuestList():void
        {
            this.view.hideFade();
            this.view.questList.tabs.tabSelectedSignal.remove(this.onTabSelected);
            this.view.renderList();
            this.view.questList.tabs.tabSelectedSignal.add(this.onTabSelected);
            this.onTabSelected(DailyQuestsList.QUEST_TAB_LABEL);
        }

        private function onRefreshPopupClosed():void
        {
            this.view.hideFade();
            this.closePopupSignal.dispatch(this.dailyQuestRefreshPopup);
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
        }

        private function hasEnoughGold(_arg_1:int):Boolean
        {
            return (_arg_1 <= this.hudModel.gameSprite.map.player_.credits_);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view

