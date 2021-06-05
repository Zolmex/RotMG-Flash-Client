// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalItemDataFactory

package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard
{
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.assets.services.CharacterFactory;
    
    import kabam.rotmg.classes.model.CharacterClass;
    import kabam.rotmg.classes.model.CharacterSkin;
    import com.company.util.ConversionUtil;
    

    public class SeasonalItemDataFactory 
    {

        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var classesModel:ClassesModel;
        [Inject]
        public var factory:CharacterFactory;
        private var seasonalLeaderBoardItemDatas:Vector.<SeasonalLeaderBoardItemData>;


        public function createSeasonalLeaderBoardItemDatas(_arg_1:XML):Vector.<SeasonalLeaderBoardItemData>
        {
            this.seasonalLeaderBoardItemDatas = new Vector.<SeasonalLeaderBoardItemData>(0);
            this.createItemsFromList(_arg_1.FameListElem);
            return (this.seasonalLeaderBoardItemDatas);
        }

        private function createItemsFromList(_arg_1:XMLList):void
        {
            var _local_2:XML;
            var _local_3:SeasonalLeaderBoardItemData;
            for each (_local_2 in _arg_1)
            {
                if (!this.seasonalLeaderBoardItemDatasContains(_local_2))
                {
                    _local_3 = this.createSeasonalLeaderBoardItemData(_local_2);
                    _local_3.isOwn = (_local_2.Name == this.playerModel.getName());
                    this.seasonalLeaderBoardItemDatas.push(_local_3);
                }
            }
        }

        private function seasonalLeaderBoardItemDatasContains(_arg_1:XML):Boolean
        {
            var _local_2:SeasonalLeaderBoardItemData;
            for each (_local_2 in this.seasonalLeaderBoardItemDatas)
            {
                if (((_local_2.accountId == _arg_1.@accountId) && (_local_2.charId == _arg_1.@charId)))
                {
                    return (true);
                }
            }
            return (false);
        }

        public function createSeasonalLeaderBoardItemData(_arg_1:XML):SeasonalLeaderBoardItemData
        {
            var _local_2:int = _arg_1.ObjectType;
            var _local_3:int = _arg_1.Texture;
            var _local_4:CharacterClass = this.classesModel.getCharacterClass(_local_2);
            var _local_5:CharacterSkin = _local_4.skins.getSkin(_local_3);
            var _local_6:int = ((_arg_1.hasOwnProperty("Tex1")) ? _arg_1.Tex1 : 0);
            var _local_7:int = ((_arg_1.hasOwnProperty("Tex2")) ? _arg_1.Tex2 : 0);
            var _local_8:int = ((_local_5.is16x16) ? 50 : 100);
            var _local_9:SeasonalLeaderBoardItemData = new SeasonalLeaderBoardItemData();
            _local_9.rank = _arg_1.Rank;
            _local_9.accountId = _arg_1.@accountId;
            _local_9.charId = _arg_1.@charId;
            _local_9.name = _arg_1.Name;
            _local_9.totalFame = _arg_1.TotalFame;
            _local_9.character = this.factory.makeIcon(_local_5.template, _local_8, _local_6, _local_7, (_local_9.rank <= 10));
            _local_9.equipmentSlots = _local_4.slotTypes;
            _local_9.equipment = ConversionUtil.toIntVector(_arg_1.Equipment);
            return (_local_9);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard

