# 対象ラベル: claim_composition_not_right_distributive_over_pointwise_intersection
# def_composition_right_intersection_nondistributivity_witness の三元舞台で、
# 本文の証明の各式変形を段ごとに検査する。
#   (L'*(N'⊓M'))(a) = (N'⊓M')(b) ∪ (N'⊓M')(c) = ∅ ∪ ∅ = ∅
#   ((L'*N')⊓(L'*M'))(a) = (N'(b)∪N'(c)) ∩ (M'(b)∪M'(c)) = {a} ∩ {a} = {a}
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

a, b, c = 0, 1, 2
cells = (a, b, c)
assert len(set(cells)) == 3

Lp = (frozenset({b, c}), frozenset(), frozenset())
Np = (frozenset(), frozenset({a}), frozenset())
Mp = (frozenset(), frozenset(), frozenset({a}))

assert Lp[a] == frozenset({b, c}) and Lp[b] == frozenset() and Lp[c] == frozenset()
assert Np[a] == frozenset() and Np[b] == frozenset({a}) and Np[c] == frozenset()
assert Mp[a] == frozenset() and Mp[b] == frozenset() and Mp[c] == frozenset({a})

# 左辺の式変形
meet = pointwise_intersection(cells, Np, Mp)
left_side = compose(cells, Lp, meet)
assert left_side[a] == meet[b] | meet[c]     # ∪_{u ∈ {b,c}} (N'⊓M')(u)
assert meet[b] == Np[b] & Mp[b]
assert meet[c] == Np[c] & Mp[c]
assert meet[b] == frozenset() and meet[c] == frozenset()
assert left_side[a] == frozenset()           # ∅ ∪ ∅ = ∅

# 右辺の式変形
LN = compose(cells, Lp, Np)
LM = compose(cells, Lp, Mp)
assert LN[a] == Np[b] | Np[c]
assert LM[a] == Mp[b] | Mp[c]
right_side = pointwise_intersection(cells, LN, LM)
assert right_side[a] == (Np[b] | Np[c]) & (Mp[b] | Mp[c])
assert (Np[b] | Np[c]) == frozenset({a}) and (Mp[b] | Mp[c]) == frozenset({a})
assert frozenset({a}) & frozenset({a}) == frozenset({a})   # 集合の冪等律
assert right_side[a] == frozenset({a})

assert a not in left_side[a]
assert a in right_side[a]
assert left_side != right_side

print("PASS right_nondistributivity witness_cells={} lhs_at_a={} rhs_at_a={}".format(
    len(cells), sorted(left_side[a]), sorted(right_side[a])
))
