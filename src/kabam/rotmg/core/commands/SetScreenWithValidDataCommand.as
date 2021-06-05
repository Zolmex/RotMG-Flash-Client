// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.core.commands.SetScreenWithValidDataCommand

package kabam.rotmg.core.commands
{
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.core.signals.SetScreenSignal;
    import flash.display.Sprite;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.account.core.services.GetCharListTask;
    import kabam.rotmg.dailyLogin.tasks.FetchPlayerCalendarTask;
    import io.decagames.rotmg.supportCampaign.tasks.GetCampaignStatusTask;
    import io.decagames.rotmg.pets.tasks.GetOwnedPetSkinsTask;
    import io.decagames.rotmg.seasonalEvent.tasks.GetSeasonalEventTask;
    import io.decagames.rotmg.seasonalEvent.tasks.GetLegacySeasonsTask;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import com.company.assembleegameclient.screens.LoadingScreen;
    import kabam.lib.tasks.TaskSequence;
    import kabam.lib.tasks.DispatchSignalTask;

    public class SetScreenWithValidDataCommand 
    {

        [Inject]
        public var model:PlayerModel;
        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var view:Sprite;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var task:GetCharListTask;
        [Inject]
        public var calendarTask:FetchPlayerCalendarTask;
        [Inject]
        public var campaignStatusTask:GetCampaignStatusTask;
        [Inject]
        public var petSkinsTask:GetOwnedPetSkinsTask;
        [Inject]
        public var getSeasonalEventTask:GetSeasonalEventTask;
        [Inject]
        public var getLegacySeasonsTask:GetLegacySeasonsTask;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;


        public function execute():void
        {
            if (this.model.isInvalidated)
            {
                this.reloadDataThenSetScreen();
            }
            else
            {
                this.setScreen.dispatch(this.view);
            }
        }

        private function reloadDataThenSetScreen():void
        {
            this.setScreen.dispatch(new LoadingScreen());
            var _local_1:TaskSequence = new TaskSequence();
            _local_1.add(this.task);
            _local_1.add(this.calendarTask);
            _local_1.add(this.petSkinsTask);
            _local_1.add(this.campaignStatusTask);
            if (!this.seasonalEventModel.isChallenger)
            {
                _local_1.add(this.getSeasonalEventTask);
            }
            _local_1.add(new DispatchSignalTask(this.setScreen, this.view));
            this.monitor.add(_local_1);
            _local_1.start();
        }


    }
}//package kabam.rotmg.core.commands

