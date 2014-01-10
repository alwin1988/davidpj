
////////////////////////////////////////////////////////////////////////////////
//
//  SHINYNET
//  Copyright 2011 SHINYNET
//  All Rights Reserved.
//
//  NOTICE: Shinynet permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package com.shinynet.shinylib.formatters
{
import spark.formatters.NumberFormatter;

/**
 * 
 * @author Devin
 * 
 */
public class PercentFormatter extends NumberFormatter
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 
	 */	
	public function PercentFormatter()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inheritDoc 
	 */	
	override public function format(value:Object):String
	{
		if (value == null)
			return null;
		
		const number:Number = Number(value);
		
		if (isNaN(number))
			return super.format(value);
		else
			return super.format(number * 100) + "%";
	}
	
}
}