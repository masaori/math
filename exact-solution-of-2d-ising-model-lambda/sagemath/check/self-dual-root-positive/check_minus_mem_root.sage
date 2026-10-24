from pathlib import Path
load(str(Path(__file__).resolve().parent / "_plus_mem_prelude.sage"))
for s in plus_mem_roots:
    assert reconstruct_in_quadratic_field(-one_k-s,s) == (minus_one_q,minus_one_q)
print("PASS minus_mem_root: 2")
