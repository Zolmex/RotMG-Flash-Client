// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.lib.ui.GroupMappedSignal

package kabam.lib.ui
{
    import org.osflash.signals.Signal;
    import flash.utils.Dictionary;
    import flash.events.IEventDispatcher;
    import flash.events.Event;

    public class GroupMappedSignal extends Signal 
    {

        private var eventType:String;
        private var mappedTargets:Dictionary;

        public function GroupMappedSignal(_arg_1:String, ... _args)
        {
            this.eventType = _arg_1;
            this.mappedTargets = new Dictionary(true);
            super(_args);
        }

        public function map(_arg_1:IEventDispatcher, _arg_2:*):void
        {
            this.mappedTargets[_arg_1] = _arg_2;
            _arg_1.addEventListener(this.eventType, this.onTarget, false, 0, true);
        }

        private function onTarget(_arg_1:Event):void
        {
            dispatch(this.mappedTargets[_arg_1.target]);
        }


    }
}//package kabam.lib.ui

