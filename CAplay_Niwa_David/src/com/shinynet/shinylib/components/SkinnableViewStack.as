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
import mx.core.INavigatorContent;
import mx.core.ISelectableList;
import mx.events.CollectionEvent;
import mx.events.PropertyChangeEvent;
import mx.utils.BitFlagUtil;

import spark.components.SkinnableContainer;
import spark.events.IndexChangeEvent;
import spark.layouts.supportClasses.LayoutBase;

//--------------------------------------
//  Events
//--------------------------------------

/**
 *  Dispatched when the selected child container changes.
 *
 *  @eventType spark.events.IndexChangeEvent.CHANGE
 */
[Event(name="change", type="spark.events.IndexChangeEvent")]

//--------------------------------------
//  Excluded APIs
//--------------------------------------

[Exclude(name="layout", kind="property")]

/**
 * 
 * @author Devin
 * 
 */
public class SkinnableViewStack extends SkinnableContainer implements ISelectableList
{
	
	//--------------------------------------------------------------------------
	//
	//  Class constants
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @private
	 */
	private static const SELECTED_INDEX_PROPERTY_FLAG:uint = 1 << 0;
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function SkinnableViewStack()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @private
	 */
	private var contentGroupProperties:Object = {};
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  layout
	//----------------------------------
	
	/**
	 *  @private
	 */
	override public function get layout():LayoutBase
	{
		return contentGroup.layout; 
	}
	
	/**
	 * @private
	 */
	override public function set layout(value:LayoutBase):void
	{
	}
	
	//--------------------------------------------------------------------------
	//
	//  Properties proxied to contentGroup
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  selectedIndex
	//----------------------------------

	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#selectedIndex 
	 */	
	public function set selectedIndex(value:int):void
	{
		if (contentGroup)
		{
			ISelectableList(contentGroup).selectedIndex = value;
			contentGroupProperties = BitFlagUtil.update(contentGroupProperties as uint, 
				SELECTED_INDEX_PROPERTY_FLAG, true);
		}
		else
			contentGroupProperties.selectedIndex = value;
	}
	
	/**
	 * @private
	 */
	public function get selectedIndex():int
	{
		return (contentGroup) 
			? ISelectableList(contentGroup).selectedIndex 
			: contentGroupProperties.layout;
	}
	
	//----------------------------------
	//  length
	//----------------------------------
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#length
	 */
	public function get length():int
	{
		return ISelectableList(contentGroup).length;
	}
	
	//----------------------------------
	//  selectedChild
	//----------------------------------
	
	[Bindable("valueCommit")]
	[Bindable("creationComplete")]
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#selectedChild 
	 */
	public function get selectedChild():INavigatorContent
	{
		return ViewStack(contentGroup).selectedChild;
	}
	
	/**
	 *  @private
	 */
	public function set selectedChild(value:INavigatorContent):void
	{
		ViewStack(contentGroup).selectedChild = value;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inheritDoc
	 */
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == contentGroup)
		{
			contentGroup.addEventListener(IndexChangeEvent.CHANGE, contentGroup_changeHandler);
			contentGroup.addEventListener(CollectionEvent.COLLECTION_CHANGE, contentGroup_collectionChangeHandler);
			contentGroup.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, contentGroup_propertyChangeHandler);
			
			// copy proxied values from contentGroupProperties (if set) to contentGroup
			
			var newContentGroupProperties:uint = 0;
			
			if (contentGroupProperties.selecedIndex !== undefined)
			{
				ISelectableList(contentGroup).selectedIndex = contentGroupProperties.selectedIndex;
				newContentGroupProperties = BitFlagUtil.update(newContentGroupProperties, 
					SELECTED_INDEX_PROPERTY_FLAG, true);
			}
			
			contentGroupProperties = newContentGroupProperties;
		}
	}
	
	/**
	 * @inheritDoc
	 */
	override protected function partRemoved(partName:String, instance:Object):void
	{
		if (instance == contentGroup)
		{
			contentGroup.removeEventListener(IndexChangeEvent.CHANGE, contentGroup_changeHandler);
			contentGroup.removeEventListener(CollectionEvent.COLLECTION_CHANGE, contentGroup_collectionChangeHandler);
			contentGroup.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, contentGroup_propertyChangeHandler);
			
			// copy proxied values from contentGroup (if explicitely set) to contentGroupProperties
			
			var newContentGroupProperties:Object = {};
			
			if (BitFlagUtil.isSet(contentGroupProperties as uint, SELECTED_INDEX_PROPERTY_FLAG))
				newContentGroupProperties.autoLayout = contentGroup.autoLayout;
			
			contentGroupProperties = newContentGroupProperties;
		}
		
		super.partRemoved(partName, instance);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods proxied to contentGroup
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#addItem
	 */
	public function addItem(item:Object):void
	{
		ISelectableList(contentGroup).addItem(item);
	}
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#addItemAt
	 */
	public function addItemAt(item:Object, index:int):void
	{
		ISelectableList(contentGroup).addItemAt(item, index);
	}
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#getItemAt
	 */
	public function getItemAt(index:int, prefetch:int=0):Object
	{
		return ISelectableList(contentGroup).getItemAt(index, prefetch);
	}
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#getItemIndex
	 */
	public function getItemIndex(item:Object):int
	{
		return ISelectableList(contentGroup).getItemIndex(item);
	}
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#itemUpdated
	 */
	public function itemUpdated(item:Object, property:Object=null, oldValue:Object=null, newValue:Object=null):void
	{
		ISelectableList(contentGroup).itemUpdated(item, property, oldValue, newValue);
	}
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#removeAll
	 */
	public function removeAll():void
	{
		ISelectableList(contentGroup).removeAll();
	}
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#removeItemAt
	 */
	public function removeItemAt(index:int):Object
	{
		return ISelectableList(contentGroup).removeItemAt(index);
	}
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#setItemAt
	 */
	public function setItemAt(item:Object, index:int):Object
	{
		return ISelectableList(contentGroup).setItemAt(item, index);
	}
	
	/**
	 * @copy com.shinynet.shinylib.components.ViewStack#toArray
	 */
	public function toArray():Array
	{
		return ISelectableList(contentGroup).toArray();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private function contentGroup_changeHandler(event:IndexChangeEvent):void
	{
		dispatchEvent(event.clone());
	}
	
	/**
	 * @private
	 */
	private function contentGroup_collectionChangeHandler(event:CollectionEvent):void
	{
		dispatchEvent(event.clone());
	}
	
	/**
	 * @private
	 */
	private function contentGroup_propertyChangeHandler(event:PropertyChangeEvent):void
	{
		dispatchEvent(event.clone());	
	}
	
}
}