﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.tooltip.MyPlayerToolTip

package com.company.assembleegameclient.ui.tooltip
{
    import kabam.rotmg.assets.services.CharacterFactory;
    import kabam.rotmg.classes.model.ClassesModel;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.ui.GameObjectListItem;
    import com.company.assembleegameclient.ui.StatusBar;
    import com.company.assembleegameclient.ui.LineBreakDesign;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
    import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
    import com.company.assembleegameclient.appengine.CharacterStats;
    import kabam.rotmg.game.view.components.StatsView;
    import kabam.rotmg.core.StaticInjectorContext;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.classes.model.CharacterClass;
    import kabam.rotmg.classes.model.CharacterSkin;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.constants.GeneralConstants;
    import com.company.assembleegameclient.util.FameUtil;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.filters.DropShadowFilter;

    public class MyPlayerToolTip extends ToolTip 
    {

        private var factory:CharacterFactory;
        private var classes:ClassesModel;
        public var player_:Player;
        private var playerPanel_:GameObjectListItem;
        private var hpBar_:StatusBar;
        private var mpBar_:StatusBar;
        private var lineBreak_:LineBreakDesign;
        private var bestLevel_:TextFieldDisplayConcrete;
        private var nextClassQuest_:TextFieldDisplayConcrete;
        private var eGrid:EquippedGrid;
        private var iGrid:InventoryGrid;
        private var bGrid:InventoryGrid;
        private var accountName:String;
        private var charXML:XML;
        private var charStats:CharacterStats;
        private var stats_:StatsView;

        public function MyPlayerToolTip(_arg_1:String, _arg_2:XML, _arg_3:CharacterStats)
        {
            super(0x363636, 1, 0xFFFFFF, 1);
            this.accountName = _arg_1;
            this.charXML = _arg_2;
            this.charStats = _arg_3;
        }

        public function createUI():void
        {
            var _local_5:Number;
            this.factory = StaticInjectorContext.getInjector().getInstance(CharacterFactory);
            this.classes = StaticInjectorContext.getInjector().getInstance(ClassesModel);
            var _local_1:int = int(this.charXML.ObjectType);
            var _local_2:XML = ObjectLibrary.xmlLibrary_[_local_1];
            this.player_ = Player.fromPlayerXML(this.accountName, this.charXML);
            var _local_3:CharacterClass = this.classes.getCharacterClass(this.player_.objectType_);
            var _local_4:CharacterSkin = _local_3.skins.getSkin(this.charXML.Texture);
            this.player_.animatedChar_ = this.factory.makeCharacter(_local_4.template);
            this.playerPanel_ = new GameObjectListItem(0xB3B3B3, true, this.player_);
            addChild(this.playerPanel_);
            _local_5 = 36;
            this.hpBar_ = new StatusBar(176, 16, 14693428, 0x545454, TextKey.STATUS_BAR_HEALTH_POINTS, true);
            this.hpBar_.x = 6;
            this.hpBar_.y = _local_5;
            addChild(this.hpBar_);
            _local_5 = (_local_5 + 22);
            this.mpBar_ = new StatusBar(176, 16, 6325472, 0x545454, TextKey.STATUS_BAR_MANA_POINTS, true);
            this.mpBar_.x = 6;
            this.mpBar_.y = _local_5;
            addChild(this.mpBar_);
            _local_5 = (_local_5 + 22);
            this.stats_ = new StatsView();
            this.stats_.draw(this.player_, false);
            this.stats_.x = 6;
            this.stats_.y = (_local_5 - 3);
            addChild(this.stats_);
            _local_5 = (_local_5 + 44);
            this.eGrid = new EquippedGrid(null, this.player_.slotTypes_, this.player_);
            this.eGrid.x = 8;
            this.eGrid.y = _local_5;
            addChild(this.eGrid);
            this.eGrid.setItems(this.player_.equipment_);
            _local_5 = (_local_5 + 44);
            this.iGrid = new InventoryGrid(null, this.player_, GeneralConstants.NUM_EQUIPMENT_SLOTS);
            this.iGrid.x = 8;
            this.iGrid.y = _local_5;
            addChild(this.iGrid);
            this.iGrid.setItems(this.player_.equipment_);
            _local_5 = (_local_5 + 88);
            if (this.player_.hasBackpack_)
            {
                this.bGrid = new InventoryGrid(null, this.player_, (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS));
                this.bGrid.x = 8;
                this.bGrid.y = _local_5;
                addChild(this.bGrid);
                this.bGrid.setItems(this.player_.equipment_);
                _local_5 = (_local_5 + 88);
            };
            _local_5 = (_local_5 + 8);
            this.lineBreak_ = new LineBreakDesign(100, 0x1C1C1C);
            this.lineBreak_.x = 6;
            this.lineBreak_.y = _local_5;
            addChild(this.lineBreak_);
            this.makeBestLevelText();
            this.bestLevel_.x = 8;
            this.bestLevel_.y = (height - 2);
            var _local_6:int = FameUtil.nextStarFame(((this.charStats == null) ? 0 : this.charStats.bestFame()), 0);
            if (_local_6 > 0)
            {
                this.makeNextClassQuestText(_local_6, _local_2);
            };
        }

        public function makeNextClassQuestText(_arg_1:int, _arg_2:XML):void
        {
            this.nextClassQuest_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(174);
            this.nextClassQuest_.setStringBuilder(new LineBuilder().setParams(TextKey.MY_PLAYER_TOOL_TIP_NEXT_CLASS_QUEST, {
                "nextStarFame":_arg_1,
                "character":ClassToolTip.getDisplayId(_arg_2)
            }));
            this.nextClassQuest_.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.nextClassQuest_);
            waiter.push(this.nextClassQuest_.textChanged);
        }

        public function makeBestLevelText():void
        {
            this.bestLevel_ = new TextFieldDisplayConcrete().setSize(14).setColor(6206769);
            var _local_1:int = ((this.charStats == null) ? 0 : this.charStats.numStars());
            var _local_2:String = ((this.charStats != null) ? this.charStats.bestLevel() : 0).toString();
            var _local_3:String = ((this.charStats != null) ? this.charStats.bestFame() : 0).toString();
            this.bestLevel_.setStringBuilder(new LineBuilder().setParams(TextKey.BESTLEVEL__STATS, {
                "numStars":_local_1,
                "bestLevel":_local_2,
                "fame":_local_3
            }));
            this.bestLevel_.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.bestLevel_);
            waiter.push(this.bestLevel_.textChanged);
        }

        override protected function alignUI():void
        {
            if (this.nextClassQuest_)
            {
                this.nextClassQuest_.x = 8;
                this.nextClassQuest_.y = (this.bestLevel_.getBounds(this).bottom - 2);
            };
        }

        override public function draw():void
        {
            this.hpBar_.draw(this.player_.hp_, this.player_.maxHP_, this.player_.maxHPBoost_, this.player_.maxHPMax_, this.player_.level_);
            this.mpBar_.draw(this.player_.mp_, this.player_.maxMP_, this.player_.maxMPBoost_, this.player_.maxMPMax_, this.player_.level_);
            this.lineBreak_.setWidthColor((width - 10), 0x1C1C1C);
            super.draw();
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

