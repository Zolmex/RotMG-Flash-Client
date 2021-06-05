// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.Player

package com.company.assembleegameclient.objects
{
    
    import flash.geom.Point;
    import flash.geom.Matrix;
    import com.company.assembleegameclient.util.AnimatedChar;
    import org.osflash.signals.Signal;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.objects.particles.HealingEffect;
    import kabam.rotmg.game.signals.AddTextLineSignal;
    import kabam.rotmg.assets.services.CharacterFactory;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import com.company.util.IntPoint;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsPath;
    import kabam.rotmg.core.StaticInjectorContext;
    import org.swiftsuspenders.Injector;
    import flash.utils.Dictionary;
    import com.company.util.ConversionUtil;
    import kabam.rotmg.constants.GeneralConstants;
    import kabam.rotmg.messaging.impl.data.StatData;
    import flash.utils.getTimer;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.chat.model.ChatMessage;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import com.company.assembleegameclient.sound.SoundEffectLibrary;
    import com.company.assembleegameclient.objects.particles.LevelUpEffect;
    import com.company.util.PointUtil;
    import com.company.assembleegameclient.map.Square;
    import flash.geom.Vector3D;
    import com.company.assembleegameclient.util.ConditionEffect;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import kabam.rotmg.text.view.BitmapTextFactory;
    import com.company.assembleegameclient.util.FameUtil;
    import com.company.assembleegameclient.util.PlayerUtil;
    import com.company.util.GraphicsUtil;
    import com.company.util.MoreColorUtil;
    import kabam.rotmg.stage3D.GraphicsFillExtra;
    import flash.display.IGraphicsData;
    import com.company.assembleegameclient.map.Camera;
    import com.company.assembleegameclient.util.MaskedImage;
    import flash.geom.ColorTransform;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import com.company.util.CachingColorTransformer;
    import io.decagames.rotmg.supportCampaign.data.SupporterFeatures;
    import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
    import kabam.rotmg.constants.UseType;
    import kabam.rotmg.constants.ActivationType;
    import com.company.assembleegameclient.util.MathUtil;
    import com.company.assembleegameclient.tutorial.doneAction;
    import com.company.assembleegameclient.tutorial.Tutorial;
    import com.company.util.Trig;
    import com.company.assembleegameclient.util.FreeList;
    import kabam.rotmg.ui.model.TabStripModel;
    import kabam.rotmg.game.model.PotionInventoryModel;
    
    import com.company.assembleegameclient.objects.particles.*;

    public class Player extends Character 
    {

        public static const MS_BETWEEN_TELEPORT:int = 10000;
        public static const MS_REALM_TELEPORT:int = 120000;
        private static const MOVE_THRESHOLD:Number = 0.4;
        public static var isAdmin:Boolean = false;
        public static var isMod:Boolean = false;
        private static const NEARBY:Vector.<Point> = new <Point>[new Point(0, 0), new Point(1, 0), new Point(0, 1), new Point(1, 1)];
        private static var newP:Point = new Point();
        private static const RANK_OFFSET_MATRIX:Matrix = new Matrix(1, 0, 0, 1, 2, 2);
        private static const RANK_STAR_BG_OFFSET_MATRIX:Matrix = new Matrix(0.8, 0, 0, 0.8, 0, 0);
        private static const NAME_OFFSET_MATRIX:Matrix = new Matrix(1, 0, 0, 1, 20, 1);
        private static const MIN_MOVE_SPEED:Number = 0.004;
        private static const MAX_MOVE_SPEED:Number = 0.0096;
        private static const MIN_ATTACK_FREQ:Number = 0.0015;
        private static const MAX_ATTACK_FREQ:Number = 0.008;
        private static const MIN_ATTACK_MULT:Number = 0.5;
        private static const MAX_ATTACK_MULT:Number = 2;

        public var xpTimer:int;
        public var skinId:int;
        public var skin:AnimatedChar;
        public var isShooting:Boolean;
        public var creditsWereChanged:Signal = new Signal();
        public var fameWasChanged:Signal = new Signal();
        public var supporterFlagWasChanged:Signal = new Signal();
        private var famePortrait_:BitmapData = null;
        public var lastSwap_:int = -1;
        public var accountId_:String = "";
        public var credits_:int = 0;
        public var tokens_:int = 0;
        public var numStars_:int = 0;
        public var starsBg_:int = 0;
        public var fame_:int = 0;
        public var nameChosen_:Boolean = false;
        public var currFame_:int = -1;
        public var nextClassQuestFame_:int = -1;
        public var legendaryRank_:int = -1;
        public var guildName_:String = null;
        public var guildRank_:int = -1;
        public var isFellowGuild_:Boolean = false;
        public var breath_:int = -1;
        public var maxMP_:int = 200;
        public var mp_:Number = 0;
        public var nextLevelExp_:int = 1000;
        public var exp_:int = 0;
        public var attack_:int = 0;
        public var speed_:int = 0;
        public var dexterity_:int = 0;
        public var vitality_:int = 0;
        public var wisdom_:int = 0;
        public var mpZeroed_:Boolean = false;
        public var maxHPBoost_:int = 0;
        public var maxMPBoost_:int = 0;
        public var attackBoost_:int = 0;
        public var defenseBoost_:int = 0;
        public var speedBoost_:int = 0;
        public var vitalityBoost_:int = 0;
        public var wisdomBoost_:int = 0;
        public var dexterityBoost_:int = 0;
        public var xpBoost_:int = 0;
        public var healthPotionCount_:int = 0;
        public var magicPotionCount_:int = 0;
        public var projectileLifeMul_:Number = 1;
        public var projectileSpeedMult_:Number = 1;
        public var attackMax_:int = 0;
        public var defenseMax_:int = 0;
        public var speedMax_:int = 0;
        public var dexterityMax_:int = 0;
        public var vitalityMax_:int = 0;
        public var wisdomMax_:int = 0;
        public var maxHPMax_:int = 0;
        public var maxMPMax_:int = 0;
        public var supporterFlag:int = 0;
        public var hasBackpack_:Boolean = false;
        public var starred_:Boolean = false;
        public var ignored_:Boolean = false;
        public var distSqFromThisPlayer_:Number = 0;
        protected var rotate_:Number = 0;
        protected var relMoveVec_:Point = null;
        protected var moveMultiplier_:Number = 1;
        public var attackPeriod_:int = 0;
        public var nextAltAttack_:int = 0;
        public var nextTeleportAt_:int = 0;
        public var dropBoost:int = 0;
        public var tierBoost:int = 0;
        public var isNotInCombatMapArea:Boolean;
        protected var healingEffect_:HealingEffect = null;
        protected var nearestMerchant_:Merchant = null;
        public var isDefaultAnimatedChar:Boolean = true;
        public var projectileIdSetOverrideNew:String = "";
        public var projectileIdSetOverrideOld:String = "";
        private var addTextLine:AddTextLineSignal;
        private var factory:CharacterFactory;
        private var supportCampaignModel:SupporterCampaignModel;
        private var ip_:IntPoint = new IntPoint();
        private var breathBackFill_:GraphicsSolidFill = null;
        private var breathBackPath_:GraphicsPath = null;
        private var breathFill_:GraphicsSolidFill = null;
        private var breathPath_:GraphicsPath = null;

        public function Player(_arg_1:XML)
        {
            var _local_2:Injector = StaticInjectorContext.getInjector();
            this.addTextLine = _local_2.getInstance(AddTextLineSignal);
            this.factory = _local_2.getInstance(CharacterFactory);
            this.supportCampaignModel = _local_2.getInstance(SupporterCampaignModel);
            super(_arg_1);
            this.attackMax_ = int(_arg_1.Attack.@max);
            this.defenseMax_ = int(_arg_1.Defense.@max);
            this.speedMax_ = int(_arg_1.Speed.@max);
            this.dexterityMax_ = int(_arg_1.Dexterity.@max);
            this.vitalityMax_ = int(_arg_1.HpRegen.@max);
            this.wisdomMax_ = int(_arg_1.MpRegen.@max);
            this.maxHPMax_ = int(_arg_1.MaxHitPoints.@max);
            this.maxMPMax_ = int(_arg_1.MaxMagicPoints.@max);
            texturingCache_ = new Dictionary();
        }

        public static function fromPlayerXML(name:String, playerXML:XML):Player
        {
            var objectType:int;
            var objXML:XML;
            var player:Player;
            objectType = int(playerXML.ObjectType);
            try
            {
                objXML = ObjectLibrary.xmlLibrary_[objectType];
                player = new Player(objXML);
                player.name_ = name;
                player.level_ = int(playerXML.Level);
                player.exp_ = int(playerXML.Exp);
                player.equipment_ = ConversionUtil.toIntVector(playerXML.Equipment);
                player.calculateStatBoosts();
                player.lockedSlot = new Vector.<int>(player.equipment_.length);
                player.maxHP_ = (player.maxHPBoost_ + int(playerXML.MaxHitPoints));
                player.hp_ = int(playerXML.HitPoints);
                player.maxMP_ = (player.maxMPBoost_ + int(playerXML.MaxMagicPoints));
                player.mp_ = int(playerXML.MagicPoints);
                player.attack_ = (player.attackBoost_ + int(playerXML.Attack));
                player.defense_ = (player.defenseBoost_ + int(playerXML.Defense));
                player.speed_ = (player.speedBoost_ + int(playerXML.Speed));
                player.dexterity_ = (player.dexterityBoost_ + int(playerXML.Dexterity));
                player.vitality_ = (player.vitalityBoost_ + int(playerXML.HpRegen));
                player.wisdom_ = (player.wisdomBoost_ + int(playerXML.MpRegen));
                player.tex1Id_ = int(playerXML.Tex1);
                player.tex2Id_ = int(playerXML.Tex2);
                player.hasBackpack_ = (playerXML.HasBackpack == "1");
            }
            catch(error:Error)
            {
                throw (new Error(((("Type: 0x" + objectType.toString(16)) + "doesn't exist. ") + error.message)));
            }
            return (player);
        }


        public function getFameBonus():int
        {
            var _local_3:int;
            var _local_4:XML;
            var _local_1:int;
            var _local_2:uint;
            while (_local_2 < GeneralConstants.NUM_EQUIPMENT_SLOTS)
            {
                if (((equipment_) && (equipment_.length > _local_2)))
                {
                    _local_3 = equipment_[_local_2];
                    if (_local_3 != -1)
                    {
                        _local_4 = ObjectLibrary.xmlLibrary_[_local_3];
                        if (((!(_local_4 == null)) && (_local_4.hasOwnProperty("FameBonus"))))
                        {
                            _local_1 = (_local_1 + int(_local_4.FameBonus));
                        }
                    }
                }
                _local_2++;
            }
            return (_local_1);
        }

        public function calculateStatBoosts():void
        {
            var _local_2:int;
            var _local_3:XML;
            var _local_4:XML;
            var _local_5:int;
            var _local_6:int;
            this.maxHPBoost_ = 0;
            this.maxMPBoost_ = 0;
            this.attackBoost_ = 0;
            this.defenseBoost_ = 0;
            this.speedBoost_ = 0;
            this.vitalityBoost_ = 0;
            this.wisdomBoost_ = 0;
            this.dexterityBoost_ = 0;
            var _local_1:uint;
            while (_local_1 < GeneralConstants.NUM_EQUIPMENT_SLOTS)
            {
                if (((equipment_) && (equipment_.length > _local_1)))
                {
                    _local_2 = equipment_[_local_1];
                    if (_local_2 != -1)
                    {
                        _local_3 = ObjectLibrary.xmlLibrary_[_local_2];
                        if (((!(_local_3 == null)) && (_local_3.hasOwnProperty("ActivateOnEquip"))))
                        {
                            for each (_local_4 in _local_3.ActivateOnEquip)
                            {
                                if (_local_4.toString() == "IncrementStat")
                                {
                                    _local_5 = int(_local_4.@stat);
                                    _local_6 = int(_local_4.@amount);
                                    switch (_local_5)
                                    {
                                        case StatData.MAX_HP_STAT:
                                            this.maxHPBoost_ = (this.maxHPBoost_ + _local_6);
                                            break;
                                        case StatData.MAX_MP_STAT:
                                            this.maxMPBoost_ = (this.maxMPBoost_ + _local_6);
                                            break;
                                        case StatData.ATTACK_STAT:
                                            this.attackBoost_ = (this.attackBoost_ + _local_6);
                                            break;
                                        case StatData.DEFENSE_STAT:
                                            this.defenseBoost_ = (this.defenseBoost_ + _local_6);
                                            break;
                                        case StatData.SPEED_STAT:
                                            this.speedBoost_ = (this.speedBoost_ + _local_6);
                                            break;
                                        case StatData.VITALITY_STAT:
                                            this.vitalityBoost_ = (this.vitalityBoost_ + _local_6);
                                            break;
                                        case StatData.WISDOM_STAT:
                                            this.wisdomBoost_ = (this.wisdomBoost_ + _local_6);
                                            break;
                                        case StatData.DEXTERITY_STAT:
                                            this.dexterityBoost_ = (this.dexterityBoost_ + _local_6);
                                            break;
                                    }
                                }
                            }
                        }
                    }
                }
                _local_1++;
            }
        }

        public function setRelativeMovement(_arg_1:Number, _arg_2:Number, _arg_3:Number):void
        {
            var _local_4:Number;
            if (this.relMoveVec_ == null)
            {
                this.relMoveVec_ = new Point();
            }
            this.rotate_ = _arg_1;
            this.relMoveVec_.x = _arg_2;
            this.relMoveVec_.y = _arg_3;
            if (isConfused())
            {
                _local_4 = this.relMoveVec_.x;
                this.relMoveVec_.x = -(this.relMoveVec_.y);
                this.relMoveVec_.y = -(_local_4);
                this.rotate_ = -(this.rotate_);
            }
        }

        public function setCredits(_arg_1:int):void
        {
            this.credits_ = _arg_1;
            this.creditsWereChanged.dispatch();
        }

        public function setFame(_arg_1:int):void
        {
            this.fame_ = _arg_1;
            this.fameWasChanged.dispatch();
        }

        public function setSupporterFlag(_arg_1:int):void
        {
            this.supporterFlag = _arg_1;
            this.supporterFlagWasChanged.dispatch();
        }

        public function hasSupporterFeature(_arg_1:int):Boolean
        {
            return ((this.supporterFlag & _arg_1) == _arg_1);
        }

        public function setTokens(_arg_1:int):void
        {
            this.tokens_ = _arg_1;
        }

        public function setGuildName(_arg_1:String):void
        {
            var _local_3:GameObject;
            var _local_4:Player;
            var _local_5:Boolean;
            this.guildName_ = _arg_1;
            var _local_2:Player = map_.player_;
            if (_local_2 == this)
            {
                for each (_local_3 in map_.goDict_)
                {
                    _local_4 = (_local_3 as Player);
                    if (((!(_local_4 == null)) && (!(_local_4 == this))))
                    {
                        _local_4.setGuildName(_local_4.guildName_);
                    }
                }
            }
            else
            {
                _local_5 = ((((!(_local_2 == null)) && (!(_local_2.guildName_ == null))) && (!(_local_2.guildName_ == ""))) && (_local_2.guildName_ == this.guildName_));
                if (_local_5 != this.isFellowGuild_)
                {
                    this.isFellowGuild_ = _local_5;
                    nameBitmapData_ = null;
                }
            }
        }

        public function isTeleportEligible(_arg_1:Player):Boolean
        {
            return (!(((_arg_1.dead_) || (_arg_1.isPaused())) || (_arg_1.isInvisible())));
        }

        public function msUtilTeleport():int
        {
            var _local_1:int = getTimer();
            return (Math.max(0, (this.nextTeleportAt_ - _local_1)));
        }

        public function teleportTo(_arg_1:Player):Boolean
        {
            if (isPaused())
            {
                this.addTextLine.dispatch(this.makeErrorMessage(TextKey.PLAYER_NOTELEPORTWHILEPAUSED));
                return (false);
            }
            var _local_2:int = this.msUtilTeleport();
            if (_local_2 > 0)
            {
                if (!((_local_2 > MS_BETWEEN_TELEPORT) && (_arg_1.isFellowGuild_)))
                {
                    this.addTextLine.dispatch(this.makeErrorMessage(TextKey.PLAYER_TELEPORT_COOLDOWN, {"seconds":int(((_local_2 / 1000) + 1))}));
                    return (false);
                }
            }
            if (!this.isTeleportEligible(_arg_1))
            {
                if (_arg_1.isInvisible())
                {
                    this.addTextLine.dispatch(this.makeErrorMessage(TextKey.TELEPORT_INVISIBLE_PLAYER, {"player":_arg_1.name_}));
                }
                else
                {
                    this.addTextLine.dispatch(this.makeErrorMessage(TextKey.PLAYER_TELEPORT_TO_PLAYER, {"player":_arg_1.name_}));
                }
                return (false);
            }
            map_.gs_.gsc_.teleport(_arg_1.objectId_);
            this.nextTeleportAt_ = (getTimer() + MS_BETWEEN_TELEPORT);
            return (true);
        }

        private function makeErrorMessage(_arg_1:String, _arg_2:Object=null):ChatMessage
        {
            return (ChatMessage.make(Parameters.ERROR_CHAT_NAME, _arg_1, -1, -1, "", false, _arg_2));
        }

        public function levelUpEffect(_arg_1:String, _arg_2:Boolean=true):void
        {
            if (((!(Parameters.data_.noParticlesMaster)) && (_arg_2)))
            {
                this.levelUpParticleEffect();
            }
            var _local_3:CharacterStatusText = new CharacterStatusText(this, 0xFF00, 2000);
            _local_3.setStringBuilder(new LineBuilder().setParams(_arg_1));
            map_.mapOverlay_.addStatusText(_local_3);
        }

        public function handleLevelUp(_arg_1:Boolean):void
        {
            SoundEffectLibrary.play("level_up");
            if (_arg_1)
            {
                this.levelUpEffect(TextKey.PLAYER_NEWCLASSUNLOCKED, false);
                this.levelUpEffect(TextKey.PLAYER_LEVELUP);
            }
            else
            {
                this.levelUpEffect(TextKey.PLAYER_LEVELUP);
            }
        }

        public function levelUpParticleEffect(_arg_1:uint=0xFF00FF00):void
        {
            map_.addObj(new LevelUpEffect(this, _arg_1, 20), x_, y_);
        }

        public function handleExpUp(_arg_1:int):void
        {
            if (((level_ == 20) && (!(this.bForceExp()))))
            {
                return;
            }
            var _local_2:CharacterStatusText = new CharacterStatusText(this, 0xFF00, 1000);
            _local_2.setStringBuilder(new LineBuilder().setParams("+{exp} EXP", {"exp":_arg_1}));
            map_.mapOverlay_.addStatusText(_local_2);
        }

        private function bForceExp():Boolean
        {
            return ((Parameters.data_.forceEXP) && ((Parameters.data_.forceEXP == 1) || ((Parameters.data_.forceEXP == 2) && (map_.player_ == this))));
        }

        public function updateFame(_arg_1:int):void
        {
            var _local_2:CharacterStatusText = new CharacterStatusText(this, 0xE25F00, 2000);
            _local_2.setStringBuilder(new LineBuilder().setParams("+{fame} Fame", {"fame":_arg_1}));
            map_.mapOverlay_.addStatusText(_local_2);
        }

        private function getNearbyMerchant():Merchant
        {
            var _local_3:Point;
            var _local_4:Merchant;
            var _local_1:int = (((x_ - int(x_)) > 0.5) ? 1 : -1);
            var _local_2:int = (((y_ - int(y_)) > 0.5) ? 1 : -1);
            for each (_local_3 in NEARBY)
            {
                this.ip_.x_ = (x_ + (_local_1 * _local_3.x));
                this.ip_.y_ = (y_ + (_local_2 * _local_3.y));
                _local_4 = map_.merchLookup_[this.ip_];
                if (_local_4 != null)
                {
                    return ((PointUtil.distanceSquaredXY(_local_4.x_, _local_4.y_, x_, y_) < 1) ? _local_4 : null);
                }
            }
            return (null);
        }

        public function walkTo(_arg_1:Number, _arg_2:Number):Boolean
        {
            this.modifyMove(_arg_1, _arg_2, newP);
            return (this.moveTo(newP.x, newP.y));
        }

        override public function moveTo(_arg_1:Number, _arg_2:Number):Boolean
        {
            var _local_3:Boolean = super.moveTo(_arg_1, _arg_2);
            if (map_.gs_.evalIsNotInCombatMapArea())
            {
                this.nearestMerchant_ = this.getNearbyMerchant();
            }
            return (_local_3);
        }

        public function modifyMove(_arg_1:Number, _arg_2:Number, _arg_3:Point):void
        {
            if (((isParalyzed()) || (isPetrified())))
            {
                _arg_3.x = x_;
                _arg_3.y = y_;
                return;
            }
            var _local_4:Number = (_arg_1 - x_);
            var _local_5:Number = (_arg_2 - y_);
            if (((((_local_4 < MOVE_THRESHOLD) && (_local_4 > -(MOVE_THRESHOLD))) && (_local_5 < MOVE_THRESHOLD)) && (_local_5 > -(MOVE_THRESHOLD))))
            {
                this.modifyStep(_arg_1, _arg_2, _arg_3);
                return;
            }
            var _local_6:Number = (MOVE_THRESHOLD / Math.max(Math.abs(_local_4), Math.abs(_local_5)));
            var _local_7:Number = 0;
            _arg_3.x = x_;
            _arg_3.y = y_;
            var _local_8:Boolean;
            while ((!(_local_8)))
            {
                if ((_local_7 + _local_6) >= 1)
                {
                    _local_6 = (1 - _local_7);
                    _local_8 = true;
                }
                this.modifyStep((_arg_3.x + (_local_4 * _local_6)), (_arg_3.y + (_local_5 * _local_6)), _arg_3);
                _local_7 = (_local_7 + _local_6);
            }
        }

        public function modifyStep(_arg_1:Number, _arg_2:Number, _arg_3:Point):void
        {
            var _local_6:Number;
            var _local_7:Number;
            var _local_4:Boolean = ((((x_ % 0.5) == 0) && (!(_arg_1 == x_))) || (!(int((x_ / 0.5)) == int((_arg_1 / 0.5)))));
            var _local_5:Boolean = ((((y_ % 0.5) == 0) && (!(_arg_2 == y_))) || (!(int((y_ / 0.5)) == int((_arg_2 / 0.5)))));
            if ((((!(_local_4)) && (!(_local_5))) || (this.isValidPosition(_arg_1, _arg_2))))
            {
                _arg_3.x = _arg_1;
                _arg_3.y = _arg_2;
                return;
            }
            if (_local_4)
            {
                _local_6 = ((_arg_1 > x_) ? (int((_arg_1 * 2)) / 2) : (int((x_ * 2)) / 2));
                if (int(_local_6) > int(x_))
                {
                    _local_6 = (_local_6 - 0.01);
                }
            }
            if (_local_5)
            {
                _local_7 = ((_arg_2 > y_) ? (int((_arg_2 * 2)) / 2) : (int((y_ * 2)) / 2));
                if (int(_local_7) > int(y_))
                {
                    _local_7 = (_local_7 - 0.01);
                }
            }
            if (!_local_4)
            {
                _arg_3.x = _arg_1;
                _arg_3.y = _local_7;
                if (((!(square_ == null)) && (!(square_.props_.slideAmount_ == 0))))
                {
                    this.resetMoveVector(false);
                }
                return;
            }
            if (!_local_5)
            {
                _arg_3.x = _local_6;
                _arg_3.y = _arg_2;
                if (((!(square_ == null)) && (!(square_.props_.slideAmount_ == 0))))
                {
                    this.resetMoveVector(true);
                }
                return;
            }
            var _local_8:Number = ((_arg_1 > x_) ? (_arg_1 - _local_6) : (_local_6 - _arg_1));
            var _local_9:Number = ((_arg_2 > y_) ? (_arg_2 - _local_7) : (_local_7 - _arg_2));
            if (_local_8 > _local_9)
            {
                if (this.isValidPosition(_arg_1, _local_7))
                {
                    _arg_3.x = _arg_1;
                    _arg_3.y = _local_7;
                    return;
                }
                if (this.isValidPosition(_local_6, _arg_2))
                {
                    _arg_3.x = _local_6;
                    _arg_3.y = _arg_2;
                    return;
                }
            }
            else
            {
                if (this.isValidPosition(_local_6, _arg_2))
                {
                    _arg_3.x = _local_6;
                    _arg_3.y = _arg_2;
                    return;
                }
                if (this.isValidPosition(_arg_1, _local_7))
                {
                    _arg_3.x = _arg_1;
                    _arg_3.y = _local_7;
                    return;
                }
            }
            _arg_3.x = _local_6;
            _arg_3.y = _local_7;
        }

        private function resetMoveVector(_arg_1:Boolean):void
        {
            moveVec_.scaleBy(-0.5);
            if (_arg_1)
            {
                moveVec_.y = (moveVec_.y * -1);
            }
            else
            {
                moveVec_.x = (moveVec_.x * -1);
            }
        }

        public function isValidPosition(_arg_1:Number, _arg_2:Number):Boolean
        {
            var _local_3:Square = map_.getSquare(_arg_1, _arg_2);
            if (((!(square_ == _local_3)) && ((_local_3 == null) || (!(_local_3.isWalkable())))))
            {
                return (false);
            }
            var _local_4:Number = (_arg_1 - int(_arg_1));
            var _local_5:Number = (_arg_2 - int(_arg_2));
            if (_local_4 < 0.5)
            {
                if (this.isFullOccupy((_arg_1 - 1), _arg_2))
                {
                    return (false);
                }
                if (_local_5 < 0.5)
                {
                    if (((this.isFullOccupy(_arg_1, (_arg_2 - 1))) || (this.isFullOccupy((_arg_1 - 1), (_arg_2 - 1)))))
                    {
                        return (false);
                    }
                }
                else
                {
                    if (_local_5 > 0.5)
                    {
                        if (((this.isFullOccupy(_arg_1, (_arg_2 + 1))) || (this.isFullOccupy((_arg_1 - 1), (_arg_2 + 1)))))
                        {
                            return (false);
                        }
                    }
                }
            }
            else
            {
                if (_local_4 > 0.5)
                {
                    if (this.isFullOccupy((_arg_1 + 1), _arg_2))
                    {
                        return (false);
                    }
                    if (_local_5 < 0.5)
                    {
                        if (((this.isFullOccupy(_arg_1, (_arg_2 - 1))) || (this.isFullOccupy((_arg_1 + 1), (_arg_2 - 1)))))
                        {
                            return (false);
                        }
                    }
                    else
                    {
                        if (_local_5 > 0.5)
                        {
                            if (((this.isFullOccupy(_arg_1, (_arg_2 + 1))) || (this.isFullOccupy((_arg_1 + 1), (_arg_2 + 1)))))
                            {
                                return (false);
                            }
                        }
                    }
                }
                else
                {
                    if (_local_5 < 0.5)
                    {
                        if (this.isFullOccupy(_arg_1, (_arg_2 - 1)))
                        {
                            return (false);
                        }
                    }
                    else
                    {
                        if (_local_5 > 0.5)
                        {
                            if (this.isFullOccupy(_arg_1, (_arg_2 + 1)))
                            {
                                return (false);
                            }
                        }
                    }
                }
            }
            return (true);
        }

        public function isFullOccupy(_arg_1:Number, _arg_2:Number):Boolean
        {
            var _local_3:Square = map_.lookupSquare(_arg_1, _arg_2);
            return (((_local_3 == null) || (_local_3.tileType_ == 0xFF)) || ((!(_local_3.obj_ == null)) && (_local_3.obj_.props_.fullOccupy_)));
        }

        override public function update(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Vector3D;
            var _local_7:Number;
            var _local_8:int;
            var _local_9:Vector.<uint>;
            if (((this.tierBoost) && (!(this.isNotInCombatMapArea))))
            {
                if (!isPaused())
                {
                    this.tierBoost = (this.tierBoost - _arg_2);
                    if (this.tierBoost < 0)
                    {
                        this.tierBoost = 0;
                    }
                }
            }
            if (((this.dropBoost) && (!(this.isNotInCombatMapArea))))
            {
                if (!isPaused())
                {
                    this.dropBoost = (this.dropBoost - _arg_2);
                    if (this.dropBoost < 0)
                    {
                        this.dropBoost = 0;
                    }
                }
            }
            if (((this.xpTimer) && (!(isPaused()))))
            {
                this.xpTimer = (this.xpTimer - _arg_2);
                if (this.xpTimer < 0)
                {
                    this.xpTimer = 0;
                }
            }
            if (((isHealing()) && (!(isPaused()))))
            {
                if (((!(Parameters.data_.noParticlesMaster)) && (this.healingEffect_ == null)))
                {
                    this.healingEffect_ = new HealingEffect(this);
                    map_.addObj(this.healingEffect_, x_, y_);
                }
            }
            else
            {
                if (this.healingEffect_ != null)
                {
                    map_.removeObj(this.healingEffect_.objectId_);
                    this.healingEffect_ = null;
                }
            }
            if (((map_.player_ == this) && (isPaused())))
            {
                return (true);
            }
            if (this.relMoveVec_ != null)
            {
                _local_3 = Parameters.data_.cameraAngle;
                if (this.rotate_ != 0)
                {
                    _local_3 = (_local_3 + ((_arg_2 * Parameters.PLAYER_ROTATE_SPEED) * this.rotate_));
                    Parameters.data_.cameraAngle = _local_3;
                }
                if (((!(this.relMoveVec_.x == 0)) || (!(this.relMoveVec_.y == 0))))
                {
                    _local_4 = this.getMoveSpeed();
                    _local_5 = Math.atan2(this.relMoveVec_.y, this.relMoveVec_.x);
                    if (square_.props_.slideAmount_ > 0)
                    {
                        _local_6 = new Vector3D();
                        _local_6.x = (_local_4 * Math.cos((_local_3 + _local_5)));
                        _local_6.y = (_local_4 * Math.sin((_local_3 + _local_5)));
                        _local_6.z = 0;
                        _local_7 = _local_6.length;
                        _local_6.scaleBy((-1 * (square_.props_.slideAmount_ - 1)));
                        moveVec_.scaleBy(square_.props_.slideAmount_);
                        if (moveVec_.length < _local_7)
                        {
                            moveVec_ = moveVec_.add(_local_6);
                        }
                    }
                    else
                    {
                        moveVec_.x = (_local_4 * Math.cos((_local_3 + _local_5)));
                        moveVec_.y = (_local_4 * Math.sin((_local_3 + _local_5)));
                    }
                }
                else
                {
                    if (((moveVec_.length > 0.00012) && (square_.props_.slideAmount_ > 0)))
                    {
                        moveVec_.scaleBy(square_.props_.slideAmount_);
                    }
                    else
                    {
                        moveVec_.x = 0;
                        moveVec_.y = 0;
                    }
                }
                if (((!(square_ == null)) && (square_.props_.push_)))
                {
                    moveVec_.x = (moveVec_.x - (square_.props_.animate_.dx_ / 1000));
                    moveVec_.y = (moveVec_.y - (square_.props_.animate_.dy_ / 1000));
                }
                this.walkTo((x_ + (_arg_2 * moveVec_.x)), (y_ + (_arg_2 * moveVec_.y)));
            }
            else
            {
                if (!super.update(_arg_1, _arg_2))
                {
                    return (false);
                }
            }
            if ((((((map_.player_ == this) && (square_.props_.maxDamage_ > 0)) && ((square_.lastDamage_ + 500) < _arg_1)) && (!(isInvincible()))) && ((square_.obj_ == null) || (!(square_.obj_.props_.protectFromGroundDamage_)))))
            {
                _local_8 = map_.gs_.gsc_.getNextDamage(square_.props_.minDamage_, square_.props_.maxDamage_);
                _local_9 = new Vector.<uint>();
                _local_9.push(ConditionEffect.GROUND_DAMAGE);
                damage(true, _local_8, _local_9, (hp_ <= _local_8), null);
                map_.gs_.gsc_.groundDamage(_arg_1, x_, y_);
                square_.lastDamage_ = _arg_1;
            }
            return (true);
        }

        public function onMove():void
        {
            if (map_ == null)
            {
                return;
            }
            var _local_1:Square = map_.getSquare(x_, y_);
            if (_local_1.props_.sinking_)
            {
                sinkLevel_ = Math.min((sinkLevel_ + 1), Parameters.MAX_SINK_LEVEL);
                this.moveMultiplier_ = (0.1 + ((1 - (sinkLevel_ / Parameters.MAX_SINK_LEVEL)) * (_local_1.props_.speed_ - 0.1)));
            }
            else
            {
                sinkLevel_ = 0;
                this.moveMultiplier_ = _local_1.props_.speed_;
            }
        }

        override protected function makeNameBitmapData():BitmapData
        {
            var _local_1:StringBuilder = new StaticStringBuilder(name_);
            var _local_2:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
            var _local_3:BitmapData = _local_2.make(_local_1, 16, this.getNameColor(), true, NAME_OFFSET_MATRIX, true);
            _local_3.draw(FameUtil.numStarsToIcon(this.numStars_, this.starsBg_), RANK_STAR_BG_OFFSET_MATRIX);
            return (_local_3);
        }

        private function getNameColor():uint
        {
            return (PlayerUtil.getPlayerNameColor(this));
        }

        protected function drawBreathBar(_arg_1:Vector.<IGraphicsData>, _arg_2:int):void
        {
            var _local_8:Number;
            var _local_9:Number;
            if (this.breathPath_ == null)
            {
                this.breathBackFill_ = new GraphicsSolidFill();
                this.breathBackPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
                this.breathFill_ = new GraphicsSolidFill(2542335);
                this.breathPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
            }
            if (this.breath_ <= Parameters.BREATH_THRESH)
            {
                _local_8 = ((Parameters.BREATH_THRESH - this.breath_) / Parameters.BREATH_THRESH);
                this.breathBackFill_.color = MoreColorUtil.lerpColor(0x111111, 0xFF0000, (Math.abs(Math.sin((_arg_2 / 300))) * _local_8));
            }
            else
            {
                this.breathBackFill_.color = 0x111111;
            }
            var _local_3:int = 20;
            var _local_4:int = 12;
            var _local_5:int = 5;
            var _local_6:Vector.<Number> = (this.breathBackPath_.data as Vector.<Number>);
            _local_6.length = 0;
            var _local_7:Number = 1.2;
            _local_6.push(((posS_[0] - _local_3) - _local_7), (posS_[1] + _local_4), ((posS_[0] + _local_3) + _local_7), (posS_[1] + _local_4), ((posS_[0] + _local_3) + _local_7), (((posS_[1] + _local_4) + _local_5) + _local_7), ((posS_[0] - _local_3) - _local_7), (((posS_[1] + _local_4) + _local_5) + _local_7));
            _arg_1.push(this.breathBackFill_);
            _arg_1.push(this.breathBackPath_);
            _arg_1.push(GraphicsUtil.END_FILL);
            if (this.breath_ > 0)
            {
                _local_9 = (((this.breath_ / 100) * 2) * _local_3);
                this.breathPath_.data.length = 0;
                _local_6 = (this.breathPath_.data as Vector.<Number>);
                _local_6.length = 0;
                _local_6.push((posS_[0] - _local_3), (posS_[1] + _local_4), ((posS_[0] - _local_3) + _local_9), (posS_[1] + _local_4), ((posS_[0] - _local_3) + _local_9), ((posS_[1] + _local_4) + _local_5), (posS_[0] - _local_3), ((posS_[1] + _local_4) + _local_5));
                _arg_1.push(this.breathFill_);
                _arg_1.push(this.breathPath_);
                _arg_1.push(GraphicsUtil.END_FILL);
            }
            GraphicsFillExtra.setSoftwareDrawSolid(this.breathFill_, true);
            GraphicsFillExtra.setSoftwareDrawSolid(this.breathBackFill_, true);
        }

        override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
        {
            super.draw(_arg_1, _arg_2, _arg_3);
            if (this != map_.player_)
            {
                if (!Parameters.screenShotMode_)
                {
                    drawName(_arg_1, _arg_2);
                }
            }
            else
            {
                if (this.breath_ >= 0)
                {
                    this.drawBreathBar(_arg_1, _arg_3);
                }
            }
        }

        private function getMoveSpeed():Number
        {
            if (isSlowed())
            {
                return (MIN_MOVE_SPEED * this.moveMultiplier_);
            }
            var _local_1:Number = (MIN_MOVE_SPEED + ((this.speed_ / 75) * (MAX_MOVE_SPEED - MIN_MOVE_SPEED)));
            if (((isSpeedy()) || (isNinjaSpeedy())))
            {
                _local_1 = (_local_1 * 1.5);
            }
            return (_local_1 * this.moveMultiplier_);
        }

        public function attackFrequency():Number
        {
            if (isDazed())
            {
                return (MIN_ATTACK_FREQ);
            }
            var _local_1:Number = (MIN_ATTACK_FREQ + ((this.dexterity_ / 75) * (MAX_ATTACK_FREQ - MIN_ATTACK_FREQ)));
            if (isBerserk())
            {
                _local_1 = (_local_1 * 1.5);
            }
            return (_local_1);
        }

        private function attackMultiplier():Number
        {
            if (isWeak())
            {
                return (MIN_ATTACK_MULT);
            }
            var _local_1:Number = (MIN_ATTACK_MULT + ((this.attack_ / 75) * (MAX_ATTACK_MULT - MIN_ATTACK_MULT)));
            if (isDamaging())
            {
                _local_1 = (_local_1 * 1.5);
            }
            return (_local_1);
        }

        private function makeSkinTexture():void
        {
            var _local_1:MaskedImage = this.skin.imageFromAngle(0, AnimatedChar.STAND, 0);
            animatedChar_ = this.skin;
            texture_ = _local_1.image_;
            mask_ = _local_1.mask_;
            this.isDefaultAnimatedChar = true;
        }

        private function setToRandomAnimatedCharacter():void
        {
            var _local_1:Vector.<XML> = ObjectLibrary.hexTransforms_;
            var _local_2:uint = uint(Math.floor((Math.random() * _local_1.length)));
            var _local_3:int = int(_local_1[_local_2].@type);
            var _local_4:TextureData = ObjectLibrary.typeToTextureData_[_local_3];
            texture_ = _local_4.texture_;
            mask_ = _local_4.mask_;
            animatedChar_ = _local_4.animatedChar_;
            this.isDefaultAnimatedChar = false;
        }

        override protected function getTexture(_arg_1:Camera, _arg_2:int):BitmapData
        {
            var _local_5:MaskedImage;
            var _local_10:int;
            var _local_11:Dictionary;
            var _local_12:Number;
            var _local_13:int;
            var _local_14:ColorTransform;
            var _local_3:Number = 0;
            var _local_4:int = AnimatedChar.STAND;
            if (((this.isShooting) || (_arg_2 < (attackStart_ + this.attackPeriod_))))
            {
                facing_ = attackAngle_;
                _local_3 = (((_arg_2 - attackStart_) % this.attackPeriod_) / this.attackPeriod_);
                _local_4 = AnimatedChar.ATTACK;
            }
            else
            {
                if (((!(moveVec_.x == 0)) || (!(moveVec_.y == 0))))
                {
                    _local_10 = int((3.5 / this.getMoveSpeed()));
                    if (((!(moveVec_.y == 0)) || (!(moveVec_.x == 0))))
                    {
                        facing_ = Math.atan2(moveVec_.y, moveVec_.x);
                    }
                    _local_3 = ((_arg_2 % _local_10) / _local_10);
                    _local_4 = AnimatedChar.WALK;
                }
            }
            if (this.isHexed())
            {
                ((this.isDefaultAnimatedChar) && (this.setToRandomAnimatedCharacter()));
            }
            else
            {
                if (!this.isDefaultAnimatedChar)
                {
                    this.makeSkinTexture();
                }
            }
            if (_arg_1.isHallucinating_)
            {
                _local_5 = new MaskedImage(getHallucinatingTexture(), null);
            }
            else
            {
                _local_5 = animatedChar_.imageFromFacing(facing_, _arg_1, _local_4, _local_3);
            }
            var _local_6:int = tex1Id_;
            var _local_7:int = tex2Id_;
            var _local_8:BitmapData;
            if (this.nearestMerchant_)
            {
                _local_11 = texturingCache_[this.nearestMerchant_];
                if (_local_11 == null)
                {
                    texturingCache_[this.nearestMerchant_] = new Dictionary();
                }
                else
                {
                    _local_8 = _local_11[_local_5];
                }
                _local_6 = this.nearestMerchant_.getTex1Id(tex1Id_);
                _local_7 = this.nearestMerchant_.getTex2Id(tex2Id_);
            }
            else
            {
                _local_8 = texturingCache_[_local_5];
            }
            if (_local_8 == null)
            {
                _local_8 = TextureRedrawer.resize(_local_5.image_, _local_5.mask_, size_, false, _local_6, _local_7);
                if (this.nearestMerchant_ != null)
                {
                    texturingCache_[this.nearestMerchant_][_local_5] = _local_8;
                }
                else
                {
                    texturingCache_[_local_5] = _local_8;
                }
            }
            if (hp_ < (maxHP_ * 0.2))
            {
                _local_12 = (int((Math.abs(Math.sin((_arg_2 / 200))) * 10)) / 10);
                _local_13 = 128;
                _local_14 = new ColorTransform(1, 1, 1, 1, (_local_12 * _local_13), (-(_local_12) * _local_13), (-(_local_12) * _local_13));
                _local_8 = CachingColorTransformer.transformBitmapData(_local_8, _local_14);
            }
            var _local_9:BitmapData = texturingCache_[_local_8];
            if (_local_9 == null)
            {
                if (this.hasSupporterFeature(SupporterFeatures.GLOW))
                {
                    _local_9 = GlowRedrawer.outlineGlow(_local_8, SupporterCampaignModel.SUPPORT_COLOR, 1.4, false, 0, true);
                }
                else
                {
                    _local_9 = GlowRedrawer.outlineGlow(_local_8, ((this.legendaryRank_ == -1) ? 0 : 0xFF0000));
                }
                texturingCache_[_local_8] = _local_9;
            }
            if ((((isPaused()) || (isStasis())) || (isPetrified())))
            {
                _local_9 = CachingColorTransformer.filterBitmapData(_local_9, PAUSED_FILTER);
            }
            else
            {
                if (isInvisible())
                {
                    _local_9 = CachingColorTransformer.alphaBitmapData(_local_9, 0.4);
                }
            }
            return (_local_9);
        }

        override public function getPortrait():BitmapData
        {
            var _local_1:MaskedImage;
            var _local_2:int;
            if (portrait_ == null)
            {
                _local_1 = animatedChar_.imageFromDir(AnimatedChar.RIGHT, AnimatedChar.STAND, 0);
                _local_2 = int(((4 / _local_1.image_.width) * 100));
                portrait_ = TextureRedrawer.resize(_local_1.image_, _local_1.mask_, _local_2, true, tex1Id_, tex2Id_);
                portrait_ = GlowRedrawer.outlineGlow(portrait_, 0);
            }
            return (portrait_);
        }

        public function getFamePortrait(_arg_1:int):BitmapData
        {
            var _local_2:MaskedImage;
            var _local_3:int;
            if (this.famePortrait_ == null)
            {
                _local_2 = animatedChar_.imageFromDir(AnimatedChar.RIGHT, AnimatedChar.STAND, 0);
                _local_3 = int(((4 / _local_2.image_.width) * _arg_1));
                this.famePortrait_ = TextureRedrawer.resize(_local_2.image_, _local_2.mask_, _local_3, true, tex1Id_, tex2Id_);
                this.famePortrait_ = GlowRedrawer.outlineGlow(this.famePortrait_, 0);
            }
            return (this.famePortrait_);
        }

        public function useAltWeapon(_arg_1:Number, _arg_2:Number, _arg_3:int):Boolean
        {
            var _local_7:Point;
            var _local_12:int;
            var _local_13:XML;
            var _local_14:String;
            var _local_15:Number;
            var _local_16:Point;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:Point;
            var _local_20:ProjectileProperties;
            var _local_21:Number;
            var _local_22:Number;
            var _local_23:Point;
            var _local_24:Number;
            var _local_25:int;
            if (((map_ == null) || (isPaused())))
            {
                return (false);
            }
            var _local_4:int = equipment_[1];
            if (_local_4 == -1)
            {
                return (false);
            }
            var _local_5:XML = ObjectLibrary.xmlLibrary_[_local_4];
            if (((_local_5 == null) || (!(_local_5.hasOwnProperty("Usable")))))
            {
                return (false);
            }
            if (isSilenced())
            {
                SoundEffectLibrary.play("error");
                return (false);
            }
            var _local_6:Number = (Parameters.data_.cameraAngle + Math.atan2(_arg_2, _arg_1));
            var _local_8:Boolean;
            var _local_9:Boolean;
            var _local_10:Boolean;
            if (_arg_3 == UseType.START_USE)
            {
                for each (_local_13 in _local_5.Activate)
                {
                    _local_14 = _local_13.toString();
                    if (_local_14 == ActivationType.TELEPORT_LIMIT)
                    {
                        _local_15 = Number(_local_13.@maxDistance);
                        _local_16 = new Point((x_ + (_local_15 * Math.cos(_local_6))), (y_ + (_local_15 * Math.sin(_local_6))));
                        if (!this.isValidPosition(_local_16.x, _local_16.y))
                        {
                            SoundEffectLibrary.play("error");
                            return (false);
                        }
                    }
                    if (((_local_14 == ActivationType.TELEPORT) || (_local_14 == ActivationType.OBJECT_TOSS)))
                    {
                        _local_8 = true;
                        _local_10 = true;
                    }
                    if (((((((_local_14 == ActivationType.BULLET_NOVA) || (_local_14 == ActivationType.POISON_GRENADE)) || (_local_14 == ActivationType.VAMPIRE_BLAST)) || (_local_14 == ActivationType.TRAP)) || (_local_14 == ActivationType.BOOST_RANGE)) || (_local_14 == ActivationType.STASIS_BLAST)))
                    {
                        _local_8 = true;
                    }
                    if (_local_14 == ActivationType.SHOOT)
                    {
                        _local_9 = true;
                    }
                    if (_local_14 == ActivationType.BULLET_CREATE)
                    {
                        _local_17 = (Math.sqrt(((_arg_1 * _arg_1) + (_arg_2 * _arg_2))) / 50);
                        _local_18 = Math.max(this.getAttribute(_local_13, "minDistance", 0), Math.min(this.getAttribute(_local_13, "maxDistance", 4.4), _local_17));
                        _local_19 = new Point((x_ + (_local_18 * Math.cos(_local_6))), (y_ + (_local_18 * Math.sin(_local_6))));
                        _local_20 = ObjectLibrary.propsLibrary_[_local_4].projectiles_[0];
                        _local_21 = ((_local_20.speed_ * _local_20.lifetime_) / 20000);
                        _local_22 = (_local_6 + (this.getAttribute(_local_13, "offsetAngle", 90) * MathUtil.TO_RAD));
                        _local_23 = new Point((_local_19.x + (_local_21 * Math.cos((_local_22 + Math.PI)))), (_local_19.y + (_local_21 * Math.sin((_local_22 + Math.PI)))));
                        if (this.isFullOccupy((_local_23.x + 0.5), (_local_23.y + 0.5)))
                        {
                            SoundEffectLibrary.play("error");
                            return (false);
                        }
                    }
                }
            }
            if (_local_8)
            {
                _local_7 = map_.pSTopW(_arg_1, _arg_2);
                if (((_local_7 == null) || ((_local_10) && (!(this.isValidPosition(_local_7.x, _local_7.y))))))
                {
                    SoundEffectLibrary.play("error");
                    return (false);
                }
            }
            else
            {
                _local_24 = (Math.sqrt(((_arg_1 * _arg_1) + (_arg_2 * _arg_2))) / 50);
                _local_7 = new Point((x_ + (_local_24 * Math.cos(_local_6))), (y_ + (_local_24 * Math.sin(_local_6))));
            }
            var _local_11:int = getTimer();
            if (_arg_3 == UseType.START_USE)
            {
                if (_local_11 < this.nextAltAttack_)
                {
                    SoundEffectLibrary.play("error");
                    return (false);
                }
                _local_12 = int(_local_5.MpCost);
                if (_local_12 > this.mp_)
                {
                    SoundEffectLibrary.play("no_mana");
                    return (false);
                }
                _local_25 = 500;
                if (_local_5.hasOwnProperty("Cooldown"))
                {
                    _local_25 = (Number(_local_5.Cooldown) * 1000);
                }
                this.nextAltAttack_ = (_local_11 + _local_25);
                this.mpZeroed_ = false;
                map_.gs_.gsc_.useItem(_local_11, objectId_, 1, _local_4, _local_7.x, _local_7.y, _arg_3);
                if (_local_9)
                {
                    this.doShoot(_local_11, _local_4, _local_5, _local_6, false, false);
                }
            }
            else
            {
                if (_local_5.hasOwnProperty("MultiPhase"))
                {
                    map_.gs_.gsc_.useItem(_local_11, objectId_, 1, _local_4, _local_7.x, _local_7.y, _arg_3);
                    _local_12 = int(_local_5.MpEndCost);
                    if (((((_local_12 <= this.mp_) && (!(this.mpZeroed_))) && (!(map_.isPetYard))) && (!(map_.isQuestRoom))))
                    {
                        this.doShoot(_local_11, _local_4, _local_5, _local_6, false, false);
                    }
                }
            }
            return (true);
        }

        public function getAttribute(_arg_1:XML, _arg_2:String, _arg_3:Number=0):Number
        {
            return ((_arg_1.hasOwnProperty(("@" + _arg_2))) ? Number(_arg_1.@[_arg_2]) : _arg_3);
        }

        public function attemptAttackAngle(_arg_1:Number):void
        {
            this.shoot((Parameters.data_.cameraAngle + _arg_1));
        }

        override public function setAttack(_arg_1:int, _arg_2:Number):void
        {
            var _local_3:XML = ObjectLibrary.xmlLibrary_[_arg_1];
            if (((_local_3 == null) || (!(_local_3.hasOwnProperty("RateOfFire")))))
            {
                return;
            }
            var _local_4:Number = Number(_local_3.RateOfFire);
            this.attackPeriod_ = ((1 / this.attackFrequency()) * (1 / _local_4));
            super.setAttack(_arg_1, _arg_2);
        }

        private function shoot(_arg_1:Number):void
        {
            if (((((map_ == null) || (isStunned())) || (isPaused())) || (isPetrified())))
            {
                return;
            }
            var _local_2:int = equipment_[0];
            if (_local_2 == -1)
            {
                this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, TextKey.PLAYER_NO_WEAPON_EQUIPPED));
                return;
            }
            var _local_3:XML = ObjectLibrary.xmlLibrary_[_local_2];
            var _local_4:int = getTimer();
            var _local_5:Number = Number(_local_3.RateOfFire);
            this.attackPeriod_ = ((1 / this.attackFrequency()) * (1 / _local_5));
            if (_local_4 < (attackStart_ + this.attackPeriod_))
            {
                return;
            }
            doneAction(map_.gs_, Tutorial.ATTACK_ACTION);
            attackAngle_ = _arg_1;
            attackStart_ = _local_4;
            this.doShoot(attackStart_, _local_2, _local_3, attackAngle_, true, true);
        }

        private function doShoot(_arg_1:int, _arg_2:int, _arg_3:XML, _arg_4:Number, _arg_5:Boolean, _arg_6:Boolean):void
        {
            var _local_14:uint;
            var _local_15:Projectile;
            var _local_16:int;
            var _local_17:int;
            var _local_18:Number;
            var _local_19:int;
            var _local_7:int = ((_arg_3.hasOwnProperty("NumProjectiles")) ? int(_arg_3.NumProjectiles) : 1);
            var _local_8:Number = (((_arg_3.hasOwnProperty("ArcGap")) ? Number(_arg_3.ArcGap) : 11.25) * Trig.toRadians);
            var _local_9:Number = (_local_8 * (_local_7 - 1));
            var _local_10:Number = (_arg_4 - (_local_9 / 2));
            var _local_11:Number = ((_arg_6) ? this.projectileLifeMul_ : 1);
            var _local_12:Number = ((_arg_6) ? this.projectileSpeedMult_ : 1);
            this.isShooting = _arg_5;
            var _local_13:int;
            while (_local_13 < _local_7)
            {
                _local_14 = getBulletId();
                _local_15 = (FreeList.newObject(Projectile) as Projectile);
                if (((_arg_5) && (!(this.projectileIdSetOverrideNew == ""))))
                {
                    _local_15.reset(_arg_2, 0, objectId_, _local_14, _local_10, _arg_1, this.projectileIdSetOverrideNew, this.projectileIdSetOverrideOld, _local_11, _local_12);
                }
                else
                {
                    _local_15.reset(_arg_2, 0, objectId_, _local_14, _local_10, _arg_1, "", "", _local_11, _local_12);
                }
                _local_16 = int(_local_15.projProps_.minDamage_);
                _local_17 = int(_local_15.projProps_.maxDamage_);
                _local_18 = ((_arg_5) ? this.attackMultiplier() : 1);
                _local_19 = (map_.gs_.gsc_.getNextDamage(_local_16, _local_17) * _local_18);
                if (_arg_1 > (map_.gs_.moveRecords_.lastClearTime_ + 600))
                {
                    _local_19 = 0;
                }
                _local_15.setDamage(_local_19);
                if (((_local_13 == 0) && (!(_local_15.sound_ == null))))
                {
                    SoundEffectLibrary.play(_local_15.sound_, 0.75, false);
                }
                map_.addObj(_local_15, (x_ + (Math.cos(_arg_4) * 0.3)), (y_ + (Math.sin(_arg_4) * 0.3)));
                map_.gs_.gsc_.playerShoot(_arg_1, _local_15);
                _local_10 = (_local_10 + _local_8);
                _local_13++;
            }
        }

        public function isHexed():Boolean
        {
            return (!((condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.HEXED_BIT) == 0));
        }

        public function isInventoryFull():Boolean
        {
            if (equipment_ == null)
            {
                return (false);
            }
            var _local_1:int = equipment_.length;
            var _local_2:uint = 4;
            while (_local_2 < _local_1)
            {
                if (equipment_[_local_2] <= 0)
                {
                    return (false);
                }
                _local_2++;
            }
            return (true);
        }

        public function nextAvailableInventorySlot():int
        {
            var _local_1:int = ((this.hasBackpack_) ? equipment_.length : (equipment_.length - GeneralConstants.NUM_INVENTORY_SLOTS));
            var _local_2:uint = 4;
            while (_local_2 < _local_1)
            {
                if (equipment_[_local_2] <= 0)
                {
                    return (_local_2);
                }
                _local_2++;
            }
            return (-1);
        }

        public function numberOfAvailableSlots():int
        {
            var _local_1:int = ((this.hasBackpack_) ? equipment_.length : (equipment_.length - GeneralConstants.NUM_INVENTORY_SLOTS));
            var _local_2:int;
            var _local_3:uint = 4;
            while (_local_3 < _local_1)
            {
                if (equipment_[_local_3] <= 0)
                {
                    _local_2++;
                }
                _local_3++;
            }
            return (_local_2);
        }

        public function swapInventoryIndex(_arg_1:String):int
        {
            var _local_2:int;
            var _local_3:int;
            if (!this.hasBackpack_)
            {
                return (-1);
            }
            if (_arg_1 == TabStripModel.BACKPACK)
            {
                _local_2 = GeneralConstants.NUM_EQUIPMENT_SLOTS;
                _local_3 = (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS);
            }
            else
            {
                _local_2 = (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS);
                _local_3 = equipment_.length;
            }
            var _local_4:uint = _local_2;
            while (_local_4 < _local_3)
            {
                if (equipment_[_local_4] <= 0)
                {
                    return (_local_4);
                }
                _local_4++;
            }
            return (-1);
        }

        public function getPotionCount(_arg_1:int):int
        {
            switch (_arg_1)
            {
                case PotionInventoryModel.HEALTH_POTION_ID:
                    return (this.healthPotionCount_);
                case PotionInventoryModel.MAGIC_POTION_ID:
                    return (this.magicPotionCount_);
            }
            return (0);
        }

        public function getTex1():int
        {
            return (tex1Id_);
        }

        public function getTex2():int
        {
            return (tex2Id_);
        }


    }
}//package com.company.assembleegameclient.objects

