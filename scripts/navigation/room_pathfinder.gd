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
    for id in ids:
        output.append(_world(id))
    output.append(Vector3(destination.x, 0.05, destination.z))
    return output
