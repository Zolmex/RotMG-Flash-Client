// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.appengine.AppEngineConfig

package kabam.rotmg.appengine
{
    import robotlegs.bender.framework.api.IConfig;
    import robotlegs.bender.framework.api.IContext;
    import kabam.rotmg.application.api.ApplicationSetup;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.appengine.api.RetryLoader;
    import kabam.rotmg.appengine.impl.AppEngineRetryLoader;
    import kabam.rotmg.appengine.impl.AppEngineRequestStats;
    import kabam.rotmg.appengine.impl.SimpleAppEngineClient;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.appengine.impl.StatsRecorderAppEngineClient;
    import kabam.rotmg.appengine.impl.TrackingAppEngineClient;

    public class AppEngineConfig implements IConfig 
    {

        private const TRACK_APP_ENGINE_CALLS:Boolean = true;

        [Inject]
        public var context:IContext;
        [Inject]
        public var setup:ApplicationSetup;
        [Inject]
        public var injector:Injector;


        public function configure():void
        {
            this.configureCoreDependencies();
            if (this.setup.isToolingEnabled())
            {
                this.configureForTesting();
            }
            else
            {
                if (this.TRACK_APP_ENGINE_CALLS)
                {
                    this.configureForTracking();
                }
                else
                {
                    this.configureForSimplicity();
                };
            };
        }

        private function configureCoreDependencies():void
        {
            this.injector.map(RetryLoader).toType(AppEngineRetryLoader);
        }

        private function configureForTesting():void
        {
            this.injector.map(AppEngineRequestStats).asSingleton();
            this.injector.map(SimpleAppEngineClient);
            this.injector.map(AppEngineClient).toType(StatsRecorderAppEngineClient);
        }

        private function configureForTracking():void
        {
            this.injector.map(SimpleAppEngineClient);
            this.injector.map(AppEngineClient).toType(TrackingAppEngineClient);
        }

        private function configureForSimplicity():void
        {
            this.injector.map(AppEngineClient).toType(SimpleAppEngineClient);
        }


    }
}//package kabam.rotmg.appengine

