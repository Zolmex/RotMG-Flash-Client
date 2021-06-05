// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.tooltips.TooltipAble

package kabam.rotmg.tooltips
{
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;

    public interface TooltipAble 
    {

        function setShowToolTipSignal(_arg_1:ShowTooltipSignal):void;
        function getShowToolTip():ShowTooltipSignal;
        function setHideToolTipsSignal(_arg_1:HideTooltipsSignal):void;
        function getHideToolTips():HideTooltipsSignal;

    }
}//package kabam.rotmg.tooltips

