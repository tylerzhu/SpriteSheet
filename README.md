SpriteSheet
===========

ActionScript 3.0 Sprite Sheet render engine

实现了SpriteSheet精灵序列图引擎，可以解析Flash Cs6/TexturePacker导出的JSON、JSON-Array、XML格式的SpriteSheet。
相关介绍：http://www.cnblogs.com/skynet/p/3570421.html

SpriteSheet调整中心等功能，参考SpriteSheet编辑工具：https://github.com/saylorzhu/SpriteSheetEdit 

Demo
-----------
. 加载SpriteSheet png图片及数据描述文件

>AssetManager.getInstance().getGroupAssets("spritesheets-json", ["data/json/jsonformat.json", "data/json/jsonformat.png"], onAnimLoaded);

. 创建SpriteSheet实例：

>private function onAnimLoaded():void  
{  
	var bitmapData:BitmapData = AssetManager.getInstance().bulkLoader.getBitmapData("data/json/jsonformat.png");  
	var sheets:* = AssetManager.getInstance().getContent("data/json/jsonformat.json");  
	var sp:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON);  
	sp.setAction("呼吸", 14);  
	sp.play();  
	addChild(sp);  
}

