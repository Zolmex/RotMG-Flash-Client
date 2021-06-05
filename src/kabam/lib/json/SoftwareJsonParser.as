// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.lib.json.SoftwareJsonParser

package kabam.lib.json
{
    import com.adobe.serialization.json.JSON;

    public class SoftwareJsonParser implements JsonParser 
    {


        public function stringify(_arg_1:Object):String
        {
            return (com.adobe.serialization.json.JSON.encode(_arg_1));
        }

        public function parse(_arg_1:String):Object
        {
            return _arg_1 ? (com.adobe.serialization.json.JSON.decode(_arg_1)) : null;
        }


    }
}//package kabam.lib.json

