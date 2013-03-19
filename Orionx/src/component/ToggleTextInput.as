package component
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.RichEditableText;
	import spark.components.TextInput;
	
	/**
	 *  Dispatched when the user makes some change to the text input and confirms the change.
	 *
	 *  @eventType flash.events.Event
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Event(name="confirm", type="flash.events.Event")]
	
	/**
	 * This editable label control allows direct manipulation of a label display
	 * by swapping the label with a textInput when editing value.
	 * 
	 * @since November 2011
	 * @author Yang
	 */
	[SkinState("display")]
	public class ToggleTextInput extends TextInput
	{
		/** Button for switching to the textInput for editing value **/
		[SkinPart(required="true")]
		public var labelButton:Button;
		
		/** Button for adding text to an empty textInput **/
		[SkinPart(required="true")]
		public var addButton:Button;
		
		/** Button for confirming change made **/
		[SkinPart(required="false")]
		public var confirmButton:Button;
		
		/** Button for canceling any change **/
		[SkinPart(required="false")]
		public var cancelButton:Button;
		
		/** Original text before starting to edit value **/
		private var _oldText:String;
		
		/** Whether to change the component back to editing mode when validation failed **/
		private var _preventInvalidValue:Boolean;
		
		/** Whether currently editing value **/
		private var _editing:Boolean;
		
		/** Label for addButton (when the textInput is empty) **/
		private var _addButtonLabel:String;
		
		/** Whether the current value is a valid entry **/
		private var valid:Boolean;
		
		/**
		 * Constructor.
		 */
		public function ToggleTextInput()
		{
			super();
			init();
		}
		
		/**
		 * Initializes the component.  
		 */
		private function init():void
		{
			editing = false;
			preventInvalidValue = true;
			valid = true;
			
			addEventListener(FlexEvent.INVALID, invalidHandler, false, 0, true);
			addEventListener(FlexEvent.VALID, validHandler, false, 0, true);
			addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler, false, 0, true);
		}
		
		/**
		 * Updates the display label to reflect change made to the textInput.
		 */
		private function updateLabel():void
		{
			_oldText = text;
			if(labelButton)
			{
				labelButton.label = text;
				if(text && text != "")
				{
					labelButton.visible = true;
					labelButton.includeInLayout = true;
					if(addButton)
					{
						addButton.visible = false;
						addButton.includeInLayout = false;
					}
				} else {
					labelButton.visible = false;
					labelButton.includeInLayout = false;
					if(addButton)
					{
						addButton.visible = true;
						addButton.includeInLayout = true;
					}
				}
			}
		}
		
		/**
		 * Keep the component in editing mode if the new value commited is invalid.
		 * This behaviour can be disabled by setting preventInvalidValue to false.
		 */
		private function invalidHandler(e:FlexEvent):void
		{
			valid = false;
			if(preventInvalidValue &&　!editing)
			{
				editing = true;
				setFocus();
			}
		}
		
		/**
		 * When the new value commited is valid.
		 */
		private function validHandler(e:FlexEvent):void
		{
			valid = true;
		}
		

		/**
		 * Changes to editing mode when the testDisplay gains gocus.
		 */
		private function textDisplayFocusInHandler(event:FocusEvent):void
		{
			if(!editing)
			{
				editing = true;
			}
		}
		
		/**
		 * When the component loses focus, confirms the change if it's valid
		 * and cancels the change if it's invalid.
		 */
		override protected function focusOutHandler(event:FocusEvent):void
		{
			if(focusManager.getFocus() != confirmButton &&
				focusManager.getFocus() != cancelButton &&
				focusManager.getFocus() != this)
			{
				dispatchConfirmEvent();
				if(valid || !preventInvalidValue)
				{
					updateLabel();
				} else {
					text = _oldText;
				}
				editing = false;
			}
			super.focusOutHandler(event);
		}
		
		/**
		 * Sets the text of the component and updates the label.
		 */
		[Bindable]
		public override function set text(value:String):void
		{
			super.text = value;
			updateLabel();
		}
		
		/**
		 * Returns the original text before starting to edit value.
		 */
		public function get oldText():String
		{
			return _oldText;
		}
		
		/**
		 * Returns whether to change the component back to editing mode when validation failed.
		 */
		public function get preventInvalidValue():Boolean
		{
			return _preventInvalidValue;
		}
		
		/**
		 * Sets whether to change the component back to editing mode when validation failed.
		 */
		[Bindable]
		public function set preventInvalidValue(value:Boolean):void
		{
			_preventInvalidValue = value;
		}
		
		/**
		 * Returns whether the component is currently in editing mode.
		 */
		public function get editing():Boolean
		{
			return _editing;
		}
		
		/**
		 * Sets whether the component is currently in editing mode.
		 */
		[Bindable]
		public function set editing(value:Boolean):void
		{
			_editing = value;
			invalidateSkinState();
		}
		
		/**
		 * Returns the label for addButton (when the textInput is empty).
		 */
		public function get addButtonLabel():String
		{
			return _addButtonLabel;
		}
		
		/**
		 * Sets the label for addButton (when the textInput is empty).
		 */
		[Bindable]
		public function set addButtonLabel(value:String):void
		{
			_addButtonLabel = value;
			if(addButton)
				addButton.label = value;
		}

		/**
		 * Returns the current skin state.
		 */
		override protected function getCurrentSkinState():String
		{
			if(!editing)
			{
				return "display";
			}else{
				return super.getCurrentSkinState();
			}
		}
		
		/**
		 * Confirms the change made to the textInput.
		 */
		private function confirmChange():void
		{
			if(valid || !preventInvalidValue)
			{
				dispatchConfirmEvent();
				updateLabel();
				editing = false;
			} else {
				setFocus();
			}
		}
		
		/**
		 * Changes to editing mode after the labelButton is clicked.
		 */
		private function labelButtonClickHandler(e:MouseEvent):void
		{
			editing = true;
			setFocus();
		}
		
		/**
		 * Changes to editing mode after the addButton is clicked.
		 */
		private function addButtonClickHandler(e:MouseEvent):void
		{
			editing = true;
			setFocus();
		}
		
		/**
		 * Confirms the change made after the confirmButton is clicked.
		 */
		private function confirmButtonClickHandler(e:MouseEvent):void
		{
			confirmChange();
		}
		
		/**
		 * Cancels any change made after the cancelButton is clicked.
		 */
		private function cancelButtonClickHandler(e:MouseEvent):void
		{
			text = _oldText;
			editing = false;
			dispatchConfirmEvent();
		}
		
		/**
		 * Handles keyboardEvent.
		 * Cancels any change made if the Escape is pressed and
		 * Confirms the change made if the Enter key is pressed.
		 */
		private function keyboardHandler(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.ESCAPE)
			{
				text = _oldText;
				editing = false;
				dispatchConfirmEvent();
			}
			else if(e.keyCode == Keyboard.ENTER)
			{
				//dispatches valueCommit event to trigger validation
				dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
				//confirms any change
				confirmChange();			
			}
		}
		
		/**
		 * Dispatches the confirm event when exiting the editing mode.
		 * The confirm event will only be dispatched
		 * if the new value is different from the original value.
		 */
		private function dispatchConfirmEvent():void
		{
			if(text != oldText && valid &&
				!(text == "" && oldText == null) &&
				!(text == null && oldText == ""))
			{
				dispatchEvent(new Event("confirm"));
			}
		}
		 
		/**
		 * Configures and attaches event handlers to skin parts.
		 */
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if(instance == labelButton)
			{
				labelButton.visible = false;
				labelButton.includeInLayout = false;
				labelButton.label = text;

				if(text && text != "")
				{
					labelButton.visible = true;
					labelButton.includeInLayout = true;
					if(addButton)
					{
						addButton.visible = false;
						addButton.includeInLayout = false;
					}
				}
				
				(instance as Button).addEventListener(MouseEvent.CLICK, labelButtonClickHandler);
			}
			else if(instance == addButton)
			{
				addButton.label = addButtonLabel;
				if(labelButton && text && text != "")
				{
					labelButton.visible = true;
					labelButton.includeInLayout = true;
					addButton.visible = false;
					addButton.includeInLayout = false;
				}
				(instance as Button).addEventListener(MouseEvent.CLICK, addButtonClickHandler);
			}
			else if(instance == confirmButton)
			{
				(instance as Button).addEventListener(MouseEvent.CLICK, confirmButtonClickHandler);
			}
			else if(instance == cancelButton)
			{
				(instance as Button).addEventListener(MouseEvent.CLICK, cancelButtonClickHandler);
			}
			else if(instance == textDisplay)
			{
				(instance as RichEditableText).addEventListener(FocusEvent.FOCUS_IN, textDisplayFocusInHandler);
			}
		}
		
		/**
		 * Removes event handlers to skin parts.
		 */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			if(instance == labelButton)
			{
				(instance as Button).removeEventListener(MouseEvent.CLICK, labelButtonClickHandler);
			}
			else if(instance == addButton)
			{
				(instance as Button).removeEventListener(MouseEvent.CLICK, addButtonClickHandler);
			}
			else if(instance == confirmButton)
			{
				(instance as Button).removeEventListener(MouseEvent.CLICK, confirmButtonClickHandler);
			}
			else if(instance == cancelButton)
			{
				(instance as Button).removeEventListener(MouseEvent.CLICK, cancelButtonClickHandler);
			}
			else if(instance == textDisplay)
			{
				(instance as RichEditableText).removeEventListener(FocusEvent.FOCUS_IN, textDisplayFocusInHandler);
			}
		}
		
	}
}