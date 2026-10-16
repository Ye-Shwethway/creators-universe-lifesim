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
    var rig_node: Skeleton3D = null
    var shape_node: MeshInstance3D = null
    var bone_names: Array[String] = []
    var morph_names: Array[String] = []
    var queue: Array[Node] = [root]
    while not queue.is_empty():
        var node: Node = queue.pop_front()
        if node is Skeleton3D:
            rig_node = node as Skeleton3D
            skeletons += 1
            skins += (node as Skeleton3D).get_bone_count()
            for b in (node as Skeleton3D).get_bone_count():
                bone_names.append((node as Skeleton3D).get_bone_name(b))
        if node is MeshInstance3D:
            var candidate_mesh: MeshInstance3D = node as MeshInstance3D
            if candidate_mesh.mesh != null and candidate_mesh.mesh.get_blend_shape_count() >= 4:
                shape_node = candidate_mesh
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
    var needed: Array[String] = ["mixamorig_LeftUpLeg", "mixamorig_RightUpLeg", "mixamorig_LeftArm", "mixamorig_RightArm"]
    for bone_name in needed:
        var idx: int = rig_node.find_bone(bone_name)
        if idx < 0:
            push_error("Missing walk animation bone: " + bone_name)
            quit(4)
            return
        rig_node.set_bone_pose_rotation(idx, Quaternion(Vector3.RIGHT, 0.2))
    var tested: int = 0
    var morph_requested: Array[String] = ["shouldersWider", "chestPectorals", "waistNarrower", "armsMuscular", "bodyMuscular"]
    for morph in morph_requested:
        if not morph_names.has(morph):
            push_error("Required physique shape key missing: " + morph)
            quit(5)
            return
        for n in root.find_children("*", "MeshInstance3D", true, false):
            var instance: MeshInstance3D = n as MeshInstance3D
            if instance.mesh == null:
                continue
            var index: int = instance.mesh.get_blend_shape_count()
            for i in index:
                if str(instance.mesh.get_blend_shape_name(i)) == morph:
                    instance.set_blend_shape_value(i, 0.5)
                    if absf(instance.get_blend_shape_value(i) - 0.5) > 0.01:
                        push_error("Morph did not accept value: " + morph)
                        quit(6)
                        return
                    tested += 1
    if tested < morph_requested.size():
        push_error("Morph value test incomplete")
        quit(7)
        return
    print("LIFESIM_POSE_MORPH_TEST bones=", needed.size(), " morph_assignments=", tested, " PASS")
    quit(0)
