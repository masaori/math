# 対象ラベル: claim_all_self_transpose_assignments_composition_closed_iff_subsingleton
# 「閉性 ⇒ |V| <= 1」の向きの第一段。相異なる a, b を持つ任意の有限舞台で、本文の二つの証人
#   N_a(v) = {a} (v = a), ∅ (v ≠ a)
#   M_{a,b}(v) = {b} (v = a), {a} (v = b), ∅ (それ以外)
# が自己転置であることを、本文の二つの同値の連鎖の各段に分けて検査する。
#   w ∈ N_a(v) ⟺ v = w = a ⟺ v ∈ N_a(w)
#   w ∈ M_{a,b}(v) ⟺ (v = a ∧ w = b) ∨ (v = b ∧ w = a) ⟺ v ∈ M_{a,b}(w)
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

pair_count = 0
membership_count = 0

for n in range(2, 6):
    cells = tuple(range(n))
    for a in cells:
        for b in cells:
            if a == b:
                continue
            pair_count += 1
            N = loop_witness(cells, a)
            M = edge_witness(cells, a, b)

            for v in cells:
                for w in cells:
                    membership_count += 1
                    # N_a の第一段: 定義から所属条件を出す
                    assert (w in N[v]) == (v == a and w == a)
                    # N_a の第二段: 条件が v, w について対称
                    assert (v == a and w == a) == (w == a and v == a)
                    # N_a の第三段: 対称形を再び定義で読み替える
                    assert (w == a and v == a) == (v in N[w])

                    # M_{a,b} の第一段: 定義から所属条件を出す
                    assert (w in M[v]) == ((v == a and w == b) or (v == b and w == a))
                    # M_{a,b} の第二段: 二つの選言の交換
                    assert (((v == a and w == b) or (v == b and w == a))
                            == ((w == a and v == b) or (w == b and v == a)))
                    # M_{a,b} の第三段: 交換した形を再び定義で読み替える
                    assert (((w == a and v == b) or (w == b and v == a))
                            == (v in M[w]))

            # claim_self_transpose_iff_symmetric_membership の結論（転置表の一致）
            assert transpose(cells, N) == N
            assert transpose(cells, M) == M

print("PASS witnesses_self_transpose pairs={} membership_checks={}".format(
    pair_count, membership_count
))
