from pathlib import Path
load(str(Path(__file__).resolve().parent / "_plus_mem_prelude.sage"))
for s in plus_mem_roots:
    assert -one_k+(-s) == -(j(one_q))+(-s)
print("PASS minus_mem_map_one: 2")
