// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.web.view.WebRegisterDialog

package kabam.rotmg.account.web.view
{
    import com.company.assembleegameclient.account.ui.Frame;
    import org.osflash.signals.Signal;
    import kabam.rotmg.account.ui.components.DateField;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.events.TextEvent;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.filters.DropShadowFilter;
    import org.osflash.signals.natives.NativeMappedSignal;
    import flash.events.MouseEvent;
    import kabam.rotmg.account.web.model.AccountData;
    import com.company.util.EmailValidator;

    public class WebRegisterDialog extends Frame 
    {

        private const errors:Array = [];

        public var register:Signal;
        public var signIn:Signal;
        public var cancel:Signal;
        private var emailInput:LabeledField;
        private var passwordInput:LabeledField;
        private var retypePasswordInput:LabeledField;
        private var playerNameInput:LabeledField;
        private var ageVerificationInput:DateField;
        private var signInText:TextFieldDisplayConcrete;
        private var tosText:TextFieldDisplayConcrete;
        private var endLink:String = "</a></font>";

        public function WebRegisterDialog()
        {
            super("Register an account to play Realm of the Mad God", "RegisterWebAccountDialog.leftButton", "RegisterWebAccountDialog.rightButton", "/registerAccount", 326);
            this.makeUIElements();
            this.makeSignals();
        }

        private function makeUIElements():void
        {
            this.playerNameInput = new LabeledField("Player Name", false, 275);
            this.playerNameInput.inputText_.maxChars = 10;
            this.playerNameInput.inputText_.restrict = "A-Za-z";
            this.emailInput = new LabeledField(TextKey.REGISTER_WEB_ACCOUNT_EMAIL, false, 275);
            this.passwordInput = new LabeledField(TextKey.REGISTER_WEB_ACCOUNT_PASSWORD, true, 275);
            this.retypePasswordInput = new LabeledField("Confirm Password", true, 275);
            this.ageVerificationInput = new DateField();
            this.ageVerificationInput.setTitle(TextKey.BIRTHDAY);
            addLabeledField(this.playerNameInput);
            addLabeledField(this.emailInput);
            addLabeledField(this.passwordInput);
            addLabeledField(this.retypePasswordInput);
            addComponent(this.ageVerificationInput, 17);
            addSpace(35);
            addSpace(17);
            this.makeTosText();
            addSpace((17 * 2));
            this.makeSignInText();
        }

        public function makeSignInText():void
        {
            this.signInText = new TextFieldDisplayConcrete();
            var _local_1:* = '<font color="#7777EE"><a href="event:flash.events.TextEvent">';
            this.signInText.setStringBuilder(new LineBuilder().setParams(TextKey.SIGN_IN_TEXT, {
                "signIn":_local_1,
                "_signIn":this.endLink
            }));
            this.signInText.addEventListener(TextEvent.LINK, this.linkEvent);
            this.configureTextAndAdd(this.signInText);
        }

        public function makeTosText():void
        {
            this.tosText = new TextFieldDisplayConcrete();
            var _local_1:* = (('<font color="#7777EE"><a href="' + Parameters.TERMS_OF_USE_URL) + '" target="_blank">');
            var _local_2:* = (('<font color="#7777EE"><a href="' + Parameters.PRIVACY_POLICY_URL) + '" target="_blank">');
            this.tosText.setStringBuilder(new LineBuilder().setParams(TextKey.TOS_TEXT, {
                "tou":_local_1,
                "_tou":this.endLink,
                "policy":_local_2,
                "_policy":this.endLink
            }));
            this.configureTextAndAdd(this.tosText);
        }

        public function configureTextAndAdd(_arg_1:TextFieldDisplayConcrete):void
        {
            _arg_1.setSize(12).setColor(0xB3B3B3).setBold(true);
            _arg_1.setTextWidth(275);
            _arg_1.setMultiLine(true).setWordWrap(true).setHTML(true);
            _arg_1.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(_arg_1);
            positionText(_arg_1);
        }

        private function linkEvent(_arg_1:TextEvent):void
        {
            this.signIn.dispatch();
        }

        private function makeSignals():void
        {
            this.cancel = new NativeMappedSignal(leftButton_, MouseEvent.CLICK);
            rightButton_.addEventListener(MouseEvent.CLICK, this.onRegister);
            this.register = new Signal(AccountData);
            this.signIn = new Signal();
        }

        private function onRegister(_arg_1:MouseEvent):void
        {
            var _local_2:Boolean = this.areInputsValid();
            this.displayErrors();
            if (_local_2)
            {
                this.sendData();
            };
        }

        private function areInputsValid():Boolean
        {
            this.errors.length = 0;
            var _local_1:Boolean = true;
            _local_1 = ((this.isEmailValid()) && (_local_1));
            _local_1 = ((this.isPasswordValid()) && (_local_1));
            _local_1 = ((this.isPasswordVerified()) && (_local_1));
            _local_1 = ((this.isPlayerNameValid()) && (_local_1));
            _local_1 = ((this.isAgeVerified()) && (_local_1));
            return ((this.isAgeValid()) && (_local_1));
        }

        private function isAgeVerified():Boolean
        {
            var _local_1:uint = DateFieldValidator.getPlayerAge(this.ageVerificationInput);
            var _local_2:* = (_local_1 >= 16);
            this.ageVerificationInput.setErrorHighlight((!(_local_2)));
            if (!_local_2)
            {
                this.errors.push(TextKey.INELIGIBLE_AGE);
            };
            return (_local_2);
        }

        private function isAgeValid():Boolean
        {
            var _local_1:Boolean = this.ageVerificationInput.isValidDate();
            this.ageVerificationInput.setErrorHighlight((!(_local_1)));
            if (!_local_1)
            {
                this.errors.push(TextKey.INVALID_BIRTHDATE);
            };
            return (_local_1);
        }

        private function isEmailValid():Boolean
        {
            var _local_1:Boolean = EmailValidator.isValidEmail(this.emailInput.text());
            this.emailInput.setErrorHighlight((!(_local_1)));
            if (!_local_1)
            {
                this.errors.push(TextKey.INVALID_EMAIL_ADDRESS);
            };
            return (_local_1);
        }

        private function isPasswordValid():Boolean
        {
            var _local_1:* = (this.passwordInput.text().length >= 5);
            this.passwordInput.setErrorHighlight((!(_local_1)));
            if (!_local_1)
            {
                this.errors.push(TextKey.PASSWORD_TOO_SHORT);
            };
            return (_local_1);
        }

        private function isPasswordVerified():Boolean
        {
            var _local_1:* = (this.passwordInput.text() == this.retypePasswordInput.text());
            this.retypePasswordInput.setErrorHighlight((!(_local_1)));
            if (!_local_1)
            {
                this.errors.push(TextKey.PASSWORDS_DONT_MATCH);
            };
            return (_local_1);
        }

        private function isPlayerNameValid():Boolean
        {
            var _local_1:Boolean = ((!(this.playerNameInput.text() == "")) && (this.playerNameInput.text().length <= 10));
            this.playerNameInput.setErrorHighlight((!(_local_1)));
            if (!_local_1)
            {
                this.errors.push("Invalid Player Name");
            };
            return (_local_1);
        }

        public function displayErrors():void
        {
            if (this.errors.length == 0)
            {
                this.clearErrors();
            }
            else
            {
                this.displayErrorText(((this.errors.length == 1) ? this.errors[0] : TextKey.MULTIPLE_ERRORS_MESSAGE));
            };
        }

        public function displayServerError(_arg_1:String):void
        {
            this.displayErrorText(_arg_1);
        }

        private function clearErrors():void
        {
            titleText_.setStringBuilder(new LineBuilder().setParams("Register an account to play Realm of the Mad God"));
            titleText_.setColor(0xB3B3B3);
        }

        private function displayErrorText(_arg_1:String):void
        {
            titleText_.setStringBuilder(new LineBuilder().setParams(_arg_1));
            titleText_.setColor(16549442);
        }

        private function sendData():void
        {
            var _local_1:AccountData = new AccountData();
            _local_1.username = this.emailInput.text();
            _local_1.password = this.passwordInput.text();
            _local_1.name = this.playerNameInput.text();
            this.register.dispatch(_local_1);
        }


    }
}//package kabam.rotmg.account.web.view

