from pathlib import Path
load(str(Path(__file__).resolve().parent / "_plus_mem_prelude.sage"))
for s in plus_mem_roots:
    assert -(j(one_q))+(-s) == j(minus_one_q)+(-s)
print("PASS minus_mem_map_neg: 2")
