// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.particles.HealParticle

package com.company.assembleegameclient.objects.particles
{
    import com.company.assembleegameclient.objects.GameObject;
    import flash.geom.Vector3D;
    import com.company.util.MoreColorUtil;

    public class HealParticle extends Particle 
    {

        public var duration_:int;
        private var percentDone:Number;
        private var currentLife:int;
        public var go_:GameObject;
        public var angle_:Number;
        public var dist_:Number;
        protected var moveVec_:Vector3D = new Vector3D();
        public var color1_:uint;
        public var color2_:uint;

        public function HealParticle(_arg_1:uint, _arg_2:Number, _arg_3:int, _arg_4:int, _arg_5:Number, _arg_6:GameObject, _arg_7:Number, _arg_8:Number, _arg_9:uint)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.color1_ = _arg_1;
            this.color2_ = _arg_9;
            this.moveVec_.z = _arg_5;
            this.duration_ = _arg_4;
            this.go_ = _arg_6;
            this.angle_ = _arg_7;
            this.dist_ = _arg_8;
        }

        override public function update(_arg_1:int, _arg_2:int):Boolean
        {
            this.percentDone = (this.currentLife / this.duration_);
            setColor(MoreColorUtil.lerpColor(this.color2_, this.color1_, this.percentDone));
            x_ = (this.go_.x_ + (this.dist_ * Math.cos(this.angle_)));
            y_ = (this.go_.y_ + (this.dist_ * Math.sin(this.angle_)));
            z_ = (z_ + ((this.moveVec_.z * _arg_2) * 0.008));
            this.currentLife = (this.currentLife + _arg_2);
            return (this.percentDone < 1);
        }


    }
}//package com.company.assembleegameclient.objects.particles

