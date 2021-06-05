﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.view.MysteryBoxPanel

package kabam.rotmg.game.view
{
    import com.company.assembleegameclient.ui.panels.Panel;
    import org.osflash.signals.Signal;
    import com.company.assembleegameclient.objects.SellableObject;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.util.components.LegacyBuyButton;
    import com.company.assembleegameclient.ui.DeprecatedTextButton;
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import kabam.rotmg.core.StaticInjectorContext;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.mysterybox.services.GetMysteryBoxesTask;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.model.TextKey;
    import flash.text.TextFieldAutoSize;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.mysterybox.services.MysteryBoxModel;
    import kabam.rotmg.account.core.Account;
    import flash.events.MouseEvent;
    import kabam.rotmg.arena.util.ArenaViewAssetFactory;
    import flash.events.Event;
    import com.company.assembleegameclient.game.GameSprite;
    import flash.events.KeyboardEvent;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import io.decagames.rotmg.shop.ShopConfiguration;
    import io.decagames.rotmg.shop.ShopPopupView;
    import kabam.rotmg.mysterybox.components.MysteryBoxSelectModal;
    import kabam.rotmg.account.core.view.RegisterPromptDialog;
    import com.company.assembleegameclient.util.Currency;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.ui.panels.*;

    public class MysteryBoxPanel extends Panel 
    {

        private const BUTTON_OFFSET:int = 17;

        public var buyItem:Signal = new Signal(SellableObject);
        private var owner_:SellableObject;
        private var nameText_:TextFieldDisplayConcrete;
        private var buyButton_:LegacyBuyButton;
        private var infoButton_:DeprecatedTextButton;
        private var icon_:Sprite;
        private var bitmap_:Bitmap;

        public function MysteryBoxPanel(_arg_1:GameSprite, _arg_2:uint)
        {
            var _local_3:Injector = StaticInjectorContext.getInjector();
            var _local_4:GetMysteryBoxesTask = _local_3.getInstance(GetMysteryBoxesTask);
            _local_4.start();
            super(_arg_1);
            this.nameText_ = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth((WIDTH - 44));
            this.nameText_.setBold(true);
            this.nameText_.setStringBuilder(new LineBuilder().setParams(TextKey.SELLABLEOBJECTPANEL_TEXT));
            this.nameText_.setWordWrap(true);
            this.nameText_.setMultiLine(true);
            this.nameText_.setAutoSize(TextFieldAutoSize.CENTER);
            this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.nameText_);
            this.icon_ = new Sprite();
            addChild(this.icon_);
            this.bitmap_ = new Bitmap(null);
            this.icon_.addChild(this.bitmap_);
            var _local_5:* = "MysteryBoxPanel.open";
            var _local_6:* = "MysteryBoxPanel.checkBackLater";
            var _local_7:* = "MysteryBoxPanel.mysteryBoxShop";
            var _local_8:MysteryBoxModel = _local_3.getInstance(MysteryBoxModel);
            var _local_9:Account = _local_3.getInstance(Account);
            if (((_local_8.isInitialized()) || (!(_local_9.isRegistered()))))
            {
                this.infoButton_ = new DeprecatedTextButton(16, _local_5);
                this.infoButton_.addEventListener(MouseEvent.CLICK, this.onInfoButtonClick);
                addChild(this.infoButton_);
            }
            else
            {
                this.infoButton_ = new DeprecatedTextButton(16, _local_6);
                addChild(this.infoButton_);
            }
            this.nameText_.setStringBuilder(new LineBuilder().setParams("Shop"));
            this.bitmap_.bitmapData = ArenaViewAssetFactory.returnHostBitmap(_arg_2).bitmapData;
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        public function setOwner(_arg_1:SellableObject):void
        {
            if (_arg_1 == this.owner_)
            {
                return;
            }
            this.owner_ = _arg_1;
            this.buyButton_.setPrice(this.owner_.price_, this.owner_.currency_);
            var _local_2:String = this.owner_.soldObjectName();
            this.nameText_.setStringBuilder(new LineBuilder().setParams(_local_2));
            this.bitmap_.bitmapData = this.owner_.getIcon();
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            this.icon_.x = -4;
            this.icon_.y = -8;
            this.nameText_.x = 44;
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            this.infoButton_.removeEventListener(MouseEvent.CLICK, this.onInfoButtonClick);
        }

        private function onInfoButtonClick(_arg_1:MouseEvent):void
        {
            this.onInfoButton();
        }

        private function onInfoButton():void
        {
            var _local_5:ShowPopupSignal;
            var _local_1:Injector = StaticInjectorContext.getInjector();
            var _local_2:MysteryBoxModel = _local_1.getInstance(MysteryBoxModel);
            var _local_3:Account = _local_1.getInstance(Account);
            var _local_4:OpenDialogSignal = _local_1.getInstance(OpenDialogSignal);
            if (((_local_2.isInitialized()) && (_local_3.isRegistered())))
            {
                if (ShopConfiguration.USE_NEW_SHOP)
                {
                    _local_5 = _local_1.getInstance(ShowPopupSignal);
                    _local_5.dispatch(new ShopPopupView());
                }
                else
                {
                    _local_4.dispatch(new MysteryBoxSelectModal());
                }
            }
            else
            {
                if (!_local_3.isRegistered())
                {
                    _local_4.dispatch(new RegisterPromptDialog("SellableObjectPanelMediator.text", {"type":Currency.typeToName(Currency.GOLD)}));
                }
            }
        }

        private function onKeyDown(_arg_1:KeyboardEvent):void
        {
            if (((_arg_1.keyCode == Parameters.data_.interact) && (stage.focus == null)))
            {
                this.onInfoButton();
            }
        }

        override public function draw():void
        {
            this.nameText_.y = ((this.nameText_.height > 30) ? 0 : 12);
            this.infoButton_.x = ((WIDTH / 2) - (this.infoButton_.width / 2));
            this.infoButton_.y = ((HEIGHT - (this.infoButton_.height / 2)) - this.BUTTON_OFFSET);
            if (!contains(this.infoButton_))
            {
                addChild(this.infoButton_);
            }
        }


    }
}//package kabam.rotmg.game.view

