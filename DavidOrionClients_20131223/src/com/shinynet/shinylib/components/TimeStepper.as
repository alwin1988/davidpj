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

import com.shinynet.shinylib.util.DateUtil;

import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import mx.events.FlexEvent;
import mx.managers.IFocusManager;

import spark.components.Spinner;
import spark.components.TextInput;
import spark.formatters.DateTimeFormatter;

//--------------------------------------
//  Styles
//--------------------------------------

/**
 *  The alpha of the border for this component.
 *
 *  @default 0.5
 */
[Style(name="borderAlpha", type="Number", inherit="no", theme="spark")]

/**
 *  The color of the border for this component.
 *
 *  @default 0x000000
 */
[Style(name="borderColor", type="uint", format="Color", inherit="no", theme="spark")]

/**
 *  Controls the visibility of the border for this component.
 *
 *  @default true
 */
[Style(name="borderVisible", type="Boolean", inherit="no", theme="spark")]

/**
 *  The alpha of the content background for this component.
 *
 *  @default 1
 */
[Style(name="contentBackgroundAlpha", type="Number", inherit="yes", theme="spark")]

/**
 *  @copy spark.components.supportClasses.GroupBase#style:contentBackgroundColor
 */
[Style(name="contentBackgroundColor", type="uint", format="Color", inherit="yes", theme="spark")]

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
 */
[Exclude(name="stepSize", kind="property")]

/**
 * 
 * @author Devin
 * 
 */
