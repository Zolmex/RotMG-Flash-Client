// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestListElementMediator

package io.decagames.rotmg.dailyQuests.view.list
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.dailyQuests.signal.ShowQuestInfoSignal;
    import flash.events.MouseEvent;

    public class DailyQuestListElementMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestListElement;
        [Inject]
        public var showInfoSignal:ShowQuestInfoSignal;


        override public function initialize():void
        {
            this.showInfoSignal.add(this.resetElement);
            this.view.addEventListener(MouseEvent.CLICK, this.onClickHandler);
        }

        private function resetElement(_arg_1:String, _arg_2:int, _arg_3:String):void
        {
            if (((_arg_1 == "") || (_arg_2 == -1)))
            {
                return;
            }
            if (_arg_1 != this.view.id)
            {
                if (((!(_arg_2 == 7)) && (!(this.view.category == 7))))
                {
                    this.view.isSelected = false;
                }
                else
                {
                    if (_arg_2 == this.view.category)
                    {
                        this.view.isSelected = false;
                    }
                }
            }
        }

        override public function destroy():void
        {
            this.view.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
        }

        private function onClickHandler(_arg_1:MouseEvent):void
        {
            this.view.isSelected = true;
            var _local_2:String = ((this.view.category == 7) ? DailyQuestsList.EVENT_TAB_LABEL : DailyQuestsList.QUEST_TAB_LABEL);
            this.showInfoSignal.dispatch(this.view.id, this.view.category, _local_2);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list

