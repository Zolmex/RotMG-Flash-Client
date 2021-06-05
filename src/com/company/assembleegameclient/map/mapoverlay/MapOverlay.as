// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.map.mapoverlay.MapOverlay

package com.company.assembleegameclient.map.mapoverlay
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.map.Map;
    import kabam.rotmg.game.view.components.QueuedStatusTextList;
    import kabam.rotmg.game.view.components.QueuedStatusText;
    import com.company.assembleegameclient.map.Camera;

    public class MapOverlay extends Sprite 
    {

        private const speechBalloons:Object = {}
        private const queuedText:Object = {}

        public function MapOverlay()
        {
            mouseEnabled = true;
            mouseChildren = true;
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown, false, 0, true);
        }

        private function onMouseDown(_arg_1:MouseEvent):void
        {
            if (Parameters.isGpuRender())
            {
                (parent as Map).mapHitArea.dispatchEvent(_arg_1);
            }
        }

        public function addSpeechBalloon(_arg_1:SpeechBalloon):void
        {
            var _local_2:int = _arg_1.go_.objectId_;
            var _local_3:SpeechBalloon = this.speechBalloons[_local_2];
            if (((_local_3) && (contains(_local_3))))
            {
                removeChild(_local_3);
            }
            this.speechBalloons[_local_2] = _arg_1;
            addChild(_arg_1);
        }

        public function addStatusText(_arg_1:CharacterStatusText):void
        {
            addChild(_arg_1);
        }

        public function addQueuedText(_arg_1:QueuedStatusText):void
        {
            var _local_2:int = _arg_1.go_.objectId_;
            var _local_3:QueuedStatusTextList = (this.queuedText[_local_2] = ((this.queuedText[_local_2]) || (this.makeQueuedStatusTextList())));
            _local_3.append(_arg_1);
        }

        private function makeQueuedStatusTextList():QueuedStatusTextList
        {
            var _local_1:QueuedStatusTextList = new QueuedStatusTextList();
            _local_1.target = this;
            return (_local_1);
        }

        public function draw(_arg_1:Camera, _arg_2:int):void
        {
            var _local_4:IMapOverlayElement;
            var _local_3:int;
            while (_local_3 < numChildren)
            {
                _local_4 = (getChildAt(_local_3) as IMapOverlayElement);
                if (((!(_local_4)) || (_local_4.draw(_arg_1, _arg_2))))
                {
                    _local_3++;
                }
                else
                {
                    _local_4.dispose();
                }
            }
        }


    }
}//package com.company.assembleegameclient.map.mapoverlay

