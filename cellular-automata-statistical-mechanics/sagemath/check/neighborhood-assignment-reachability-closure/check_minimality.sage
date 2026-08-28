# 対象ラベル: claim_reflexive_transitive_closure_minimal
# 自己近傍を含み推移的で N を含む全候補に対する最小性を検査する。
# 帰属: 有限集合と有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

pairs_checked = 0
qualifying_pairs = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    assignments = neighborhood_assignments(cells)
    candidates = tuple(M for M in assignments if is_reflexive(cells, M) and is_transitive(cells, M))
    for assignment in assignments:
        result = closure(cells, assignment)
        for candidate in candidates:
            pairs_checked += 1
            if included(assignment, candidate):
                qualifying_pairs += 1
                for exponent in range(n * n + 2):
                    assert included(power(cells, assignment, exponent), candidate)
                assert included(result, candidate)

print("PASS check_minimality")
print("  assignment-candidate pairs checked:", pairs_checked)
print("  qualifying upper bounds checked:", qualifying_pairs)
