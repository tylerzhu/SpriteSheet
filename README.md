SpriteSheet
===========

ActionScript 3.0 Sprite Sheet render engine

实现了SpriteSheet精灵序列图引擎，可以解析Flash Cs6/TexturePacker导出的JSON、JSON-Array、XML格式的SpriteSheet。

Demo
-----------
<code>
AssetManager.getInstance().getGroupAssets("spritesheets-json", ["data/json/jsonformat.json", "data/json/jsonformat.png"], onAnimLoaded);

private function onAnimLoaded():void
{
	var bitmapData:BitmapData = AssetManager.getInstance().bulkLoader.getBitmapData("data/json/jsonformat.png");
	var sheets:* = AssetManager.getInstance().getContent("data/json/jsonformat.json");
	var sp:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON);
	sp.setAction("呼吸", 14);
	sp.play();
	addChild(sp);
}
</code>
