package
{
	import com.as3game.asset.AssetManager;
	import com.as3game.spritesheet.SpriteSheet;
	import com.as3game.spritesheet.vos.DataFormat;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class TestSpriteSheet extends Sprite
	{
		
		public function TestSpriteSheet()
		{
			SWFProfiler.init(stage, this);
			AssetManager.getInstance().getGroupAssets("spritesheets-json", ["data/json/jsonformat.json", "data/json/jsonformat.png"], onAnimLoaded);
			AssetManager.getInstance().getGroupAssets("spritesheets-xml", ["data/xml/xmlformat.xml", "data/xml/xmlformat.png"], onAnimLoadedXML);
			AssetManager.getInstance().getGroupAssets("spritesheets-jsonarray", ["data/json-array/jsonarrayformat.json", "data/json-array/jsonarrayformat.png"], onAnimLoadedJsonArray);
		}
		
		
		private function onAnimLoaded():void
		{
			var bitmapData:BitmapData = AssetManager.getInstance().bulkLoader.getBitmapData("data/json/jsonformat.png");
			var sheets:* = AssetManager.getInstance().getContent("data/json/jsonformat.json");
			var sp:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON);
			sp.setAction("呼吸", 14);
			//sp.setAction("打击", 14);
			sp.play();
			addChild(sp);
			
			var sp1:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON);
			sp1.x = 100;
			sp1.setAction("打击", 14);
			sp1.play();
			addChild(sp1);
			//sp1.filters = [new ColorMatrixFilter([
				//0.3,0.6,0.082,0,0,
				//0.3,0.6,0.082,0,0,
				//0.3,0.6,0.082,0,0,
				//0,0,0,1,0])];;
			
			var sp2:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON);
			sp2.x = 250;
			sp2.setAction("左行走", 14);
			sp2.play();
			addChild(sp2);
			
			var sp3:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON);
			sp3.x = 400;
			sp3.setAction("挨打", 14);
			sp3.play();
			addChild(sp3);
			
			var sp4:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON);
			sp4.x = 550;
			sp4.setAction("攻击", 30);
			sp4.play();
			addChild(sp4);
			
			var tf:TextField = new TextField();
			tf.text = "spritesheets-json";
			tf.width = 200;
			addChild(tf);
		}
		
		private function onAnimLoadedXML():void
		{
			var bitmapData:BitmapData = AssetManager.getInstance().bulkLoader.getBitmapData("data/xml/xmlformat.png");
			var sheets:* = AssetManager.getInstance().getContent("data/xml/xmlformat.xml");
			var sp:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_XML);
			sp.setAction("呼吸", 15);
			sp.play();
			sp.y = 150;
			addChild(sp);
			
			var sp1:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_XML);
			sp1.x = 100;
			sp1.y = 150;
			sp1.setAction("打击", 14);
			sp1.play();
			addChild(sp1);
			
			var sp2:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_XML);
			sp2.x = 250;
			sp2.y = 150;
			sp2.setAction("左行走", 14);
			sp2.play();
			addChild(sp2);
			sp2.buttonMode = true;
			sp2.addEventListener(MouseEvent.CLICK, onClickHandler);
		
			var sp3:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_XML);
			sp3.x = 400;
			sp3.y = 150;
			sp3.setAction("挨打", 14);
			sp3.play();
			addChild(sp3);
			
			var sp4:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_XML);
			sp4.x = 550;
			sp4.y = 150;
			sp4.setAction("攻击", 30);
			sp4.play();
			addChild(sp4);
			
			var tf:TextField = new TextField();
			tf.width = 200;
			tf.text = "spritesheets-xml";
			tf.y = 150;
			addChild(tf);
		}
		
		private function onClickHandler(e:MouseEvent):void 
		{
			var sp:SpriteSheet = e.currentTarget as SpriteSheet;
			trace("~~~~~~~~~~~~~~~~~~~~~~~~~~~", sp.isPlaying);
			if (sp.actionName == "打击") 
			{
				sp.stop();
				sp.setAction("挨打", 14);
				sp.play();
				//sp.gotoAndStop(13);
				trace("===========================", sp.isPlaying);
			}
			else 
			{
				sp.stop();
				sp.setAction("打击", 14);
				sp.play();
				//sp.play();
				//sp.gotoAndPlay(1);
			}
		}
		
		private function onAnimLoadedJsonArray():void
		{
			var bitmapData:BitmapData = AssetManager.getInstance().bulkLoader.getBitmapData("data/json-array/jsonarrayformat.png");
			var sheets:* = AssetManager.getInstance().getContent("data/json-array/jsonarrayformat.json");
			var sp:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON_ARRAY);
			sp.setAction("呼吸", 15);
			sp.play();
			sp.y = 300;
			addChild(sp);
			
			var sp1:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON_ARRAY);
			sp1.x = 100;
			sp1.y = 300;
			sp1.setAction("打击", 14);
			sp1.play();
			addChild(sp1);
			
			var sp2:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON_ARRAY);
			sp2.x = 250;
			sp2.y = 300;
			sp2.setAction("左行走", 14);
			sp2.play();
			addChild(sp2);
			sp2.buttonMode = true;
			
			var sp3:SpriteSheet = new SpriteSheet(bitmapData, sheets, DataFormat.FORMAT_JSON_ARRAY);
			sp3.x = 400;
			sp3.y = 300;
			sp3.setAction("挨打", 14);
			sp3.play();
			addChild(sp3);
			
			var tf:TextField = new TextField();
			tf.width = 200;
			tf.text = "spritesheets-jsonarray";
			tf.y = 300;
			addChild(tf);
		}
	}

}