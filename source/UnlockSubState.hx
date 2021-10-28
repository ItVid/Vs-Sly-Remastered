package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class UnlockSubState extends MusicBeatState
{
	override function create()
	{
		super.create();
		
		var bg:FlxSprite = new FlxSprite(-320, -170).loadGraphic(Paths.image('unlock', 'preload'));
		bg.setGraphicSize(Std.int(bg.width * 0.67));
		add(bg);	
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ANY)
		{
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
