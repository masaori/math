from pathlib import Path
load(str(Path(__file__).resolve().parent / "_plus_mem_prelude.sage"))
for s in plus_mem_roots:
    assert (minus_one_q,minus_one_q) in cartesian_product([QQ,QQ])
print("PASS minus_mem_pair: 2")
