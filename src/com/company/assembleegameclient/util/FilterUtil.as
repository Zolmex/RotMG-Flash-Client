// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.util.FilterUtil

package com.company.assembleegameclient.util
{
    import flash.filters.DropShadowFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.GlowFilter;
    import flash.filters.ColorMatrixFilter;
    import com.company.util.MoreColorUtil;

    public class FilterUtil 
    {

        private static const UILABEL_DROP_SHADOW_FILTER_01:Array = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
        private static const UILABEL_DROP_SHADOW_FILTER_02:Array = [new DropShadowFilter(1, 90, 0, 0.6, 4, 4)];
        private static const UILABEL_COMBO_FILTER:Array = [new DropShadowFilter(1, 90, 0, 1, 2, 2), new DropShadowFilter(0, 90, 0, 0.4, 4, 4, 1, BitmapFilterQuality.HIGH)];
        private static const STANDARD_DROP_SHADOW_FILTER:Array = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        private static const STANDARD_OUTLINE_FILTER:Array = [new GlowFilter(0, 1, 2, 2, 10, 1)];
        private static const LARGE_GLOW_FILTER:Array = [new GlowFilter(0xFFFFFF, 0.6, 10, 10, 10, 1)];
        private static const GREY_COLOR_FILTER:Array = [new ColorMatrixFilter(MoreColorUtil.singleColorFilterMatrix(0x363636))];
        private static const DARK_GREY_COLOR_FILTER:Array = [new ColorMatrixFilter(MoreColorUtil.singleColorFilterMatrix(0x1C1C1C))];
        private static var _CHALLENGER_LEADER_BOARD_DROP_SHADOW:Array = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];


        public static function getUILabelDropShadowFilter01():Array
        {
            return (UILABEL_DROP_SHADOW_FILTER_01);
        }

        public static function getUILabelDropShadowFilter02():Array
        {
            return (UILABEL_DROP_SHADOW_FILTER_02);
        }

        public static function getUILabelComboFilter():Array
        {
            return (UILABEL_COMBO_FILTER);
        }

        public static function getStandardDropShadowFilter():Array
        {
            return (STANDARD_DROP_SHADOW_FILTER);
        }

        public static function getTextOutlineFilter():Array
        {
            return (STANDARD_OUTLINE_FILTER);
        }

        public static function getGreyColorFilter():Array
        {
            return (GREY_COLOR_FILTER);
        }

        public static function getDarkGreyColorFilter():Array
        {
            return (DARK_GREY_COLOR_FILTER);
        }

        public static function getLargeGlowFilter():Array
        {
            return (LARGE_GLOW_FILTER);
        }

        public static function get CHALLENGER_LEADER_BOARD_DROP_SHADOW():Array
        {
            return (_CHALLENGER_LEADER_BOARD_DROP_SHADOW);
        }


    }
}//package com.company.assembleegameclient.util

