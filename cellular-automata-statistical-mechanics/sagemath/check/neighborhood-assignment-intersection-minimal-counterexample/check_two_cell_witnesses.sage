# 対象ラベル: claim_two_cell_composition_intersection_nondistributivity
# def_two_cell_intersection_nondistributivity_witnesses の二元舞台 V_2 = {a, b} で、
# 本文の証明の各式変形を段ごとに検査する。
#   ((N⊓M)*L)(b)   = ∪_{u ∈ N(b)∩M(b)} L(u) = ∪_{u ∈ ∅} L(u) = ∅
#   ((N*L)⊓(M*L))(b) = L(a) ∩ L(b) = {a}
#   (L'*(N'⊓M'))(b)  = (N'⊓M')(a) ∪ (N'⊓M')(b) = ∅ ∪ ∅ = ∅
#   ((L'*N')⊓(L'*M'))(b) = (N'(a)∪N'(b)) ∩ (M'(a)∪M'(b)) = {a} ∩ {a} = {a}
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

# V_2 = {a, b} を相異なる二元として表す
a, b = 0, 1
cells = (a, b)
assert len(set(cells)) == 2

# 左側の証人
N = (frozenset(), frozenset({a}))
M = (frozenset(), frozenset({b}))
L = (frozenset({a}), frozenset({a}))
assert N[a] == frozenset() and N[b] == frozenset({a})
assert M[a] == frozenset() and M[b] == frozenset({b})
assert L[a] == frozenset({a}) and L[b] == frozenset({a})

meet = pointwise_intersection(cells, N, M)
assert meet[b] == N[b] & M[b]
assert N[b] & M[b] == frozenset()               # {a} ∩ {b} = ∅（a ≠ b）
left_lhs = compose(cells, meet, L)
assert left_lhs[b] == frozenset()               # 空集合を添字とする合併

NL = compose(cells, N, L)
ML = compose(cells, M, L)
assert NL[b] == L[a]                            # ∪_{u ∈ {a}} L(u) = L(a)
assert ML[b] == L[b]                            # ∪_{u ∈ {b}} L(u) = L(b)
left_rhs = pointwise_intersection(cells, NL, ML)
assert left_rhs[b] == L[a] & L[b]
assert L[a] & L[b] == frozenset({a})

assert a not in left_lhs[b]
assert a in left_rhs[b]
assert left_lhs != left_rhs

# 右側の証人
Np = (frozenset(), frozenset({a}))
Mp = (frozenset({a}), frozenset())
Lp = (frozenset(), frozenset({a, b}))
assert Np[a] == frozenset() and Np[b] == frozenset({a})
assert Mp[a] == frozenset({a}) and Mp[b] == frozenset()
assert Lp[a] == frozenset() and Lp[b] == frozenset({a, b})

meet_p = pointwise_intersection(cells, Np, Mp)
right_lhs = compose(cells, Lp, meet_p)
assert right_lhs[b] == meet_p[a] | meet_p[b]    # ∪_{u ∈ {a, b}}（Lp[b] = {a, b}）
assert meet_p[a] == frozenset() and meet_p[b] == frozenset()
assert right_lhs[b] == frozenset()

LN = compose(cells, Lp, Np)
LM = compose(cells, Lp, Mp)
assert LN[b] == Np[a] | Np[b]
assert LM[b] == Mp[a] | Mp[b]
assert LN[b] == frozenset({a}) and LM[b] == frozenset({a})
right_rhs = pointwise_intersection(cells, LN, LM)
assert right_rhs[b] == LN[b] & LM[b]
assert LN[b] & LM[b] == frozenset({a})          # 集合の冪等律

assert a not in right_lhs[b]
assert a in right_rhs[b]
assert right_lhs != right_rhs

print("PASS two_cell_witnesses cells={} left_lhs_at_b={} left_rhs_at_b={} right_lhs_at_b={} right_rhs_at_b={}".format(
    len(cells), sorted(left_lhs[b]), sorted(left_rhs[b]),
    sorted(right_lhs[b]), sorted(right_rhs[b])
))
