package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class CharacterSetting
{
	public var x(default, null):Int;
	public var y(default, null):Int;
	public var scale(default, null):Float;
	public var flipped(default, null):Bool;

	public function new(x:Int = 0, y:Int = 0, scale:Float = 1.0, flipped:Bool = false)
	{
		this.x = x;
		this.y = y;
		this.scale = scale;
		this.flipped = flipped;
	}
}

class MenuCharacter extends FlxSprite
{
	private static var settings:Map<String, CharacterSetting> = [
		'bf' => new CharacterSetting(0, 30, 1.5, true),
		'bfConfirm' => new CharacterSetting(0, 30, 1.5, true),
		'gf' => new CharacterSetting(50, 80, 1.5, true),
		'sly' => new CharacterSetting(-15, 140, 1.1),
		'slyasleep' => new CharacterSetting(-15, 135, 1),
		'roger' => new CharacterSetting(-15, 95, 2),
		'sly1' => new CharacterSetting(170, 95, 1.05, true),
		'sly1.5' => new CharacterSetting(210, 125, 1.2, true),
		'sly2' => new CharacterSetting(200, 150, 0.9, true),
		'rogerlogo' => new CharacterSetting(100, 90, 1.2, true)
	];

	private var flipped:Bool = false;

	public function new(x:Int, y:Int, scale:Float, flipped:Bool)
	{
		super(x, y);
		this.flipped = flipped;

		antialiasing = true;

		frames = Paths.getSparrowAtlas('campaign_menu_UI_characters');

		animation.addByPrefix('bf', "BF idle dance white", 24);
		animation.addByPrefix('bfConfirm', 'BF HEY!!', 24, false);
		animation.addByPrefix('gf', "GF Dancing Beat WHITE", 24);
		animation.addByPrefix('sly', "slynormal", 24);
		animation.addByPrefix('slyasleep', "slyslep", 24);
		animation.addByPrefix('roger', "rogeridle", 24);
		animation.addByPrefix('sly1', "original", 24);
		animation.addByPrefix('sly1.5', "slylogo", 24);
		animation.addByPrefix('sly2', "logo bumpin 2", 24);
		animation.addByPrefix('rogerlogo', "rogerlogo", 24);

		setGraphicSize(Std.int(width * scale));
		updateHitbox();
	}

	public function setCharacter(character:String):Void
	{
		if (character == '')
		{
			visible = false;
			return;
		}
		else
		{
			visible = true;
		}

		animation.play(character);

		var setting:CharacterSetting = settings[character];
		offset.set(setting.x, setting.y);
		setGraphicSize(Std.int(width * setting.scale));
		flipX = setting.flipped != flipped;
	}
}
