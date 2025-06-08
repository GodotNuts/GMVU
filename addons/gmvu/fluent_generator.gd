@tool
class_name FluentGenerator
extends EditorScript

enum BindingType { OneTime, OneWay, TwoWay }

const IGNORE = Control.MouseFilter.MOUSE_FILTER_IGNORE
const PASS = Control.MouseFilter.MOUSE_FILTER_PASS
const STOP = Control.MouseFilter.MOUSE_FILTER_STOP
const BOX_A_BEGIN = BoxContainer.AlignmentMode.ALIGNMENT_BEGIN
const BOX_A_CENTER = BoxContainer.AlignmentMode.ALIGNMENT_CENTER
const BOX_A_END = BoxContainer.AlignmentMode.ALIGNMENT_END
const FLOW_A_BEGIN = FlowContainer.AlignmentMode.ALIGNMENT_BEGIN
const FLOW_A_CENTER = FlowContainer.AlignmentMode.ALIGNMENT_CENTER
const FLOW_A_END = FlowContainer.AlignmentMode.ALIGNMENT_END
const LAST_WRAP_BEGIN = FlowContainer.LastWrapAlignmentMode.LAST_WRAP_ALIGNMENT_BEGIN
const LAST_WRAP_CENTER = FlowContainer.LastWrapAlignmentMode.LAST_WRAP_ALIGNMENT_CENTER
const LAST_WRAP_END = FlowContainer.LastWrapAlignmentMode.LAST_WRAP_ALIGNMENT_END
const LAST_WRAP_INHERIT = FlowContainer.LastWrapAlignmentMode.LAST_WRAP_ALIGNMENT_INHERIT
const EXPAND = Control.SizeFlags.SIZE_EXPAND
const FILL = Control.SizeFlags.SIZE_FILL
const EXPAND_FILL = Control.SizeFlags.SIZE_EXPAND_FILL
const SHRINK_BEGIN = Control.SizeFlags.SIZE_SHRINK_BEGIN
const SHRINK_CENTER = Control.SizeFlags.SIZE_SHRINK_CENTER
const SHRINK_END = Control.SizeFlags.SIZE_SHRINK_END
const SCROLL_DISABLED = ScrollContainer.ScrollMode.SCROLL_MODE_DISABLED
const SCROLL_MODE_AUTO = ScrollContainer.ScrollMode.SCROLL_MODE_AUTO
const SCROLL_MODE_SHOW_ALWAYS = ScrollContainer.ScrollMode.SCROLL_MODE_SHOW_ALWAYS
const SCROLL_MODE_SHOW_NEVER = ScrollContainer.ScrollMode.SCROLL_MODE_SHOW_NEVER
const SCROLL_MODE_RESERVE = ScrollContainer.ScrollMode.SCROLL_MODE_RESERVE
const TOP_LEFT = Control.LayoutPreset.PRESET_TOP_LEFT
const TOP_RIGHT = Control.LayoutPreset.PRESET_TOP_RIGHT
const BOTTOM_LEFT = Control.LayoutPreset.PRESET_BOTTOM_LEFT
const BOTTOM_RIGHT = Control.LayoutPreset.PRESET_BOTTOM_RIGHT
const CENTER_LEFT = Control.LayoutPreset.PRESET_CENTER_LEFT
const CENTER_TOP = Control.LayoutPreset.PRESET_CENTER_TOP
const CENTER_RIGHT = Control.LayoutPreset.PRESET_CENTER_RIGHT
const CENTER_BOTTOM = Control.LayoutPreset.PRESET_CENTER_BOTTOM
const CENTER = Control.LayoutPreset.PRESET_CENTER
const LEFT_WIDE = Control.LayoutPreset.PRESET_LEFT_WIDE
const RIGHT_WIDE = Control.LayoutPreset.PRESET_RIGHT_WIDE
const TOP_WIDE = Control.LayoutPreset.PRESET_TOP_WIDE
const BOTTOM_WIDE = Control.LayoutPreset.PRESET_BOTTOM_WIDE
const VCENTER_WIDE = Control.LayoutPreset.PRESET_VCENTER_WIDE
const HCENTER_WIDE = Control.LayoutPreset.PRESET_HCENTER_WIDE
const FULL_RECT = Control.LayoutPreset.PRESET_FULL_RECT

func view() -> CustomControl:
	return CustomControl.new(Control.new())

