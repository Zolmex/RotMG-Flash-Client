// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.application.EnvironmentConfig

package kabam.rotmg.application
{
    import robotlegs.bender.framework.api.IConfig;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.application.model.DomainModel;

    public class EnvironmentConfig implements IConfig 
    {

        [Inject]
        public var injector:Injector;


        public function configure():void
        {
            this.injector.map(DomainModel).asSingleton();
        }


    }
}//package kabam.rotmg.application

