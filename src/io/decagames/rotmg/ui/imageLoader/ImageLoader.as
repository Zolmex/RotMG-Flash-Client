// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.ui.imageLoader.ImageLoader

package io.decagames.rotmg.ui.imageLoader
{
    import flash.display.Loader;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.Event;
    import flash.net.URLRequest;

    public class ImageLoader 
    {

        private var _loader:Loader;
        private var _callBack:Function;


        private static function onIOError(_arg_1:IOErrorEvent):void
        {
        }

        private static function onSecurityEventError(_arg_1:SecurityErrorEvent):void
        {
        }


        public function loadImage(imageURL:String, callBack:Function):void
        {
            this._callBack = callBack;
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, callBack);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityEventError);
            try
            {
                this._loader.load(new URLRequest(imageURL));
            }
            catch(error:SecurityError)
            {
            }
        }

        public function removeLoaderListeners():void
        {
            if (((this._loader) && (this._loader.contentLoaderInfo)))
            {
                this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this._callBack);
                this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
                this._loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityEventError);
            }
        }

        public function get loader():Loader
        {
            return (this._loader);
        }


    }
}//package io.decagames.rotmg.ui.imageLoader

