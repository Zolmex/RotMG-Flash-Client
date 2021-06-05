// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.text.view.BaseSimpleTextMediator

package kabam.rotmg.text.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.ui.BaseSimpleText;
    import kabam.rotmg.text.model.FontModel;

    public class BaseSimpleTextMediator extends Mediator 
    {

        [Inject]
        public var view:BaseSimpleText;
        [Inject]
        public var model:FontModel;


        override public function initialize():void
        {
            var _local_1:String = this.model.getFont().getName();
            this.view.setFont(_local_1);
        }


    }
}//package kabam.rotmg.text.view

