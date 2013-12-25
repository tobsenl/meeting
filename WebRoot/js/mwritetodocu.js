for (var i = 0; i < arrFirstClass.length; i++) {
	if (arrSecondClass[i].length>0)	
	{
		if(i < arrFirstClass.length-1)	
		{			
			mpmenu = new mMenu(arrFirstClass[i][1] +"<span style='margin-left: 4px;'>|</span>","",'self','','','','');			
		} 
		else
		{
		mpmenu = new mMenu(arrFirstClass[i][1],"",'self','','','','');
		}
	} 
	else 
	{
		if(i < arrFirstClass.length-1)	
		{
			mpmenu = new mMenu(arrFirstClass[i][1] +"<span style='margin-left: 4px;'>&nbsp;|</span>",arrFirstClass[i][2],'self','','','','');	
		} 
		else
		{
			mpmenu = new mMenu(arrFirstClass[i][1],arrFirstClass[i][2],'self','','','','');	
		}
	} 
	for (var k = 0; k < arrSecondClass[i].length; k++) {
	  mpmenu.addItem(new mMenuItem(arrSecondClass[i][k][1],arrSecondClass[i][k][2] + "&picNum=" + i ,'self',false,arrSecondClass[i][k][2] + "&picNum=" + i ,null,'','','',''));
	}
}
mwritetodocument();