﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.dialogs.DebugDialog

package com.company.assembleegameclient.ui.dialogs
{
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import flash.events.Event;

    public class DebugDialog extends StaticDialog 
    {

        private var f:Function;

        public function DebugDialog(_arg_1:String, _arg_2:String="Debug", _arg_3:Function=null)
        {
            super(_arg_2, _arg_1, "OK", null, null);
            this.f = _arg_3;
            addEventListener(Dialog.LEFT_BUTTON, this.onDialogComplete);
        }

        private function onDialogComplete(_arg_1:Event):void
        {
            var _local_2:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
            _local_2.dispatch();
            if (((!(this.parent == null)) && (this.parent.contains(this))))
            {
                this.parent.removeChild(this);
            }
            if (this.f != null)
            {
                this.f();
            }
        }


    }
}//package com.company.assembleegameclient.ui.dialogs

