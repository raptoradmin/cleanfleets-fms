using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;

//----------------------------------------------------------------------------------------
//-- Copyright (C) 2009 SOHOsoft. All rights reserved.
//--
//-- Description:	Module used to clone an entity object.
//-- Date Created: Tuesday, March 6, 2007
//--
//-- $Archive:  $
//-- $Author: Ptaffet $
//-- $Log:  $
//-- 
//--
//----------------------------------------------------------------------------------------
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

static internal class CloneIt
{

	public static object Clone(object obj)
	{

		using (MemoryStream buffer = new MemoryStream()) {
			BinaryFormatter f = new BinaryFormatter();

			f.Serialize(buffer, obj);
			buffer.Position = 0;
			object o = f.Deserialize(buffer);
			return o;
		}

	}

}
