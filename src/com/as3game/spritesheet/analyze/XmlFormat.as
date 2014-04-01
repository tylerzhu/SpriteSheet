package com.as3game.spritesheet.analyze
{
	import com.as3game.spritesheet.SpriteFrame;
	
	/**
	 * 解析XML格式的SpriteSheet数据描述文件
	 * @author Tylerzhu
	 */
	public class XmlFormat
	{
		private var mMeta:Object;
		private var mFrames:Vector.<SpriteFrame>;
		
		public function XmlFormat(xml:XML)
		{
			mFrames = new Vector.<SpriteFrame>();
			var spriteFrame:SpriteFrame;
			
			var xmlList:XMLList = xml.SubTexture;
			for (var i:int = 0; i < xmlList.length(); i++)
			{
				spriteFrame = new SpriteFrame();
				spriteFrame.id = String(xmlList[i].@name);
				spriteFrame.x = int(xmlList[i].@x);
				spriteFrame.y = int(xmlList[i].@y);
				spriteFrame.width = int(xmlList[i].@width);
				spriteFrame.height = int(xmlList[i].@height);
				spriteFrame.offX = -1 * int(xmlList[i].@frameX);
				spriteFrame.offY = -1 * int(xmlList[i].@frameY);
				spriteFrame.centerX = Number(xmlList[i].@centerX);
				spriteFrame.centerY = Number(xmlList[i].@centerY);
				mFrames.push(spriteFrame);
			}
		}
		
		public function getData():Object
		{
			return {"meta": mMeta, "frames": mFrames};
		}
	
	}

}