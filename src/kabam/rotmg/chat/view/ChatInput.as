// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.chat.view.ChatInput

package kabam.rotmg.chat.view
{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import flash.text.TextField;
    import kabam.rotmg.chat.model.ChatModel;
    import flash.events.KeyboardEvent;
    import flash.text.TextFieldType;
    import flash.filters.GlowFilter;
    import flash.events.Event;
    import flash.ui.Keyboard;

    public class ChatInput extends Sprite 
    {

        public const message:Signal = new Signal(String);
        public const close:Signal = new Signal();

        private var input:TextField;
        private var enteredText:Boolean;
        private var lastInput:String = "";

        public function ChatInput()
        {
            visible = false;
            this.enteredText = false;
        }

        public function setup(_arg_1:ChatModel, _arg_2:TextField):void
        {
            addChild((this.input = _arg_2));
            _arg_2.width = (_arg_1.bounds.width - 2);
            _arg_2.height = _arg_1.lineHeight;
            _arg_2.y = (_arg_1.bounds.height - _arg_1.lineHeight);
        }

        public function activate(_arg_1:String, _arg_2:Boolean):void
        {
            this.enteredText = false;
            if (_arg_1 != null)
            {
                this.input.text = _arg_1;
            };
            var _local_3:int = ((_arg_1) ? _arg_1.length : 0);
            this.input.setSelection(_local_3, _local_3);
            if (_arg_2)
            {
                this.activateEnabled();
            }
            else
            {
                this.activateDisabled();
            };
            visible = true;
        }

        public function deactivate():void
        {
            this.enteredText = false;
            removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            stage.removeEventListener(KeyboardEvent.KEY_UP, this.onTextChange);
            visible = false;
            ((stage) && (stage.focus = null));
        }

        public function hasEnteredText():Boolean
        {
            return (this.enteredText);
        }

        private function activateEnabled():void
        {
            this.input.type = TextFieldType.INPUT;
            this.input.border = true;
            this.input.selectable = true;
            this.input.maxChars = 128;
            this.input.borderColor = 0xFFFFFF;
            this.input.height = 18;
            this.input.filters = [new GlowFilter(0, 1, 3, 3, 2, 1)];
            addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.onTextChange);
            ((stage) && (stage.focus = this.input));
        }

        private function onTextChange(_arg_1:Event):void
        {
            this.enteredText = true;
        }

        private function activateDisabled():void
        {
            this.input.type = TextFieldType.DYNAMIC;
            this.input.border = false;
            this.input.selectable = false;
            this.input.filters = [new GlowFilter(0, 1, 3, 3, 2, 1)];
            this.input.height = 18;
            removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            stage.removeEventListener(KeyboardEvent.KEY_UP, this.onTextChange);
        }

        private function onKeyUp(_arg_1:KeyboardEvent):void
        {
            var _local_2:int;
            if (_arg_1.keyCode == Keyboard.ENTER)
            {
                if (this.input.text != "")
                {
                    this.message.dispatch(this.input.text);
                }
                else
                {
                    this.close.dispatch();
                };
                this.lastInput = this.input.text;
                _arg_1.stopImmediatePropagation();
            };
            if (_arg_1.keyCode == Keyboard.UP)
            {
                this.input.text = this.lastInput;
                _local_2 = this.lastInput.length;
                this.input.setSelection(_local_2, _local_2);
                _arg_1.stopImmediatePropagation();
            };
        }


    }
}//package kabam.rotmg.chat.view

