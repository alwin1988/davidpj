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

package com.shinynet.shinylib.collections
{
import flash.events.Event;
import flash.utils.Proxy;
import flash.utils.flash_proxy;

import mx.collections.IList;


/**
 * 
 *
 * @author Devin
 */
public class VectorList extends Proxy implements IList
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function VectorList(vector:Vector)
	{
		this.vector = vector;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var vector:Vector;
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: Proxy
	//
	//--------------------------------------------------------------------------
	
	override flash_proxy function callProperty(name:*, ...parameters):*
	{
		return vector[name].apply(vector, parameters);
	}
	
	override flash_proxy function deleteProperty(name:*):Boolean
	{
		// TODO Auto Generated method stub
		return super.flash_proxy::deleteProperty(name);
	}
	
	override flash_proxy function getDescendants(name:*):*
	{
		// TODO Auto Generated method stub
		return super.flash_proxy::getDescendants(name);
	}
	
	override flash_proxy function getProperty(name:*):*
	{
		// TODO Auto Generated method stub
		return super.flash_proxy::getProperty(name);
	}
	
	override flash_proxy function hasProperty(name:*):Boolean
	{
		// TODO Auto Generated method stub
		return super.flash_proxy::hasProperty(name);
	}
	
	override flash_proxy function isAttribute(name:*):Boolean
	{
		// TODO Auto Generated method stub
		return super.flash_proxy::isAttribute(name);
	}
	
	override flash_proxy function nextName(index:int):String
	{
		// TODO Auto Generated method stub
		return super.flash_proxy::nextName(index);
	}
	
	override flash_proxy function nextNameIndex(index:int):int
	{
		// TODO Auto Generated method stub
		return super.flash_proxy::nextNameIndex(index);
	}
	
	override flash_proxy function nextValue(index:int):*
	{
		// TODO Auto Generated method stub
		return super.flash_proxy::nextValue(index);
	}
	
	override flash_proxy function setProperty(name:*, value:*):void
	{
		// TODO Auto Generated method stub
		super.flash_proxy::setProperty(name, value);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Implemented methods: IList
	//
	//--------------------------------------------------------------------------
	
	public function addItem(item:Object):void
	{
		// TODO Auto Generated method stub
		
	}
	
	public function addItemAt(item:Object, index:int):void
	{
		// TODO Auto Generated method stub
		
	}
	
	public function getItemAt(index:int, prefetch:int=0):Object
	{
		// TODO Auto Generated method stub
		return null;
	}
	
	public function getItemIndex(item:Object):int
	{
		// TODO Auto Generated method stub
		return 0;
	}
	
	public function itemUpdated(item:Object, property:Object=null, 
								oldValue:Object=null, newValue:Object=null):void
	{
		// TODO Auto Generated method stub
		
	}
	
	public function get length():int
	{
		// TODO Auto Generated method stub
		return 0;
	}
	
	public function removeAll():void
	{
		// TODO Auto Generated method stub
		
	}
	
	public function removeItemAt(index:int):Object
	{
		// TODO Auto Generated method stub
		return null;
	}
	
	public function setItemAt(item:Object, index:int):Object
	{
		// TODO Auto Generated method stub
		return null;
	}
	
	public function toArray():Array
	{
		// TODO Auto Generated method stub
		return null;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Implemented methods: IEventDispatcher
	//
	//--------------------------------------------------------------------------
	
	public function addEventListener(type:String, listener:Function, 
									 useCapture:Boolean=false, priority:int=0, 
									 useWeakReference:Boolean=false):void
	{
		// TODO Auto Generated method stub
		
	}
	
	public function dispatchEvent(event:Event):Boolean
	{
		// TODO Auto Generated method stub
		return false;
	}
	
	public function hasEventListener(type:String):Boolean
	{
		// TODO Auto Generated method stub
		return false;
	}
	
	public function removeEventListener(type:String, listener:Function, 
										useCapture:Boolean=false):void
	{
		// TODO Auto Generated method stub
		
	}
	
	public function willTrigger(type:String):Boolean
	{
		// TODO Auto Generated method stub
		return false;
	}
	
	
}
}