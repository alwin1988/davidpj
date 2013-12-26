////////////////////////////////////////////////////////////////////////////////
//
//  SHINYNET
//  Copyright 2012 SHINYNET
//  All Rights Reserved.
//
//  NOTICE: Shinynet permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
/////////////////////////////////////////////////////////////////////////////

package com.shinynet.shinylib.components
{
import mx.core.ContainerCreationPolicy;
import mx.core.IDeferredContentOwner;
import mx.core.IDeferredInstance;
import mx.core.IFlexModuleFactory;
import mx.events.FlexEvent;

import spark.components.Group;

//--------------------------------------
//  Events
//--------------------------------------

/**
 *  Dispatched after the content for this component has been created. With deferred 
 *  instantiation, the content for a component may be created long after the 
 *  component is created.
 *
 *  @eventType mx.events.FlexEvent.CONTENT_CREATION_COMPLETE
 */
[Event(name="contentCreationComplete", type="mx.events.FlexEvent")]

//--------------------------------------
//  Excluded APIs
//--------------------------------------

[DefaultProperty("mxmlContentFactory")]

/**
 * 
 * @author Devin
 * 
 */
public class DeferredContentGroup extends Group implements IDeferredContentOwner
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 
	 */	
	public function DeferredContentGroup()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Properties 
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  moduleFactory
	//----------------------------------
	
	/**
	 *  @private
	 */
	override public function set moduleFactory(moduleFactory:IFlexModuleFactory):void
	{
		super.moduleFactory = moduleFactory;
		
		// Register the _creationPolicy style as inheriting. See the creationPolicy
		// getter for details on usage of this style.
		styleManager.registerInheritingStyle("_creationPolicy");
	}
	
	//--------------------------------------------------------------------------
	//
	//  Implemented properties: IDeferredContentOwner
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  creationPolicy
	//----------------------------------
	
	// Internal flag used when creationPolicy="none".
	// When set, the value of the backing store _creationPolicy
	// style is "auto" so descendants inherit the correct value.
	private var creationPolicyNone:Boolean = false;
	
	[Inspectable(enumeration="auto,all,none", defaultValue="auto")]
	/**
	 *  @inheritDoc
	 *
	 *  @default auto
	 */
	public function get creationPolicy():String
	{
		// Use an inheriting style as the backing storage for this property.
		// This allows the property to be inherited by either mx or spark
		// containers, and also to correctly cascade through containers that
		// don't have this property (ie Group).
		// This style is an implementation detail and should be considered
		// private. Do not set it from CSS.
		var result:String = getStyle("_creationPolicy");
		
		if (result == null)
			result = ContainerCreationPolicy.AUTO;
		
		if (creationPolicyNone)
			result = ContainerCreationPolicy.NONE;
		
		return result;
	}
	
	/**
	 *  @private
	 */
	public function set creationPolicy(value:String):void
	{
		if (value == ContainerCreationPolicy.NONE)
		{
			// creationPolicy of none is not inherited by descendants.
			// In this case, set the style to "auto" and set a local
			// flag for subsequent access to the creationPolicy property.
			creationPolicyNone = true;
			value = ContainerCreationPolicy.AUTO;
		}
		else
		{
			creationPolicyNone = false;
		}
		
		setStyle("_creationPolicy", value);
	}
	
	//----------------------------------
	//  deferredContentCreated
	//----------------------------------
	
	private var _deferredContentCreated:Boolean;
	
	[Bindable("contentCreationComplete")]
	/**
	 *  Contains <code>true</code> if deferred content has been created.
	 */
	public function get deferredContentCreated():Boolean
	{
		return _deferredContentCreated;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  mxmlContentFactory
	//----------------------------------
	
	/** 
	 *  @private
	 *  Backing variable for the contentFactory property.
	 */
	private var _mxmlContentFactory:IDeferredInstance;
	
	/**
	 *  @private
	 *  Flag that indicates whether or not the content has been created.
	 */
	private var mxmlContentCreated:Boolean = false;
	
	[InstanceType("Array")]
	[ArrayElementType("mx.core.IVisualElement")]
	
	/**
	 *  A factory object that creates the initial value for the
	 *  <code>content</code> property.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public function set mxmlContentFactory(value:IDeferredInstance):void
	{
		if (value == _mxmlContentFactory)
			return;
		
		_mxmlContentFactory = value;
		mxmlContentCreated = false;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Create content children, if the <code>creationPolicy</code> property 
	 *  is not equal to <code>none</code>.
	 */
	override protected function createChildren():void
	{
		super.createChildren();
		
		// TODO (rfrishbe): When navigator support is added, this is where we would 
		// determine if content should be created now, or wait until
		// later. For now, we always create content here unless
		// creationPolicy="none".
		createContentIfNeeded();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Implemented methods: IDeferredContentOwner
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Create the content for this component. 
	 *  When the <code>creationPolicy</code> property is <code>auto</code> or
	 *  <code>all</code>, this function is called automatically by the Flex framework.
	 *  When <code>creationPolicy</code> is <code>none</code>, you call this method to initialize
	 *  the content.
	 */
	public function createDeferredContent():void
	{
		if (!mxmlContentCreated)
		{
			mxmlContentCreated = true;
			
			if (_mxmlContentFactory)
			{
				var deferredContent:Object = _mxmlContentFactory.getInstance();
				mxmlContent = deferredContent as Array;
				_deferredContentCreated = true;
				dispatchEvent(new FlexEvent(FlexEvent.CONTENT_CREATION_COMPLETE));
			}
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @private
	 */
	private function createContentIfNeeded():void
	{
		if (!mxmlContentCreated && creationPolicy != ContainerCreationPolicy.NONE)
			createDeferredContent();
	}
	
}
}