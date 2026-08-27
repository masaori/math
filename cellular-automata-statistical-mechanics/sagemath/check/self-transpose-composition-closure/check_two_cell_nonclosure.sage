# 対象ラベル: claim_self_transpose_neighborhood_assignments_not_composition_closed
# 二元舞台の証人 N, M について N star M が自己転置でないことを、本文の式変形の各段に分けて検査する。
#   (N star M)(a) = ∪_{u ∈ N(a)} M(u) = M(a) = {b}
#   (M star N)(a) = ∪_{u ∈ M(a)} N(u) = N(b) = ∅
#   b ∈ {b} かつ b ∉ ∅ なので N star M ≠ M star N
#   自己転置性と可換性の同値により N star M は自己転置でない
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

cells = WITNESS_CELLS
a, b = cells
N = WITNESS_LOOP
M = WITNESS_EDGE

NM = compose(cells, N, M)
MN = compose(cells, M, N)

# 第一段: 合成近傍の定義（対象セル a での合併）
union_NM_at_a = set()
for u in N[a]:
    union_NM_at_a |= set(M[u])
assert NM[a] == frozenset(union_NM_at_a)
# 第二段: N(a) = {a} なので合併は M(a) の一項だけ
assert N[a] == frozenset((a,))
assert frozenset(union_NM_at_a) == M[a]
# 第三段: M(a) = {b}
assert M[a] == frozenset((b,))
assert NM[a] == frozenset((b,))

# 第一段: 合成近傍の定義（対象セル a での合併）
union_MN_at_a = set()
for u in M[a]:
    union_MN_at_a |= set(N[u])
assert MN[a] == frozenset(union_MN_at_a)
# 第二段: M(a) = {b} なので合併は N(b) の一項だけ
assert M[a] == frozenset((b,))
assert frozenset(union_MN_at_a) == N[b]
# 第三段: N(b) = ∅
assert N[b] == frozenset()
assert MN[a] == frozenset()

# 非等号: b ∈ (N star M)(a) かつ b ∉ (M star N)(a)
assert b in NM[a]
assert b not in MN[a]
assert NM[a] != MN[a]
assert NM != MN

# 同値の適用: 可換でないので合成は自己転置でない
assert transpose(cells, N) == N
assert transpose(cells, M) == M
assert transpose(cells, NM) != NM
# 転置を直に計算しても同じ結論になる（同値を経ない独立確認）
assert transpose(cells, NM) == MN

def _table(assignment):
    return tuple(tuple(sorted(assignment[v])) for v in cells)


print("PASS two_cell_nonclosure NM={} MN={} transpose_NM={}".format(
    _table(NM), _table(MN), _table(transpose(cells, NM))
))
