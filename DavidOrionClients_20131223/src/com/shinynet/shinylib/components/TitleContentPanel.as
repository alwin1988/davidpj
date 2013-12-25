
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
import spark.components.Group;
import spark.components.Panel;
import spark.layouts.supportClasses.LayoutBase;

//----------------------------------
//  Skin states
//----------------------------------

/**
 * 
 */
[SkinState("normalWithTitleContent")]

/**
 * 
 */
[SkinState("disabledWithTitleContent")]

/**
 * 
 */
[SkinState("normalWithControlBarAndTitleContent")]

/**
 * 
 */
[SkinState("disabledWithControlBarAndTitleContent")]

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
 * The TitleContentPanel class defines a Panel container that adds a title
 * area and an action area. 
 *
 *  @mxml
 *  
 * <p>The <code>&lt;s:Panel&gt;</code> tag inherits all of the tag 
 * attributes of its superclass and adds the following tag attributes:</p>
 *  
 * <pre>
 * &lt;s:Panel
 *  <strong>Properties</strong>
 *   titleConent="null"
 *   titleConentLayout="HorizontalLayout"
 *   actionContent="null"
 *   actionContentLayout="HorizontalLayout"
 *  &gt;
 *     ...
 *     <i>child tags</i>
 *     ...
 * &lt;/s:Panel&gt;
 * </pre>
 *
 * @see com.shinynet.shinylib.components.TitleContentPanelSkin
 */
public class TitleContentPanel extends Panel
{

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 
	 */	
	public function TitleContentPanel()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Skin parts
	//
	//--------------------------------------------------------------------------
	
	[SkinPart(required="false")]
	/**
	 * The skin part that defines the appearance of the 
	 * title content area of the container.
	 * By default, the TitleContentPanelSkin class defines the title content
	 * area to appear at the left of the title area of the TitleContentPanel. 
	 *
	 *  @see com.shinynet.shinylib.skins.TitleContentPanelSkin
	 */	
	public var titleContentGroup:Group;
	
	
	[SkinPart(required="false")]
	/**
	 * The skin part that defines the appearance of the 
     * action content area of the container.
     * By default, the TitleContentPanelSkin class defines the action content
	 * area to appear at the right of the title area of the TitleContentPanel. 
     *
     *  @see com.shinynet.shinylib.skins.TitleContentPanelSkin
	 */	
	public var actionContentGroup:Group;
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//--------------------------------------
	//  titleContent
	//--------------------------------------
	
	/**
	 * @private 
	 */	
	private var _titleContent:Array;
	
	[ArrayElementType("mx.core.IVisualElement")]
	/**
	 * The set of components to include in the title content area of the 
	 * TitleContentPanel container.
	 * 
	 * <p>The location and appearance of the title content area of the
	 * TitleContentPanel container is determined by the
	 * com.shinynet.shinylib.skins.TitleContentPanelSkin class. 
	 * By default, the TitleContentPanelSkin class defines the title content
	 * area to appear at the left of the title area of the TitleContentPanel
	 * container.</p>
	 *
	 *  @default null
	 */
	public function get titleContent():Array
	{
		return _titleContent;
	}
	
	/**
	 * @private
	 */
	public function set titleContent(value:Array):void
	{
		_titleContent = value;
		
		if (titleContentGroup)
			titleContentGroup.mxmlContent = value;
	}
	
	//--------------------------------------
	//  actionContent
	//--------------------------------------
	
	/**
	 * @private 
	 */	
	private var _actionContent:Array;

	[ArrayElementType("mx.core.IVisualElement")]
	/**
	 * The set of components to include in the action content area of the 
     * TitleContentPanel container.
	 * 
	 * <p>The location and appearance of the action content area of the
	 * TitleContentPanel container is determined by the
	 * com.shinynet.shinylib.skins.TitleContentPanelSkin class. 
     * By default, the TitleContentPanelSkin class defines the action content
	 * area to appear at the right of the title area of the TitleContentPanel
	 * container.</p>
     *
     *  @default null
	 */
	public function get actionContent():Array
	{
		return _actionContent;
	}

	/**
	 * @private
	 */
	public function set actionContent(value:Array):void
	{
		_actionContent = value;
		
		if (actionContentGroup)
			actionContentGroup.mxmlContent = value;
	}
	
	//--------------------------------------
	//  titleContentLayout
	//--------------------------------------
	
	/**
	 * @private 
	 */	
	private var _titleContentLayout:LayoutBase;
	
	/**
	 * Defines the layout of the title conent area of the container.
	 * 
	 * @default HorizontalLayout
	 */
	public function get titleContentLayout():LayoutBase
	{
		return (titleContentGroup) 
		? titleContentGroup.layout
			: _titleContentLayout;
	}
	
	/**
	 * @private
	 */
	public function set titleContentLayout(value:LayoutBase):void
	{
		_titleContentLayout = value;
		
		if (titleContentGroup)
			titleContentGroup.layout = value;
	}
	
	//--------------------------------------
	//  actionContentLayout
	//--------------------------------------
	
	/**
	 * @private 
	 */	
	private var _actionContentLayout:LayoutBase;

	/**
	 * Defines the layout of the action content area of the container.
	 * 
	 * @default HorizontalLayout
	 */
	public function get actionContentLayout():LayoutBase
	{
		return (actionContentGroup) 
			? actionContentGroup.layout
			: _actionContentLayout;
	}

	/**
	 * @private
	 */
	public function set actionContentLayout(value:LayoutBase):void
	{
		_actionContentLayout = value;
		
		if (actionContentGroup)
			actionContentGroup.layout = value;
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
		var skinSkate:String = super.getCurrentSkinState();
		
		if (_titleContent)
		{
			if (skinSkate == "normal" || skinSkate == "disabled")
				skinSkate += "WithTitleContent";
			else
				skinSkate += "AndTitleContent";
		}
		
		return skinSkate;
	}
	
	/**
	 * @inheritDoc 
	 */	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == titleContentGroup)
		{
			titleContentGroup.mxmlContent = _titleContent;
			
			if (_titleContentLayout)
				titleContentGroup.layout = _titleContentLayout;
		}
		else if (instance == actionContentGroup)
		{
			actionContentGroup.mxmlContent = _actionContent;
			
			if (_actionContentLayout)
				actionContentGroup.layout = _actionContentLayout;
		}
	}
	
	/**
	 * @inheritDoc 
	 */	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		if (instance == titleContentGroup)
		{
			titleContentGroup.mxmlContent = null;
			titleContentGroup.layout = null;
		}
		else if (instance == actionContentGroup)
		{
			actionContentGroup.mxmlContent = null;
			actionContentGroup.layout = null;
		}
		
		super.partRemoved(partName, instance);
	}

}
}