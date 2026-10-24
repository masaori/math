from pathlib import Path
load(str(Path(__file__).resolve().parent / "_plus_mem_prelude.sage"))
for s in plus_mem_roots:
    assert -one_k-s == -one_k+(-s)
print("PASS minus_mem_notation: 2")