func export_path() -> String:
	return "res://generated_views/generated_file"	

class CustomControl extends RefCounted:
	var node_name: String
	var node: Control
	var child_array: Array = []
	#var bindings: Array[ControlBinding] = []

	func _init(base_node: Control):
		node = base_node

	func named(name: String) -> CustomControl:
		node_name = name
		return self
	
	func min_size(x: int, y: int) -> CustomControl:
		node.custom_minimum_size = Vector2(x, y)
		return self
	
	func children(value: Array) -> CustomControl:
		child_array = value
		return self

	func mouse_filter(value: Control.MouseFilter) -> CustomControl:
		node.mouse_filter = value
		return self
	
	func unique(value: bool) -> CustomControl:
		node.unique_name_in_owner = value
		return self
	
	func grow_h(value: Control.GrowDirection) -> CustomControl:
		node.grow_horizontal = value
		return self
		
	func grow_v(value: Control.GrowDirection) -> CustomControl:
		node.grow_vertical = value
		return self
	
	func anchors(value) -> CustomControl:
		var anchors_array = [0, 0, 0, 0]
		if value is Array:
			if value.size() == 2:
				anchors_array[0] = value[1]
				anchors_array[1] = value[0]
				anchors_array[2] = value[0]
				anchors_array[3] = value[1]
			elif value.size() == 4:
				anchors_array[0] = value[0]
				anchors_array[1] = value[1]
				anchors_array[2] = value[2]
				anchors_array[3] = value[3]
			else:
				push_error("Could not resolve anchors array, requires array of size 2 or 4")
				return self
		elif value is Control.LayoutPreset:
			node.set_anchors_preset(value, true)
			return self
		
		var idx = 0
		const anchor_positions = [SIDE_TOP, SIDE_RIGHT, SIDE_BOTTOM, SIDE_LEFT]
		for side in anchor_positions:
			node.set_anchor(side, anchors_array[idx])
			idx += 1
			
		return self

	func h_size(value: Control.SizeFlags) -> CustomControl:
		node.size_flags_horizontal = value
		return self

	func v_size(value: Control.SizeFlags) -> CustomControl:
		node.size_flags_vertical = value
		return self

	#func bind(property_name: String, binding_type: BindingType, data_context: Variant, data_property_name: String):
		#bindings.push_back(ControlBinding.new(property_name, binding_type, data_context, data_property_name))
		#return self

	func build() -> Control:	
		for child in child_array:
			var ch = child as CustomControl
			
			if ch:
				var built_child = ch.build()
				if not ch.node_name.is_empty():
					built_child.name = ch.node_name
				node.add_child(built_child, true)
			else:
				push_error("Children must inherit CustomControl")
		
		if not node_name.is_empty():
			node.name = node_name
		return node

class CustomLabel extends CustomControl:
	func _init():
		super(Label.new())

	func text(value: String) -> CustomLabel:
		node.text = value
		return self


class CustomColorRect extends CustomControl:
	func _init():
		super(ColorRect.new())

	func color(value: Color) -> CustomColorRect:
		node.color = value
		return self

class CustomLineEdit extends CustomControl:
	func _init():
		super(LineEdit.new())

	func text(value: String) -> CustomLineEdit:
		node.text = value
		return self

	func placeholder_text(value: String) -> CustomLineEdit:
		node.placeholder_text = value
		return self
	
	func secret(value: bool) -> CustomLineEdit:
		node.secret = value
		return self

	func colors(value: Dictionary[String, Color]) -> CustomLineEdit:
		for color in value:
			if node.has(color):
				node[color] = value[color]
				
		return self
	
	func text_changed(value: Callable) -> CustomLineEdit:
		node.text_changed.connect(value)
		return self

class CustomNinePatchRect extends CustomControl:
	func _init():
		super(NinePatchRect.new())

	func texture(value: Texture2D) -> CustomNinePatchRect:
		node.texture = value
		return self

	func patch_margins(margins: Array[int]) -> CustomNinePatchRect:
		var all_margins = [0, 0, 0, 0]
		if margins.size() == 1:
			all_margins[0] = margins[0]
			all_margins[1] = margins[0]
			all_margins[2] = margins[0]
			all_margins[3] = margins[0]
		elif margins.size() == 2:
			all_margins[0] = margins[1]
			all_margins[1] = margins[0]
			all_margins[2] = margins[1]
			all_margins[3] = margins[0]
		elif margins.size() == 4:
			all_margins[0] = margins[0]
			all_margins[1] = margins[1]
			all_margins[2] = margins[2]
			all_margins[3] = margins[3]
		else:
			push_error("Patch margins must be 1, 2, or 4 value arrays")
			return
		
		var idx = 0
		for margin in ["top", "right", "bottom", "left"]:
			node["patch_margin_%s" % margin] = all_margins[idx]
			idx += 1
		
		return self

