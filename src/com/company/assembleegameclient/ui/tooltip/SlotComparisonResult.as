// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.tooltip.SlotComparisonResult

package com.company.assembleegameclient.ui.tooltip
{
    import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
    import flash.utils.Dictionary;

    public class SlotComparisonResult 
    {

        public var lineBuilder:AppendingLineBuilder;
        public var processedTags:Dictionary;

        public function SlotComparisonResult()
        {
            this.lineBuilder = new AppendingLineBuilder();
            this.processedTags = new Dictionary(true);
        }

    }
}//package com.company.assembleegameclient.ui.tooltip

