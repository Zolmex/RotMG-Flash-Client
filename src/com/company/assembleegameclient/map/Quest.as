// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.map.Quest

package com.company.assembleegameclient.map
{
    import flash.utils.getTimer;
    import com.company.assembleegameclient.objects.GameObject;

    public class Quest 
    {

        public var map_:Map;
        public var objectId_:int = -1;
        private var questAvailableAt_:int = 0;
        private var questOldAt_:int = 0;

        public function Quest(_arg_1:Map)
        {
            this.map_ = _arg_1;
        }

        public function setObject(_arg_1:int):void
        {
            if (((this.objectId_ == -1) && (!(_arg_1 == -1))))
            {
                this.questAvailableAt_ = (getTimer() + 200);
                this.questOldAt_ = this.questAvailableAt_;
            };
            this.objectId_ = _arg_1;
        }

        public function completed():void
        {
            this.questAvailableAt_ = (getTimer() + 200);
            this.questOldAt_ = this.questAvailableAt_;
        }

        public function getObject(_arg_1:int):GameObject
        {
            if (_arg_1 < this.questAvailableAt_)
            {
                return (null);
            };
            return (this.map_.goDict_[this.objectId_]);
        }

        public function isNew(_arg_1:int):Boolean
        {
            return (_arg_1 < this.questOldAt_);
        }


    }
}//package com.company.assembleegameclient.map

