﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.util.MoreDateUtil

package com.company.util
{
    public class MoreDateUtil 
    {


        public static function getDayStringInPT():String
        {
            var _local_1:Date = new Date();
            var _local_2:Number = _local_1.getTime();
            _local_2 = (_local_2 + (((_local_1.timezoneOffset - 420) * 60) * 1000));
            _local_1.setTime(_local_2);
            var _local_3:DateFormatterReplacement = new DateFormatterReplacement();
            _local_3.formatString = "MMMM D, YYYY";
            return (_local_3.format(_local_1));
        }


    }
}//package com.company.util

