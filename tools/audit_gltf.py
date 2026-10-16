#!/usr/bin/env python3
"""Offline glTF/GLB humanoid audit. Reports facts, never fabricates rig/morph capability."""
import argparse
import json
import struct
import sys
from pathlib import Path

def load_gltf(path):
    data = path.read_bytes()
    if path.suffix.lower() == ".glb":
        if len(data) < 20 or data[:4] != b"glTF":
            raise ValueError("Not a GLB")
        magic, version, length = struct.unpack_from("<4sII", data)
        if version != 2 or length != len(data):
            raise ValueError("Malformed GLB header/length")
        size, chunk_type = struct.unpack_from("<II", data, 12)
        if chunk_type != 0x4E4F534A or 20 + size > len(data):
            raise ValueError("Missing/invalid JSON chunk")
        return json.loads(data[20:20 + size].decode("utf8"))
    return json.loads(data.decode("utf8"))

def inspect(path):
    doc = load_gltf(path)
    assets = doc.get("asset", {})
    if not str(assets.get("version", "")).startswith("2."):
        raise ValueError("glTF 2.0 required")
    meshes = doc.get("meshes", [])
    skins = doc.get("skins", [])
    nodes = doc.get("nodes", [])
    animations = doc.get("animations", [])
    morphs = []
    for mesh in meshes:
        for prim in mesh.get("primitives", []):
            if "targets" in prim:
                morphs.append(len(prim["targets"]))
    joint_counts = [len(s.get("joints", [])) for s in skins]
    linked = [n for n in nodes if "skin" in n and "mesh" in n]
    materials = doc.get("materials", [])
    return {
        "asset": path.name, "version": assets.get("version"),
        "meshes": len(meshes), "skins": len(skins),
        "skin_joints": joint_counts, "skinned_mesh_nodes": len(linked),
        "animations": len(animations), "materials": len(materials),
        "morph_target_counts_by_primitive": morphs,
        "morph_target_names": [m.get("extras", {}).get("targetNames", []) for m in meshes],
        "extensions_required": doc.get("extensionsRequired", []),
        "rig_gate": bool(joint_counts and linked),
        "shape_gate": bool(morphs and max(morphs) >= 4)
    }

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("asset", type=Path)
    parser.add_argument("--require-rig", action="store_true")
    parser.add_argument("--require-four-morphs", action="store_true")
    args = parser.parse_args()
    try:
        result = inspect(args.asset)
        print(json.dumps(result, indent=2))
        if args.require_rig and not result["rig_gate"]:
            print("FAIL: skinned rigged mesh not detected", file=sys.stderr)
            return 2
        if args.require_four_morphs and not result["shape_gate"]:
            print("FAIL: four morph targets not found", file=sys.stderr)
            return 3
        return 0
    except (OSError, ValueError, json.JSONDecodeError, struct.error) as e:
        print("FAIL:", e, file=sys.stderr)
        return 1

if __name__ == "__main__":
    sys.exit(main())
