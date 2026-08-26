# 対象ラベル: claim_neighborhood_assignment_transpose_reverses_composition
# (N*M)^T = M^T * N^T を全数検査する。本文の証明の各段を分けて検査する。
#   w ∈ (N*M)^T(v) ⟺ v ∈ (N*M)(w)             （所属の向きの反転）
#                  ⟺ ∃u ∈ N(w), v ∈ M(u)      （合成近傍の定義）
#                  ⟺ ∃u ∈ M^T(v), w ∈ N^T(u)  （所属の向きの反転を二回）
#                  ⟺ w ∈ (M^T * N^T)(v)       （合成近傍の定義）
# 併せて、順序を反転しない側 (N*M)^T = N^T * M^T が一般には成り立たないことを走査で確かめる。
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

pair_count = 0
step_count = 0
order_preserving_failure_count = {}
minimal_order_failure_size = None

for size in (0, 1, 2, 3):
    cells = tuple(range(size))
    assignments = neighborhood_assignments(cells)
    failures = 0
    for N in assignments:
        TN = transpose(cells, N)
        for M in assignments:
            pair_count += 1
            TM = transpose(cells, M)
            composed = compose(cells, N, M)
            left = transpose(cells, composed)
            right = compose(cells, TM, TN)

            for v in cells:
                for w in cells:
                    step_count += 1
                    # 第一段: 所属の向きの反転
                    assert (w in left[v]) == (v in composed[w])
                    # 第二段: 合成近傍の定義（存在文）
                    exists_witness = any(v in M[u] for u in N[w])
                    assert (v in composed[w]) == exists_witness
                    # 第三段: 所属の向きの反転を二回（証人の条件の書き換え）
                    for u in cells:
                        assert (u in N[w] and v in M[u]) == (u in TM[v] and w in TN[u])
                    reversed_witness = any(w in TN[u] for u in TM[v])
                    assert exists_witness == reversed_witness
                    # 第四段: 合成近傍の定義（逆順の合成への所属）
                    assert reversed_witness == (w in right[v])

                # 集合の外延性
                assert left[v] == right[v]

            # 写像の外延性
            assert left == right

            # 順序を反転しない側は一般には成り立たない
            if left != compose(cells, TN, TM):
                failures += 1

    order_preserving_failure_count[size] = failures
    if failures > 0 and minimal_order_failure_size is None:
        minimal_order_failure_size = size

assert order_preserving_failure_count[0] == 0
assert order_preserving_failure_count[1] == 0
assert order_preserving_failure_count[2] > 0
assert order_preserving_failure_count[3] > 0
assert minimal_order_failure_size == 2

print("PASS transpose_reverses_composition pairs={} steps={}".format(pair_count, step_count))
print("     order_preserving_failures_by_size={} minimal_failure_size={}".format(
    order_preserving_failure_count, minimal_order_failure_size
))
