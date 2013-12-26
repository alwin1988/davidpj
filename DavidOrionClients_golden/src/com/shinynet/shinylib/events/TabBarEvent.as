package com.shinynet.shinylib.events
{
import mx.events.CloseEvent;

public class TabBarEvent extends CloseEvent
{
	
	//--------------------------------------------------------------------------
	//
	//  Class constants
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  The <code>CloseEvent.CLOSE</code> constant defines the value of the 
	 *  <code>type</code> property of the event object for a <code>close</code> event.
	 * 
	 *  <p>The properties of the event object have the following values:</p>
	 *  <table class="innertable">
	 *     <tr><th>Property</th><th>Value</th></tr>
	 *     <tr><td><code>bubbles</code></td><td>false</td></tr>
	 *     <tr><td><code>cancelable</code></td><td>false</td></tr>
	 *     <tr><td><code>currentTarget</code></td><td>The Object that defines the 
	 *       event listener that handles the event. For example, if you use 
	 *       <code>myButton.addEventListener()</code> to register an event listener, 
	 *       myButton is the value of the <code>currentTarget</code>. </td></tr>
	 *     <tr><td><code>detail</code></td><td>For controls with multiple buttons, 
	 *       <code>detail</code> identifies the button in the popped up control 
	 *       that was clicked.</td></tr>
	 *     <tr><td><code>target</code></td><td>The Object that dispatched the event; 
	 *       it is not always the Object listening for the event. 
	 *       Use the <code>currentTarget</code> property to always access the 
	 *       Object listening for the event.</td></tr>
	 *  </table>
	 *
	 *  @eventType close
	 */
	public static const CLOSE:String = "close";
	
	public static const OPEN:String = "open";
	
	public function TabBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, detail:int=-1)
	{
		super(type, bubbles, cancelable, detail);
	}
}
}