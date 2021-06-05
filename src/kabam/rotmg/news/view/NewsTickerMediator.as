// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.news.view.NewsTickerMediator

package kabam.rotmg.news.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;

    public class NewsTickerMediator extends Mediator 
    {

        [Inject]
        public var view:NewsTicker;
        [Inject]
        public var openDialog:OpenDialogSignal;


        override public function initialize():void
        {
        }

        override public function destroy():void
        {
        }


    }
}//package kabam.rotmg.news.view

