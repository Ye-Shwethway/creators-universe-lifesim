extends Control
class_name LifeSimMobileControls

signal movement_changed(axis: Vector2)
signal camera_dragged(delta: Vector2)
signal destination_tapped(screen_position: Vector2)
signal camera_zoomed(amount: float)
signal pause_toggled
signal reset_camera
signal run_changed(active: bool)

var joystick_id: int = -1
var camera_id: int = -1
var camera_start: Vector2 = Vector2.ZERO
var camera_drag_distance: float = 0.0
var touch_positions: Dictionary = {}
var pinch_previous_distance: float = 0.0
var pinching: bool = false
var joystick_origin: Vector2 = Vector2.ZERO
var joystick_axis: Vector2 = Vector2.ZERO
var paused: bool = false
var running: bool = false
const PAD_RADIUS: float = 73.0

func _ready() -> void:
    set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    mouse_filter = Control.MOUSE_FILTER_IGNORE
    queue_redraw()

func _input(event: InputEvent) -> void:
    if event is InputEventScreenTouch:
        var touch := event as InputEventScreenTouch
        if touch.pressed:
            touch_positions[touch.index] = touch.position
            if touch_positions.size() == 2 and joystick_id == -1:
                var positions: Array = touch_positions.values()
                pinch_previous_distance = (positions[0] as Vector2).distance_to(positions[1] as Vector2)
                pinching = true
                camera_drag_distance = 1000.0
            if pinching:
                get_viewport().set_input_as_handled()
                return
            if touch.position.y < 92.0 and touch.position.x > size.x - 120.0:
                paused = not paused
                pause_toggled.emit()
                queue_redraw()
                get_viewport().set_input_as_handled()
                return
            if touch.position.y > size.y * 0.48 and touch.position.x < size.x * 0.46 and joystick_id == -1:
                joystick_id = touch.index
                joystick_origin = touch.position
                joystick_axis = Vector2.ZERO
                queue_redraw()
                get_viewport().set_input_as_handled()
            elif touch.position.x >= size.x * 0.45 and camera_id == -1:
                camera_id = touch.index
                camera_start = touch.position
                camera_drag_distance = 0.0
        else:
            touch_positions.erase(touch.index)
            var was_pinching: bool = pinching
            if touch_positions.size() < 2:
                pinching = false
                pinch_previous_distance = 0.0
            if was_pinching:
                if touch.index == camera_id:
                    camera_id = -1
                get_viewport().set_input_as_handled()
                return
            if touch.index == joystick_id:
                joystick_id = -1
                joystick_axis = Vector2.ZERO
                movement_changed.emit(Vector2.ZERO)
                queue_redraw()
                get_viewport().set_input_as_handled()
            if touch.index == camera_id:
                if camera_drag_distance < 15.0 and camera_start.distance_to(touch.position) < 15.0:
                    destination_tapped.emit(touch.position)
                camera_id = -1
    elif event is InputEventScreenDrag:
        var drag := event as InputEventScreenDrag
        if touch_positions.has(drag.index):
            touch_positions[drag.index] = drag.position
        if pinching and touch_positions.size() == 2:
            var fingers: Array = touch_positions.values()
            var separation: float = (fingers[0] as Vector2).distance_to(fingers[1] as Vector2)
            if pinch_previous_distance > 0.0:
                camera_zoomed.emit((pinch_previous_distance - separation) * 0.012)
            pinch_previous_distance = separation
            get_viewport().set_input_as_handled()
            return
        if drag.index == joystick_id:
            joystick_axis = ((drag.position - joystick_origin) / PAD_RADIUS).limit_length()
            movement_changed.emit(Vector2(joystick_axis.x, joystick_axis.y))
            queue_redraw()
            get_viewport().set_input_as_handled()
        elif drag.index == camera_id:
            camera_drag_distance += drag.relative.length()
            if camera_drag_distance >= 15.0:
                camera_dragged.emit(drag.relative)
            get_viewport().set_input_as_handled()
    elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
        camera_dragged.emit((event as InputEventMouseMotion).relative)
    elif event is InputEventMouseButton and not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        destination_tapped.emit(event.position)
    elif event is InputEventMouseButton and event.pressed:
        var mouse := event as InputEventMouseButton
        if mouse.button_index == MOUSE_BUTTON_WHEEL_UP:
            camera_zoomed.emit(-0.5)
        elif mouse.button_index == MOUSE_BUTTON_WHEEL_DOWN:
            camera_zoomed.emit(0.5)

func _draw() -> void:
    var center: Vector2 = joystick_origin if joystick_id >= 0 else Vector2(105.0, size.y - 115.0)
    draw_circle(center, 77.0, Color(0.1, 0.16, 0.21, 0.45))
    draw_arc(center, 77.0, 0, TAU, 48, Color(1.0, 1.0, 1.0, 0.58), 3.0, true)
    draw_circle(center + joystick_axis * PAD_RADIUS, 31.0, Color(0.28, 0.76, 0.88, 0.75))
    draw_rect(Rect2(size.x - 112.0, 15.0, 98.0, 58.0), Color(0.07, 0.13, 0.19, 0.75), true)
    var font: Font = ThemeDB.fallback_font
    draw_string(font, Vector2(size.x - 96.0, 51.0), "RESUME" if paused else "PAUSE", HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color.WHITE)
    draw_string(font, Vector2(size.x - 210.0, size.y - 50.0), "Drag to orbit", HORIZONTAL_ALIGNMENT_LEFT, -1, 17, Color.WHITE)
    draw_string(font, Vector2(18.0, 40.0), "LIFESIM   M1.1", HORIZONTAL_ALIGNMENT_LEFT, -1, 22, Color.WHITE)

func _notification(what: int) -> void:
    if what == NOTIFICATION_RESIZED:
        queue_redraw()
