// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.application.impl.LocalhostSetup

package kabam.rotmg.application.impl
{
    import kabam.rotmg.application.api.ApplicationSetup;
    import com.company.assembleegameclient.parameters.Parameters;

    public class LocalhostSetup implements ApplicationSetup 
    {

        public static const SERVER:String = "http://localhost:8080";
        private const BUILD_LABEL:String = "<font color='#FFEE00'>LOCALHOST</font> #{VERSION}";


        public function getAppEngineUrl(_arg_1:Boolean=false):String
        {
            return (SERVER);
        }

        public function getBuildLabel():String
        {
            var _local_1:String = ((Parameters.BUILD_VERSION + ".") + Parameters.MINOR_VERSION);
            return (this.BUILD_LABEL.replace("{VERSION}", _local_1));
        }

        public function useLocalTextures():Boolean
        {
            return (true);
        }

        public function isToolingEnabled():Boolean
        {
            return (false);
        }

        public function isServerLocal():Boolean
        {
            return (true);
        }

        public function isGameLoopMonitored():Boolean
        {
            return (true);
        }

        public function useProductionDialogs():Boolean
        {
            return (false);
        }

        public function areErrorsReported():Boolean
        {
            return (false);
        }

        public function areDeveloperHotkeysEnabled():Boolean
        {
            return (true);
        }

        public function isDebug():Boolean
        {
            return (true);
        }

        public function getServerDomain():String
        {
            return ("localhost");
        }


    }
}//package kabam.rotmg.application.impl

