# 対象ラベル: claim_transitive_and_factorable_neighborhood_assignment_independent
# 本文が挙げた二つの有限反例を、それぞれ定義へ戻って検査する。
#   (l) V1 = {a, b}, N1(a) = {b}, N1(b) = ∅ は推移的だが二段分解可能でない
#   (m) V2 = {a, b, c}, N2(a) = {a, b}, N2(b) = {b, c}, N2(c) = {c} は
#       二段分解可能だが推移的でない
# 併せて、二種類の反例が現れる最小の舞台元数を全数走査で記録する。本文は存在だけを主張しており
# 最小性は主張していないが、走査は二段分解可能だが推移的でない反例が二元舞台に既に存在することを
# 示す（本文の三元舞台の例より小さい）。
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

# (l) 二元舞台の反例
cells1 = (0, 1)  # 0 = a, 1 = b
N1 = (frozenset((1,)), frozenset())
# 二段の辺が無いので推移性の前提が成り立つ組が無い
assert [(v, u, w) for v in cells1 for u in N1[v] for w in N1[u]] == []
assert is_transitive(cells1, N1)
assert 1 in N1[0]
assert [u for u in N1[0] if 1 in N1[u]] == []
assert not is_two_step_factorable(cells1, N1)
assert not is_idempotent(cells1, N1)

# (m) 三元舞台の反例
cells2 = (0, 1, 2)  # 0 = a, 1 = b, 2 = c
N2 = (frozenset((0, 1)), frozenset((1, 2)), frozenset((2,)))
for v in cells2:
    for w in N2[v]:
        u = v  # 自己近傍を含むので u := v が証人になる
        assert u in N2[v]
        assert w in N2[u]
assert is_two_step_factorable(cells2, N2)
assert 1 in N2[0] and 2 in N2[1] and 2 not in N2[0]
assert not is_transitive(cells2, N2)
assert not is_idempotent(cells2, N2)

# 全数走査による最小舞台の記録（本文の主張は存在だけであり、最小性は主張していない）
first_transitive_not_factorable = None
first_factorable_not_transitive = None
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for N in neighborhood_assignments(cells):
        t = is_transitive(cells, N)
        f = is_two_step_factorable(cells, N)
        if t and not f and first_transitive_not_factorable is None:
            first_transitive_not_factorable = n
        if f and not t and first_factorable_not_transitive is None:
            first_factorable_not_transitive = n

assert first_transitive_not_factorable == 2
assert first_factorable_not_transitive == 2

# 走査が見つけた二元舞台の反例を、定義へ戻って個別に検査する
cells3 = (0, 1)
N3 = (frozenset((0, 1)), frozenset((0,)))
for v in cells3:
    for w in N3[v]:
        assert any(w in N3[u] for u in N3[v])
assert is_two_step_factorable(cells3, N3)
assert 0 in N3[1] and 1 in N3[0] and 1 not in N3[1]
assert not is_transitive(cells3, N3)
assert not is_idempotent(cells3, N3)

print("smallest stage with transitive but not factorable:", first_transitive_not_factorable)
print("smallest stage with factorable but not transitive:", first_factorable_not_transitive)
print("PASS check_independence_counterexamples")
