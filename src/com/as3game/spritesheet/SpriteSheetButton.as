package com.as3game.spritesheet 
{
	import com.as3game.spritesheet.analyze.JsonArrayFormat;
	import com.as3game.spritesheet.analyze.JsonFormat;
	import com.as3game.spritesheet.analyze.XmlFormat;
	import com.as3game.spritesheet.vos.Animation;
	import com.as3game.spritesheet.vos.DataFormat;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class SpriteSheetButton extends Sprite 
	{
		private var mTexture:BitmapData; //SpriteSheet位图
		private var mSheets:Object; //SpriteSheet描述数据
		private var mTextureAtlas:TextureAtlas;
		private var mCanvas:Bitmap; //画布
		private var mButtonName:String; //按钮名称（默认为all）
		private var mAnimation:Animation; //按钮帧序列
		
		public function SpriteSheetButton(texture:BitmapData, sheets:*, dataFormat:String = "format_xml", buttonName:String = "all")
		{
			mButtonName = buttonName;
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
			
			initButton(buttonName);
		}
		
		public function get sheets():Object 
		{
			return mSheets;
		}
		
		public function get centor():Point 
		{
			return mAnimation.center;
		}
		
		public function destroy():void 
		{
			mCanvas.bitmapData.dispose();
			mCanvas = null;
			mTexture = null;
			mButtonName = null;
			mSheets = null;
			mAnimation.destroy();
			mAnimation = null;
		}
		
		private function initButton(buttonName:String):void 
		{
			var frames:Vector.<SpriteFrame> = new Vector.<SpriteFrame>();
			for each (var item:SpriteFrame in mSheets.frames) 
			{
				if (item.id.indexOf(mButtonName) != -1 || mButtonName == "all") 
				{
					frames.push(item);
				}
			}
			
			mAnimation = new Animation(mButtonName, frames);
			mTextureAtlas = new TextureAtlas();
			mTextureAtlas.init(mTexture, mAnimation);
			
			mCanvas = new Bitmap();
			mCanvas.bitmapData = new BitmapData(mTextureAtlas.maxRect.width, mTextureAtlas.maxRect.height);
			mCanvas.x = mAnimation.center.x;
			mCanvas.y = mAnimation.center.y;
			addChild(mCanvas);
			
			mTextureAtlas.drawFrame(0, mCanvas.bitmapData);
			
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			mTextureAtlas.drawFrame(0, mCanvas.bitmapData);
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			mTextureAtlas.drawFrame(0, mCanvas.bitmapData);
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			mTextureAtlas.drawFrame(1, mCanvas.bitmapData);
		}
		
	}

}