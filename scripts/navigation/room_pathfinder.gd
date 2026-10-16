extends RefCounted
class_name LifeSimRoomPathfinder
## Small-room deterministic clearance grid. Replace with NavMesh region graph for large worlds.
const CELL: float = 0.5
const LIMIT: float = 6.0
const GRID: int = 25
var grid: AStarGrid2D

func _init() -> void:
    grid = AStarGrid2D.new()
    grid.region = Rect2i(0, 0, GRID, GRID)
    grid.cell_size = Vector2(CELL, CELL)
    grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
    grid.update()
    # Clearance accounts for capsule radius (0.35) + margins.
    for x in GRID:
        for y in GRID:
            var p: Vector3 = _world(Vector2i(x, y))
            if absf(p.x) > LIMIT or absf(p.z) > LIMIT:
                grid.set_point_solid(Vector2i(x, y))
            elif absf(p.x - 3.4) < 1.65 and absf(p.z + 2.6) < 1.05:
                grid.set_point_solid(Vector2i(x, y))
            elif absf(p.x + 3.0) < 1.35 and absf(p.z + 2.6) < 0.95:
                grid.set_point_solid(Vector2i(x, y))

func _cell(world: Vector3) -> Vector2i:
    return Vector2i(clampi(roundi((world.x + LIMIT) / CELL), 0, GRID - 1), clampi(roundi((world.z + LIMIT) / CELL), 0, GRID - 1))

func _world(cell: Vector2i) -> Vector3:
    return Vector3(cell.x * CELL - LIMIT, 0.05, cell.y * CELL - LIMIT)

func route(from: Vector3, destination: Vector3) -> Array[Vector3]:
    var output: Array[Vector3] = []
    if absf(destination.x) > LIMIT or absf(destination.z) > LIMIT:
        return output
    var start: Vector2i = _cell(from)
    var finish: Vector2i = _cell(destination)
    if grid.is_point_solid(start) or grid.is_point_solid(finish):
        return output
    var ids: Array[Vector2i] = grid.get_id_path(start, finish)
    if ids.is_empty():
        return output
    var raw: Array[Vector3] = []
    raw.append(Vector3(from.x, 0.05, from.z))
    for id in ids:
        raw.append(_world(id))
    raw.append(Vector3(destination.x, 0.05, destination.z))
    # String-pull grid path into the furthest safe visible waypoint.
    # Samples have subcell spacing and use the same clearance-solid grid.
    var anchor: int = 0
    while anchor < raw.size() - 1:
        var farthest: int = anchor + 1
        for candidate in range(raw.size() - 1, anchor, -1):
            if _clear_segment(raw[anchor], raw[candidate]):
                farthest = candidate
                break
        output.append(raw[farthest])
        anchor = farthest
    return output

func _clear_segment(a: Vector3, b: Vector3) -> bool:
    var dist: float = a.distance_to(b)
    var steps: int = maxi(1, ceili(dist / 0.1))
    for i in range(steps + 1):
        var t: float = float(i) / float(steps)
        var sample: Vector3 = a.lerp(b, t)
        if absf(sample.x) > LIMIT or absf(sample.z) > LIMIT:
            return false
        var cell: Vector2i = _cell(sample)
        if grid.is_point_solid(cell):
            return false
    return true
