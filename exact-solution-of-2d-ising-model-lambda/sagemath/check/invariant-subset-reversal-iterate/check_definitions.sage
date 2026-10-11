# 対象ラベル: def_finite_map_iteration, claim_invariant_subset_reversal_iterate
from pathlib import Path
from itertools import product
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
map_count = 0
value_count = 0
for size in range(5):
    for f in product(range(size), repeat=size):
        map_count += 1
        values = tuple(range(size))
        for k in range(14):
            for i in range(size):
                assert values[i] == repeat_value(f, k, i)
                value_count += 1
            # 本文の再帰: 第 k+1 反復の i での値は、第 k 反復の f(i) での値。
            values = tuple(values[f[i]] for i in range(size))
assert map_count == 289
assert value_count == 15596
assert any(len(sigma) == 0 for sigma, *_ in isr_cases)
assert any(len(C) == 0 and len(sigma) > 0 for sigma, C, *_ in isr_cases)
assert any(len(C) == len(sigma) and len(sigma) > 0 for sigma, C, *_ in isr_cases)
print("PASS check_definitions.sage: 289 maps, 15596 values; empty domain and both extreme subsets included")
