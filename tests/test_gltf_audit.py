import json
import struct
import tempfile
import unittest
from pathlib import Path
from tools.audit_gltf import inspect

class GltfAuditTests(unittest.TestCase):
    def test_rig_and_targets(self):
        doc = {"asset":{"version":"2.0"},"meshes":[{"primitives":[{"attributes":{"POSITION":0},"targets":[{},{},{},{}]}],"extras":{"targetNames":["Shoulders","Chest","Arms","Waist"]}}],"skins":[{"joints":[1,2]}],"nodes":[{"mesh":0,"skin":0},{"name":"root"},{"name":"joint"}]}
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp) / "sample.gltf"
            p.write_text(json.dumps(doc))
            r = inspect(p)
            self.assertTrue(r["rig_gate"])
            self.assertTrue(r["shape_gate"])
            binary = json.dumps(doc).encode()
            while len(binary) % 4: binary += b" "
            blob = struct.pack("<4sII",b"glTF",2,20+len(binary))+struct.pack("<II",len(binary),0x4E4F534A)+binary
            g = Path(tmp)/"sample.glb"
            g.write_bytes(blob)
            self.assertTrue(inspect(g)["rig_gate"])

    def test_nonrigged_placeholder_fails(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp)/"simple.gltf"
            p.write_text(json.dumps({"asset":{"version":"2.0"},"meshes":[{"primitives":[{}]}]}))
            r = inspect(p)
            self.assertFalse(r["rig_gate"])
            self.assertFalse(r["shape_gate"])

if __name__ == "__main__":
    unittest.main()
