/*
    HTMLToolTip - ToolTip customization to support HTML.
    Copyright (C) 2010  Blogagic (http://blogagic.com/)
    
    Custom ToolTip class supporting HTML tags in the tooltip text.
    
    To replace the default ToolTip class by the custom HTMLToolTip class, 
    just call (in the creationComplete() handler of your application for example):
    		ToolTipManager.toolTipClass = HTMLToolTip;
    
    Tooltip text can then include the HTML tags supported by Flex.
    (refer to Adobe LiveDocs for all details, section Using the htmlText property, available
    at: http://livedocs.adobe.com/flex/3/html/help.html?content=textcontrols_04.html )
    
	Example:
		var tip:String;
		tip = "<font color='#076baa' size='+4'><b>Easily style your tooltips:</b></font><br><br>";
		tip += "<i>Italic</i>, <b>Bold</b>, <i><b>Bold+Italic</b></i>, <u>Underlined</u>, ...<br>";
		tip += "<br><font color='#FF0000'><b>Choose your favorite color</b></font><br>";
		tip += "<br><font size='24'>Use a big font size</font><br>";
		tip += "<font size='6'>or a very small one</font>";			
		myObject.toolTip = tip;

	Note: I hadn't been able to determine who was the first to find this trick but, clearly,
	this was not me :-) So credit goes to this unknown flex coder! 
	My small contribution is just about updated	comments and the small demo application illustrating 
	the capabilities brought by this quick and easy customization.
		
    Licensed under the Creative Commons BSD Licence
	http://creativecommons.org/licenses/BSD/
*/

package com.blogagic.util
{
    import mx.controls.ToolTip;
	 
    public class HTMLToolTip extends ToolTip
    {
        public function HTMLToolTip()
        {    super(); }

		/***
		 * commitProperties is called whenever the tooltip text is changed
		 * Just copy the new text in the htmlText property of the IUITextField
		 * embedded in ToolTip object and you're done!
		 ***/
		
        override protected function commitProperties():void{
            super.commitProperties();
            textField.htmlText = text;
        }
    }
}

