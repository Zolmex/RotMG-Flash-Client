// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.model.DailyQuest

package io.decagames.rotmg.dailyQuests.model
{
    import __AS3__.vec.Vector;

    public class DailyQuest 
    {

        public var completed:Boolean;
        public var id:String;
        public var name:String;
        public var description:String;
        public var expiration:String;
        public var rewards:Vector.<int>;
        public var requirements:Vector.<int>;
        public var category:int;
        public var itemOfChoice:Boolean;
        public var repeatable:Boolean;
        public var weight:int;


        public function toString():String
        {
            return ((((((((((((((((((((("Quest: id=" + this.id) + ", name=") + this.name) + ", description=") + this.description) + ", expiration=") + this.expiration) + ", weight=") + this.weight) + ", category=") + this.category) + ", rewards=") + this.rewards) + ", requirements=") + this.requirements) + ", is itemOfChoice? ") + ((this.itemOfChoice) ? "true" : "false")) + ", is completed? ") + ((this.completed) ? "true" : "false")) + ", repeatable? ") + ((this.repeatable) ? "true" : "false"));
        }


    }
}//package io.decagames.rotmg.dailyQuests.model

