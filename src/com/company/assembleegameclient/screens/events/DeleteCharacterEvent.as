// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.events.DeleteCharacterEvent

package com.company.assembleegameclient.screens.events
{
    import flash.events.Event;
    import com.company.assembleegameclient.appengine.SavedCharacter;

    public class DeleteCharacterEvent extends Event 
    {

        public static const DELETE_CHARACTER_EVENT:String = "DELETE_CHARACTER_EVENT";

        public var savedChar_:SavedCharacter;

        public function DeleteCharacterEvent(_arg_1:SavedCharacter)
        {
            super(DELETE_CHARACTER_EVENT);
            this.savedChar_ = _arg_1;
        }

    }
}//package com.company.assembleegameclient.screens.events

