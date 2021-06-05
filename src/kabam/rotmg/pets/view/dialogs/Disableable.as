// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.pets.view.dialogs.Disableable

package kabam.rotmg.pets.view.dialogs
{
    import flash.events.IEventDispatcher;

    public interface Disableable extends IEventDispatcher 
    {

        function disable():void;
        function isEnabled():Boolean;

    }
}//package kabam.rotmg.pets.view.dialogs

