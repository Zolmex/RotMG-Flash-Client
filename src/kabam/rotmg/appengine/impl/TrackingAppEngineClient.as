// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.appengine.impl.TrackingAppEngineClient

package kabam.rotmg.appengine.impl
{
    import kabam.rotmg.appengine.api.AppEngineClient;
    import org.osflash.signals.OnceSignal;
    import flash.utils.getTimer;

    public class TrackingAppEngineClient implements AppEngineClient 
    {

        [Inject]
        public var wrapped:SimpleAppEngineClient;
        private var target:String;
        private var time:int;


        public function get complete():OnceSignal
        {
            return (this.wrapped.complete);
        }

        public function setDataFormat(_arg_1:String):void
        {
            this.wrapped.setDataFormat(_arg_1);
        }

        public function setSendEncrypted(_arg_1:Boolean):void
        {
            this.wrapped.setSendEncrypted(_arg_1);
        }

        public function setMaxRetries(_arg_1:int):void
        {
            this.wrapped.setMaxRetries(_arg_1);
        }

        public function sendRequest(_arg_1:String, _arg_2:Object):void
        {
            this.target = _arg_1;
            this.time = getTimer();
            this.wrapped.sendRequest(_arg_1, _arg_2);
        }

        public function requestInProgress():Boolean
        {
            return (false);
        }


    }
}//package kabam.rotmg.appengine.impl

