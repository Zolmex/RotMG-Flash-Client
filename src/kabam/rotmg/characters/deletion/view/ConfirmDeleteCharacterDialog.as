// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.characters.deletion.view.ConfirmDeleteCharacterDialog

package kabam.rotmg.characters.deletion.view
{
    import flash.display.Sprite;
    import com.company.assembleegameclient.ui.dialogs.Dialog;
    import org.osflash.signals.Signal;
    import kabam.rotmg.core.StaticInjectorContext;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.text.model.TextKey;
    import flash.events.Event;
    import com.company.assembleegameclient.ui.dialogs.*;

    public class ConfirmDeleteCharacterDialog extends Sprite 
    {

        private const CANCEL_EVENT:String = Dialog.LEFT_BUTTON;
        private const DELETE_EVENT:String = Dialog.RIGHT_BUTTON;

        public var deleteCharacter:Signal;
        public var cancel:Signal;

        public function ConfirmDeleteCharacterDialog()
        {
            this.deleteCharacter = new Signal();
            this.cancel = new Signal();
        }

        public function setText(_arg_1:String, _arg_2:String):void
        {
            var _local_3:Boolean = StaticInjectorContext.getInjector().getInstance(SeasonalEventModel).isChallenger;
            var _local_4:String = ((_local_3) ? "It will cost you a character life to delete {name} the {displayID} - Are you really sure you want to?" : TextKey.CONFIRMDELETECHARACTERDIALOG);
            var _local_5:Dialog = new Dialog(TextKey.CONFIRMDELETE_VERIFYDELETION, "", TextKey.CONFIRMDELETE_CANCEL, TextKey.CONFIRMDELETE_DELETE, "/deleteDialog");
            _local_5.setTextParams(_local_4, {
                "name":_arg_1,
                "displayID":_arg_2
            });
            _local_5.addEventListener(this.CANCEL_EVENT, this.onCancel);
            _local_5.addEventListener(this.DELETE_EVENT, this.onDelete);
            addChild(_local_5);
        }

        private function onCancel(_arg_1:Event):void
        {
            this.cancel.dispatch();
        }

        private function onDelete(_arg_1:Event):void
        {
            this.deleteCharacter.dispatch();
        }


    }
}//package kabam.rotmg.characters.deletion.view

