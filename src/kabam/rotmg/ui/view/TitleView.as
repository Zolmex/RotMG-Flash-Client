// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.view.TitleView

package kabam.rotmg.ui.view
{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.ui.view.components.MenuOptionsBar;
    import kabam.rotmg.ui.model.EnvironmentData;
    import org.osflash.signals.Signal;
    import kabam.rotmg.ui.view.components.DarkLayer;
    import com.company.assembleegameclient.screens.AccountScreen;
    import com.company.assembleegameclient.ui.SoundIcon;
    import com.company.assembleegameclient.screens.TitleMenuOption;
    import flash.text.TextFieldAutoSize;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.model.TextKey;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

    public class TitleView extends Sprite 
    {

        internal static var TitleScreenGraphic:Class = TitleView_TitleScreenGraphic;
        internal static var TitleScreenBackground:Class = TitleView_TitleScreenBackground;
        public static const MIDDLE_OF_BOTTOM_BAND:Number = 589.45;
        public static var queueEmailConfirmation:Boolean = false;
        public static var queuePasswordPrompt:Boolean = false;
        public static var queuePasswordPromptFull:Boolean = false;
        public static var queueRegistrationPrompt:Boolean = false;

        private var versionText:TextFieldDisplayConcrete;
        private var copyrightText:TextFieldDisplayConcrete;
        private var menuOptionsBar:MenuOptionsBar;
        private var data:EnvironmentData;
        public var playClicked:Signal;
        public var accountClicked:Signal;
        public var legendsClicked:Signal;
        public var supportClicked:Signal;
        public var editorClicked:Signal;
        public var quitClicked:Signal;
        public var optionalButtonsAdded:Signal = new Signal();
        private var _buttonFactory:ButtonFactory;

        public function TitleView()
        {
            this.init();
        }

        private function init():void
        {
            this._buttonFactory = new ButtonFactory();
            addChild(new TitleScreenBackground());
            addChild(new DarkLayer());
            addChild(new TitleScreenGraphic());
            this.menuOptionsBar = this.makeMenuOptionsBar();
            addChild(this.menuOptionsBar);
            addChild(new AccountScreen());
            this.makeChildren();
            addChild(new SoundIcon());
        }

        private function makeMenuOptionsBar():MenuOptionsBar
        {
            var _local_1:TitleMenuOption = this._buttonFactory.getPlayButton();
            var _local_2:TitleMenuOption = this._buttonFactory.getAccountButton();
            var _local_3:TitleMenuOption = this._buttonFactory.getLegendsButton();
            var _local_4:TitleMenuOption = this._buttonFactory.getSupportButton();
            this.playClicked = _local_1.clicked;
            this.accountClicked = _local_2.clicked;
            this.legendsClicked = _local_3.clicked;
            this.supportClicked = _local_4.clicked;
            var _local_5:MenuOptionsBar = new MenuOptionsBar();
            _local_5.addButton(_local_1, MenuOptionsBar.CENTER);
            _local_5.addButton(_local_4, MenuOptionsBar.LEFT);
            _local_5.addButton(_local_2, MenuOptionsBar.LEFT);
            _local_5.addButton(_local_3, MenuOptionsBar.RIGHT);
            return (_local_5);
        }

        private function makeChildren():void
        {
            this.versionText = this.makeText().setHTML(true).setAutoSize(TextFieldAutoSize.LEFT).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.versionText.y = MIDDLE_OF_BOTTOM_BAND;
            addChild(this.versionText);
            this.copyrightText = this.makeText().setAutoSize(TextFieldAutoSize.RIGHT).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.copyrightText.setStringBuilder(new LineBuilder().setParams(TextKey.COPYRIGHT));
            this.copyrightText.filters = [new DropShadowFilter(0, 0, 0)];
            this.copyrightText.x = 800;
            this.copyrightText.y = MIDDLE_OF_BOTTOM_BAND;
            addChild(this.copyrightText);
        }

        public function makeText():TextFieldDisplayConcrete
        {
            var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(12).setColor(0x7F7F7F);
            _local_1.filters = [new DropShadowFilter(0, 0, 0)];
            return (_local_1);
        }

        public function initialize(_arg_1:EnvironmentData):void
        {
            this.data = _arg_1;
            this.updateVersionText();
            this.handleOptionalButtons();
        }

        public function putNoticeTagToOption(_arg_1:TitleMenuOption, _arg_2:String, _arg_3:int=14, _arg_4:uint=10092390, _arg_5:Boolean=true):void
        {
            _arg_1.createNoticeTag(_arg_2, _arg_3, _arg_4, _arg_5);
        }

        private function updateVersionText():void
        {
            this.versionText.setStringBuilder(new StaticStringBuilder(this.data.buildLabel));
        }

        private function handleOptionalButtons():void
        {
            ((this.data.canMapEdit) && (this.createEditorButton()));
            ((this.data.isDesktop) && (this.createQuitButton()));
            this.optionalButtonsAdded.dispatch();
        }

        private function createQuitButton():void
        {
            var _local_1:TitleMenuOption = this._buttonFactory.getQuitButton();
            this.menuOptionsBar.addButton(_local_1, MenuOptionsBar.RIGHT);
            this.quitClicked = _local_1.clicked;
        }

        private function createEditorButton():void
        {
            var _local_1:TitleMenuOption = this._buttonFactory.getEditorButton();
            this.menuOptionsBar.addButton(_local_1, MenuOptionsBar.RIGHT);
            this.editorClicked = _local_1.clicked;
        }

        public function get buttonFactory():ButtonFactory
        {
            return (this._buttonFactory);
        }


    }
}//package kabam.rotmg.ui.view

