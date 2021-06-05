﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.text.controller.TextFieldDisplayMediator

package kabam.rotmg.text.controller
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.text.view.TextFieldDisplay;
    import kabam.rotmg.text.model.FontModel;
    import kabam.rotmg.text.model.TextAndMapProvider;

    public class TextFieldDisplayMediator extends Mediator 
    {

        [Inject]
        public var textFieldDisplay:TextFieldDisplay;
        [Inject]
        public var fontModel:FontModel;
        [Inject]
        public var textAndMapProvider:TextAndMapProvider;


        override public function initialize():void
        {
            this.textFieldDisplay.setFont(this.fontModel.getFont());
            this.textFieldDisplay.setTextField(this.textAndMapProvider.getTextField());
            this.textFieldDisplay.setStringMap(this.textAndMapProvider.getStringMap());
        }


    }
}//package kabam.rotmg.text.controller

