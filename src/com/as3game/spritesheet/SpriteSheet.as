package com.as3game.spritesheet
{
	import com.as3game.spritesheet.analyze.JsonArrayFormat;
	import com.as3game.spritesheet.analyze.JsonFormat;
	import com.as3game.spritesheet.analyze.XmlFormat;
	import com.as3game.spritesheet.vos.Animation;
	import com.as3game.spritesheet.vos.DataFormat;
	import com.as3game.time.GameTimer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	/**
	 * SpriteSheet位图动画类
	 * @author Tylerzhu
	 */
	public class SpriteSheet extends Sprite
	{
		private var mTextureAtlas:TextureAtlas;
		private var mPlaying:Boolean;
		private var mCurFrame:uint;
		private var mCanvas:Bitmap;//当前帧位图画布
		
		private var mTexture:BitmapData; //SpriteSheet位图
		private var mSheets:Object; //SpriteSheet描述数据
		private var mActionName:String; //当前动作名称（默认为all）
		private var mAnimation:Animation;//当前动画(一张SpriteSheet中经常会包含多个动画序列，walk/stand/attack)
		private var mObjectId:String;
		
		public function SpriteSheet(texture:BitmapData, sheets:*, dataFormat:String)
		{
			mObjectId = "SpriteSheet" + getTimer();
			mActionName = "";
			mTexture = texture;
			switch (dataFormat)
			{
				case DataFormat.FORMAT_JSON:
					mSheets = new JsonFormat(sheets as String).getData();
					break;
				case DataFormat.FORMAT_JSON_ARRAY:
					mSheets = new JsonArrayFormat(sheets as String).getData();
					break;
				case DataFormat.FORMAT_XML:
					mSheets = new XmlFormat(sheets as XML).getData();
					break;
				default: 
			}
		}
		
		public function get centor():Point 
		{
			return mAnimation.center;
		}
		
		public function setAction(id:String = "all", frameRate:int = 30, loop:Boolean = true):void 
		{
			if (id == mActionName) 
			{
				return;
			}
			
			// 清理操作
			if (mCanvas) 
			{
				removeChild(mCanvas);
				mCanvas.bitmapData.dispose();
			}
			if (mAnimation) 
			{
				mAnimation.destroy();
			}
			if (mTextureAtlas) 
			{
				mTextureAtlas.destroy();
			}
			
			//
			mActionName = id;
			mCurFrame = 0;
			
			var frames:Vector.<SpriteFrame> = new Vector.<SpriteFrame>();
			if (mActionName == "all") 
			{
				frames = mSheets.frames;
			}
			else 
			{
				for each (var item:SpriteFrame in mSheets.frames) 
				{
					if (item.id.indexOf(id) != -1) 
					{
						frames.push(item);
					}
				}
			}
			
			mAnimation = new Animation(id, frames, frameRate, loop);
			mTextureAtlas = new TextureAtlas();
			mTextureAtlas.init(mTexture, mAnimation);
			
			mCanvas = new Bitmap();
			mCanvas.bitmapData = new BitmapData(mTextureAtlas.maxRect.width, mTextureAtlas.maxRect.height);
			mCanvas.x = mAnimation.center.x;
			mCanvas.y = mAnimation.center.y;
			addChild(mCanvas);
		}
		
		public function get isPlaying():Boolean 
		{
			return mPlaying;
		}
		
		/**
		 * 播放SpriteSheet位图动画
		 */
		public function play():void
		{
			if (mActionName == "") 
			{
				return;
			}
			mPlaying = true;
			mTextureAtlas.drawFrame(mCurFrame, mCanvas.bitmapData);
			
			GameTimer.getInstance().register(mObjectId, 1000 * mAnimation.delay, 0, update);
		}
		
		/**
		 * 停止SpriteSheet位图动画
		 */
		public function stop():void
		{
			mPlaying = false;
			GameTimer.getInstance().unregister(mObjectId);
		}
		
		/**
		 * 将播放头移到SpriteSheet的指定帧并开始播放。
		 * @param	frame	表示播放头转到的帧编号的数字。
		 */
		public function gotoAndPlay(frame:uint):void
		{
			mCurFrame = frame;
			if (mCurFrame >= mAnimation.arFrames.length) 
			{
				mCurFrame = mAnimation.arFrames.length - 1;
			}
			play();
		}
		
		/**
		 * 将播放头移到SpriteSheet的指定帧并停在那里。
		 * @param	frame	表示播放头转到的帧编号的数字。
		 */
		public function gotoAndStop(frame:uint):void
		{
			stop();
			mCurFrame = frame;
			if (mCurFrame >= mAnimation.arFrames.length) 
			{
				mCurFrame = mAnimation.arFrames.length - 1;
			}
			mTextureAtlas.drawFrame(mCurFrame, mCanvas.bitmapData);
		}
		
		public function get currenFrame():uint 
		{
			return mCurFrame;
		}
		
		public function get actionName():String 
		{
			return mActionName;
		}
		
		private function update(count:uint):void 
		{
			mCurFrame ++;
			if (mCurFrame >= mAnimation.arFrames.length) 
			{
				if (mAnimation.loop) 
				{
					mCurFrame = 0;
				}
				else 
				{
					GameTimer.getInstance().unregister(mObjectId);
					return;
				}
			}
			mTextureAtlas.drawFrame(mCurFrame, mCanvas.bitmapData);
			
		}
	}

}