public class TimeStepper extends Spinner
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 
	 */	
	public function TimeStepper()
	{
		super();
		
		snapInterval = DateUtil.MILISECONDS_IN_SECOND;
		minimum = new Date(Number.MIN_VALUE).valueOf();
		maximum = new Date(Number.MAX_VALUE).valueOf();
		value = new Date().valueOf();
		
		hoursFormatter.dateTimePattern = "h";
		minutesFormatter.dateTimePattern = "mm";
		secondsFormatter.dateTimePattern = "ss";
		meridianFormatter.dateTimePattern = "a";
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private 
	 */	
	private var displayHasFocus:Boolean;
	
	/**
	 * @private 
	 */	
	private var hoursFormatter:DateTimeFormatter = new DateTimeFormatter();
	
	/**
	 * @private 
	 */	
	private var minutesFormatter:DateTimeFormatter = new DateTimeFormatter();
	
	/**
	 * @private 
	 */	
	private var secondsFormatter:DateTimeFormatter = new DateTimeFormatter();
	
	/**
	 * @private 
	 */	
	private var meridianFormatter:DateTimeFormatter = new DateTimeFormatter();
	
	//--------------------------------------------------------------------------
	//
	//  Skin parts
	//
	//--------------------------------------------------------------------------
	
	[SkinPart(required="true")]
	/**
	 * Skin part for displaying the hours.
	 */	
	public var hoursDisplay:TextInput;
	
	[SkinPart(required="true")]
	/**
	 * Skin part for displaying the minutes
	 */	
	public var minutesDisplay:TextInput;
	
	[SkinPart(required="false")]
	/**
	 * Skin part for displaying the seconds. 
	 */	
	public var secondsDisplay:TextInput;
	
	[SkinPart(required="false")]
	/**
	 * Skin part for displaying the meridian
	 */	
	public var meridianDisplay:TextInput;
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties: UIComponent
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  baselinePosition
	//----------------------------------
	
	/**
	 *  @private
	 */
	override public function get baselinePosition():Number
	{
		return getBaselinePositionForPart(hoursDisplay);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Properties: Range
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  stepSize
	//----------------------------------
	
	/**
	 * @private
	 */	
	private final function set $stepSize(value:Number):void
	{
		super.stepSize = value;
	}
	
	/**
	 * @private
	 * 
	 * The stepSize is handled internally and should not be set by user.
	 * Otherwise, the component may not behave as exptect. 
	 */	
	override public function set stepSize(value:Number):void
	{
		
	}
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  showSeconds
	//----------------------------------
	
	/**
	 * @private
	 * Storage for the showSeconds property.
	 */
	private var _showSeconds:Boolean;
	
	/**
	 * 
	 */
	public function get showSeconds():Boolean
	{
		return _showSeconds;
	}
	
	/**
	 * @private
	 */
	public function set showSeconds(value:Boolean):void
	{
		if (_showSeconds == value)
			return;
		
		_showSeconds = value;
		invalidateSkinState();
	}
	
	//----------------------------------
	//  timeInterval
	//----------------------------------
	
	/**
	 * @private
	 * Storage for the timeInterval property.
	 */
	private var _timeInterval:Number;
	
	/**
	 * 
	 */
	public function get timeInterval():Number
	{
		return _timeInterval;
	}
	
	/**
	 * @private
	 */
	public function set timeInterval(value:Number):void
	{
		if (_timeInterval == value)
			return;
		
		_timeInterval = value;
	}
	
	
	//----------------------------------
	//  timeFormat
	//----------------------------------
	
	/**
	 * @private
	 * Storage for the timeFormat property.
	 */
	private var _timeFormat:uint = 12;
	
	/**
	 * @private 
	 */	
	private var timeFormateChanged:Boolean;
	
	[Inspectable(enumeration="12,24", defaultValue="12")]	
	/**
	 * Sets the time format, 12 hour or 24 hour format.
	 * 
	 * @default 12
	 */
	public function get timeFormat():uint
	{
		return _timeFormat;
	}
	
	/**
	 * @private
	 */
	public function set timeFormat(value:uint):void
	{
		if (_timeFormat == value)
			return;
		
		_timeFormat = (value == 12 || value == 24) ? value : 12;
		timeFormateChanged = true;
		invalidateProperties();
		invalidateSkinState();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: Range
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @private
	 */
	override protected function setValue(newValue:Number):void
	{
		super.setValue(newValue);
		
		hoursDisplay.text = hoursFormatter.format(value);
		minutesDisplay.text = minutesFormatter.format(value);
		if (secondsDisplay)
			secondsDisplay.text = secondsFormatter.format(value);
		if (meridianDisplay)
			meridianDisplay.text = meridianFormatter.format(value);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: SkinnableComponent
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inheritDoc 
	 */	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == hoursDisplay)
		{
			hoursDisplay.addEventListener(FlexEvent.ENTER, display_enterHandler);
			hoursDisplay.addEventListener(FocusEvent.FOCUS_IN, display_focusInHandler);
			hoursDisplay.addEventListener(FocusEvent.FOCUS_OUT, display_focusOutHandler); 
			hoursDisplay.focusEnabled = false;
			hoursDisplay.text = hoursFormatter.format(value);
		}
		else if (instance == minutesDisplay)
		{
			minutesDisplay.addEventListener(FlexEvent.ENTER, display_enterHandler);
			minutesDisplay.addEventListener(FocusEvent.FOCUS_IN, display_focusInHandler);
			minutesDisplay.addEventListener(FocusEvent.FOCUS_OUT, display_focusOutHandler); 
			minutesDisplay.focusEnabled = false;
			minutesDisplay.text = minutesFormatter.format(value);
		}
		else if (instance == secondsDisplay)
		{
			secondsDisplay.addEventListener(FlexEvent.ENTER, display_enterHandler);
			secondsDisplay.addEventListener(FocusEvent.FOCUS_IN, display_focusInHandler);
			secondsDisplay.addEventListener(FocusEvent.FOCUS_OUT, display_focusOutHandler);
			secondsDisplay.focusEnabled = false;
			secondsDisplay.text = secondsFormatter.format(value);
		}
		else if (instance == meridianDisplay)
		{
			meridianDisplay.addEventListener(FlexEvent.ENTER, display_enterHandler);
			meridianDisplay.addEventListener(FocusEvent.FOCUS_IN, display_focusInHandler);
			meridianDisplay.addEventListener(FocusEvent.FOCUS_OUT,display_focusOutHandler); 
			meridianDisplay.focusEnabled = false;
			meridianDisplay.text = meridianFormatter.format(value);
		}
	}
	
	/**
	 * @inheritDoc 
	 */	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
			
		if (instance == hoursDisplay)
		{
			hoursDisplay.removeEventListener(FlexEvent.ENTER, display_enterHandler);
			hoursDisplay.removeEventListener(FocusEvent.FOCUS_IN, display_focusInHandler);
			hoursDisplay.removeEventListener(FocusEvent.FOCUS_OUT, display_focusOutHandler); 
		}
		else if (instance == minutesDisplay)
		{
			minutesDisplay.removeEventListener(FlexEvent.ENTER, display_enterHandler);
			minutesDisplay.removeEventListener(FocusEvent.FOCUS_IN, display_focusInHandler);
			minutesDisplay.removeEventListener(FocusEvent.FOCUS_OUT, display_focusOutHandler); 
		}
		else if (instance == secondsDisplay)
		{
			secondsDisplay.removeEventListener(FlexEvent.ENTER, display_enterHandler);
			secondsDisplay.removeEventListener(FocusEvent.FOCUS_IN, display_focusInHandler);
			secondsDisplay.removeEventListener(FocusEvent.FOCUS_OUT, display_focusOutHandler);
		}
		else if (instance == meridianDisplay)
		{
			meridianDisplay.removeEventListener(FlexEvent.ENTER, display_enterHandler);
			meridianDisplay.removeEventListener(FocusEvent.FOCUS_IN, display_focusInHandler);
			meridianDisplay.removeEventListener(FocusEvent.FOCUS_OUT,display_focusOutHandler); 
		}
	}
	
	/**
	 * @inheritDoc 
	 */	
	override protected function getCurrentSkinState():String
	{
		var skinState:String = super.getCurrentSkinState();
		
		if (timeFormat == 24)
			skinState += "AndAstronomical";
		
		if (showSeconds)
			skinState += "WithSeconds";
		
		return skinState;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: UIComponent
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @inheritDoc 
	 */	
	override protected function commitProperties():void
	{
		super.commitProperties();
		
		if (timeFormateChanged)
		{
			timeFormateChanged = false;
			hoursFormatter.dateTimePattern = (_timeFormat == 12) ? "h" : "k";
			setValue(value);
		}
	}
	
	/**
	 *  @private
	 */
	override public function setFocus():void
	{
		if (stage)
		{
			if (!displayHasFocus)
			{
				var focusManager:IFocusManager = focusManager;
				
				stage.focus = hoursDisplay.textDisplay as InteractiveObject;
				
				if (hoursDisplay.textDisplay)
					hoursDisplay.textDisplay.selectAll();
			}
			else
				displayHasFocus = false;
		}
	}
	
	/**
	 *  @private
	 */
	override protected function isOurFocus(target:DisplayObject):Boolean
	{
		return target == hoursDisplay.textDisplay
			|| target == minutesDisplay.textDisplay
			|| (secondsDisplay && target == secondsDisplay.textDisplay)
			|| (meridianDisplay && target == meridianDisplay.textDisplay);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: Range
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @private
	 */
	override public function changeValueByStep(increase:Boolean = true):void
	{
		if (stage.focus == hoursDisplay.textDisplay)
			$stepSize = Math.max(DateUtil.MILISECONDS_IN_HOUR, snapInterval);
		else if (stage.focus == minutesDisplay.textDisplay)
			$stepSize = Math.max(DateUtil.MILISECONDS_IN_MINUTE, snapInterval);
		else if (secondsDisplay && stage.focus == secondsDisplay.textDisplay)
			$stepSize = Math.max(DateUtil.MILISECONDS_IN_SECOND, snapInterval);
		else if (meridianDisplay && stage.focus == meridianDisplay.textDisplay)
			$stepSize = Math.max(DateUtil.MILISECONDS_IN_MERIDIAN, snapInterval);
		
		super.changeValueByStep(increase);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private 
	 */	
	private function commitText(display:TextInput):void
	{
		var dateValue:Date = new Date(value);
		
		if (display == hoursDisplay)
		{
			var hoursValue:Number = Number(hoursDisplay.text);
			
			if (!isNaN(hoursValue))
			{
				// If the user is in 12 hour mode and the time displayed is
				// PM, then it's assumed that the hours entered is meant to
				// be the number of hours after noon.
				if (_timeFormat == 12 && dateValue.hours >= 12)
					hoursValue += 12;
				
				dateValue.hours = hoursValue;
			}
		}
		else if (display == minutesDisplay)
		{
			var minutesValue:Number = Number(minutesDisplay.text);
			
			if (!isNaN(minutesValue))
				dateValue.minutes = minutesValue;
		}
		else if (display == secondsDisplay)
		{
			var secondsValue:Number = Number(secondsDisplay.text);
			
			if (!isNaN(secondsValue))
				dateValue.seconds = secondsValue;
		}
		else if (meridianDisplay && display == meridianDisplay)
		{
			if (meridianDisplay.text.toUpperCase().indexOf("A") >= 0)
			{
				if (dateValue.hours >= 12)
					dateValue.hours -= 12;
			}
			else // PM
			{
				if (dateValue.hours < 12)
					dateValue.hours += 12;
			}
		}
		setValue(dateValue.valueOf());
	}
	
	//--------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private 
	 */	
	protected function display_focusInHandler(event:FocusEvent):void
	{
		if (stage)
		{
			displayHasFocus = true;
			
			var display:TextInput = event.currentTarget as TextInput;
			
			stage.focus = display.textDisplay as InteractiveObject;
			
			if (display.textDisplay)
				display.textDisplay.selectAll();
		}
	}
	
	/**
	 * @private 
	 */	
	protected function display_focusOutHandler(event:FocusEvent):void
	{
		commitText(event.currentTarget as TextInput);
	}
	
	/**
	 * @private 
	 */	
	protected function display_enterHandler(event:FlexEvent):void
	{
		commitText(event.currentTarget as TextInput);
	}
	
	/**
	 *  @private
	 */  
	override protected function focusInHandler(event:FocusEvent):void
	{
		super.focusInHandler(event);
		
		addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, true);
	}
	
	/**
	 *  @private
	 */  
	override protected function focusOutHandler(event:FocusEvent):void
	{
		super.focusOutHandler(event);
		
		removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, true);
	}
	
	/**
	 *  @private
	 */
	override protected function keyDownHandler(event:KeyboardEvent):void
	{
		if (event.isDefaultPrevented())
			return;
		
		var display:TextInput;
		
		if (event.keyCode == Keyboard.LEFT)
		{
			if (meridianDisplay && stage.focus == meridianDisplay.textDisplay)
			{
				if (secondsDisplay)
					display = secondsDisplay;
				else
					display = minutesDisplay;
			}
			else if (secondsDisplay && stage.focus == secondsDisplay.textDisplay)
			{
				display = minutesDisplay;
			}
			else if (stage.focus == minutesDisplay.textDisplay)
			{
				display = hoursDisplay;
			}
		}
		else if (event.keyCode == Keyboard.RIGHT)
		{
			if (stage.focus == hoursDisplay.textDisplay)
			{
				display = minutesDisplay;
			}
			else if (stage.focus == minutesDisplay.textDisplay)
			{
				if (secondsDisplay)
					display = secondsDisplay;
				else if (meridianDisplay)
					display = meridianDisplay;
			}
			else if (secondsDisplay && stage.focus == secondsDisplay.textDisplay)
			{
				if (meridianDisplay)
					display = meridianDisplay;
			}
		}
		
		if (display)
		{
			event.preventDefault();
			displayHasFocus = true;
			
			stage.focus = display.textDisplay as InteractiveObject;
			
			if (display.textDisplay)
				display.textDisplay.selectAll();
		}
		
		// Accept defaults for up/down
		super.keyDownHandler(event);
	}
	
}
}