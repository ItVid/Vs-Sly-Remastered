package;

import GameJolt.GameJoltAPI;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class GalleryState extends MusicBeatState
{
	var curSelected:Int = 0;

	var newInput:Bool = true;
	var galleryart:FlxSprite;
	var gallerytext:FlxText;
	var rightarrow:FlxSprite;
	var leftarrow:FlxSprite;

	override function create()
	{
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('gallerybg'));
		bg.setGraphicSize(Std.int(bg.width * 0.67));
		bg.updateHitbox();
		bg.antialiasing = true;
		add(bg);

		leftarrow = new FlxSprite(0, 0).loadGraphic(Paths.image('leftarrow'));
		leftarrow.setGraphicSize(Std.int(leftarrow.width * 0.67));
		leftarrow.updateHitbox();
		leftarrow.antialiasing = true;
		add(leftarrow);

		rightarrow = new FlxSprite(0, 0).loadGraphic(Paths.image('rightarrow'));
		rightarrow.setGraphicSize(Std.int(rightarrow.width * 0.67));
		rightarrow.updateHitbox();
		rightarrow.antialiasing = true;
		add(rightarrow);

		var escapetext:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('escapetext'));
		escapetext.setGraphicSize(Std.int(escapetext.width * 0.67));
		escapetext.updateHitbox();
		escapetext.antialiasing = true;
		add(escapetext);

		var gallerytextbox:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('gallerytextbox'));
		gallerytextbox.setGraphicSize(Std.int(gallerytextbox.width * 0.67));
		gallerytextbox.updateHitbox();
		gallerytextbox.antialiasing = true;
		add(gallerytextbox);

		// NG.core.calls.event.logEvent('swag').send();

		galleryart = new FlxSprite(0, 0).loadGraphic(Paths.image('galleryart0'));
		galleryart.setGraphicSize(Std.int(galleryart.width * 0.67));
		galleryart.updateHitbox();
		add(galleryart);

		gallerytext = new FlxText(0, 0, FlxG.width, "", 64);
		
			gallerytext.setFormat(Paths.font("bubblegum.otf"), 64, CENTER);
			gallerytext.screenCenter(X);
			gallerytext.y = 620;
			add(gallerytext);

		changeItem();

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (curSelected ==  10 || curSelected == 15 || curSelected == 19 || curSelected == 11 || curSelected == 8)
			FlxG.mouse.visible = true;
		else
			FlxG.mouse.visible = false;


		if (FlxG.mouse.pressed)
		{
			if (curSelected ==  10)
			LoadingState.loadAndSwitchState(new VideoState("assets/videos/recording1.webm",new GalleryState()));

			if (curSelected ==  15)
			LoadingState.loadAndSwitchState(new VideoState("assets/videos/recording2.webm",new GalleryState()));

			if (curSelected ==  19)
			LoadingState.loadAndSwitchState(new VideoState("assets/videos/recording3.webm",new GalleryState()));

			if (curSelected == 11)
			{
				GameJoltAPI.getTrophy(150850);
				FlxG.save.data.roger = true;
			PlayState.isStoryMode = false;

			var poop:String = Highscore.formatSong('Roger', 2);

			PlayState.SONG = Song.loadFromJson(poop, 'roger');
			PlayState.storyDifficulty = 2;
			PlayState.campaignScore = 0;
			LoadingState.loadAndSwitchState(new PlayState(), true);		
			}

			if (curSelected == 8)
			{
			FlxG.save.data.sly2 = true;
			PlayState.isStoryMode = false;

			var poop:String = Highscore.formatSong('Sly', 2);

			PlayState.SONG = Song.loadFromJson(poop, 'sly');
			PlayState.storyDifficulty = 2;
			PlayState.campaignScore = 0;
			LoadingState.loadAndSwitchState(new PlayState(), true);		
			}
		}


			if (controls.LEFT_P)
			{
				leftarrow.x -= 5;
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
				new FlxTimer().start(0.1, function(tmr:FlxTimer)
			{
				leftarrow.x += 5;
			});
			}

			if (controls.RIGHT_P)
			{
				rightarrow.x += 5;
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
				new FlxTimer().start(0.1, function(tmr:FlxTimer)
			{
				rightarrow.x -= 5;
			});
			}

			if (controls.BACK)
			{
				FlxG.switchState(new MainMenuState());
			}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= 22)
			curSelected = 0;
		if (curSelected <= -1)
			curSelected = 21;

		remove(galleryart);
		galleryart = new FlxSprite(0, 0).loadGraphic(Paths.image('galleryart' + curSelected));
		galleryart.setGraphicSize(Std.int(galleryart.width * 0.67));
		galleryart.updateHitbox();
		add(galleryart);

		switch (curSelected)
		{
			case 0:
			gallerytext.text = "First Sly Art (2015)";

			case 1:
			gallerytext.text = "Original Sly Sprite Sketch";

			case 2:
			gallerytext.text = "VS Sly Main Sly Artwork";

			case 3:
			gallerytext.text = "Quake Sly Art";

			case 4:
			gallerytext.text = "Sly Defeated";

			case 5:
			gallerytext.text = "Loading Screen Sly";

			case 6:
			gallerytext.text = "Dreammatch Sly Art";

			case 7:
			gallerytext.text = "Sly Sleeping";

			case 8:
			gallerytext.text = "VS Sly 2 Sly";

			case 9:
			gallerytext.text = "VS Sly 2 Boyfriend";

			case 10:
			gallerytext.text = "VS Sly 2 Hoodie Guy";

			case 11:
			gallerytext.text = "VS Roger Art";

			case 12:
			gallerytext.text = "Sly Art by @Sulraye";

			case 13:
			gallerytext.text = "Sly Art by @CryoGX";

			case 14:
			gallerytext.text = "Dreamatch Sly Sketch";

			case 15:
			gallerytext.text = "Hoodie Guy Sketch";

			case 16:
			gallerytext.text = "Nightmare Sly Main Art";

			case 17:
			gallerytext.text = "EMFNF2 Graffiti Contest Submission";

			case 18:
			gallerytext.text = "Sly Had To Do It To Em";

			case 19:
			gallerytext.text = "Sly and Hoodie Guy";

			case 20:
			gallerytext.text = "BG Characters (Left)";

			case 21:
			gallerytext.text = "BG Characters (Right)";

			case 22:
			gallerytext.text = "VS Sly 2 Boyfriend";
		}
	}
}