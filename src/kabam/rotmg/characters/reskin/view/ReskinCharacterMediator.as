﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.characters.reskin.view.ReskinCharacterMediator

package kabam.rotmg.characters.reskin.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.characters.reskin.control.ReskinCharacterSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.classes.model.CharacterSkins;

    public class ReskinCharacterMediator extends Mediator 
    {

        [Inject]
        public var view:ReskinCharacterView;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var model:ClassesModel;
        [Inject]
        public var reskinCharacter:ReskinCharacterSignal;
        [Inject]
        public var closeDialogs:CloseDialogsSignal;
        private var skins:CharacterSkins;


        override public function initialize():void
        {
            this.skins = this.getCharacterSkins();
            this.view.selected.add(this.onSelected);
            this.view.cancelled.add(this.onCancelled);
        }

        private function getCharacterSkins():CharacterSkins
        {
            return (this.model.getSelected().skins);
        }

        override public function destroy():void
        {
            this.view.selected.remove(this.onSelected);
            this.view.cancelled.remove(this.onCancelled);
        }

        private function onSelected():void
        {
            this.closeDialogs.dispatch();
            this.reskinCharacter.dispatch(this.skins.getSelectedSkin());
        }

        private function onCancelled():void
        {
            this.closeDialogs.dispatch();
        }


    }
}//package kabam.rotmg.characters.reskin.view

