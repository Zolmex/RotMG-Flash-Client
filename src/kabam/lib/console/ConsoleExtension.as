// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.lib.console.ConsoleExtension

package kabam.lib.console
{
    import robotlegs.bender.framework.api.IExtension;
    import flash.display.DisplayObjectContainer;
    import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
    import kabam.lib.resizing.ResizeExtension;
    import robotlegs.bender.framework.api.IContext;

    public class ConsoleExtension implements IExtension 
    {

        [Inject]
        public var contextView:DisplayObjectContainer;


        public function extend(_arg_1:IContext):void
        {
            _arg_1.extend(SignalCommandMapExtension).extend(ResizeExtension).configure(ConsoleConfig);
        }


    }
}//package kabam.lib.console

