package;

import openfl.display.BitmapData;
import openfl.system.System;
import flixel.util.FlxTimer;
import flixel.math.FlxRandom;
import flixel.FlxObject;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;

import Discord.DiscordClient;

using StringTools;

class CreditsMenu extends MusicBeatState
{
	var curSelected:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;
	//var boolList = StoryMenuState.getLocks();
	
	public static var credits:Array<String> = [
	'CREATOR, ART, CUTSCENES',
	'SamTheSly',
	'',
	'LEAD PROGRAMMER',
	'LemonKing',
	'',
	'PROGRAMMER',
	'Vidz',
	'',
	'Music',
	'',
	'VS Sly Music',
	'SamTheSly',
	'',
	'VS ROGER MUSIC',
	'Runnerdude127',
	'',
	'VAs',
	'SamTheSly',
	'Runnerdude127',
	'CritVA',
	'',
	'NOTE SPLASHES',
	'Bonk',
	'',
	'CHROMATIC ABBERATION',
	'GWebDev',
	'',
	'OG SPRITE ANIMATION',
	'ash237',
	'',
	'SPRITE ANIMATION',
	'mapleee',
	'Lemony',
	'IL tofu', 
	'SamTheSly',
	'',
	'MODCHARTING',
	'NeonWare',
	'ZenusPurity_',
	'',
	'CHARTING',
	'CommanderLilac',
	'DiscWraith',
	'niffirg',
	'SamTheSly'
	];

	override function create()
	{
		
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Inside The Credits Menu...", null);
		
		FlxG.autoPause = false;
	
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBG'));
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...credits.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, new EReg('_', 'g').replace(new EReg('0', 'g').replace(credits[i], 'O'), ' '), true, false);
			songText.isMenuItem = true;
			songText.targetY = i;

			if(credits[i].contains(":")){
				songText.color = 0xFFFFFF00;
			}

			grpSongs.add(songText);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		changeSelection();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.F)
		{
		FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			FlxG.autoPause = true;
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
			/*switch (curSelected){
				case 1:
					fancyOpenURL("https://twitter.com/samthesly");
				case 4:
					fancyOpenURL("https://twitter.com/1emonking");
				case 7:
					fancyOpenURL("https://twitter.com/Runnerdude127");
				case 10:
					fancyOpenURL("https://twitter.com/ash__i_guess_");
				case 13:
					fancyOpenURL("https://twitter.com/mmmmmmmmmaple");
				case 17:
					fancyOpenURL("https://twitter.com/CritVA70");
				case 24:
					fancyOpenURL("https://twitter.com/CommanderLilac");

				default:
			}*/
		}
	}

	function changeSelection(change:Int = 0)
	{

		curSelected += change;

		if (curSelected < 0)
			curSelected = credits.length - 1;
		if (curSelected >= credits.length)
			curSelected = 0;

		var changeTest = curSelected;

		if(credits[curSelected] == "" || credits[curSelected].contains(":") && credits[curSelected] != "PROGRAMMERS:"){
			changeSelection(change == 0 ? 1 : change);
		}

		if(changeTest == curSelected){
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}
		

		var bullShit:Int = 0;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}

	}
}