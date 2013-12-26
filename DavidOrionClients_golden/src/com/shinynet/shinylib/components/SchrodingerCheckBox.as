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

package com.shinynet.shinylib.components
{
import flash.events.Event;

import mx.events.FlexEvent;

import spark.components.CheckBox;

//----------------------------------
//  Skin states
//----------------------------------

/**
 * 
 */
[SkinState("upAndSchrodinger")]

/**
 * 
 */
[SkinState("overAndSchrodinger")]

/**
 * 
 */
[SkinState("downAndSchrodinger")]

/**
 * 
 */
[SkinState("disabledAndSchrodinger")]

//--------------------------------------
//  Other metadata
//--------------------------------------

/**
 * Because this component does not define a skin for the mobile theme, It is
 * recommended that you not use it in a mobile application. Alternatively, you
 * can define your own mobile skin for the component. For more information,
 * see <a href="http://help.adobe.com/en_US/flex/mobileapps/WS19f279b149e7481c698e85712b3011fe73-8000.html">Basics of mobile skinning</a>.
 */
[DiscouragedForProfile("mobileDevice")]

/**
 * 
 * @author Devin
 * 
 */
public class SchrodingerCheckBox extends CheckBox
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 
	 */	
	public function SchrodingerCheckBox()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inheritDoc 
	 */	
	override public function set selected(value:Boolean):void
	{
		_schrodinger = false;
		super.selected = value;
		invalidateSkinState();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  schrodinger
	//----------------------------------
	
	/**
	 * @private
	 * Storage for the schrodinger property.
	 */
	private var _schrodinger:Boolean;
	
	[Bindable("schrodingerChange")]
	/**
	 * 
	 */
	public function get schrodinger():Boolean
	{
		return _schrodinger;
	}
	
	/**
	 * @private
	 */
	public function set schrodinger(value:Boolean):void
	{
		if (_schrodinger == value)
			return;
		
		_schrodinger = value;
		
		if (value)
		{
			setSelected(false);
		}
		
		invalidateSkinState();
		dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
		dispatchEvent(new Event("schrodingerChange"));
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: SkinnableComponent
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inheritDoc 
	 */	
	override protected function getCurrentSkinState():String
	{
		var skinState:String = super.getCurrentSkinState();
		
		if (schrodinger)
			return skinState + "AndSchrodinger";
		
		return skinState;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private 
	 */	
	private function setSelected(value:Boolean):void
	{
		super.selected = value;
	}
	
	
}
}