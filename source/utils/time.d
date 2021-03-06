module utils.time;

import std.conv;
import std.array;
import std.string;
import std.datetime;
import std.digest.md;
import std.digest.sha;
import std.algorithm.searching;
import std.experimental.logger;
import core.stdc.time;

class Time
{
	public static int getCurrUnixStrampInt()
	{
		SysTime currentTime = cast(SysTime)Clock.currTime();
		time_t time = currentTime.toUnixTime;
		return safeConvert!(time_t,int)(time);
	}

	public static string getCurrUnixStramp()
	{
		SysTime currentTime = cast(SysTime)Clock.currTime();
		time_t time = currentTime.toUnixTime;
		return safeConvert!(time_t,string)(time);
	}
	
    public static string getCurrStringDate()
	{
		return unixStrampToDate(getCurrUnixStrampInt());
	}

	public static int getFormatUnixStramp(string date)
	{
		return dateToUnixStramp(date);
	}

	public static string unixStrampToDate(int stramp)
	{
		try 
		{
			auto currentTime = SysTime.fromUnixTime(to!long(stramp));

			auto year = currentTime.year;
			auto month = currentTime.month;
			auto day = currentTime.day;
			auto hour = currentTime.hour;
			auto minute = currentTime.minute;
			auto second = currentTime.second;

			return to!string(format("%s-%s-%s %s:%s:%s",to!string(year),to!string(getMonth(to!string(month))),to!string(day),
						to!string(hour),to!string(minute),to!string(second)));
		}
		catch(Exception e)
		{
			return string.init;
		}
	}

	public static int dateToUnixStramp(string date)
	{
		try 
		{
			auto sdate = split(date," ");
			auto sfdate = split(sdate[0],"-");
			auto ssdate = split(sdate[1],":");
			auto stime = sfdate[0] ~ "-" 
				~ dateLenChange(sfdate[1]) ~ "-" 
				~ dateLenChange(sfdate[2])
				~ "T"
				~ dateLenChange(ssdate[0]) ~ ":"
				~ dateLenChange(ssdate[1]) ~ ":"
				~ dateLenChange(ssdate[2])
				;
			auto fdate = SysTime.fromISOExtString(stime);
			auto ftdate = fdate.toUnixTime;
			auto iftdate =  safeConvert!(time_t,int)(ftdate);	
			return iftdate;
		}
		catch(Exception e)
		{
			return int.init;
		}
	}
	
    private static int getMonth(string month)
	{
		switch (month) 
		{
			case "jan" : return 1;
			case "feb" : return 2;
			case "mar" : return 3;
			case "apr" : return 4;
			case "may" : return 5;
			case "jun" : return 6;
			case "jul" : return 7;
			case "aug" : return 8;
			case "sep" : return 9;
			case "oct" : return 10;
			case "nov" : return 11;
			case "dec" : return 12;
			default : return 0;
		}
	} 

	private static string dateLenChange(string str)
	{
		if(str.length == 1)
		{
			str = "0" ~ str;
		}
		return str;
	}

	private static T safeConvert(F,T)(F value)
	{
		try
		{
			return to!T(value);
		}
		catch
		{
			return T.init;
		}
	}
}
