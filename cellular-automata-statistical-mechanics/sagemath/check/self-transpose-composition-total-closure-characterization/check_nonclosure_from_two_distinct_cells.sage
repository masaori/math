# 対象ラベル: claim_all_self_transpose_assignments_composition_closed_iff_subsingleton
# 「閉性 ⇒ |V| <= 1」の向きの第二段。相異なる a, b を持つ任意の有限舞台で、本文の二つの合成の値
#   (N_a star M_{a,b})(a) = ∪_{u ∈ N_a(a)} M_{a,b}(u) = M_{a,b}(a) = {b}
#   (M_{a,b} star N_a)(a) = ∪_{u ∈ M_{a,b}(a)} N_a(u) = N_a(b) = ∅
# を段ごとに検査し、b ∈ {b} かつ b ∉ ∅ から非可換を出し、
# claim_self_transpose_composition_iff_commute により合成が自己転置でないことを結論する。
# したがって |V| >= 2 の舞台では Closed_st(V) が成り立たない。
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

pair_count = 0

for n in range(2, 6):
    cells = tuple(range(n))
    # 定義そのものの否定: Closed_st(V) は成り立たない（全走査は |V| <= 3 まで）
    if n <= 3:
        assert not closed_st(cells)
    for a in cells:
        for b in cells:
            if a == b:
                continue
            pair_count += 1
            N = loop_witness(cells, a)
            M = edge_witness(cells, a, b)
            NM = compose(cells, N, M)
            MN = compose(cells, M, N)

            # (N_a star M_{a,b})(a) の三段
            union_first = set()
            for u in N[a]:
                union_first |= set(M[u])
            assert NM[a] == frozenset(union_first)          # 合成近傍の定義
            assert N[a] == frozenset((a,))                  # N_a(a) = {a}
            assert frozenset(union_first) == M[a]           # 合併は一項だけ
            assert M[a] == frozenset((b,))                  # M_{a,b}(a) = {b}
            assert NM[a] == frozenset((b,))

            # (M_{a,b} star N_a)(a) の三段
            union_second = set()
            for u in M[a]:
                union_second |= set(N[u])
            assert MN[a] == frozenset(union_second)         # 合成近傍の定義
            assert M[a] == frozenset((b,))                  # M_{a,b}(a) = {b}
            assert frozenset(union_second) == N[b]          # 合併は一項だけ
            assert N[b] == frozenset()                      # a ≠ b と N_a の定義
            assert MN[a] == frozenset()

            # 非等号
            assert b in NM[a]
            assert b not in MN[a]
            assert NM != MN

            # 同値の適用（自己転置な二つの割り当ての合成が自己転置 ⟺ 可換）
            assert transpose(cells, N) == N
            assert transpose(cells, M) == M
            assert transpose(cells, NM) != NM
            # 同値を経ない独立確認
            assert transpose(cells, NM) == MN


print("PASS nonclosure_from_two_distinct_cells pairs={}".format(pair_count))
