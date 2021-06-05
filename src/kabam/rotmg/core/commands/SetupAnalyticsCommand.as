// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.core.commands.SetupAnalyticsCommand

package kabam.rotmg.core.commands
{
    import kabam.rotmg.application.api.ApplicationSetup;
    import kabam.rotmg.core.service.GoogleAnalytics;
    import kabam.rotmg.account.core.Account;
    import robotlegs.bender.framework.api.ILogger;

    public class SetupAnalyticsCommand 
    {

        [Inject]
        public var setup:ApplicationSetup;
        [Inject]
        public var analytics:GoogleAnalytics;
        [Inject]
        public var account:Account;
        [Inject]
        public var logger:ILogger;


        public function execute():void
        {
            this.analytics.init(this.setup.getAnalyticsCode(), this.setup.getServerDomain());
        }


    }
}//package kabam.rotmg.core.commands

