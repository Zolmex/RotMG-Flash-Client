// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.DeprecatedTextButtonStatic

package com.company.assembleegameclient.ui
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

    public class DeprecatedTextButtonStatic extends TextButtonBase 
    {

        public const textChanged:Signal = new Signal();

        public function DeprecatedTextButtonStatic(_arg_1:int, _arg_2:String, _arg_3:int=0)
        {
            super(_arg_3);
            addText(_arg_1);
            text_.setStringBuilder(new StaticStringBuilder(_arg_2));
            text_.textChanged.addOnce(this.onTextChanged);
        }

        protected function onTextChanged():void
        {
            initText();
            this.textChanged.dispatch();
        }


    }
}//package com.company.assembleegameclient.ui

