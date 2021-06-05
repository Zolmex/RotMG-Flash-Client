﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.account.kongregate.services.KongregateSharedObject

package kabam.rotmg.account.kongregate.services
{
    import flash.net.SharedObject;
    import com.company.assembleegameclient.util.GUID;

    public class KongregateSharedObject 
    {

        private var guid:String;


        public function getGuestGUID():String
        {
            return (this.guid = ((this.guid) || (this.makeGuestGUID())));
        }

        private function makeGuestGUID():String
        {
            var _local_1:String;
            var _local_2:SharedObject;
            try
            {
                _local_2 = SharedObject.getLocal("KongregateRotMG", "/");
                if (_local_2.data.hasOwnProperty("GuestGUID"))
                {
                    _local_1 = _local_2.data["GuestGUID"];
                }
            }
            catch(error:Error)
            {
            }
            if (_local_1 == null)
            {
                _local_1 = GUID.create();
                try
                {
                    _local_2 = SharedObject.getLocal("KongregateRotMG", "/");
                    _local_2.data["GuestGUID"] = _local_1;
                    _local_2.flush();
                }
                catch(error:Error)
                {
                }
            }
            return (_local_1);
        }


    }
}//package kabam.rotmg.account.kongregate.services

