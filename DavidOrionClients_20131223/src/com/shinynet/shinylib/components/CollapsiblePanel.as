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
import flash.display.InteractiveObject;
import flash.events.MouseEvent;

import spark.components.Panel;

/**
 *  The length of the transition when the panel closes, in milliseconds.
 * 
 *  The default value 250.
 */
[Style(name="closeDuration", type="Number", format="Time", inherit="no")]

/**
 *  Length of the transition when the panel opens, in milliseconds.
 *
 *  The default value  is 250.
 */
[Style(name="openDuration", type="Number", format="Time", inherit="no")]

/**
 * 
 * @author Devin
 * 
 */
public class CollapsiblePanel extends Panel
{

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 
	 */	
	public function CollapsiblePanel()
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
	private var cachedWidth:Number;
	
	//--------------------------------------------------------------------------
	//
	//  Skin parts
	//
	//--------------------------------------------------------------------------
	
	[SkinPart(required="true")]
	/**
	 * The clickable area to expand/collapse the panel.
	 */	
	public var collapseArea:InteractiveObject;
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  collapsed
	//----------------------------------
	
	/**
	 * @private
	 * Storage for the collapsed property.
	 */
	private var _collapsed:Boolean;
	
	/**
	 * 
	 */
	public function get collapsed():Boolean
	{
		return _collapsed;
	}
	
	/**
	 * @private
	 */
	public function set collapsed(value:Boolean):void
	{
		if (_collapsed == value)
			return;
		
		_collapsed = value;
		invalidateSkinState();
	}
	
	
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: UIComponent
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private 
	 */	
	override protected function measure():void
	{
		super.measure();
		
		if (_collapsed && !isNaN(cachedWidth))
			measuredWidth = cachedWidth;
		else
			cachedWidth = measuredWidth;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: SkinnableComponent
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private 
	 */	
	override protected function getCurrentSkinState():String
	{
		var skinState:String = super.getCurrentSkinState();
		
		if (_collapsed)
		{
			if (skinState == "disabled")
				return "collapsedAndDisabled"
			else
				return "collapsed";
		}
		return skinState;
	}
	
	/**
	 * @private 
	 */	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == collapseArea)
		{
			collapseArea.addEventListener(MouseEvent.CLICK, collapseArea_clickHandler);
		}
	}
	
	/**
	 * @private 
	 */	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		if (instance == collapseArea)
		{
			collapseArea.removeEventListener(MouseEvent.CLICK, collapseArea_clickHandler);
		}
		
		super.partRemoved(partName, instance);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private 
	 */	
	protected function collapseArea_clickHandler(event:MouseEvent):void
	{
		collapsed = !collapsed;
	}
	
}
}