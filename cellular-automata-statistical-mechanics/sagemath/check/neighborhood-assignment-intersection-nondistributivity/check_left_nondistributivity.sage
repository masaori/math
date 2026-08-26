# 対象ラベル: claim_composition_not_left_distributive_over_pointwise_intersection
# def_composition_left_intersection_nondistributivity_witness の三元舞台で、
# 本文の証明の各式変形を段ごとに検査する。
#   ((N⊓M)*L)(a) = ∪_{u ∈ N(a)∩M(a)} L(u) = ∪_{u ∈ ∅} L(u) = ∅
#   ((N*L)⊓(M*L))(a) = L(b) ∩ L(c) = {a}
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

# V_cap = {a, b, c} を相異なる三元として表す
a, b, c = 0, 1, 2
cells = (a, b, c)
assert len(set(cells)) == 3

N = (frozenset({b}), frozenset(), frozenset())
M = (frozenset({c}), frozenset(), frozenset())
L = (frozenset(), frozenset({a}), frozenset({a}))

# 舞台の宣言どおりであることを確認する（指定しなかった近傍は空集合）
assert N[a] == frozenset({b}) and N[b] == frozenset() and N[c] == frozenset()
assert M[a] == frozenset({c}) and M[b] == frozenset() and M[c] == frozenset()
assert L[a] == frozenset() and L[b] == frozenset({a}) and L[c] == frozenset({a})

# 左辺の式変形
meet = pointwise_intersection(cells, N, M)
assert meet[a] == N[a] & M[a]
assert N[a] & M[a] == frozenset()          # {b} ∩ {c} = ∅（b ≠ c）
left_side = compose(cells, meet, L)
assert left_side[a] == frozenset()          # 空集合を添字とする合併

# 右辺の式変形
NL = compose(cells, N, L)
ML = compose(cells, M, L)
assert NL[a] == L[b]                        # ∪_{u ∈ {b}} L(u) = L(b)
assert ML[a] == L[c]                        # ∪_{u ∈ {c}} L(u) = L(c)
right_side = pointwise_intersection(cells, NL, ML)
assert right_side[a] == L[b] & L[c]
assert L[b] & L[c] == frozenset({a})

# a ∉ ∅ かつ a ∈ {a} なので二つの近傍割り当ては異なる
assert a not in left_side[a]
assert a in right_side[a]
assert left_side != right_side

print("PASS left_nondistributivity witness_cells={} lhs_at_a={} rhs_at_a={}".format(
    len(cells), sorted(left_side[a]), sorted(right_side[a])
))
