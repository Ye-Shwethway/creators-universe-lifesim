extends SceneTree
func _initialize() -> void:
    var file := "res://assets/public/candidates/humanoid.glb"
    var packed: PackedScene = load(file)
    if packed == null:
        push_error("Cannot load candidate as PackedScene")
        quit(2)
        return
    var root: Node = packed.instantiate()
    root.name = "CandidateRoot"
    get_root().add_child(root)
    var skeletons: int = 0
    var skins: int = 0
    var meshes: int = 0
    var targets: int = 0
    var clips: int = 0
    var bone_names: Array[String] = []
    var morph_names: Array[String] = []
    var queue: Array[Node] = [root]
    while not queue.is_empty():
        var node: Node = queue.pop_front()
        if node is Skeleton3D:
            skeletons += 1
            skins += (node as Skeleton3D).get_bone_count()
            for b in (node as Skeleton3D).get_bone_count():
                bone_names.append((node as Skeleton3D).get_bone_name(b))
        if node is MeshInstance3D:
            meshes += 1
            var instance: MeshInstance3D = node as MeshInstance3D
            if instance.mesh != null:
                targets += instance.mesh.get_blend_shape_count()
                for i in instance.mesh.get_blend_shape_count():
                    morph_names.append(str(instance.mesh.get_blend_shape_name(i)))
        if node is AnimationPlayer:
            clips += (node as AnimationPlayer).get_animation_list().size()
        for child in node.get_children():
            queue.append(child)
    print("LIFESIM_HUMANOID_INSPECT skeletons=", skeletons, " bones=", skins, " mesh_nodes=", meshes, " shape_keys=", targets, " clips=", clips)
    print("LIFESIM_BONE_NAMES ", JSON.stringify(bone_names))
    print("LIFESIM_MORPH_NAMES ", JSON.stringify(morph_names))
    if skeletons < 1 or skins < 10 or meshes < 1 or targets < 4:
        push_error("Candidate lacks required imported rig/morph basics")
        quit(3)
        return
    quit(0)
