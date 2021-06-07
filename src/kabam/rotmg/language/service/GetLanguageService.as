﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.language.service.GetLanguageService

package kabam.rotmg.language.service
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.language.model.LanguageModel;
    import kabam.rotmg.language.model.StringMap;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
    import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

    public class GetLanguageService extends BaseTask 
    {

        private static const LANGUAGE:String = "LANGUAGE";

        [Inject]
        public var model:LanguageModel;
        [Inject]
        public var strings:StringMap;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var client:AppEngineClient;
        private var language:String;


        override protected function startTask():void
        {
            this.language = this.model.getLanguageFamily();
            this.client.complete.addOnce(this.onComplete);
            this.client.setMaxRetries(3);
            this.client.sendRequest("/app/getLanguageStrings", {"languageType":this.language});
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (_arg_1)
            {
                this.onLanguageResponse(_arg_2);
            }
            else
            {
                this.onLanguageError();
            }
            completeTask(_arg_1, _arg_2);
        }

        private function onLanguageResponse(_arg_1:String):void
        {
            this.strings.clear();
            var _local_2:Object = JSON.parse(_arg_1);
            for each (var _local_3:Array in _local_2)
            {
                this.strings.setValue(_local_3[0], _local_3[1], _local_3[2]);
            }
            PetRarityEnum.parseNames();
        }

        private function onLanguageError():void
        {
            this.strings.setValue("ok", "ok", this.model.getLanguageFamily());
            var _local_1:ErrorDialog = new ErrorDialog((("Unable to load language [" + this.language) + "]"));
            this.openDialog.dispatch(_local_1);
            completeTask(false);
        }


    }
}//package kabam.rotmg.language.service

