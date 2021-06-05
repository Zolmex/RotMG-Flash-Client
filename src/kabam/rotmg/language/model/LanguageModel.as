// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.language.model.LanguageModel

package kabam.rotmg.language.model
{
    import __AS3__.vec.Vector;

    public interface LanguageModel 
    {

        function getLanguage():String;
        function setLanguage(_arg_1:String):void;
        function getLanguageFamily():String;
        function getLanguageNames():Vector.<String>;
        function getLanguageCodeForName(_arg_1:String):String;
        function getNameForLanguageCode(_arg_1:String):String;

    }
}//package kabam.rotmg.language.model

