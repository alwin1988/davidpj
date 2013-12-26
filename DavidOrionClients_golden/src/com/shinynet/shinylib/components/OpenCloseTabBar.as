
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
import com.shinynet.shinylib.events.TabBarEvent;

import flash.events.MouseEvent;

import mx.core.EventPriority;

import spark.components.Button;
import spark.components.TabBar;

//--------------------------------------
//  Events
//--------------------------------------

/**
 * 
 */
[Event(name="open", type="com.shinynet.shinylib.events.TabBarEvent")]

/**
 * 
 */
[Event(name="close", type="com.shinynet.shinylib.events.TabBarEvent")]

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
public class OpenCloseTabBar extends TabBar
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 
	 */	
	public function OpenCloseTabBar()
	{
		super();
		
		addEventListener(TabBarEvent.CLOSE, closeHandler, false, EventPriority.DEFAULT_HANDLER);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Skin parts
	//
	//--------------------------------------------------------------------------
	
	[SkinPart(required="true")]
	/**
	 * 
	 */	
	public var openButton:Button;
	
	//----------------------------------
	//  showOpenButton
	//----------------------------------
	
	/**
	 * @private
	 * Storage for the showOpenButton property.
	 */
	private var _showOpenButton:Boolean = true;
	
	/**
	 * @default true
	 */
	public function get showOpenButton():Boolean
	{
		return _showOpenButton;
	}
	
	/**
	 * @private
	 */
	public function set showOpenButton(value:Boolean):void
	{
		if (_showOpenButton == value)
			return;
		
		_showOpenButton = value;
	}
	
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: SkinnableComponent
	//
	//--------------------------------------------------------------------------
	
	override protected function getCurrentSkinState():String
	{
		var skinState:String = super.getCurrentSkinState();
		
		if (_showOpenButton)
			skinState += "WithOpenButton";
		
		return skinState;
	}
	
	/**
	 * @inheritDoc 
	 */	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == openButton)
		{
			openButton.addEventListener(MouseEvent.CLICK, openButton_clickHandler);
		}
	}
	
	/**
	 * @inheritDoc 
	 */	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		
		if (instance == openButton)
		{
			openButton.removeEventListener(MouseEvent.CLICK, openButton_clickHandler);
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
	protected function openButton_clickHandler(event:MouseEvent):void
	{
		dispatchEvent(new TabBarEvent(TabBarEvent.OPEN));
	}
	
	/**
	 * @private 
	 */	
	protected function closeHandler(event:TabBarEvent):void
	{
		if (!event.isDefaultPrevented())
			dataProvider.removeItemAt(event.detail);
	}
}
}