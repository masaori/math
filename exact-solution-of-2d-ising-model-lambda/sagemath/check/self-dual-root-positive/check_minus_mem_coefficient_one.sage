from pathlib import Path
load(str(Path(__file__).resolve().parent / "_plus_mem_prelude.sage"))
for s in plus_mem_roots:
    assert j(minus_one_q)+(-one_k)*s == j(minus_one_q)+(-j(one_q))*s
print("PASS minus_mem_coefficient_one: 2")
