package;

import haxe.Json;
import lime.utils.Assets;

using StringTools;

typedef SwagWeeks =
{
	var modName:String;
	var weeks:haxe.DynamicAccess<SwagWeek>;//Map<String, SwagWeek>;
	@:optional var storyMenuColor:String;
	@:optional var introTexts:Array<Array<String>>;
}

typedef SwagWeek =
{
	var weekText:String;
	var comment:String;
	var tracks:Array<Dynamic>;
	var menuCharacters:Array<String>;
	var locked:Bool;
	var freeplay:Array<String>;
}

class WeeksParser
{
	public function new(song, notes, bpm)
	{
	}

	public static function getWeeksInfoFromJson(folder:String):SwagWeeks
	{
		var assetKey = Paths.jsonWeekTop("weeks", "weeks", folder);
		
		var rawJson = Assets.getText(assetKey).trim();

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
			// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
			// Removes weird null characters
		}

		return parseJSONshit(rawJson);
	}

	public static function addCustomIntroTexts(mods:Array<String>) {
		for(mod in mods) {
			var info = getWeeksInfoFromJson(mod);
			var introTexts = info.introTexts;

			if(introTexts != null) {
				for(text in introTexts) {
					TitleState.introTexts.push(text);
				}
			}
		}
	}

	public static function parseJSONshit(rawJson:String):SwagWeeks
	{
		var swagShit:SwagWeeks = cast Json.parse(rawJson);
		return swagShit;
	}
}