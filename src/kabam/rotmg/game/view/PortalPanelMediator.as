// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.view.PortalPanelMediator

package kabam.rotmg.game.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.ui.panels.PortalPanel;
    import kabam.rotmg.game.signals.ExitGameSignal;
    import kabam.rotmg.core.service.GoogleAnalytics;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import com.company.assembleegameclient.ui.tooltip.IconToolTip;

    public class PortalPanelMediator extends Mediator 
    {

        [Inject]
        public var view:PortalPanel;
        [Inject]
        public var exitGameSignal:ExitGameSignal;
        [Inject]
        public var googleAnalytics:GoogleAnalytics;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipsSignal:HideTooltipsSignal;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        private var challengerTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void
        {
            this.view.googleAnalytics = this.googleAnalytics;
            this.view.exitGameSignal.add(this.onExitGame);
            this.view.enterButton_.addEventListener(MouseEvent.CLICK, this.view.onEnterSpriteClick);
        }

        private function onExitGame():void
        {
            this.exitGameSignal.dispatch();
        }

        override public function destroy():void
        {
            this.view.exitGameSignal.remove(this.onExitGame);
            ((this.challengerTooltipDelegate) && (this.challengerTooltipDelegate.removeDisplayObject()));
            this.challengerTooltipDelegate = null;
        }

        private function createChallengerTooltipDelegate(_arg_1:IconToolTip):void
        {
            this.challengerTooltipDelegate = new HoverTooltipDelegate();
            this.challengerTooltipDelegate.setHideToolTipsSignal(this.hideTooltipsSignal);
            this.challengerTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.challengerTooltipDelegate.setDisplayObject((this.view.enterButton_ as DisplayObject));
            this.challengerTooltipDelegate.tooltip = _arg_1;
        }


    }
}//package kabam.rotmg.game.view

