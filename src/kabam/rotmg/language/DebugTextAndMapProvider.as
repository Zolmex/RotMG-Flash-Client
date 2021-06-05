// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.language.DebugTextAndMapProvider

package kabam.rotmg.language
{
    import kabam.rotmg.text.model.TextAndMapProvider;
    import kabam.rotmg.language.model.DebugStringMap;
    import kabam.rotmg.text.view.DebugTextField;
    import flash.text.TextField;
    import kabam.rotmg.language.model.StringMap;

    public class DebugTextAndMapProvider implements TextAndMapProvider 
    {

        [Inject]
        public var debugStringMap:DebugStringMap;


        public function getTextField():TextField
        {
            var _local_1:DebugTextField = new DebugTextField();
            _local_1.debugStringMap = this.debugStringMap;
            return (_local_1);
        }

        public function getStringMap():StringMap
        {
            return (this.debugStringMap);
        }


    }
}//package kabam.rotmg.language

