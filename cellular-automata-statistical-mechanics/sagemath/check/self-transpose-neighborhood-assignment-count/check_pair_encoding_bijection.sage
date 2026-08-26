# 対象ラベル: claim_self_transpose_pair_encoding_bijection
# ε_V が自己転置な近傍割り当て全体から U(V) の部分集合全体への全単射であり、
# 逆写像が ρ_V であることを全数検査する。本文の証明の各段を分けて検査する。
#   ε_V の所属条件が非順序対の表示順序に依存しないこと
#   w ∈ ρ_V(B)(v) ⟺ {v,w} ∈ B ⟺ {w,v} ∈ B ⟺ v ∈ ρ_V(B)(w)、よって ρ_V(B) は自己転置
#   {v,w} ∈ ε_V(ρ_V(B)) ⟺ w ∈ ρ_V(B)(v) ⟺ {v,w} ∈ B、外延性で ε_V ∘ ρ_V = id
#   w ∈ ρ_V(ε_V(N))(v) ⟺ {v,w} ∈ ε_V(N) ⟺ w ∈ N(v)、二回の外延性で ρ_V ∘ ε_V = id
# 帰属: 有限集合、有限部分集合、有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

encoding_count = 0
reconstruction_count = 0

for size in (0, 1, 2, 3, 4):
    cells = tuple(range(size))
    U = unordered_pairs(cells)
    self_transpose = self_transpose_assignments(cells)

    # 第一段: ε_V の所属条件は非順序対の表示順序に依存しない
    for N in self_transpose:
        for pair in U:
            values = set()
            for v, w in ordered_representatives(pair):
                values.add(w in N[v])
            assert len(values) == 1

    for B in subsets(tuple(sorted(U, key=lambda pair: tuple(sorted(pair))))):
        reconstruction_count += 1
        R = pair_reconstruction(cells, B)

        # 第二段: ρ_V(B) の所属の対称性（表示順序の入れ替えを経由する）
        for v in cells:
            for w in cells:
                assert (w in R[v]) == (frozenset((v, w)) in B)
                assert (frozenset((v, w)) in B) == (frozenset((w, v)) in B)
                assert (frozenset((w, v)) in B) == (v in R[w])
                assert (w in R[v]) == (v in R[w])
        # 第三段: 対称性から自己転置性（前の検算の逆方向を適用した結果）
        assert transpose(cells, R) == R
        assert R in self_transpose

        # 第四段: ε_V(ρ_V(B)) = B を所属ごとに検査してから外延性で等号
        for pair in U:
            v, w = ordered_representatives(pair)[0]
            assert (pair in pair_encoding(cells, R)) == (w in R[v])
            assert (w in R[v]) == (pair in B)
        assert pair_encoding(cells, R) == B

    for N in self_transpose:
        encoding_count += 1
        E = pair_encoding(cells, N)

        # 第五段: ε_V(N) は U(V) の部分集合である
        assert E <= U

        # 第六段: ρ_V(ε_V(N)) = N を所属ごとに検査してから二回の外延性で等号
        S = pair_reconstruction(cells, E)
        for v in cells:
            for w in cells:
                assert (w in S[v]) == (frozenset((v, w)) in E)
                assert (frozenset((v, w)) in E) == (w in N[v])
                assert (w in S[v]) == (w in N[v])
            assert S[v] == N[v]
        assert S == N

    # 第七段: 二つの合成が恒等なので、個数も一致する（全単射の帰結）
    assert len(self_transpose) == 2 ** len(U)
    assert len(frozenset(pair_encoding(cells, N) for N in self_transpose)) == len(self_transpose)

print("PASS pair_encoding_bijection self_transpose={} pair_sets={}".format(
    encoding_count, reconstruction_count
))
