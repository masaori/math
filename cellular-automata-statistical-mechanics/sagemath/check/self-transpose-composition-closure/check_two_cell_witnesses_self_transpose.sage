# 対象ラベル: claim_self_transpose_composition_loop_witness_is_self_transpose
#             claim_self_transpose_composition_edge_witness_is_self_transpose
#             def_self_transpose_composition_nonclosure_witness
# 二元舞台 V_st = {a, b} 上の二つの証人が自己転置であることを、本文の所属条件から段ごとに検査する。
#   自己ループの証人 N: w ∈ N(v) ⟺ v = w = a
#   二点を結ぶ証人 M: w ∈ M(v) ⟺ {v,w} = {a,b}
#   どちらも所属条件が v, w について対称なので、自己転置性の同値の逆向きが使える。
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

cells = WITNESS_CELLS
a, b = cells
assert a != b

N = WITNESS_LOOP
M = WITNESS_EDGE

# 定義の有限表そのもの
assert N[a] == frozenset((a,))
assert N[b] == frozenset()
assert M[a] == frozenset((b,))
assert M[b] == frozenset((a,))

step_count = 0
for v in cells:
    for w in cells:
        step_count += 1
        # 自己ループの証人: 第一段（有限表から所属条件へ）
        assert (w in N[v]) == (v == a and w == a)
        # 第二段（等号の対称性により所属条件は v, w について対称）
        assert (v == a and w == a) == (w == a and v == a)
        # 両段の合成
        assert (w in N[v]) == (v in N[w])

        # 二点を結ぶ証人: 第一段（有限表から所属条件へ）
        assert (w in M[v]) == (frozenset((v, w)) == frozenset((a, b)))
        # 第二段（二元集合の等号は表示順序に依らない）
        assert (frozenset((v, w)) == frozenset((a, b))) == (
            frozenset((w, v)) == frozenset((a, b))
        )
        # 両段の合成
        assert (w in M[v]) == (v in M[w])

# 自己転置性の同値の逆向き（所属の対称性から転置表の一致へ）
for v in cells:
    assert transpose(cells, N)[v] == N[v]
    assert transpose(cells, M)[v] == M[v]
assert transpose(cells, N) == N
assert transpose(cells, M) == M

print("PASS two_cell_witnesses_self_transpose steps={}".format(step_count))
