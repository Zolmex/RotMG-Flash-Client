﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.lib.resizing.ResizeExtension

package kabam.lib.resizing
{
    import robotlegs.bender.framework.api.IExtension;
    import robotlegs.bender.extensions.mediatorMap.MediatorMapExtension;
    import robotlegs.bender.framework.api.IContext;

    public class ResizeExtension implements IExtension 
    {


        public function extend(_arg_1:IContext):void
        {
            _arg_1.extend(MediatorMapExtension);
            _arg_1.configure(ResizeConfig);
        }


    }
}//package kabam.lib.resizing

