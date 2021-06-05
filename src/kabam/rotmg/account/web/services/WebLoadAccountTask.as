﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.web.services.WebLoadAccountTask

package kabam.rotmg.account.web.services
{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.services.LoadAccountTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.web.model.AccountData;
    import flash.net.SharedObject;
    import com.company.assembleegameclient.util.GUID;

    public class WebLoadAccountTask extends BaseTask implements LoadAccountTask 
    {

        [Inject]
        public var account:Account;
        [Inject]
        public var client:AppEngineClient;
        private var data:AccountData;


        override protected function startTask():void
        {
            this.getAccountData();
            if (this.data.username)
            {
                this.setAccountDataThenComplete();
            }
            else
            {
                this.setGuestPasswordAndComplete();
            };
        }

        private function getAccountData():void
        {
            var rotmg:SharedObject;
            this.data = new AccountData();
            try
            {
                rotmg = SharedObject.getLocal("RotMG", "/");
                ((rotmg.data["GUID"]) && (this.data.username = rotmg.data["GUID"]));
                ((rotmg.data["Password"]) && (this.data.password = rotmg.data["Password"]));
                ((rotmg.data["Token"]) && (this.data.token = rotmg.data["Token"]));
                if (rotmg.data.hasOwnProperty("Name"))
                {
                    this.data.name = rotmg.data["Name"];
                };
            }
            catch(error:Error)
            {
                data.username = null;
                data.password = null;
            };
        }

        private function setAccountDataThenComplete():void
        {
            this.account.updateUser(this.data.username, this.data.password, this.data.token);
            this.account.verify(false);
            completeTask(true);
        }

        private function setGuestPasswordAndComplete():void
        {
            this.account.updateUser(GUID.create(), null, "");
            completeTask(true);
        }


    }
}//package kabam.rotmg.account.web.services

