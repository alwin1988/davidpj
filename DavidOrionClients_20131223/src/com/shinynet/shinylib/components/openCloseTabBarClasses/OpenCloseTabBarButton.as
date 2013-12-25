
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

package com.shinynet.shinylib.components.openCloseTabBarClasses
{
import com.shinynet.shinylib.events.TabBarEvent;

import flash.events.MouseEvent;

import spark.components.Button;
import spark.components.ButtonBarButton;

//--------------------------------------
//  Events
//--------------------------------------

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
public class OpenCloseTabBarButton extends ButtonBarButton
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 
	 */	
	public function OpenCloseTabBarButton()
	{
		super();
		
		mouseChildren = true;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private 
	 */	
	private var showCloseButton:Boolean = true;
	
	//--------------------------------------------------------------------------
	//
	//  Skin parts
	//
	//--------------------------------------------------------------------------
	
	[SkinPart(required="false")]
	/**
	 * 
	 */	
	public var closeButton:Button;
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inheritDoc 
	 */	
	override public function set data(value:Object):void
	{
		super.data = value;
		
		if (value && value.hasOwnProperty("showCloseButton"))
		{
			showCloseButton = Boolean(value.showCloseButton);
			invalidateSkinState();
		}
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
		
		if (showCloseButton)
			skinState += "WithCloseButton";
		
		return skinState;
	}
	
	/**
	 * @inheritDoc 
	 */	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == closeButton)
		{
			closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
		}
	}
	
	/**
	 * @inheritDoc 
	 */	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		
		if (instance == closeButton)
		{
			closeButton.removeEventListener(MouseEvent.CLICK, closeButton_clickHandler);
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
	protected function closeButton_clickHandler(event:MouseEvent):void
	{
		event.stopImmediatePropagation();
		
		dispatchEvent(new TabBarEvent(TabBarEvent.CLOSE, true, true, itemIndex));
	}
	
}
}