class CustomBoxContainer extends CustomControl:
	func _init(control: BoxContainer):
		super(control)

	func align(value: BoxContainer.AlignmentMode) -> CustomBoxContainer:
		node.alignment = value
		return self
	
	func sep(value: int) -> CustomBoxContainer:
		node.separation = value
		return self
		
class CustomMarginContainer extends CustomControl:
	func _init():
		super(MarginContainer.new())
		
	func margins(value: Array[int]) -> CustomMarginContainer:
		var all_margins = [0, 0, 0, 0]
		
		if value.size() == 1:
			all_margins[0] = value[0]
			all_margins[1] = value[0]
			all_margins[2] = value[0]
			all_margins[3] = value[0]
		elif value.size() == 2:
			all_margins[0] = value[1]
			all_margins[1] = value[0]
			all_margins[2] = value[1]
			all_margins[3] = value[0]
		elif value.size() == 4:
			all_margins[0] = value[0]
			all_margins[1] = value[1]
			all_margins[2] = value[2]
			all_margins[3] = value[3]
		else:
			push_error("Margin arrays can take only 1, 2, or 4 values.")
			return self
			
		var idx = 0
		var margin_names = ["margin_top", "margin_right", "margin_bottom", "margin_left"]
		for margin in margin_names:
			node.add_theme_constant_override(margin, all_margins[idx])
			idx += 1
			
		return self
		
class CustomGridContainer extends CustomControl:
	func _init():
		super(GridContainer.new())

	func cols(value: int) -> CustomGridContainer:
		node.columns = value
		return self
			
	func h_sep(value: int) -> CustomGridContainer:
		node.h_separation = value
		return self
		
	func v_sep(value: int) -> CustomGridContainer:
		node.v_separation = value
		return self
		
class CustomPanelContainer extends CustomControl:
	func _init():
		super(PanelContainer.new())

	func panel(value: StyleBox) -> CustomPanelContainer:
		node.panel = value
		return self
		
class CustomScrollContainer extends CustomControl:
	func _init():
		super(ScrollContainer.new())
	
	func h_scroll_mode(value: ScrollContainer.ScrollMode) -> CustomScrollContainer:
		node.horizontal_scroll_mode = value
		return self
		
	func v_scroll_mode(value: ScrollContainer.ScrollMode) -> CustomScrollContainer:
		node.vertical_scroll_mode = value
		return self
			
	func h_scroll_amount(value: int) -> CustomScrollContainer:
		node.scroll_horizontal = value
		return self
		
	func v_scroll_amount(value: int) -> CustomScrollContainer:
		node.scroll_vertical = value
		return self
			
	func panel(value: StyleBox) -> CustomScrollContainer:
		node.panel = value
		return self
			
	func focus(value: StyleBox) -> CustomScrollContainer:
		node.focus = value
		return self
			
	func follow(value: bool) -> CustomScrollContainer:
		node.follow_focus = value
		return self

class CustomFlowContainer extends CustomControl:
	func _init(control: FlowContainer):
		super(control)

	func align(value: FlowContainer.AlignmentMode) -> CustomFlowContainer:
		node.alignment = value
		return self
		
	func last_wrap_align(value: FlowContainer.LastWrapAlignmentMode) -> CustomFlowContainer:
		node.last_wrap_alignment = value
		return self
	
	func reverse(value: bool) -> CustomFlowContainer:
		node.reverse_fill = value
		return self
	
	func h_sep(value: int) -> CustomFlowContainer:
		node.h_separation = value
		return self
		
	func v_sep(value: int) -> CustomFlowContainer:
		node.v_separation = value
		return self

class CustomPanel extends CustomControl:
	func _init():
		super(Panel.new())

