import std.stdio;
import core.stdc.stdlib;

import utils;

void main(string[] args)
{
    writeln("sqliteD Version 0.0.1 "~Time.getCurrStringDate~
			"\nEnter \".help\" for instructions\nEnter SQL statements terminated with a \";\"");
	write("sqlited>");
	string line;
	while ((line = stdin.readln()) !is null){
		write(line);
		switch(line){
			case ".exit\n":
				exit(0);
				break;
			case ".help\n":
				break;
			default:
				writeln("Error: syntax error");
		}
		write("sqlited>");
	}
}
