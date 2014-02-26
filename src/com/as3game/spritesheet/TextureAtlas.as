package com.as3game.spritesheet
{
	import com.as3game.spritesheet.vos.Animation;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 动画序列帧数据
	 * @author Tylerzhu
	 */
	public class TextureAtlas
	{
		private var mTextureRegions:Vector.<Rectangle>;
		private var mFrameOffsets:Vector.<Point>;
		private var mTextureSheet:BitmapData;
		private var mFrameRect:Rectangle;
		
		public function TextureAtlas()
		{
			
		}
		
		/**
		 * 初始化动画帧序列，构建帧框数组、偏移点数组
		 * @param	sheet
		 * @param	animation
		 */
		public function init(sheet:BitmapData, animation:Animation):void
		{
			mTextureRegions = new Vector.<Rectangle>();
			mFrameRect = new Rectangle();
			mFrameOffsets = new Vector.<Point>();
			mTextureSheet = sheet;
			var arFrameData:Vector.<SpriteFrame> = animation.arFrames;
			var rcFrame:Rectangle;
			var regPt:Point;
			
			for (var i:int = 0; i < arFrameData.length; i++)
			{
				rcFrame = new Rectangle();
				
				rcFrame.x = arFrameData[i].x;
				rcFrame.y = arFrameData[i].y;
				rcFrame.width = arFrameData[i].width;
				rcFrame.height = arFrameData[i].height;
				mTextureRegions.push(rcFrame);
				
				regPt = new Point();
				regPt.x = arFrameData[i].offX;
				regPt.y = arFrameData[i].offY;
				mFrameOffsets.push(regPt);
				
				mFrameRect.width = Math.max(mFrameRect.width, rcFrame.width + regPt.x);
				mFrameRect.height = Math.max(mFrameRect.height, rcFrame.height + regPt.y);
			}
		
		}
		
		/**
		 *
		 * @param	frame
		 * @param	dstBmp
		 */
		public function drawFrame(frame:uint, dstBmp:BitmapData):void
		{
			dstBmp.fillRect(dstBmp.rect, 0);
			dstBmp.copyPixels(mTextureSheet, mTextureRegions[frame], mFrameOffsets[frame]);
		}
		
		public function get maxRect():Rectangle 
		{
			return mFrameRect;
		}
		
		public function destroy():void 
		{
			mTextureRegions = null;
			mFrameRect = null;
			mFrameOffsets = null;
			mTextureSheet = null;
		}
	
	}

}