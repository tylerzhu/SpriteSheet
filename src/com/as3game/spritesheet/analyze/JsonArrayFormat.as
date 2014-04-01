package com.as3game.spritesheet.analyze
{
	import com.adobe.serialization.json.JSON;
	import com.as3game.spritesheet.SpriteFrame;
	
	/**
	 * 解析JSON Array格式的SpriteSheet数据描述文件
	 * @author Tylerzhu
	 */
	public class JsonArrayFormat
	{
		private var mMeta:Object;
		private var mFrames:Vector.<SpriteFrame>;
		
		public function JsonArrayFormat(text:String)
		{
			var data:Object = com.adobe.serialization.json.JSON.decode(text);
			mMeta = data.meta;
			mFrames = new Vector.<SpriteFrame>();
			
			var frames:Object = data.frames;
			var spriteFrame:SpriteFrame;
			for each (var item:Object in frames) 
			{
				spriteFrame = new SpriteFrame();
				spriteFrame.id = item.filename;
				spriteFrame.x = item.frame.x;
				spriteFrame.y = item.frame.y;
				spriteFrame.width = item.frame.w;
				spriteFrame.height = item.frame.h;
				spriteFrame.offX = item.spriteSourceSize.x;
				spriteFrame.offY = item.spriteSourceSize.y;
				//spriteFrame.centerX = Number(xmlList[i].@centerX);
				//spriteFrame.centerY = Number(xmlList[i].@centerY);
				mFrames.push(spriteFrame);
			}
		}
		
		public function getData():Object
		{
			return {"meta": mMeta, "frames": mFrames};
		}
	}

}