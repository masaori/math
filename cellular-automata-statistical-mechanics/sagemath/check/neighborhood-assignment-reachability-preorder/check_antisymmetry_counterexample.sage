# 対象ラベル: claim_neighborhood_reachability_preorder_not_antisymmetric
# 二元舞台の明示表から、元の近傍の包含、相互到達、相異なる元を順に検査する。
# 帰属: 二元有限集合と有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

cells = (0, 1)
v0, v1 = cells
assignment = (frozenset((v1,)), frozenset((v0,)))
result = closure(cells, assignment)

assert v1 in assignment[v0]
assert assignment[v0] <= result[v0]
assert v1 in result[v0]
assert reachable(result, v0, v1)

assert v0 in assignment[v1]
assert assignment[v1] <= result[v1]
assert v0 in result[v1]
assert reachable(result, v1, v0)

assert v0 != v1
assert not all(
    left == right
    for left in cells
    for right in cells
    if reachable(result, left, right) and reachable(result, right, left)
)

print("PASS check_antisymmetry_counterexample")
print("  witness closure:", result)
