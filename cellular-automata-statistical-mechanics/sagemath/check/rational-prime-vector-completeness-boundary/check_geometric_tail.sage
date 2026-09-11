# 対象ラベル: claim_rational_prime_vector_geometric_truncations_cauchy
# 併せて検証: def_increasing_prime_sequence, def_rational_prime_vector_geometric_truncation_sequence, def_rational_prime_vector_finite_sum_distance
# 式ペア・判定: 二つの打ち切り列の有限和差量を有限等比級数の尾へ移し、閉式と上界を各段で確かめる。
# 帰属: NN・ZZ・QQ と有限台ベクトル。無限和、完備化、実数体は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stage_pairs_checked = 0
for left_stage in range(1, 17):
    for right_stage in range(1, 17):
        lower_stage = ZZ(min(left_stage, right_stage))
        upper_stage = ZZ(max(left_stage, right_stage))
        distance = finite_sum_distance(
            geometric_truncation(ZZ(left_stage)),
            geometric_truncation(ZZ(right_stage)))
        finite_tail = sum(
            (QQ(1) / QQ(2 ** index)
             for index in range(lower_stage + 1, upper_stage + 1)),
            QQ(0))
        closed_tail = QQ(1) / QQ(2 ** lower_stage) - QQ(1) / QQ(2 ** upper_stage)

        assert distance.parent() is QQ
        assert distance == finite_tail
        assert finite_tail == closed_tail
        assert closed_tail < QQ(1) / QQ(2 ** lower_stage)
        assert QQ(1) / QQ(2 ** lower_stage) <= QQ(1) / QQ(lower_stage)
        stage_pairs_checked += 1

assert stage_pairs_checked == 16 * 16
assert stage_pairs_checked > 0
print('stage pairs checked:', stage_pairs_checked)
print('RESULT: PASS')
