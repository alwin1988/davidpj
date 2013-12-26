////////////////////////////////////////////////////////////////////////////////
//
//  SHINYNET
//  Copyright 2012 SHINYNET
//  All Rights Reserved.
//
//  NOTICE: Shinynet permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package com.shinynet.shinylib.components
{
import mx.core.ISelectableList;
import mx.core.IVisualElement;
import mx.core.mx_internal;

import spark.components.Group;

use namespace mx_internal;

[Deprecated(replacement="Use com.shinynet.shinylib.components.ViewStack instead.")] 

/**
 * 
 * @author Devin
 * 
 */
public class GroupStack extends Group implements ISelectableList
{
	public function GroupStack()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Implemented properties: ISelectableList
	//
	//--------------------------------------------------------------------------
	
	//--------------------------------------
	//  selectedIndex
	//--------------------------------------
	
	private var lastIndex:int = -1;
	
	private var _selectedIndex:int;
	
	private var selectedIndexChanged:Boolean;
	
	/**
	 * @inheritDoc 
	 */	
	public function get selectedIndex():int
	{
		return _selectedIndex;
	}
	
	/**
	 * @private 
	 */	
	public function set selectedIndex(value:int):void
	{
		if (value == _selectedIndex)
			return;
		
		lastIndex = _selectedIndex;
		_selectedIndex = value;
		selectedIndexChanged = true;
		invalidateProperties();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties: Group
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inheritDoc 
	 */	
	override public function set mxmlContent(value:Array):void
	{
		super.mxmlContent = value;
		
		value.forEach(function (item:IVisualElement, index:int, array:Array):void
		{
			item.visible = (index == _selectedIndex) ? true : false;
		});
	}
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  selectedChild
	//----------------------------------
	
	/**
	 *  A reference to the currently visible child container.
	 *  The default is a reference to the first child.
	 *  If there are no children, this property is <code>null</code>.
	 * 
	 *  <p><strong>Note:</strong> You can only set this property in an
	 *  ActionScript statement, not in MXML.</p>
	 */
	public function get selectedChild():IVisualElement
	{
		return IVisualElement(getElementAt(_selectedIndex));
	}
	
	/**
	 *  @private
	 */
	public function set selectedChild(value:IVisualElement):void
	{
		selectedIndex = getElementIndex(value);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Implemented methods: IList
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inheritDoc 
	 */	
	public function addItem(item:Object):void
	{
		addElement(IVisualElement(item));
	}
	
	/**
	 * @inheritDoc 
	 */	
	public function addItemAt(item:Object, index:int):void
	{
		addElementAt(IVisualElement(item), index);
	}
	
	/**
	 * @inheritDoc 
	 */	
	public function getItemAt(index:int, prefetch:int=0):Object
	{
		return getElementAt(index);
	}
	
	/**
	 * @inheritDoc 
	 */	
	public function getItemIndex(item:Object):int
	{
		return getElementIndex(IVisualElement(item));
	}
	
	/**
	 * @inheritDoc 
	 */	
	public function itemUpdated(item:Object, property:Object=null, oldValue:Object=null, newValue:Object=null):void
	{
		// TODO Auto Generated method stub
	}
	
	/**
	 * @inheritDoc 
	 */	
	public function get length():int
	{
		return numElements;
	}
	
	/**
	 * @inheritDoc 
	 */	
	public function removeAll():void
	{
		removeAllElements();
	}
	
	/**
	 * @inheritDoc 
	 */	
	public function removeItemAt(index:int):Object
	{
		return removeElementAt(index);
	}
	
	/**
	 * @inheritDoc 
	 */	
	public function setItemAt(item:Object, index:int):Object
	{
		var removedElement:IVisualElement = removeElementAt(index);
		addElementAt(IVisualElement(item), index);
		return removedElement;
	}
	
	/**
	 * @inheritDoc 
	 */	
	public function toArray():Array
	{
		return getMXMLContent();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties: UIComponent
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inhertiDoc 
	 */	
	override protected function commitProperties():void
	{
		super.commitProperties();
		
		if (selectedIndexChanged)
		{
			selectedIndexChanged = false;
			
			if (lastIndex >= 0)
				getElementAt(lastIndex).visible = false;
			
			getElementAt(_selectedIndex).visible = true;
		}
	}
	
	
}
}