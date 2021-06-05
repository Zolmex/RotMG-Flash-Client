// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.lib.tasks.TaskResultSignal

package kabam.lib.tasks
{
    import org.osflash.signals.Signal;

    public class TaskResultSignal extends Signal 
    {

        public function TaskResultSignal()
        {
            super(BaseTask, Boolean, String);
        }

    }
}//package kabam.lib.tasks

