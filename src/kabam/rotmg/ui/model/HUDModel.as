// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.model.HUDModel

package kabam.rotmg.ui.model
{
    import com.company.assembleegameclient.game.GameSprite;
    import kabam.rotmg.ui.view.KeysView;
    import com.company.assembleegameclient.parameters.Parameters;

    public class HUDModel 
    {

        public var gameSprite:GameSprite;
        private var _keysView:KeysView;


        public function getPlayerName():String
        {
            return ((this.gameSprite.model.getName()) ? this.gameSprite.model.getName() : this.gameSprite.map.player_.name_);
        }

        public function getButtonType():String
        {
            return ((this.gameSprite.gsc_.gameId_ == Parameters.NEXUS_GAMEID) ? "OPTIONS_BUTTON" : "NEXUS_BUTTON");
        }

        public function get keysView():KeysView
        {
            return (this._keysView);
        }

        public function set keysView(_arg_1:KeysView):void
        {
            this._keysView = _arg_1;
        }


    }
}//package kabam.rotmg.ui.model

