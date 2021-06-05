﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.news.NewsConfig

package kabam.rotmg.news
{
    import robotlegs.bender.framework.api.IConfig;
    import robotlegs.bender.framework.api.IContext;
    import org.swiftsuspenders.Injector;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import kabam.rotmg.startup.control.StartupSequence;
    import kabam.rotmg.news.controller.OpenSkinSignal;
    import kabam.rotmg.news.controller.NewsDataUpdatedSignal;
    import kabam.rotmg.news.controller.NewsButtonRefreshSignal;
    import kabam.rotmg.news.model.NewsModel;
    import kabam.rotmg.news.services.GetAppEngineNewsTask;
    import kabam.rotmg.news.services.GetInGameNewsTask;
    import kabam.rotmg.news.view.NewsView;
    import kabam.rotmg.news.view.NewsMediator;
    import kabam.rotmg.news.view.NewsCell;
    import kabam.rotmg.news.view.NewsCellMediator;
    import kabam.rotmg.game.view.NewsModalButton;
    import kabam.rotmg.news.view.NewsModalMediator;
    import kabam.rotmg.news.view.NewsTicker;
    import kabam.rotmg.news.view.NewsTickerMediator;

    public class NewsConfig implements IConfig 
    {

        [Inject]
        public var context:IContext;
        [Inject]
        public var injector:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:ISignalCommandMap;
        [Inject]
        public var startupSequence:StartupSequence;


        public function configure():void
        {
            this.injector.map(OpenSkinSignal).asSingleton();
            this.injector.map(NewsDataUpdatedSignal).asSingleton();
            this.injector.map(NewsButtonRefreshSignal).asSingleton();
            this.injector.map(NewsModel).asSingleton();
            this.injector.map(GetAppEngineNewsTask).asSingleton();
            this.injector.map(GetInGameNewsTask);
            this.mediatorMap.map(NewsView).toMediator(NewsMediator);
            this.mediatorMap.map(NewsCell).toMediator(NewsCellMediator);
            this.mediatorMap.map(NewsModalButton).toMediator(NewsModalMediator);
            this.mediatorMap.map(NewsTicker).toMediator(NewsTickerMediator);
            this.startupSequence.addTask(GetAppEngineNewsTask, 6);
        }


    }
}//package kabam.rotmg.news

