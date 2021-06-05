// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.command.QuestFetchCompleteCommand

package io.decagames.rotmg.dailyQuests.command
{
    import robotlegs.bender.bundles.mvcs.Command;
    import io.decagames.rotmg.dailyQuests.messages.incoming.QuestFetchResponse;
    import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
    
    import io.decagames.rotmg.dailyQuests.model.DailyQuest;
    import io.decagames.rotmg.dailyQuests.messages.data.QuestData;
    

    public class QuestFetchCompleteCommand extends Command 
    {

        [Inject]
        public var response:QuestFetchResponse;
        [Inject]
        public var model:DailyQuestsModel;
        private var _questsList:Vector.<DailyQuest>;


        override public function execute():void
        {
            var _local_1:QuestData;
            var _local_2:DailyQuest;
            this.model.clear();
            this.model.nextRefreshPrice = this.response.nextRefreshPrice;
            if (this.response.quests)
            {
                this._questsList = new Vector.<DailyQuest>(0);
                for each (_local_1 in this.response.quests)
                {
                    _local_2 = new DailyQuest();
                    _local_2.id = _local_1.id;
                    _local_2.name = _local_1.name;
                    _local_2.description = _local_1.description;
                    _local_2.expiration = _local_1.expiration;
                    _local_2.requirements = _local_1.requirements;
                    _local_2.rewards = _local_1.rewards;
                    _local_2.completed = _local_1.completed;
                    _local_2.category = _local_1.category;
                    _local_2.itemOfChoice = _local_1.itemOfChoice;
                    _local_2.repeatable = _local_1.repeatable;
                    _local_2.weight = _local_1.weight;
                    this._questsList.push(_local_2);
                }
                this._questsList.sort(this.questWeightSort);
                this.model.addQuests(this._questsList);
            }
        }

        private function questWeightSort(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            if (_arg_1.weight > _arg_2.weight)
            {
                return (-1);
            }
            if (_arg_1.weight < _arg_2.weight)
            {
                return (1);
            }
            return (0);
        }


    }
}//package io.decagames.rotmg.dailyQuests.command

