# 対象ラベル: claim_single_cell_flip_positive_count_domain
# 式ペア・判定: G^{2k+1}x_a = G(G^{2k}x_a)
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for a in STATES:
    assert flip_iterate(configuration(a),0) == configuration(a)
    for k in range(17):
        assert (flip_iterate(configuration(a),2*k+1)) == (global_flip(flip_iterate(configuration(a),2*k))), (a,k)
        tested += 1
print("state-index pairs checked:", tested)
print("RESULT: PASS")
