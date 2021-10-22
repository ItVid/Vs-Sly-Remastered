package;

import GameJolt.GameJoltLogin;
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

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story', 'freeplay', 'options', 'extras', 'credits', 'social'];
	#else
	var optionShit:Array<String> = ['story', 'freeplay', 'extras', 'credits'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	var newInput:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.4.2" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var bg:FlxSprite;
	var bgclone:FlxSprite;
	var bgcolor:FlxSprite;
	var bgcolorclone:FlxSprite;
	var storyart:FlxSprite;
	var freeplayart:FlxSprite;
	var creditsart:FlxSprite;
	var optionsart:FlxSprite;
	var extrasart:FlxSprite;
	var socialart:FlxSprite;
	var menutriangles:FlxSprite;
	var trianglesclone:FlxSprite;
	var story:FlxSprite;
	var freeplay:FlxSprite;
	var options:FlxSprite;
	var social:FlxSprite;
	var extras:FlxSprite;
	var credits:FlxSprite;
	var more1:FlxSprite;
	var more2:FlxSprite;
	var camFollow:FlxObject;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		GameJoltAPI.connect();
		GameJoltAPI.authDaUser(FlxG.save.data.gjUser, FlxG.save.data.gjToken);

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite(-640, -360).loadGraphic(Paths.image('checkerboardwhite'));
		bg.setGraphicSize(Std.int(bg.width * 0.67));
		bg.updateHitbox();
		bg.antialiasing = true;
		add(bg);

		bgclone = new FlxSprite(640, -360).loadGraphic(Paths.image('checkerboardwhite'));
		bgclone.setGraphicSize(Std.int(bgclone.width * 0.67));
		bgclone.updateHitbox();
		bgclone.antialiasing = true;
		add(bgclone);

		bgcolor = new FlxSprite(-640, -360).loadGraphic(Paths.image('checkerboardpurple'));
		bgcolor.setGraphicSize(Std.int(bgcolor.width * 0.67));
		bgcolor.updateHitbox();
		bgcolor.antialiasing = true;
		add(bgcolor);

		bgcolorclone = new FlxSprite(640, -360).loadGraphic(Paths.image('checkerboardpurple'));
		bgcolorclone.setGraphicSize(Std.int(bgcolorclone.width * 0.67));
		bgcolorclone.updateHitbox();
		bgcolorclone.antialiasing = true;
		add(bgcolorclone);

		storyart = new FlxSprite(-640, 400).loadGraphic(Paths.image('storyart'));
		storyart.setGraphicSize(Std.int(storyart.width * 0.67));
		storyart.updateHitbox();
		storyart.antialiasing = true;
		add(storyart);
		FlxTween.tween(storyart, { y: -360}, 1, {ease: FlxEase.quadInOut});

		freeplayart = new FlxSprite(-640, -360).loadGraphic(Paths.image('freeplayart'));
		freeplayart.setGraphicSize(Std.int(freeplayart.width * 0.67));
		freeplayart.updateHitbox();
		freeplayart.antialiasing = true;
		add(freeplayart);
		freeplayart.visible = false;

		optionsart = new FlxSprite(-640, -360).loadGraphic(Paths.image('optionsart'));
		optionsart.setGraphicSize(Std.int(optionsart.width * 0.67));
		optionsart.updateHitbox();
		optionsart.antialiasing = true;
		add(optionsart);
		optionsart.visible = false;

		creditsart = new FlxSprite(-640, -360).loadGraphic(Paths.image('creditsart'));
		creditsart.setGraphicSize(Std.int(creditsart.width * 0.67));
		creditsart.updateHitbox();
		creditsart.antialiasing = true;
		add(creditsart);
		creditsart.visible = false;

		socialart = new FlxSprite(-640, -360).loadGraphic(Paths.image('socialart'));
		socialart.setGraphicSize(Std.int(socialart.width * 0.67));
		socialart.updateHitbox();
		socialart.antialiasing = true;
		add(socialart);
		socialart.visible = false;

		extrasart = new FlxSprite(-640, -360).loadGraphic(Paths.image('extrasart'));
		extrasart.setGraphicSize(Std.int(extrasart.width * 0.67));
		extrasart.updateHitbox();
		extrasart.antialiasing = true;
		add(extrasart);
		extrasart.visible = false;

		menutriangles = new FlxSprite(-640, -360).loadGraphic(Paths.image('menutriangles'));
		menutriangles.setGraphicSize(Std.int(menutriangles.width * 0.67));
		menutriangles.updateHitbox();
		menutriangles.antialiasing = true;
		add(menutriangles);

		trianglesclone = new FlxSprite(-1920, -360).loadGraphic(Paths.image('menutriangles'));
		trianglesclone.setGraphicSize(Std.int(trianglesclone.width * 0.67));
		trianglesclone.updateHitbox();
		trianglesclone.antialiasing = true;
		add(trianglesclone);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		story = new FlxSprite(-600, 230);
		story.frames = Paths.getSparrowAtlas('FNF_main_menu_assets', 'preload');
		story.animation.addByPrefix('selected', "story selected", 24);
		story.animation.addByPrefix('unselected', "story unselected", 24, false);
		story.antialiasing = true;
		story.updateHitbox();
		story.animation.play('unselected');
		add(story);

		freeplay = new FlxSprite(-250, 230);
		freeplay.frames = Paths.getSparrowAtlas('FNF_main_menu_assets', 'preload');
		freeplay.animation.addByPrefix('selected', "freeplay selected", 24);
		freeplay.animation.addByPrefix('unselected', "freeplay unselected", 24, false);
		freeplay.antialiasing = true;
		freeplay.updateHitbox();
		freeplay.animation.play('unselected');
		add(freeplay);

		options = new FlxSprite(200, 230);
		options.frames = Paths.getSparrowAtlas('FNF_main_menu_assets', 'preload');
		options.animation.addByPrefix('selected', "options selected", 24);
		options.animation.addByPrefix('unselected', "options unselected", 24, false);
		options.antialiasing = true;
		options.updateHitbox();
		options.animation.play('unselected');
		add(options);

		extras = new FlxSprite(-600, 230);
		extras.frames = Paths.getSparrowAtlas('FNF_main_menu_assets', 'preload');
		extras.animation.addByPrefix('selected', "extras selected", 24);
		extras.animation.addByPrefix('unselected', "extras unselected", 24, false);
		extras.antialiasing = true;
		extras.updateHitbox();
		extras.animation.play('unselected');
		add(extras);

		credits = new FlxSprite(-200, 230);
		credits.frames = Paths.getSparrowAtlas('FNF_main_menu_assets', 'preload');
		credits.animation.addByPrefix('selected', "credits selected", 24);
		credits.animation.addByPrefix('unselected', "credits unselected", 24, false);
		credits.antialiasing = true;
		credits.updateHitbox();
		credits.animation.play('unselected');
		add(credits);

		social = new FlxSprite(200, 230);
		social.frames = Paths.getSparrowAtlas('FNF_main_menu_assets', 'preload');
		social.animation.addByPrefix('selected', "social selected", 24);
		social.animation.addByPrefix('unselected', "social unselected", 24, false);
		social.antialiasing = true;
		social.updateHitbox();
		social.animation.play('unselected');
		add(social);

		more1 = new FlxSprite(-640, -360).loadGraphic(Paths.image('more1'));
		more1.setGraphicSize(Std.int(more1.width * 0.67));
		more1.updateHitbox();
		more1.antialiasing = true;
		add(more1);
		more1.visible = false;

		more2 = new FlxSprite(-640, -360).loadGraphic(Paths.image('more2'));
		more2.setGraphicSize(Std.int(more2.width * 0.67));
		more2.updateHitbox();
		more2.antialiasing = true;
		add(more2);
		more2.visible = false;

		menuItems = new FlxTypedGroup<FlxSprite>();
		//add(menuItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, 60 + (i * 160));
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " unselected", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " selected", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
		}

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;
	var movescreen:Bool = true;
	var floatmore:Bool = true;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (floatmore == true)
		{
			floatmore = false;
			FlxTween.tween(more1, { y: -500}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(more2, { y: -500}, 1, {ease: FlxEase.quadInOut});
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxTween.tween(more1, { y: -450}, 2, {ease: FlxEase.quadInOut});
				FlxTween.tween(more2, { y: -450}, 2, {ease: FlxEase.quadInOut});
				new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				floatmore = true;
			});
			});
		}

		if (movescreen == true)
		{
			movescreen = false;
			FlxTween.tween(bg, { x: -1920 }, 24); 
			FlxTween.tween(bgcolor, { x: -1920 }, 24); 
			FlxTween.tween(menutriangles, { x: 640 }, 24); 
			FlxTween.tween(trianglesclone, { x: -640 }, 24); 
			FlxTween.tween(bgclone, { x: -640 }, 24); 
			FlxTween.tween(bgcolorclone, { x: -640 }, 24, {
				onComplete: function(twn:FlxTween)
								{
									bg.x = -640;
					bgclone.x = 640;
					bgcolor.x = -640;
					bgcolorclone.x = 640;
					menutriangles.x = -640;
					trianglesclone.x = -1920;
					movescreen = true;
								}
							});		
		}

		if (!selectedSomethin)
		{

			switch (curSelected)
			{
				case 0:
				storyart.visible = true;
				more1.visible = true;
				more2.visible = false;
				bgcolor.color = 0xffffff;
				bgcolorclone.color = 0xffffff;
				freeplayart.visible = false;
				social.visible = false;
				extras.visible = false;
				credits.visible = false;
				story.animation.play('selected');
				story.scale.set(1.02, 1.02);
				freeplay.scale.set(1, 1);
				freeplay.animation.play('unselected');

				case 1:
				storyart.visible = false;
				freeplayart.visible = true;
				bgcolor.color = 0xcf5252;
				bgcolorclone.color = 0xcf5252;
				optionsart.visible = false;
				story.animation.play('unselected');
				options.animation.play('unselected');
				freeplay.animation.play('selected');
				options.scale.set(1, 1);
				story.scale.set(1, 1);
				freeplay.scale.set(1.02, 1.02);

				case 2:
				more1.visible = true;
				more2.visible = false;
				freeplayart.visible = false;
				extrasart.visible = false;
				optionsart.visible = true;
				bgcolor.color = 0x3f8abf;
				bgcolorclone.color = 0x3f8abf;
				story.visible = true;
				freeplay.visible = true;
				options.visible = true;
				social.visible = false;
				extras.visible = false;
				credits.visible = false;
				options.animation.play('selected');
				freeplay.animation.play('unselected');
				freeplay.scale.set(1, 1);
				options.scale.set(1.02, 1.02);

				case 3:
				more1.visible = false;
				more2.visible = true;
				story.visible = false;
				freeplay.visible = false;
				options.visible = false;
				social.visible = true;
				bgcolor.color = 0x51c45e;
				bgcolorclone.color = 0x51c45e;
				credits.visible = true;
				extras.visible = true;
				optionsart.visible = false;
				extrasart.visible = true;
				creditsart.visible = false;
				extras.animation.play('selected');
				credits.animation.play('unselected');
				credits.scale.set(1, 1);
				extras.scale.set(1.02, 1.02);


				case 4:

				credits.animation.play('selected');
				extras.animation.play('unselected');
				social.animation.play('unselected');
				extrasart.visible = false;
				creditsart.visible = true;
				bgcolor.color = 0xdfc74e;
				bgcolorclone.color = 0xdfc74e;
				socialart.visible = false;
				extras.scale.set(1, 1);
				credits.scale.set(1.02, 1.02);
				social.scale.set(1, 1);

				case 5:
				social.animation.play('selected');
				credits.animation.play('unselected');
				social.scale.set(1.02, 1.02);
				credits.scale.set(1, 1);

				creditsart.visible = false;
				socialart.visible = true;
				bgcolor.color = 0xd88147;
				bgcolorclone.color = 0xd88147;

			}


			if (controls.LEFT_P)
			{
				if (curSelected != 0)
			{	
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);

				switch (curSelected)
				{
					case 0:
				storyart.y = 400;
				FlxTween.tween(storyart, { y: -360}, 1, {ease: FlxEase.quadInOut});

				case 1:
				freeplayart.y = 400;
				FlxTween.tween(freeplayart, { y: -360}, 1, {ease: FlxEase.quadInOut});

				case 2:
				optionsart.y = 400;
				FlxTween.tween(optionsart, { y: -360}, 1, {ease: FlxEase.quadInOut});

				case 3:
				extrasart.y = 400;
				FlxTween.tween(extrasart, { y: -360}, 1, {ease: FlxEase.quadInOut});

				case 4:
				creditsart.y = 400;
				FlxTween.tween(creditsart, { y: -360}, 1, {ease: FlxEase.quadInOut});

				case 5:
				socialart.y = 400;
				FlxTween.tween(socialart, { y: -360}, 1, {ease: FlxEase.quadInOut});
				}
			}
			}

			if (controls.RIGHT_P)
			{
				if (curSelected != 5)
			{	
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);

				switch (curSelected)
				{
					case 0:
				storyart.y = 400;
				FlxTween.tween(storyart, { y: -360}, 1, {ease: FlxEase.quadInOut});

				case 1:
				freeplayart.y = 400;
				FlxTween.tween(freeplayart, { y: -360}, 1, {ease: FlxEase.quadInOut});

				case 2:
				optionsart.y = 400;
				FlxTween.tween(optionsart, { y: -360}, 1, {ease: FlxEase.quadInOut});

				case 3:
				extrasart.y = 400;
				FlxTween.tween(extrasart, { y: -360}, 1, {ease: FlxEase.quadInOut});

				case 4:
				creditsart.y = 400;
				FlxTween.tween(creditsart, { y: -360}, 1, {ease: FlxEase.quadInOut});

				case 5:
				socialart.y = 400;
				FlxTween.tween(socialart, { y: -360}, 1, {ease: FlxEase.quadInOut});
				}
			}
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				switch (curSelected)
				{
					case 0:
					FlxTween.tween(storyart, { y: -380}, 0.3, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									FlxTween.tween(storyart, { y: 400}, 1, {ease: FlxEase.quadInOut});
								}
							});

					case 1:
					FlxTween.tween(freeplayart, { y: -380}, 0.3, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									FlxTween.tween(freeplayart, { y: 400}, 1, {ease: FlxEase.quadInOut});
								}
							});

					case 2:
					FlxTween.tween(optionsart, { y: -380}, 0.3, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									FlxTween.tween(optionsart, { y: 400}, 1, {ease: FlxEase.quadInOut});
								}
							});
					case 3:
					FlxTween.tween(extrasart, { y: -380}, 0.3, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									FlxTween.tween(extrasart, { y: 400}, 1, {ease: FlxEase.quadInOut});
								}
							});
					case 4:
					FlxTween.tween(creditsart, { y: -380}, 0.3, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									FlxTween.tween(creditsart, { y: 400}, 1, {ease: FlxEase.quadInOut});
								}
							});
					case 5:
					FlxTween.tween(socialart, { y: -380}, 0.3, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									FlxTween.tween(socialart, { y: 400}, 1, {ease: FlxEase.quadInOut});
								}
							});
					}

					FlxTween.tween(menutriangles, { y: -380}, 0.3, {ease: FlxEase.quadInOut});
					FlxTween.tween(trianglesclone, { y: -380}, 0.3, {ease: FlxEase.quadInOut});
					FlxTween.tween(story, { y: 210}, 0.3, {ease: FlxEase.quadInOut});
					FlxTween.tween(freeplay, { y: 210}, 0.3, {ease: FlxEase.quadInOut});
					FlxTween.tween(options, { y: 210}, 0.3, {ease: FlxEase.quadInOut});
					FlxTween.tween(extras, { y: 210}, 0.3, {ease: FlxEase.quadInOut});
					FlxTween.tween(credits, { y: 210}, 0.3, {ease: FlxEase.quadInOut});
					FlxTween.tween(camera, { zoom: 1.5, y: 0}, 0.3, {ease: FlxEase.quadInOut});
					FlxTween.tween(social, { y: 210}, 0.3, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									FlxTween.tween(camera, { y: -800}, 1, {ease: FlxEase.quadInOut});
									FlxTween.tween(menutriangles, { y: 400}, 1, {ease: FlxEase.quadInOut});
									FlxTween.tween(trianglesclone, { y: 400}, 1, {ease: FlxEase.quadInOut});
									FlxTween.tween(story, { y: 990}, 1, {ease: FlxEase.quadInOut});
									FlxTween.tween(freeplay, { y: 990}, 1, {ease: FlxEase.quadInOut});
									FlxTween.tween(options, { y: 990}, 1, {ease: FlxEase.quadInOut});
									FlxTween.tween(extras, { y: 990}, 1, {ease: FlxEase.quadInOut});
									FlxTween.tween(credits, { y: 990}, 1, {ease: FlxEase.quadInOut});
									FlxTween.tween(social, { y: 990}, 1, {ease: FlxEase.quadInOut});
								}
							});
			




				if (optionShit[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://www.youtube.com/channel/UCvOv75LKEwqLFYtndUcfC8w", "&"]);
					#else
					FlxG.openURL('https://www.youtube.com/channel/UCvOv75LKEwqLFYtndUcfC8w');
					#end
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
		//	spr.screenCenter(X);
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'freeplay':
				FlxG.switchState(new FreeplayState());

				trace("Freeplay Menu Selected");

			case 'credits':
				FlxG.switchState(new CreditsMenu());

			case 'options':
				FlxG.switchState(new OptionsMenu());
			case 'extras':
				FlxG.switchState(new GalleryState());
			case 'social':
				FlxG.switchState(new GameJoltLogin());
		}
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 5;
		if (curSelected < 0)
			curSelected = 0;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				//camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}