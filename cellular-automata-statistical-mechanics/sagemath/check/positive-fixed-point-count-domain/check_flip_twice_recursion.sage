# 対象ラベル: claim_single_cell_flip_positive_count_domain
# 式ペア・判定: G²x_a = G(Gx_a)
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

for a in STATES:
    assert (flip_iterate(configuration(a),2)) == (global_flip(global_flip(configuration(a)))), a
print("binary states checked:", len(STATES))
print("RESULT: PASS")
