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
			case 'À', 'à': gtext[i] = 'A';
			case 'Á', 'á': gtext[i] = '€';
			case 'Â', 'â': gtext[i] = '‹';
			case 'Ã', 'ã': gtext[i] = '™';
			case 'Ä', 'ä': gtext[i] = 'ƒ';
			case 'Å', 'å': gtext[i] = 'E';
			case '¨', '¸': gtext[i] = 'E';
			case 'Æ', 'æ': gtext[i] = '„';
			case 'Ç', 'ç': gtext[i] = 'ˆ';
			case 'È', 'è': gtext[i] = '…';
			case 'É', 'é': gtext[i] = '†';
			case 'Ê', 'ê': gtext[i] = 'K';
			case 'Ë', 'ë': gtext[i] = '‡';
			case 'Ì', 'ì': gtext[i] = 'M';
			case 'Í', 'í': gtext[i] = 'ì';
			case 'Î', 'î': gtext[i] = 'O';
			case 'Ï', 'ï': gtext[i] = 'Œ';
			case 'Ð', 'ð': gtext[i] = 'P';
			case 'Ñ', 'ñ': gtext[i] = 'C';
			case 'Ò', 'ò': gtext[i] = 'T';
			case 'Ó', 'ó': gtext[i] = 'Y';
			case 'Ô', 'ô': gtext[i] = 'Ö';
			case 'Õ', 'õ': gtext[i] = 'X';
			case 'Ö', 'ö': gtext[i] = '‰';
			case '×', '÷': gtext[i] = '';
			case 'Ø', 'ø': gtext[i] = 'Ž';
			case 'Ù', 'ù': gtext[i] = 'Š';
			case 'Ú', 'ú': gtext[i] = '';
			case 'Û', 'û': gtext[i] = '‘';
			case 'Ü', 'ü': gtext[i] = '’';
			case 'Ý', 'ý': gtext[i] = '“';
			case 'Þ', 'þ': gtext[i] = '”';
			case 'ß', 'ÿ': gtext[i] = '•';
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
    new tmp[MAX_TEXTSTR];
    tmp[0]=0;
    if (txt[0]==0) return tmp;
    new i=0;
    for (i=0;i<strlen(txt);i++) {
        if(txt[i] >= 'A' && txt[i] <= 'Z' || txt[i] >= 'À' && txt[i] <= 'ß')
			tmp[i] = txt[i] + 32;
		else if(txt[i] == '¨')
			tmp[i] = '¸';
		else
			tmp[i] = txt[i];
    }
    tmp[strlen(txt)]=0;
    return tmp;
}