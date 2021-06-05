// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.account.ui.NewChooseNameFrame

package com.company.assembleegameclient.account.ui
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.text.model.TextKey;
    import flash.events.MouseEvent;

    public class NewChooseNameFrame extends Frame 
    {

        public const choose:Signal = new Signal();
        public const cancel:Signal = new Signal();

        private var name_:TextInputField;

        public function NewChooseNameFrame()
        {
            super("Choose a unique player name", "", TextKey.CHOOSE_NAME_CHOOSE, "/newChooseName");
            this.name_ = new TextInputField("Player Name", false);
            this.name_.inputText_.restrict = "A-Za-z";
            var _local_1:int = 10;
            this.name_.inputText_.maxChars = _local_1;
            addTextInputField(this.name_);
            addPlainText(TextKey.FRAME_MAX_CHAR, {"maxChars":_local_1});
            addPlainText(TextKey.FRAME_RESTRICT_CHAR);
            addPlainText(TextKey.CHOOSE_NAME_WARNING);
            rightButton_.addEventListener(MouseEvent.CLICK, this.onChoose);
        }

        private function onChoose(_arg_1:MouseEvent):void
        {
            this.choose.dispatch(this.name_.text());
        }

        public function setError(_arg_1:String):void
        {
            this.name_.setError(_arg_1);
        }


    }
}//package com.company.assembleegameclient.account.ui

