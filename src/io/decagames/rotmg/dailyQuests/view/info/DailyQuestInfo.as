// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo

package io.decagames.rotmg.dailyQuests.view.info
{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    
    import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import io.decagames.rotmg.dailyQuests.utils.SlotsRendered;
    import io.decagames.rotmg.dailyQuests.data.DailyQuestItemSlotType;
    import io.decagames.rotmg.dailyQuests.model.DailyQuest;
    

    public class DailyQuestInfo extends Sprite 
    {

        public static var INFO_WIDTH:int = 328;
        public static const INFO_HEIGHT:int = 434;

        private var contentInset:SliceScalingBitmap;
        private var contentTitle:SliceScalingBitmap;
        private var contentButton:SliceScalingBitmap;
        private var contentDivider:SliceScalingBitmap;
        private var contentDividerTitle:SliceScalingBitmap;
        private var questName:UILabel;
        private var questDescription:UILabel;
        private var rewardsTitle:UILabel;
        private var rewardsChoice:UILabel;
        private var questAvailable:UILabel;
        private var refreshInfo:UILabel;
        private var slots:Vector.<DailyQuestItemSlot>;
        private var slotMargin:int = 4;
        private var requirementsTopMargin:int = 100;
        private var rewardsTopMargin:int = 0xFF;
        private var requirementsContainer:Sprite;
        private var rewardsContainer:Sprite;
        private var _completeButton:DailyQuestCompleteButton;
        private var _playerEquipment:Vector.<int>;

        public function DailyQuestInfo()
        {
            this.init();
        }

        public static function hasAllItems(_arg_1:Vector.<int>, _arg_2:Vector.<int>):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            var _local_3:Vector.<int> = _arg_1.concat();
            for each (_local_4 in _arg_2)
            {
                _local_5 = _local_3.indexOf(_local_4);
                if (_local_5 >= 0)
                {
                    _local_3.splice(_local_5, 1);
                }
            }
            return (_local_3.length == 0);
        }


        private function init():void
        {
            this.createContentInset();
            this.createContentTitle();
            this.createContentButton();
            this.createContentDivider();
            this.createContentDividerTitle();
            this.createQuestName();
            this.createContainers();
            this.createQuestDescription();
            this.createRewardsTitle();
            this.createRewardChoice();
            this.createQuestAvailable();
            this.createRefreshInfo();
            this.createCompleteButton();
        }

        private function createContentInset():void
        {
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 325);
            this.contentInset.height = 425;
            this.contentInset.x = 0;
            this.contentInset.y = 0;
            addChild(this.contentInset);
        }

        private function createContentTitle():void
        {
            this.contentTitle = TextureParser.instance.getSliceScalingBitmap("UI", "content_title_decoration", 325);
            this.contentTitle.x = 0;
            this.contentTitle.y = 0;
            addChild(this.contentTitle);
        }

        private function createContentButton():void
        {
            this.contentButton = TextureParser.instance.getSliceScalingBitmap("UI", "content_button_decoration", 325);
            this.contentButton.x = 0;
            this.contentButton.y = 340;
            addChild(this.contentButton);
        }

        private function createContentDivider():void
        {
            this.contentDivider = TextureParser.instance.getSliceScalingBitmap("UI", "content_divider", 305);
            this.contentDivider.x = 10;
            this.contentDivider.y = 203;
            addChild(this.contentDivider);
        }

        private function createContentDividerTitle():void
        {
            this.contentDividerTitle = TextureParser.instance.getSliceScalingBitmap("UI", "content_divider_title", 145);
            this.contentDividerTitle.x = ((this.contentInset.width / 2) - (this.contentDividerTitle.width / 2));
            this.contentDividerTitle.y = 193;
            addChild(this.contentDividerTitle);
        }

        private function createQuestName():void
        {
            this.questName = new UILabel();
            DefaultLabelFormat.questNameLabel(this.questName);
            this.questName.width = INFO_WIDTH;
            this.questName.wordWrap = true;
            this.questName.x = 0;
            this.questName.y = 6;
            addChild(this.questName);
        }

        private function createContainers():void
        {
            this.requirementsContainer = new Sprite();
            addChild(this.requirementsContainer);
            this.rewardsContainer = new Sprite();
            addChild(this.rewardsContainer);
        }

        private function createQuestDescription():void
        {
            this.questDescription = new UILabel();
            DefaultLabelFormat.questDescriptionLabel(this.questDescription);
            this.questDescription.width = (INFO_WIDTH - 30);
            this.questDescription.wordWrap = true;
            this.questDescription.multiline = true;
            this.questDescription.x = 15;
            this.questDescription.y = 44;
            addChild(this.questDescription);
        }

        private function createRewardsTitle():void
        {
            this.rewardsTitle = new UILabel();
            DefaultLabelFormat.questRewardLabel(this.rewardsTitle);
            this.rewardsTitle.text = "Rewards";
            this.rewardsTitle.x = ((this.contentInset.width / 2) - (this.rewardsTitle.width / 2));
            this.rewardsTitle.y = 200;
            addChild(this.rewardsTitle);
        }

        private function createRewardChoice():void
        {
            this.rewardsChoice = new UILabel();
            DefaultLabelFormat.questChoiceLabel(this.rewardsChoice);
            this.rewardsChoice.text = "Choose one of the following Items";
            this.rewardsChoice.x = ((this.contentInset.width / 2) - (this.rewardsChoice.width / 2));
            this.rewardsChoice.y = 230;
            addChild(this.rewardsChoice);
        }

        private function createQuestAvailable():void
        {
            this.questAvailable = new UILabel();
            DefaultLabelFormat.createLabelFormat(this.questAvailable, 12, 0xA3A3A3, TextFormatAlign.CENTER, true);
            this.questAvailable.y = 280;
            addChild(this.questAvailable);
        }

        private function createRefreshInfo():void
        {
            this.refreshInfo = new UILabel();
            DefaultLabelFormat.createLabelFormat(this.refreshInfo, 12, 0xFF00, TextFormatAlign.CENTER, true);
            this.refreshInfo.width = 170;
            this.refreshInfo.multiline = true;
            this.refreshInfo.wordWrap = true;
            this.refreshInfo.text = "You can also refresh Quests up to 2 times per day!";
            this.refreshInfo.x = ((this.contentInset.width - this.refreshInfo.width) / 2);
            this.refreshInfo.y = (this.questAvailable.y + 18);
            addChild(this.refreshInfo);
        }

        private function createCompleteButton():void
        {
            this._completeButton = new DailyQuestCompleteButton();
            this._completeButton.x = 92;
            this._completeButton.y = 370;
        }

        public function dailyQuestsCompleted():void
        {
            var _local_1:DailyQuestItemSlot;
            this.questName.text = "Quests Completed!";
            this.questDescription.text = "Congratulation, you have completed all quests for today!";
            this.showQuestsCompleteInfo(true);
            for each (_local_1 in this.slots)
            {
                _local_1.parent.removeChild(_local_1);
            }
            if (!this.slots)
            {
                this.slots = new Vector.<DailyQuestItemSlot>();
            }
            else
            {
                this.slots.length = 0;
            }
        }

        public function eventQuestsCompleted():void
        {
            var _local_1:DailyQuestItemSlot;
            this.questName.text = "No Event Quests!";
            this.questDescription.text = "There are no Event quests currently available. Come back later!";
            this.showQuestsCompleteInfo(false, false);
            for each (_local_1 in this.slots)
            {
                _local_1.parent.removeChild(_local_1);
            }
            if (!this.slots)
            {
                this.slots = new Vector.<DailyQuestItemSlot>();
            }
            else
            {
                this.slots.length = 0;
            }
        }

        private function showQuestsCompleteInfo(_arg_1:Boolean, _arg_2:Boolean=true):void
        {
            this.questAvailable.visible = _arg_1;
            this.refreshInfo.visible = _arg_1;
            this.rewardsChoice.visible = ((_arg_2) ? (!(_arg_1)) : _arg_1);
            this.rewardsTitle.visible = ((_arg_2) ? (!(_arg_1)) : _arg_1);
            this.contentDivider.visible = ((_arg_2) ? (!(_arg_1)) : _arg_1);
            this.contentDividerTitle.visible = ((_arg_2) ? (!(_arg_1)) : _arg_1);
            this._completeButton.visible = ((_arg_2) ? (!(_arg_1)) : _arg_1);
        }

        public function show(_arg_1:DailyQuest, _arg_2:Vector.<int>):void
        {
            this._playerEquipment = _arg_2.concat();
            this.showQuestsCompleteInfo(false);
            this.rewardsChoice.visible = _arg_1.itemOfChoice;
            this.questName.text = _arg_1.name;
            this.questDescription.text = _arg_1.description;
            SlotsRendered.renderSlots(_arg_1.requirements, this._playerEquipment, DailyQuestItemSlotType.REQUIREMENT, this.requirementsContainer, this.requirementsTopMargin, this.slotMargin, INFO_WIDTH, this.slots);
            SlotsRendered.renderSlots(_arg_1.rewards, this._playerEquipment, DailyQuestItemSlotType.REWARD, this.rewardsContainer, this.rewardsTopMargin, this.slotMargin, INFO_WIDTH, this.slots, _arg_1.itemOfChoice);
            this._completeButton.disabled = ((_arg_1.completed) ? true : (!(hasAllItems(_arg_1.requirements, _arg_2))));
            this._completeButton.completed = _arg_1.completed;
            addChild(this._completeButton);
        }

        public function get completeButton():DailyQuestCompleteButton
        {
            return (this._completeButton);
        }

        public function setQuestAvailableTime(_arg_1:String):void
        {
            this.questAvailable.text = _arg_1;
            this.questAvailable.x = ((this.contentInset.width - this.questAvailable.width) / 2);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.info

