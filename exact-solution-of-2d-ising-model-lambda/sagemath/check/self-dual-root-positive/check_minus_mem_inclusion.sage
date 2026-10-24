from pathlib import Path
load(str(Path(__file__).resolve().parent / "_plus_mem_prelude.sage"))
for s in plus_mem_roots:
    assert j(minus_one_q) in QQbar
print("PASS minus_mem_inclusion: 2")
