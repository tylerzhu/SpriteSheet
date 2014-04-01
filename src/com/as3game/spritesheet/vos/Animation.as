package com.as3game.spritesheet.vos 
{
	import com.as3game.spritesheet.SpriteFrame;
	import flash.geom.Point;
	/**
	 * 动画信息，一张SpriteSheet中经常会包含多个动画序列
	 * 如一个战斗角色SpriteSheet包含：walk、stand、attack、unattack等等
	 * @author Tylerzhu
	 */
	public class Animation 
	{
		public var seqName:String;// 动画序列名 (e.g. "walk")
		public var delay:Number;// 帧间隔
		public var loop:Boolean;// 是否循环播放
		public var arFrames:Vector.<SpriteFrame>;// 帧信息数据
		public var center:Point; //中心点位置
		
		public function Animation(name:String, frames:Vector.<SpriteFrame>, frameRate:Number=0, looped:Boolean=true)
		{
			seqName = name;
			delay = 0;
			if(frameRate > 0)
				delay = 1.0/frameRate;
			
			arFrames = frames;
			loop = looped;
			center = new Point(frames[1].centerX, frames[1].centerY);
		}
		
		public function destroy():void
		{
			arFrames = null;
		}
	}

}