class CustomRange extends CustomControl:
	func _init(control: Range):
		super(control)

	func min_value(value: float) -> CustomRange:
		node.min_value = value
		return self

	func max_value(value: float) -> CustomRange:
		node.max_value = value
		return self

	func step(value: float) -> CustomRange:
		node.step = value
		return self
	
	func value(val: float) -> CustomRange:
		node.value = val
		return self

class CustomProgressBar extends CustomRange:
	func _init():
		super(ProgressBar.new())

	func fill_mode(value: ProgressBar.FillMode) -> CustomProgressBar:
		node.fill_mode = value
		return self
	
	func show_percentage(value: bool) -> CustomProgressBar:
		node.show_percentage = value
		return self

class CustomTextureProgressBar extends CustomRange:
	func _init():
		super(TextureProgressBar.new())
	
	func fill_mode(value: ProgressBar.FillMode) -> CustomTextureProgressBar:
		node.fill_mode = value
		return self
	
	func nine_patch(value: bool) -> CustomTextureProgressBar:
		node.nine_patch_stretch = value
		return self

	func patch_margins(margins: Array[int]) -> CustomTextureProgressBar:
		var all_margins = [0, 0, 0, 0]
		if margins.size() == 1:
			all_margins[0] = margins[0]
			all_margins[1] = margins[0]
			all_margins[2] = margins[0]
			all_margins[3] = margins[0]
		elif margins.size() == 2:
			all_margins[0] = margins[1]
			all_margins[1] = margins[0]
			all_margins[2] = margins[1]
			all_margins[3] = margins[0]
		elif margins.size() == 4:
			all_margins[0] = margins[0]
			all_margins[1] = margins[1]
			all_margins[2] = margins[2]
			all_margins[3] = margins[3]
		else:
			push_error("Patch margins must be 1, 2, or 4 value arrays")
			return
		
		var idx = 0
		for margin in ["top", "right", "bottom", "left"]:
			node["stretch_margin_%s" % margin] = all_margins[idx]
			idx += 1
		
		return self
	
	func textures(value: Dictionary[String, Texture2D]) -> CustomTextureProgressBar:
		for state in value:
			if node.has(state):
				node[state] = value[state]
			else:
				push_error("Missing texture with name %s" % state)
				
		return self

class CustomRichTextLabel extends CustomControl:	
	func _init():
		super(RichTextLabel.new())

	func text(value: String) -> CustomRichTextLabel:
		node.text = value
		return self
	
	func bbc(value: bool) -> CustomRichTextLabel:
		node.bbcode_enabled = value
		return self
		
	func fit(value: bool) -> CustomRichTextLabel:
		node.fit_content = value
		return self
	

class CustomTextureRect extends CustomControl:
	func _init():
		super(TextureRect.new())

	func texture(value: Texture2D) -> CustomTextureRect:
		node.texture = value
		return self
		
	func flip_h(value: bool) -> CustomTextureRect:
		node.flip_h = value
		return self
		
	func flip_v(value: bool) -> CustomTextureRect:
		node.flip_v = value
		return self
	
	func stretch(value: TextureRect.StretchMode) -> CustomTextureRect:
		node.stretch_mode = value
		return self
	
	func expand(value: TextureRect.ExpandMode) -> CustomTextureRect:
		node.stretch_mode = value
		return self
	

class CustomHSeparator extends CustomControl:
	func _init():
		super(HSeparator.new())
		
class CustomVSeparator extends CustomControl:
	func _init():
		super(VSeparator.new())

class CustomBaseButton extends CustomControl:
	func _init(control: BaseButton):
		super(control)

	func toggle_mode(value: bool) -> CustomBaseButton:
		node.toggle_mode = value
		return self
		
	func action_mode(value: BaseButton.ActionMode) -> CustomBaseButton:
		node.action_mode = value
		return self
		
	func button_group(value: ButtonGroup) -> CustomBaseButton:
		node.button_group = value
		return self
	
	#func pressed(value: Callable) -> CustomBaseButton:
		#node.pressed.connect(value)
		#return self
		
	#func toggled(value: Callable) -> CustomBaseButton:
		#node.toggled.connect(value)
		#return self

class CustomButton extends CustomBaseButton:
	func _init():
		super(Button.new())

	func h_align(value: HorizontalAlignment) -> CustomButton:
		node.alignment = value
		return self
		
	func flat(value: bool) -> CustomButton:
		node.flat = value
		return self
		
	func text(value: String) -> CustomButton:
		node.text = value
		return self
		
	func colors(value: Dictionary[String, Color]) -> CustomButton:
		for color in value:
			if node.has(color):
				node[color] = value[color]
				
		return self
		
	func style_boxes(value: Dictionary[String, StyleBox]) -> CustomButton:
		for state in value:
			if node.has(state):
				node[state] = value[state]
				
		return self
		
