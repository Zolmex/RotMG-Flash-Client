﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.account.ui.components.SelectionGroup

package com.company.assembleegameclient.account.ui.components
{
    import __AS3__.vec.Vector;

    public class SelectionGroup 
    {

        private var selectables:Vector.<Selectable>;
        private var selected:Selectable;

        public function SelectionGroup(_arg_1:Vector.<Selectable>)
        {
            this.selectables = _arg_1;
        }

        public function setSelected(_arg_1:String):void
        {
            var _local_2:Selectable;
            for each (_local_2 in this.selectables)
            {
                if (_local_2.getValue() == _arg_1)
                {
                    this.replaceSelected(_local_2);
                    return;
                };
            };
        }

        public function getSelected():Selectable
        {
            return (this.selected);
        }

        private function replaceSelected(_arg_1:Selectable):void
        {
            if (this.selected != null)
            {
                this.selected.setSelected(false);
            };
            this.selected = _arg_1;
            this.selected.setSelected(true);
        }


    }
}//package com.company.assembleegameclient.account.ui.components

