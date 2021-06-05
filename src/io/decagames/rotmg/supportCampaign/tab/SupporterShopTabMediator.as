// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.tab.SupporterShopTabMediator

package io.decagames.rotmg.supportCampaign.tab
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.ui.signals.HUDModelInitialized;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
    import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import io.decagames.rotmg.supportCampaign.signals.UpdateCampaignProgress;
    import io.decagames.rotmg.supportCampaign.signals.TierSelectedSignal;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import flash.display.Loader;
    import io.decagames.rotmg.ui.imageLoader.ImageLoader;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import com.company.assembleegameclient.objects.Player;
    import io.decagames.rotmg.supportCampaign.data.SupporterFeatures;
    import io.decagames.rotmg.shop.NotEnoughResources;
    import com.company.assembleegameclient.util.Currency;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;

    public class SupporterShopTabMediator extends Mediator 
    {

        [Inject]
        public var view:SupporterShopTabView;
        [Inject]
        public var model:SupporterCampaignModel;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var initHUDModelSignal:HUDModelInitialized;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var showPopup:ShowPopupSignal;
        [Inject]
        public var showFade:ShowLockFade;
        [Inject]
        public var removeFade:RemoveLockFade;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var updatePointsSignal:UpdateCampaignProgress;
        [Inject]
        public var selectedSignal:TierSelectedSignal;
        private var infoToolTip:TextToolTip;
        private var hoverTooltipDelegate:HoverTooltipDelegate;
        private var _loader:Loader;
        private var _imageLoader:ImageLoader;


        override public function initialize():void
        {
            this.updatePointsSignal.add(this.onPointsUpdate);
            var _local_1:DisplayObject = this.model.getCampaignImageByUrl(this.model.campaignBannerUrl);
            if (_local_1)
            {
                this.showCampaignView(_local_1);
            }
            else
            {
                this._imageLoader = new ImageLoader();
                this._imageLoader.loadImage(this.model.campaignBannerUrl, this.onBannerLoaded);
            };
        }

        private function initView():void
        {
            if (!this.model.isStarted)
            {
                this.view.addEventListener(Event.ENTER_FRAME, this.updateStartCountdown);
            };
            if (this.model.isUnlocked)
            {
                this.updateCampaignInformation();
            };
            if (this.view.unlockButton)
            {
                this.view.unlockButton.clickSignal.add(this.unlockClick);
            };
        }

        private function onBannerLoaded(_arg_1:Event):void
        {
            this._imageLoader.removeLoaderListeners();
            var _local_2:DisplayObject = this._imageLoader.loader;
            this.model.addCampaignImageByUrl(this.model.campaignBannerUrl, _local_2);
            this.showCampaignView(_local_2);
        }

        private function showCampaignView(_arg_1:DisplayObject):void
        {
            this.view.show(this.hudModel.getPlayerName(), this.model.isUnlocked, this.model.isStarted, this.model.unlockPrice, this.model.donatePointsRatio, this.model.isEnded, _arg_1);
            this.initView();
        }

        private function updateCampaignInformation():void
        {
            this.view.updatePoints(this.model.points, this.model.rank);
            this.view.drawProgress(this.model.points, this.model.rankConfig, this.model.rank, this.model.claimed);
            this.updateInfoTooltip();
            this.showCampaignTier();
            this.view.updateTime((this.model.endDate.time - new Date().time));
        }

        private function showCampaignTier():void
        {
            var _local_1:String = this.model.getCampaignPictureUrlByRank(this.model.nextClaimableTier);
            var _local_2:DisplayObject = this.model.getCampaignImageByUrl(_local_1);
            if (_local_2)
            {
                this.showTier(_local_2);
            }
            else
            {
                this._imageLoader = new ImageLoader();
                this._imageLoader.loadImage(_local_1, this.onCampaignTierImageLoaded);
            };
        }

        private function onCampaignTierImageLoaded(_arg_1:Event):void
        {
            this._imageLoader.removeLoaderListeners();
            var _local_2:DisplayObject = this._imageLoader.loader;
            this.model.addCampaignImageByUrl(this.model.getCampaignPictureUrlByRank(this.model.nextClaimableTier), _local_2);
            this.showTier(_local_2);
        }

        private function showTier(_arg_1:DisplayObject):void
        {
            this.view.showTier(this.model.nextClaimableTier, this.model.ranks, this.model.rank, this.model.claimed, _arg_1);
        }

        private function updateStartCountdown(_arg_1:Event):void
        {
            var _local_2:String = this.model.getStartTimeString();
            if (_local_2 == "")
            {
                this.view.removeEventListener(Event.ENTER_FRAME, this.updateStartCountdown);
                this.view.unlockButton.disabled = false;
            };
            this.view.updateStartCountdown(_local_2);
        }

        override public function destroy():void
        {
            this.updatePointsSignal.remove(this.onPointsUpdate);
            if (this.view.unlockButton)
            {
                this.view.unlockButton.clickSignal.remove(this.unlockClick);
            };
            this.view.removeEventListener(Event.ENTER_FRAME, this.updateStartCountdown);
        }

        private function onPointsUpdate():void
        {
            this.view.updatePoints(this.model.points, this.model.rank);
            this.showCampaignTier();
            this.view.drawProgress(this.model.points, this.model.rankConfig, this.model.rank, this.model.claimed);
            this.updateInfoTooltip();
            this.selectedSignal.dispatch(this.model.nextClaimableTier);
            var _local_1:Player = this.gameModel.player;
            if (_local_1.hasSupporterFeature(SupporterFeatures.GLOW))
            {
                _local_1.supporterPoints = this.model.points;
                _local_1.clearTextureCache();
            };
        }

        private function updateInfoTooltip():void
        {
            if (this.view.infoButton)
            {
                if (this.model.hasMaxRank())
                {
                    this.infoToolTip = new TextToolTip(0x363636, 15585539, "Bonus Points", "You have reached the maximum rank and therefore completed the Bonus Campaign - Congratulation!", 220);
                }
                else
                {
                    this.infoToolTip = new TextToolTip(0x363636, 0x9B9B9B, "Bonus Points", ("This is the amount of Bonus Points you have collected so far. Collect more Points " + "and claim Rewards!"), 220);
                };
                this.hoverTooltipDelegate = new HoverTooltipDelegate();
                this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
                this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
                this.hoverTooltipDelegate.setDisplayObject(this.view.infoButton);
                this.hoverTooltipDelegate.tooltip = this.infoToolTip;
            };
        }

        private function unlockClick(_arg_1:BaseButton):void
        {
            if (this.currentGold < this.model.unlockPrice)
            {
                this.showPopup.dispatch(new NotEnoughResources(300, Currency.GOLD));
                return;
            };
            this.showFade.dispatch();
            var _local_2:Object = this.account.getCredentials();
            this.client.sendRequest("/supportCampaign/unlock", _local_2);
            this.client.complete.addOnce(this.onUnlockComplete);
        }

        private function onUnlockComplete(isOK:Boolean, data:*):void
        {
            var xml:XML;
            var errorMessage:XML;
            var message:String;
            this.removeFade.dispatch();
            if (isOK)
            {
                try
                {
                    xml = new XML(data);
                    if (xml.hasOwnProperty("Gold"))
                    {
                        this.updateUserGold(int(xml.Gold));
                    };
                    this.view.show(null, true, this.model.isStarted, this.model.unlockPrice, this.model.donatePointsRatio, this.model.isEnded, this._loader);
                    this.model.parseUpdateData(xml);
                    this.updateCampaignInformation();
                }
                catch(e:Error)
                {
                    showPopup.dispatch(new ErrorModal(300, "Campaign Error", "General campaign error."));
                };
            }
            else
            {
                try
                {
                    errorMessage = new XML(data);
                    message = LineBuilder.getLocalizedStringFromKey(errorMessage.toString(), {});
                    this.showPopup.dispatch(new ErrorModal(300, "Campaign Error", ((message == "") ? errorMessage.toString() : message)));
                }
                catch(e:Error)
                {
                    showPopup.dispatch(new ErrorModal(300, "Campaign Error", "General campaign error."));
                };
            };
        }

        private function updateUserGold(_arg_1:int):void
        {
            var _local_2:Player = this.gameModel.player;
            if (_local_2 != null)
            {
                _local_2.setCredits(_arg_1);
            }
            else
            {
                this.playerModel.setCredits(_arg_1);
            };
        }

        private function get currentGold():int
        {
            var _local_1:Player = this.gameModel.player;
            if (_local_1 != null)
            {
                return (_local_1.credits_);
            };
            if (this.playerModel != null)
            {
                return (this.playerModel.getCredits());
            };
            return (0);
        }


    }
}//package io.decagames.rotmg.supportCampaign.tab

