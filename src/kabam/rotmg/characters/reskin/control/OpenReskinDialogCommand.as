// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.characters.reskin.control.OpenReskinDialogCommand

package kabam.rotmg.characters.reskin.control
{
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.lib.console.signals.HideConsoleSignal;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.classes.view.CharacterSkinListItemFactory;
    import kabam.rotmg.characters.reskin.view.ReskinCharacterView;
    import kabam.rotmg.classes.model.CharacterSkins;
    import __AS3__.vec.Vector;
    import flash.display.DisplayObject;

    public class OpenReskinDialogCommand 
    {

        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var hideConsole:HideConsoleSignal;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var model:ClassesModel;
        [Inject]
        public var factory:CharacterSkinListItemFactory;


        public function execute():void
        {
            this.hideConsole.dispatch();
            this.openDialog.dispatch(this.makeView());
        }

        private function makeView():ReskinCharacterView
        {
            var _local_1:ReskinCharacterView = new ReskinCharacterView();
            _local_1.setList(this.makeList());
            _local_1.x = int(((800 - _local_1.width) * 0.5));
            _local_1.y = int(((600 - _local_1.viewHeight) * 0.5));
            return (_local_1);
        }

        private function makeList():Vector.<DisplayObject>
        {
            var _local_1:CharacterSkins = this.getCharacterSkins();
            return (this.factory.make(_local_1));
        }

        private function getCharacterSkins():CharacterSkins
        {
            return (this.model.getSelected().skins);
        }


    }
}//package kabam.rotmg.characters.reskin.control

