// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.unity.popup.UnitySignUpPopupMediator

package io.decagames.rotmg.unity.popup
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import robotlegs.bender.framework.api.ILogger;
    import flash.events.MouseEvent;
    import com.company.util.EmailValidator;

    public class UnitySignUpPopupMediator extends Mediator 
    {

        [Inject]
        public var view:UnitySignUpPopup;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var logger:ILogger;
        private var steamSignupConfirmation:UnitySignupConfirmation;


        override public function initialize():void
        {
            this.view.submitButton.addEventListener(MouseEvent.CLICK, this.onOK);
            this.view.cancelButton.addEventListener(MouseEvent.CLICK, this.onCancel);
            this.view.emailInputField.setSelection(0, this.view.emailInputField.text.length);
            this.view.stage.focus = this.view.emailInputField;
        }

        override public function destroy():void
        {
            this.view.submitButton.removeEventListener(MouseEvent.CLICK, this.onOK);
            this.view.cancelButton.removeEventListener(MouseEvent.CLICK, this.onCancel);
        }

        private function onOK(_arg_1:MouseEvent):void
        {
            this.view.submitButton.removeEventListener(MouseEvent.CLICK, this.onOK);
            this.view.errorText.text = "";
            var _local_2:Boolean = this.view.checkBox.isChecked();
            var _local_3:String = this.view.emailInputField.text;
            if (!this.checkEmail(_local_3))
            {
                this.view.emailInputField.setSelection(0, this.view.emailInputField.text.length);
                this.view.errorText.text = "Invalid email address - please check.";
                this.view.submitButton.addEventListener(MouseEvent.CLICK, this.onOK);
                this.view.stage.focus = this.view.emailInputField;
            }
            else
            {
                if (!_local_2)
                {
                    this.view.errorText.text = "Please check the checkbox allowing us to contact you.";
                    this.view.submitButton.addEventListener(MouseEvent.CLICK, this.onOK);
                }
                else
                {
                    this.submit();
                }
            }
        }

        private function submit():void
        {
            this.logger.info("SteamUnityTask start");
            var _local_1:Object = this.account.getCredentials();
            _local_1.email = this.view.emailInputField.text;
            _local_1.notifyMe = ((this.view.checkBox.isChecked()) ? "1" : "0");
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/account/signupDecaEmail", _local_1);
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.closePopUp();
                this.showSignUpResult("Thank you for signing up!");
            }
            else
            {
                this.logger.error(_arg_2);
                this.showSignUpResult(_arg_2);
            }
        }

        private function checkEmail(_arg_1:String):Boolean
        {
            return (EmailValidator.isValidEmail(_arg_1));
        }

        private function onCancel(_arg_1:MouseEvent):void
        {
            this.view.cancelButton.removeEventListener(MouseEvent.CLICK, this.onCancel);
            this.closePopUp();
        }

        private function closePopUp():void
        {
            this.closePopupSignal.dispatch(this.view);
        }

        private function showSignUpResult(_arg_1:String):void
        {
            this.steamSignupConfirmation = new UnitySignupConfirmation(_arg_1);
            this.steamSignupConfirmation.okButton.addEventListener(MouseEvent.CLICK, this.onSignUpResultClose);
            this.showPopupSignal.dispatch(this.steamSignupConfirmation);
        }

        private function onSignUpResultClose(_arg_1:MouseEvent):void
        {
            this.steamSignupConfirmation.okButton.removeEventListener(MouseEvent.CLICK, this.onSignUpResultClose);
            this.closePopupSignal.dispatch(this.steamSignupConfirmation);
        }


    }
}//package io.decagames.rotmg.unity.popup

