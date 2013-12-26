
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
import flash.events.FocusEvent;

import mx.events.FlexEvent;
import mx.formatters.IFormatter;

import spark.components.TextInput;
import spark.core.IDisplayText;

//----------------------------------
//  Skin states
//----------------------------------

/**
 * 
 */
[SkinState("normalWithFormatter")]

/**
 * 
 */
[SkinState("disabledWithFormatter")]

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
public class FormattedTextInput extends TextInput
{

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 
	 */	
	public function FormattedTextInput()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private 
	 */	
	private var isFocused:Boolean;
	
	//--------------------------------------------------------------------------
	//
	//  Skin parts
	//
	//--------------------------------------------------------------------------
	
	[SkinPart(required="true")]
	/**
	 * 
	 */	
	public var formattedDisplay:IDisplayText;
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  suggestedFocusSkinExclusions
	//----------------------------------
	/** 
	 * @private 
	 */     
	private static const focusExclusions:Array = ["textDisplay","formattedDisplay"];
	
	/**
	 *  @private
	 */
	override public function get suggestedFocusSkinExclusions():Array
	{
		return focusExclusions;
	}
	
	//----------------------------------
	//  text
	//----------------------------------
	
	/**
	 *  @private
	 */
	override public function set text(value:String):void
	{
		super.text = value;
		
		if (_formatter)
			formattedDisplay.text = _formatter.format(value);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  formatter
	//----------------------------------
	
	/**
	 * @private
	 * Storage for the formatter property.
	 */
	private var _formatter:IFormatter;
	
	/**
	 * 
	 */
	public function get formatter():IFormatter
	{
		return _formatter;
	}
	
	/**
	 * @private
	 */
	public function set formatter(value:IFormatter):void
	{
		if (_formatter == value)
			return;
		
		_formatter = value;
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
		
		if (!isFocused)
		{
			if (skinState == "normal" || skinState == "disabled")
				skinState += "WithFormatter";
		}
		
		return skinState;
	}
	
	/**
	 * @inheritDoc 
	 */	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == textDisplay)
		{
			textDisplay.addEventListener(FlexEvent.VALUE_COMMIT, textDisplay_valueCommitHandler);
		}
		if (instance == formattedDisplay)
		{
			if (_formatter)
				formattedDisplay.text = _formatter.format(text);
		}
	}
	
	/**
	 * @inheritDoc 
	 */	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		if (instance == formattedDisplay)
		{
			formattedDisplay.text = null;
		}
		
		super.partRemoved(partName, instance);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//--------------------------------------------------------------------------
	
	private function textDisplay_valueCommitHandler(event:FlexEvent):void
	{
		if (_formatter)
			formattedDisplay.text = _formatter.format(text);
	}
	
	/**
	 * @private 
	 */	
	override protected function focusInHandler(event:FocusEvent):void
	{
		super.focusInHandler(event);
		
		isFocused = true;
		invalidateSkinState();
	}

	/**
	 * @private 
	 */	
	override protected function focusOutHandler(event:FocusEvent):void
	{
		super.focusOutHandler(event);
		
		isFocused = false;
		invalidateSkinState();
	}
	
}
}