// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.packages.services.PackageModel

package kabam.rotmg.packages.services
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.packages.model.PackageInfo;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;
    import kabam.rotmg.packages.model.*;

    public class PackageModel 
    {

        public static const TARGETING_BOX_SLOT:int = 100;

        public var numSpammed:int = 0;
        private var initialized:Boolean;
        private var maxSlots:int = 18;

        private var models:Object = {};
        public const updateSignal:Signal = new Signal();


        public function getBoxesForGrid():Vector.<PackageInfo>
        {
            var _local_2:PackageInfo;
            var _local_1:Vector.<PackageInfo> = new Vector.<PackageInfo>(this.maxSlots);
            for each (_local_2 in this.models)
            {
                if ((((!(_local_2.slot == 0)) && (!(_local_2.slot == TARGETING_BOX_SLOT))) && (this.isPackageValid(_local_2))))
                {
                    _local_1[(_local_2.slot - 1)] = _local_2;
                };
            };
            return (_local_1);
        }

        public function getTargetingBoxesForGrid():Vector.<PackageInfo>
        {
            var _local_2:PackageInfo;
            var _local_1:Vector.<PackageInfo> = new Vector.<PackageInfo>(this.maxSlots);
            for each (_local_2 in this.models)
            {
                if (((_local_2.slot == TARGETING_BOX_SLOT) && (this.isPackageValid(_local_2))))
                {
                    _local_1.push(_local_2);
                };
            };
            return (_local_1);
        }

        private function isPackageValid(_arg_1:PackageInfo):Boolean
        {
            return (((_arg_1.unitsLeft == -1) || (_arg_1.unitsLeft > 0)) && ((_arg_1.maxPurchase == -1) || (_arg_1.purchaseLeft > 0)));
        }

        public function startupPackage():PackageInfo
        {
            var _local_2:PackageInfo;
            var _local_1:PackageInfo;
            for each (_local_2 in this.models)
            {
                if (_local_2.slot == TARGETING_BOX_SLOT)
                {
                    return (_local_2);
                };
                if ((((this.isPackageValid(_local_2)) && (_local_2.showOnLogin)) && (!(_local_2.popupImage == ""))))
                {
                    if (_local_1 != null)
                    {
                        if (((!(_local_2.unitsLeft == -1)) || (!(_local_2.maxPurchase == -1))))
                        {
                            _local_1 = _local_2;
                        };
                    }
                    else
                    {
                        _local_1 = _local_2;
                    };
                };
            };
            return (_local_1);
        }

        public function getInitialized():Boolean
        {
            return (this.initialized);
        }

        public function getPackageById(_arg_1:int):PackageInfo
        {
            return (this.models[_arg_1]);
        }

        public function hasPackage(_arg_1:int):Boolean
        {
            return (_arg_1 in this.models);
        }

        public function setPackages(_arg_1:Array):void
        {
            var _local_2:PackageInfo;
            this.models = {};
            for each (_local_2 in _arg_1)
            {
                this.models[_local_2.id] = _local_2;
            };
            this.updateSignal.dispatch();
            this.initialized = true;
        }

        public function canPurchasePackage(_arg_1:int):Boolean
        {
            var _local_2:PackageInfo = this.models[_arg_1];
            return (!(_local_2 == null));
        }

        public function getPriorityPackage():PackageInfo
        {
            return (null);
        }

        public function setInitialized(_arg_1:Boolean):void
        {
            this.initialized = _arg_1;
        }

        public function hasPackages():Boolean
        {
            var _local_1:Object;
            for each (_local_1 in this.models)
            {
                return (true);
            };
            return (false);
        }


    }
}//package kabam.rotmg.packages.services

