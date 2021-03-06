forward SendClientMessageRus(playerid, color, message[]);
forward SendClientMessageToAllRus(color, message[]);
forward GameTextForPlayerRus(playerid, text[], time, style);
forward GameTextForAllRus(text[], time, style);
forward FixRus(string[]);
forward encodingRus(text[]);

new gtext[256];

public SendClientMessageRus(playerid, color, message[])
{
	message[0] = message[0]%256;
	SendClientMessage(playerid, color, message);
	return 1;
}

public SendClientMessageToAllRus(color, message[])
{
	message[0] = message[0]%256;
	SendClientMessageToAll(color,message);
	return 1;
}

public encodingRus(text[])
{
	new length = strlen(text);
	for(new i; i < length; i++)
	{
		switch(text[i]%256)
		{
			case '�', '�': gtext[i] = 'A';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = 'E';
			case '�', '�': gtext[i] = 'E';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = 'K';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = 'M';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = 'O';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = 'P';
			case '�', '�': gtext[i] = 'C';
			case '�', '�': gtext[i] = 'T';
			case '�', '�': gtext[i] = 'Y';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = 'X';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			case '�', '�': gtext[i] = '�';
			default: gtext[i] = text[i]%256;
		}
        gtext[length] = 0;
	}
}

public GameTextForPlayerRus(playerid, text[], time, style)
{
	encodingRus(text);
	GameTextForPlayer(playerid, gtext, time, style);
	return 1;
}

public GameTextForAllRus(text[], time, style)
{
	encodingRus(text);
	GameTextForAll(gtext, time, style);
	return 1;
}

public FixRus(string[])
{
	new length = strlen(string);
	for(new i = 0; i < length; i++)
	{
		string[i] = string[i]%256;
	}
	return 1;
}

stock strlower(txt[])
{
    new tmp[512];
    tmp[0]=0;
    if (txt[0]==0) return tmp;
    new i=0;
    for (i=0;i<strlen(txt);i++) {
        if(txt[i] >= 'A' && txt[i] <= 'Z' || txt[i] >= '�' && txt[i] <= '�')
			tmp[i] = txt[i] + 32;
		else if(txt[i] == '�')
			tmp[i] = '�';
		else
			tmp[i] = txt[i];
    }
    tmp[strlen(txt)]=0;
    return tmp;
}