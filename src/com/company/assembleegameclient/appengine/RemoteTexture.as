// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.appengine.RemoteTexture

package com.company.assembleegameclient.appengine
{
import kabam.rotmg.application.impl.LocalhostSetup;
import kabam.rotmg.application.impl.PrivateSetup;
import kabam.rotmg.application.impl.ProductionSetup;
import kabam.rotmg.application.impl.Testing2Setup;
import kabam.rotmg.application.impl.Testing3Setup;
import kabam.rotmg.application.impl.TestingSetup;
import kabam.rotmg.build.impl.BuildEnvironments;

import robotlegs.bender.framework.api.ILogger;
    import kabam.rotmg.core.StaticInjectorContext;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.appengine.impl.AppEngineRetryLoader;
    import kabam.rotmg.appengine.api.RetryLoader;
    import flash.net.URLLoaderDataFormat;
    import ion.utils.png.PNGDecoder;
    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    public class RemoteTexture 
    {

        private static const ERROR_PATTERN:String = "Remote Texture Error: {ERROR} (id:{ID}, instance:{INSTANCE})";
        private static const START_TIME:int = int(new Date().getTime());

        public var id_:String;
        public var instance_:String;
        public var callback_:Function;
        private var logger:ILogger;

        public function RemoteTexture(_arg_1:String, _arg_2:String, _arg_3:Function):void
        {
            this.id_ = _arg_1;
            this.instance_ = _arg_2;
            this.callback_ = _arg_3;
            var _local_4:Injector = StaticInjectorContext.getInjector();
            this.logger = _local_4.getInstance(ILogger);
        }

        public function run():void
        {
            var address:String;
            switch (WebMain.ENV){
                case BuildEnvironments.LOCALHOST:
                    return;
                case BuildEnvironments.PRIVATE:
                    address = PrivateSetup.SERVER;
                    break;
                case BuildEnvironments.TESTING:
                    address = TestingSetup.SERVER;
                    break;
                case BuildEnvironments.TESTING2:
                    address = Testing2Setup.SERVER;
                    break;
                case BuildEnvironments.TESTING3:
                    address = Testing3Setup.SERVER;
                    break;
                case BuildEnvironments.PRODUCTION:
                    address = ProductionSetup.SERVER;
                    break;
                case BuildEnvironments.DEV:
                case BuildEnvironments.PRODTEST:
                    return;
            }
            var _local_2:String = address + "/picture/get";
            var _local_3:Object = {};
            _local_3.id = this.id_;
            _local_3.time = START_TIME;
            var _local_4:RetryLoader = new AppEngineRetryLoader();
            _local_4.setDataFormat(URLLoaderDataFormat.BINARY);
            _local_4.complete.addOnce(this.onComplete);
            _local_4.sendRequest(_local_2, _local_3);
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.makeTexture(_arg_2);
            }
            else
            {
                this.reportError(_arg_2);
            }
        }

        public function makeTexture(_arg_1:ByteArray):void
        {
            var _local_2:BitmapData = PNGDecoder.decodeImage(_arg_1);
            this.callback_(_local_2);
        }

        public function reportError(_arg_1:String):void
        {
            _arg_1 = ERROR_PATTERN.replace("{ERROR}", _arg_1).replace("{ID}", this.id_).replace("{INSTANCE}", this.instance_);
            this.logger.warn("RemoteTexture.reportError: {0}", [_arg_1]);
            var _local_2:BitmapData = new BitmapDataSpy(1, 1);
            this.callback_(_local_2);
        }


    }
}//package com.company.assembleegameclient.appengine

