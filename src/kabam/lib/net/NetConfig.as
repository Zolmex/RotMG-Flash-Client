// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.lib.net.NetConfig

package kabam.lib.net
{
    import robotlegs.bender.framework.api.IConfig;
    import org.swiftsuspenders.Injector;
    import kabam.lib.net.impl.MessageCenter;
    import flash.net.Socket;
    import kabam.lib.net.api.MessageMap;
    import kabam.lib.net.api.MessageProvider;
    import kabam.lib.net.impl.SocketServer;

    public class NetConfig implements IConfig 
    {

        [Inject]
        public var injector:Injector;
        private var messageCenter:MessageCenter;


        public function configure():void
        {
            this.messageCenter = new MessageCenter().setInjector(this.injector);
            this.injector.map(Socket);
            this.injector.map(MessageMap).toValue(this.messageCenter);
            this.injector.map(MessageProvider).toValue(this.messageCenter);
            this.injector.map(SocketServer).asSingleton();
        }


    }
}//package kabam.lib.net

