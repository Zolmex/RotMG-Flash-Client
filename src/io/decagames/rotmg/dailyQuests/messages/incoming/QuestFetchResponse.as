// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.messages.incoming.QuestFetchResponse

package io.decagames.rotmg.dailyQuests.messages.incoming
{
    import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import __AS3__.vec.Vector;
    import io.decagames.rotmg.dailyQuests.messages.data.QuestData;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class QuestFetchResponse extends IncomingMessage 
    {

        public var quests:Vector.<QuestData>;
        public var nextRefreshPrice:int;

        public function QuestFetchResponse(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
            this.nextRefreshPrice = -1;
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            this.quests = new Vector.<QuestData>();
            var _local_2:int = _arg_1.readShort();
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                this.quests[_local_3] = new QuestData();
                this.quests[_local_3].parseFromInput(_arg_1);
                _local_3++;
            };
            this.nextRefreshPrice = _arg_1.readShort();
        }

        override public function toString():String
        {
            return (formatToString("QUESTFETCHRESPONSE"));
        }


    }
}//package io.decagames.rotmg.dailyQuests.messages.incoming

