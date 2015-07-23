package;

/**
 * ...
 * @author RSGmaker
 */
class Yinyangorb extends Enemy
{

	public var accel:Float;
	
	public var mxspd:Float;
	public function new() 
	{
		//super(main, "RedFairy");
		super("yinyangorb");
		//this.charname = "RedFairy";
		accel = 0.4;
		deccel = 0.1;
		mxspd = 5;
		Ldir = 1;
		killed = false;
		flipped = -1;
		pointvalue = 100;
		fallaccel *= 0.5;
		image.image_speed = 1;
		needtokill = false;
		reward = false;
		//respawn = false;
	}
	public override function increaserank()
	{
			//accel += 0.1;
			//mxspd += 0.5;
			pointvalue += 50;
	}
	override public function update():Void 
	{
		//super.update();
		this.scaleX = 0.7;
		this.scaleY = 0.7;
		//rotateentity(rotation + 10);
		
	if (!started)
		{
			/*var i = 0;
			while (i < rank)
			{
				accel += 0.1;
				mxspd += 0.5;
				pointvalue += 50;
				i++;
			}*/
			started = true;
		}
		/*accel = 0.5;
		deccel = 0.1;
		mxspd = 4;*/
		if (enraged)
		{
			//accel += 0.2;
			//mxspd += 2;
		}
		if (!killed)
		{
		var dir = Ldir;
		if (flipped > 0)
		{
			flipped -= 1;
			dangerous = false;
			if (flipped == 0)
			{
				flipped = -1;
				powerup();
			}
		}
		else
		{
			dangerous = true;
		}
		if (Hspeed < mxspd && dir==1 && flipped < 1)
		{
			Hspeed += accel;
			if (Hspeed > mxspd)
			{
				Hspeed = mxspd;
			}
		}
		if (Hspeed > -mxspd && dir==-1 && flipped < 1)
		{
			Hspeed -= accel;
			if (Hspeed < -mxspd)
			{
				Hspeed = -mxspd;
			}
		}
		if (ground != null && Vspeed == 0 && flipped <= 0)
		{
			/*if (game.CollisionDetectPoint(x + (Math.floor(width) >> 1), y - (192-96)) == null)
			{
				if (Hspeed > 0)
				{
					if (game.CollisionDetectPoint(x + (Math.floor(width) >> 1) + 96, y - (192 - 96)) != null)
					{
						Vspeed = -15;
					}
				}
				if (Hspeed < 0)
				{
					if (game.CollisionDetectPoint(x + (Math.floor(width) >> 1) - 96, y - (192 - 96)) != null)
					{
						Vspeed = -15;
					}
				}
				//Vspeed = -16;
			}*/
			Vspeed = -8;
		}
		updphysics();
		updateanimation();
		animate();
		
		if (ground != null)
		{
			//if (ground.bonked > -1000 && game.Hoster && game.myplayer == ground.bonkedby)
			if (ground.bonked > -1000 && Vspeed>=0)
			{
				//if (game.ismyplayer(ground.bonkedby) && game.Hoster)
				if (game.myplayer == ground.bonkedby)
				{
				//Vspeed = -4;
				//flipped = 30 * 10;
				var D:Dynamic = { };
				D.UID = UID;
				D.x = x;
				D.y = y;
				D.Hspeed = Hspeed;
				D.Vspeed = -10;
				//game.SendEvent("Bump", this.UID);
				game.SendEvent("Bump", D);
				}
			}
			else
			{
				//if ((controller[1]) && Vspeed == 0)
				if (flipped>0 && flipped < 60)
				{
					//bounce to indicate about to recover
					Vspeed = -4;
					//Vspeed = -13;
				}
			}
			
		}
			//if (y > 408 && wrapped)
			if (y > 408 && wrapped)
			{
				alive = false;
				killed = true;
				visible = false;
			}
		killable = flipped > 0;
	}
	else
	{
		y += 15;
	if (y > 600)
	{
	alive = false;
	}
	}
	}
	
	public override function bump()
	{
		//Vspeed = -4;
		/*if (flipped < 1)
		{
			if (enraged)
			{
				flipped = 30 * 4;
			}
			else
			{
				flipped = 30 * 7;
			}
		}
		else
		{
			flipped = 0;
		}*/
		alive = false;
		killed = true;
		if (ground != null && ground.bonkedby != null && ground.bonkedby.type=="Player")
		{
			var D:Dynamic = ground.bonkedby;
			D.score += pointvalue;
		}
	}
	
}