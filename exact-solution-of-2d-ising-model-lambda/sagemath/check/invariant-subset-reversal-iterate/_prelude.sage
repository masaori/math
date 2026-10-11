from pathlib import Path
load(str(Path(__file__).resolve().parent.parent / "invariant-subset-reversal" / "_prelude.sage"))

def repeat_value(f, k, i):
    value = i
    for _ in range(k):
        value = f[value]
    return value
