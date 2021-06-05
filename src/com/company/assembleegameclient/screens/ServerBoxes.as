// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.ServerBoxes

package com.company.assembleegameclient.screens
{
    import flash.display.Sprite;
    import __AS3__.vec.Vector;
    import kabam.rotmg.servers.api.Server;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.parameters.Parameters;
    import __AS3__.vec.*;

    public class ServerBoxes extends Sprite 
    {

        private var boxes_:Vector.<ServerBox> = new Vector.<ServerBox>();
        private var _isChallenger:Boolean;

        public function ServerBoxes(_arg_1:Vector.<Server>, _arg_2:Boolean=false)
        {
            var _local_3:ServerBox;
            var _local_5:Server;
            var _local_6:String;
            super();
            this._isChallenger = _arg_2;
            _local_3 = new ServerBox(null);
            _local_3.setSelected(true);
            _local_3.x = ((ServerBox.WIDTH / 2) + 2);
            _local_3.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addChild(_local_3);
            this.boxes_.push(_local_3);
            var _local_4:int = 2;
            for each (_local_5 in _arg_1)
            {
                _local_3 = new ServerBox(_local_5);
                _local_6 = ((this._isChallenger) ? Parameters.data_.preferredChallengerServer : Parameters.data_.preferredServer);
                if (_local_5.name == _local_6)
                {
                    this.setSelected(_local_3);
                };
                _local_3.x = ((_local_4 % 2) * (ServerBox.WIDTH + 4));
                _local_3.y = (int((_local_4 / 2)) * (ServerBox.HEIGHT + 4));
                _local_3.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                addChild(_local_3);
                this.boxes_.push(_local_3);
                _local_4++;
            };
        }

        private function onMouseDown(_arg_1:MouseEvent):void
        {
            var _local_2:ServerBox = (_arg_1.currentTarget as ServerBox);
            if (_local_2 == null)
            {
                return;
            };
            this.setSelected(_local_2);
            var _local_3:String = _local_2.value_;
            if (this._isChallenger)
            {
                Parameters.data_.preferredChallengerServer = _local_3;
            }
            else
            {
                Parameters.data_.preferredServer = _local_3;
            };
            Parameters.save();
        }

        private function setSelected(_arg_1:ServerBox):void
        {
            var _local_2:ServerBox;
            for each (_local_2 in this.boxes_)
            {
                _local_2.setSelected(false);
            };
            _arg_1.setSelected(true);
        }


    }
}//package com.company.assembleegameclient.screens

