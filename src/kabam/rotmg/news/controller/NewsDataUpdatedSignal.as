// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.news.controller.NewsDataUpdatedSignal

package kabam.rotmg.news.controller
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.news.model.NewsCellVO;
    import __AS3__.vec.*;

    public class NewsDataUpdatedSignal extends Signal 
    {

        public function NewsDataUpdatedSignal()
        {
            super(Vector.<NewsCellVO>);
        }

    }
}//package kabam.rotmg.news.controller

