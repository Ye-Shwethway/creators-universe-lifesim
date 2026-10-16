import bpy, math
from mathutils import Vector
from pathlib import Path

out=Path("/tmp/lifesim-candidate")
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=str(out/"normalized.glb"))
meshes=[o for o in bpy.context.scene.objects if o.type=="MESH"]
assert meshes, "No character meshes"
def frame():
    bpy.context.view_layer.update()
    verts=[o.matrix_world @ Vector(corner) for o in meshes for corner in o.bound_box]
    low=Vector([min(v[i] for v in verts) for i in range(3)])
    high=Vector([max(v[i] for v in verts) for i in range(3)])
    center=(low+high)*0.5
    extent=max((high-low).length,1)
    return center,extent
center,extent=frame()
world=bpy.data.worlds.new("Studio") if bpy.context.scene.world is None else bpy.context.scene.world
bpy.context.scene.world=world
world.use_nodes=True
world.node_tree.nodes.get("Background").inputs["Strength"].default_value=0.8
def light(location,power):
    data=bpy.data.lights.new("Softbox","AREA")
    data.energy=power; data.shape="DISK"; data.size=extent*1.7
    obj=bpy.data.objects.new("Softbox",data);bpy.context.collection.objects.link(obj)
    obj.location=center+Vector(location)*extent
    direction=center-obj.location
    obj.rotation_euler=direction.to_track_quat("-Z","Y").to_euler()
light((1,-1,1),650)
light((-1,0,0.4),350)
camera_data=bpy.data.cameras.new("QA Camera")
camera=bpy.data.objects.new("QA Camera",camera_data)
bpy.context.collection.objects.link(camera)
camera.location=center+Vector((0,-1.7,0.35))*extent
camera.rotation_euler=(center-camera.location).to_track_quat("-Z","Y").to_euler()
camera_data.type="ORTHO";camera_data.ortho_scale=extent*1.35
scene=bpy.context.scene
scene.camera=camera;scene.render.engine="BLENDER_EEVEE";scene.render.resolution_x=640;scene.render.resolution_y=760;scene.render.resolution_percentage=100
scene.render.image_settings.file_format="PNG"
def render(name,morph=None):
    for o in meshes:
        if o.data.shape_keys:
            for key in o.data.shape_keys.key_blocks:
                if key.name!="Basis":key.value=0
    if morph:
        found=0
        for o in meshes:
            keys=o.data.shape_keys
            if keys and morph in keys.key_blocks:
                keys.key_blocks[morph].value=0.8
                found+=1
        assert found, f"Missing morph {morph}"
    scene.render.filepath=str(out/name)
    bpy.ops.render.render(write_still=True)
render("humanoid-neutral.png")
render("humanoid-shoulders.png","shouldersWider")
render("humanoid-chest.png","chestPectorals")
render("humanoid-arms.png","armsMuscular")
