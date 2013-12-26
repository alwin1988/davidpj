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
import flash.display.DisplayObject;
import flash.events.Event;

import mx.automation.IAutomationObject;
import mx.core.IInvalidating;
import mx.core.INavigatorContent;
import mx.core.ISelectableList;
import mx.core.IUIComponent;
import mx.core.IVisualElement;
import mx.core.UIComponent;
import mx.core.mx_internal;
import mx.effects.Effect;
import mx.effects.EffectManager;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;
import mx.events.EffectEvent;
import mx.events.FlexEvent;
import mx.events.PropertyChangeEvent;

import spark.events.IndexChangeEvent;

use namespace mx_internal;

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

[Exclude(name="autoLayout", kind="property")]
[Exclude(name="historyManagementEnabled", kind="property")]


/**
 * 
 * @author Devin
 * 
 */
public class ViewStack extends DeferredContentGroup implements ISelectableList
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function ViewStack()
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
	private var needToInstantiateSelectedChild:Boolean = false;
	
	/**
	 *  @private
	 *  Store the last selectedIndex
	 */
	private var lastIndex:int = -1;
	
	/**
	 *  @private
	 *  Whether a change event has to be dispatched in commitProperties()
	 */
	private var dispatchChangeEventPending:Boolean = false;
	
	/**
	 *  @private
	 *  If we're in the middle of adding a child.
	 */
	private var addingChildren:Boolean = false;
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inheritDoc
	 */
	override public function set mxmlContent(value:Array):void
	{
		super.mxmlContent = value;
		
		if (value.length > 0 && _selectedIndex == -1)
			selectedIndex = 0;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Implemented properties: ISelectableList
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  selectedIndex
	//----------------------------------
	
	/**
	 *  @private
	 *  Storage for the selectedIndex property.
	 */
	private var _selectedIndex:int = -1;
	
	/**
	 *  @private
	 */
	private var proposedSelectedIndex:int = -1;
	
	[Bindable("change")]
	[Bindable("valueCommit")]
	[Bindable("creationComplete")]
	[Inspectable(category="General")]
	
	/**
	 *  The zero-based index of the currently visible child container.
	 *  Child indexes are in the range 0, 1, 2, ..., n - 1,
	 *  where <i>n</i> is the number of children.
	 *  The default value is 0, corresponding to the first child.
	 *  If there are no children, the value of this property is <code>-1</code>.
	 * 
	 *  <p><strong>Note:</strong> When you add a new child to a ViewStack 
	 *  container, the <code>selectedIndex</code> property is automatically 
	 *  adjusted, if necessary, so that the selected child remains selected.</p>
	 */
	public function get selectedIndex():int
	{
		return proposedSelectedIndex == -1 ?
			_selectedIndex :
			proposedSelectedIndex;
	}
	
	/**
	 *  @private
	 */
	public function set selectedIndex(value:int):void
	{
		// Bail if the index isn't changing.
		if (value == selectedIndex)
			return;
		
		// Propose the specified value as the new value for selectedIndex.
		// It gets applied later when measure() calls commitSelectedIndex().
		// The proposed value can be "out of range", because the children
		// may not have been created yet, so the range check is handled
		// in commitSelectedIndex(), not here. Other calls to this setter
		// can change the proposed index before it is committed. Also,
		// childAddHandler() proposes a value of 0 when it creates the first
		// child, if no value has yet been proposed.
		proposedSelectedIndex = value;
		invalidateProperties();
		
		dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
	}
	
	//--------------------------------------------------------------------------
	//
	//  Implemented properties: Ilist
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  length
	//----------------------------------
	
	/**
	 *  @private
	 *  IList implementation of length returns numElements.
	 */
	public function get length():int
	{
		return numElements;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  autoLayout
	//----------------------------------
	
	/**
	 *  @private
	 *  autoLayout is always true for ViewStack.
	 */
	override public function get autoLayout():Boolean
	{
		return true;
	}
	
	/**
	 *  @private
	 *  autoLayout is always true for ViewStack
	 *  and can't be changed by this setter.
	 *
	 *  We can probably find a way to make autoLayout work with Accordion
	 *  and ViewStack, but right now there are problems if deferred
	 *  instantiation runs at the same time as an effect. (Bug 79174)
	 */
	override public function set autoLayout(value:Boolean):void
	{
	}
	
	//----------------------------------
	//  historyManagementEnabled
	//----------------------------------
	
	/**
	 *  History management is disabled.
	 */
	public function get historyManagementEnabled():Boolean
	{
		return false;
	}
	
	/**
	 *  @private
	 */
	public function set historyManagementEnabled(value:Boolean):void
	{
	}
	
	//----------------------------------
	//  selectedChild
	//----------------------------------
	
	[Bindable("valueCommit")]
	[Bindable("creationComplete")]
	
	/**
	 *  A reference to the currently visible child container.
	 *  The default is a reference to the first child.
	 *  If there are no children, this property is <code>null</code>.
	 * 
	 *  <p><strong>Note:</strong> You can only set this property in an
	 *  ActionScript statement, not in MXML.</p>
	 */
	public function get selectedChild():INavigatorContent
	{
		if (selectedIndex == -1)
			return null;
		
		return INavigatorContent(getElementAt(selectedIndex));
	}
	
	/**
	 *  @private
	 */
	public function set selectedChild(value:INavigatorContent):void
	{
		var newIndex:int = getElementIndex(IVisualElement(value));
		
		if (newIndex >= 0 && newIndex < numElements)
			selectedIndex = newIndex;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: UIComponent
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @private
	 */
	override protected function commitProperties():void
	{
		super.commitProperties();
		
		if (proposedSelectedIndex != -1)
		{
			commitSelectedIndex(proposedSelectedIndex);
			proposedSelectedIndex = -1;
		}
		
		if (needToInstantiateSelectedChild)
		{
			instantiateSelectedChild();
			needToInstantiateSelectedChild = false;
		}
		
		// Dispatch the change event only after the child has been
		// instantiated.
		if (dispatchChangeEventPending)
		{
			dispatchChangeEvent(lastIndex, selectedIndex);
			dispatchChangeEventPending = false;
		}
		
	}
	
	/**
	 *  Responds to size changes by setting the positions and sizes
	 *  of this container's children.
	 *  For more information about the <code>updateDisplayList()</code> method,
	 *  see the <code>UIComponent.updateDisplayList()</code> method.
	 *
	 *  <p>Only one of its children is visible at a time, therefore,
	 *  a ViewStack container positions and sizes only that child.</p>
	 *
	 *  <p>The selected child is positioned in the ViewStack container's
	 *  upper-left corner, and allows for the ViewStack container's
	 *  padding and borders. </p>
	 *
	 *  <p>If the selected child has a percentage <code>width</code> or
	 *  <code>height</code> value, it is resized in that direction
	 *  to fill the specified percentage of the ViewStack container's
	 *  content area (i.e., the region inside its padding).</p>
	 *
	 *  @param unscaledWidth Specifies the width of the component, in pixels,
	 *  in the component's coordinates, regardless of the value of the
	 *  <code>scaleX</code> property of the component.
	 *
	 *  @param unscaledHeight Specifies the height of the component, in pixels,
	 *  in the component's coordinates, regardless of the value of the
	 *  <code>scaleY</code> property of the component.
	 * 
	 *  @see mx.core.UIComponent#updateDisplayList()
	 */
	override protected function updateDisplayList(unscaledWidth:Number,
												  unscaledHeight:Number):void
	{
		super.updateDisplayList(unscaledWidth, unscaledHeight);
		
		var nChildren:int = numElements;
		var w:Number = contentWidth;
		var h:Number = contentHeight;
		//var left:Number = contentX;
		//var top:Number = contentY;
		
		// Stretch the selectedIndex to fill our size
		if (selectedIndex != -1)
		{
			var child:UIComponent =
				UIComponent(getElementAt(selectedIndex));
			
/*			var newWidth:Number = w;
			var newHeight:Number = h;
			
			if (!isNaN(child.percentWidth))
			{
				if (newWidth > child.maxWidth)
					newWidth = child.maxWidth;
			}
			else
			{
				if (newWidth > child.explicitWidth)
					newWidth = child.explicitWidth;
			}
			
			if (!isNaN(child.percentHeight))
			{
				if (newHeight > child.maxHeight)
					newHeight = child.maxHeight;
			}
			else
			{
				if (newHeight > child.explicitHeight)
					newHeight = child.explicitHeight;
			}
			
			// Don't send events for the size/move. The set visible below
			if (child.width != newWidth || child.height != newHeight)
				child.setActualSize(newWidth, newHeight);
			if (child.x != left || child.y != top)
				child.move(left, top);*/

			// Now that the child is properly sized and positioned it
			// can be shown.
			child.visible = true;
		}
	}
	
	/**
	 *  @private
	 */
	override public function addElementAt(element:IVisualElement, index:int):IVisualElement
	{
		addingChildren = true;
		var obj:IVisualElement = super.addElementAt(element, index);
		internalDispatchEvent(CollectionEventKind.ADD, obj, index);
		childAddHandler(element);
		addingChildren = false;
		return obj;
	}
	
	/**
	 *  @private
	 */
	override public function removeElement(element:IVisualElement):IVisualElement
	{
		var index:int = getElementIndex(element);
		var obj:IVisualElement = super.removeElement(element);
		internalDispatchEvent(CollectionEventKind.REMOVE, obj, index);
		childRemoveHandler(element, index);
		return obj;
	}
	
	/**
	 *  @private
	 */
	override public function removeAllElements():void
	{
		super.removeAllElements();
		internalDispatchEvent(CollectionEventKind.RESET);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Implemented methods: IList
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @private
	 *  IList implementation of addItem calls addElement.
	 */
	public function addItem(item:Object):void
	{
		addElement(item as IVisualElement);
	}
	
	/**
	 *  @private
	 *  IList implementation of addItemAt calls addElementAt.
	 */
	public function addItemAt(item:Object, index:int):void
	{
		addElementAt(item as IVisualElement, index);
	}
	
	/**
	 *  @private
	 *  IList implementation of getItemAt calls getElementAt.
	 */
	public function getItemAt(index:int, prefetch:int = 0):Object
	{
		return getElementAt(index);
	}
	
	/**
	 *  @private
	 *  IList implementation of getItemIndex calls getElementIndex.
	 */
	public function getItemIndex(item:Object):int
	{
		return getElementIndex(item as IVisualElement);
	}
	
	/**
	 *  @private
	 *  IList implementation of itemUpdated doesn't do anything
	 */
	public function itemUpdated(item:Object, property:Object = null, 
								oldValue:Object = null, 
								newValue:Object = null):void
	{
	}                         
	
	/**
	 *  @private
	 *  IList implementation of removeAll calls removeAllElements.
	 */
	public function removeAll():void
	{
		removeAllElements();
	}
	
	/**
	 *  @private
	 *  IList implementation of removeItemAt calls removeElementAt.
	 */
	public function removeItemAt(index:int):Object
	{
		return removeElementAt(index);
	}
	
	/**
	 *  @private
	 *  IList implementation of setItemAt removes the old child and adds the new.
	 */
	public function setItemAt(item:Object, index:int):Object
	{
		var result:Object = removeElementAt(index);
		addElementAt(item as IVisualElement, index);
		return result;
	}
	
	/**
	 *  @private
	 *  IList implementation of toArray returns array of children.
	 */
	public function toArray():Array 
	{
		var result:Array = [];
		for (var i:int=0; i < numElements; i++)
		{
			result.push(getElementAt(i));
		}
		return result;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Commits the selected index. This function is called during the commit 
	 *  properties phase when the <code>selectedIndex</code> or 
	 *  <code>selectedItem</code> property changes.
	 *
	 *  @param newIndex The selected index.
	 */
	protected function commitSelectedIndex(newIndex:int):void
	{
		// The selectedIndex must be -1 if there are no children,
		// even if a selectedIndex has been proposed.
		if (numElements == 0)
		{
			_selectedIndex = -1;
			return;
		}
		
		// If there are children, ensure that the new index is in bounds.
		if (newIndex < 0)
			newIndex = 0;
		else if (newIndex > numElements - 1)
			newIndex = numElements - 1;
		
		// Stop all currently playing effects
		if (lastIndex != -1 && lastIndex < numElements)
			UIComponent(getElementAt(lastIndex)).endEffectsStarted();
		
		if (_selectedIndex != -1)
			(selectedChild as UIComponent).endEffectsStarted();
		
		// Remember the old index.
		lastIndex = _selectedIndex;
		
		// Bail if the index isn't changing.
		if (newIndex == lastIndex)
			return;
		
		// Commit the new index.
		_selectedIndex = newIndex;
		
		// Only dispatch a change event if we're going to and from
		// a valid index
		if (lastIndex != -1 && newIndex != -1)
			dispatchChangeEventPending = true;
		
		var listenForEffectEnd:Boolean = false;
		
		if (lastIndex != -1 && lastIndex < numElements)
		{
			var currentChild:UIComponent = UIComponent(getElementAt(lastIndex));
			
			currentChild.setVisible(false); // Hide the current child
			
			if (currentChild.getStyle("hideEffect"))
			{
				var hideEffect:Effect = EffectManager.lastEffectCreated; // This should be the hideEffect
				
				if (hideEffect)
				{
					hideEffect.addEventListener(EffectEvent.EFFECT_END, hideEffectEndHandler);
					listenForEffectEnd = true;
				}
			}
		}
		
		// If we don't have to wait for a hide effect to finish
		if (!listenForEffectEnd)
			hideEffectEndHandler(null);
	}
	
	/**
	 *  @private
	 */
	private function instantiateSelectedChild():void
	{
		if (!selectedChild)
			return;
		
		// Performance optimization: don't call createComponents if we know
		// that createComponents has already been called.
		if (selectedChild && selectedChild.deferredContentCreated == false)
		{
			if (initialized)  // Only listen if the ViewStack has already been initialized.
				selectedChild.addEventListener(FlexEvent.CREATION_COMPLETE, childCreationCompleteHandler);
			selectedChild.createDeferredContent();
		}
		
		// Do the initial measurement/layout pass for the
		// newly-instantiated descendants.
		
		if (selectedChild is IInvalidating)
			IInvalidating(selectedChild).invalidateSize();
		
		invalidateSize();
		invalidateDisplayList();
	}
	
	/**
	 *  @private
	 */
	private function childAddHandler(child:IVisualElement):void
	{
		var index:int = getElementIndex(child);
		
		if (child is IUIComponent)
		{
			var uiChild:IUIComponent = IUIComponent(child);
			// ViewStack creates all of its children initially invisible.
			// They are made as they become the selected child.
			uiChild.visible = false;
		}
		if (child is INavigatorContent)
		{
			child.addEventListener("labelChanged", navigatorChildChangedHandler);
			child.addEventListener("iconChanged", navigatorChildChangedHandler);
		}
		
		// If we just created the first child and no selected index has
		// been proposed, then propose this child to be selected.
		if (numElements == 1 && proposedSelectedIndex == -1)
		{
			_selectedIndex = 0;
			dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
			needToInstantiateSelectedChild = true;
			invalidateProperties();
		} 
		else if (index <= selectedIndex && numElements > 1 && proposedSelectedIndex == -1)         
		{
			_selectedIndex++;
			dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
		}
		
		if (child is IAutomationObject)
			IAutomationObject(child).showInAutomationHierarchy = true;
		
	}
	
	/**
	 *  @private
	 *  When a child is removed, adjust the selectedIndex such that the current
	 *  child remains selected; or if the current child was removed, then the
	 *  next (or previous) child gets automatically selected; when the last
	 *  remaining child is removed, the selectedIndex is set to -1.
	 */
	private function childRemoveHandler(child:IVisualElement, index:int):void
	{
		if (child is INavigatorContent)
		{
			child.removeEventListener("labelChanged", navigatorChildChangedHandler);
			child.removeEventListener("iconChanged", navigatorChildChangedHandler);
		}
		
		// Handle the simple case.
		if (index > selectedIndex)
			return;
		
		var currentSelectedIndex:int = selectedIndex;
		
		// This matches one of the two conditions:
		// 1. a view before the current was deleted, or
		// 2. the current view was deleted and it was also
		//    at the end of the stack.
		// In both cases, we need to decrement selectedIndex.
		if (index < currentSelectedIndex ||
			currentSelectedIndex == numElements)
		{
			// If the selectedIndex was already 0, it should go to -1.
			// -1 is a special value; in order to avoid runtime errors
			// in various methods, we need to skip the range checking in
			// commitSelectedIndex() and set _selectedIndex explicitly here.
			if (currentSelectedIndex == 0)
			{
				_selectedIndex = -1;
				dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
			}
			else
			{
				_selectedIndex--;
				dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
			}
		}
		else if (index == currentSelectedIndex)
		{
			// If we're deleting the currentSelectedIndex and there is another
			// child after it, it will become the new selected child so we
			// need to make sure it is instantiated.
			needToInstantiateSelectedChild = true;
			invalidateProperties();
		}
	}
	
	/**
	 *  @private
	 */
	private function dispatchChangeEvent(oldIndex:int, newIndex:int):void
	{
		var event:IndexChangeEvent = new IndexChangeEvent(IndexChangeEvent.CHANGE);
		event.oldIndex = oldIndex;
		event.newIndex = newIndex;
		dispatchEvent(event);
	}
	
	/**
	 *  Dispatches a collection event with the specified information.
	 *
	 *  @param kind String indicates what the kind property of the event should be
	 *  @param item Object reference to the item that was added or removed
	 *  @param location int indicating where in the source the item was added.
	 */
	private function internalDispatchEvent(kind:String, item:Object = null, location:int = -1):void
	{
		if (hasEventListener(CollectionEvent.COLLECTION_CHANGE))
		{
			var event:CollectionEvent =
				new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
			event.kind = kind;
			event.items.push(item);
			event.location = location;
			dispatchEvent(event);
		}
		
		// now dispatch a complementary PropertyChangeEvent
		if (hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE) && 
			(kind == CollectionEventKind.ADD || kind == CollectionEventKind.REMOVE))
		{
			var objEvent:PropertyChangeEvent =
				new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
			objEvent.property = location;
			if (kind == CollectionEventKind.ADD)
				objEvent.newValue = item;
			else
				objEvent.oldValue = item;
			dispatchEvent(objEvent);
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @private
	 *  Handles when the new selectedChild has finished being created.
	 */
	private function childCreationCompleteHandler(event:FlexEvent):void
	{
		event.target.removeEventListener(FlexEvent.CREATION_COMPLETE, childCreationCompleteHandler);
		event.target.dispatchEvent(new FlexEvent(FlexEvent.SHOW));
	}
	
	private function hideEffectEndHandler(event:EffectEvent):void
	{
		if (event)
			event.currentTarget.removeEventListener(EffectEvent.EFFECT_END, hideEffectEndHandler);
		
		// Give any change handlers a chance to act before we
		// instantiate our pane (which eats up all the processing cycles)
		needToInstantiateSelectedChild = true;
		invalidateProperties();
	}
	
	/**
	 *  @private
	 *  The IList implementation dispatches change events when 
	 *  label or icon properties change.
	 */
	private function navigatorChildChangedHandler(event:Event):void
	{
		var pe:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
		pe.source = event.target;
		pe.property = (event.type == "labelChanged") ? "label" : "icon";
		
		internalDispatchEvent(CollectionEventKind.UPDATE, pe, getChildIndex(event.target as DisplayObject));
	}
	
}
}