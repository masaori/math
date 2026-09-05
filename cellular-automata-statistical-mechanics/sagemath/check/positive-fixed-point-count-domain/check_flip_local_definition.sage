# 対象ラベル: claim_single_cell_flip_positive_count_domain
# 式ペア・判定: f_v(x_a|{v}) = ν((x_a|{v})(v))
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

for a in STATES:
    assert (local_flip(restriction(configuration(a)))) == (NEGATION[restriction(configuration(a))[CELL]]), a
print("binary states checked:", len(STATES))
print("RESULT: PASS")