class CustomTextureButton extends CustomBaseButton:
	func _init():
		super(TextureButton.new())

	func flip_h(value: bool) -> CustomTextureButton:
		node.flip_h = value
		return self
		
	func flip_v(value: bool) -> CustomTextureButton:
		node.flip_v = value
		return self
	
	func ignore_texture_size(value: bool) -> CustomTextureButton:
		node.ignore_texture_size = value
		return self
		
	func stretch_mode(value: TextureButton.StretchMode) -> CustomTextureButton:
		node.stretch_mode = value
		return self
	
	func click_mask(value: BitMap) -> CustomTextureButton:
		node.texture_click_mask = value
		return self
	
	func textures(value: Dictionary[String, Texture2D]) -> CustomTextureButton:
		for state in value:
			if node.has(state):
				node[state] = value[state]
			else:
				push_error("Missing texture with name %s" % state)
				
		return self

# Factory functions
func label(text_value := "") -> CustomLabel:
	return CustomLabel.new().text(text_value)

func color_rect(c: Color) -> CustomColorRect:
	return CustomColorRect.new().color(c)

func line_edit(text_value := "") -> CustomLineEdit:
	return CustomLineEdit.new().text(text_value)

func nine_patch_rect() -> CustomNinePatchRect:
	return CustomNinePatchRect.new()

func panel() -> CustomPanel:
	return CustomPanel.new()

func rt_label(text_value := "") -> CustomRichTextLabel:
	return CustomRichTextLabel.new().text(text_value)

func texture_rect() -> CustomTextureRect:
	return CustomTextureRect.new()

func h_sep() -> CustomHSeparator:
	return CustomHSeparator.new()
	
func v_sep() -> CustomVSeparator:
	return CustomVSeparator.new()

func vbox() -> CustomBoxContainer:
	var result = CustomBoxContainer.new(VBoxContainer.new())
	return result

func hbox() -> CustomBoxContainer:
	var result = CustomBoxContainer.new(HBoxContainer.new())
	return result

func hflow() -> CustomFlowContainer:
	var result = CustomFlowContainer.new(HFlowContainer.new())
	return result
	
func vflow() -> CustomFlowContainer:
	var result = CustomFlowContainer.new(VFlowContainer.new())
	return result

func centerc() -> CustomControl:
	return CustomControl.new(CenterContainer.new())

func grid() -> CustomGridContainer:
	return CustomGridContainer.new()

func marginc() -> CustomMarginContainer:
	return CustomMarginContainer.new()

func panelc() -> CustomPanelContainer:
	return CustomPanelContainer.new()

func scrollc() -> CustomScrollContainer:
	return CustomScrollContainer.new()

func progress_bar() -> CustomProgressBar:
	return CustomProgressBar.new()

func texture_progress_bar() -> CustomTextureProgressBar:
	return CustomTextureProgressBar.new()

func button() -> CustomButton:
	return CustomButton.new()

func texture_button() -> CustomTextureButton:
	return CustomTextureButton.new()

func control() -> CustomControl:
	return CustomControl.new(Control.new()).mouse_filter(IGNORE)

func _run() -> void:
	var root_control = view()
	var filepath = export_path() + ".tscn"
	
	var view = root_control.build()
	_set_owners(view, view)
	var scene = PackedScene.new()
	if scene.pack(view) == OK:
		var error = ResourceSaver.save(scene, filepath)
		if error != OK:
			push_error("An error occurred while saving the scene to disk: %s." % error)
		else:
			EditorInterface.reload_scene_from_path(filepath)

func _set_owners(ctrl: Node, owner: Node) -> void:
	for child in ctrl.get_children():
		child.owner = owner
		_set_owners(child, owner)

#class ControlBinding extends RefCounted:
	#var _prop_name: String
	#var _type: BindingType
	#var _ctx: Variant
	#var _property: String
	#
	#func _init(property_name: String, binding_type: BindingType, data_context: Variant, data_property_name: String):
		#_prop_name = property_name
		#_type = binding_type
		#_property = data_property_name
		#_ctx = data_context
