# 対象ラベル: claim_rational_prime_vector_asymptotically_distinct_cauchy_sequences_uncountable
# 併せて検証: def_rational_prime_vector_finite_sum_cauchy, def_rational_prime_vector_finite_sum_distance
# 式ペア・判定: 二元列の二つの打ち切り間の有限和差量を有限等比級数の尾で上から抑える。
# 帰属: NN・ZZ・QQ と有限台ベクトル。無限和、完備化、実数体は使わない。
import itertools
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

bit_sequences_checked = 0
stage_pairs_checked = 0
sequence_length = 8
for bits in itertools.product((ZZ(0), ZZ(1)), repeat=sequence_length):
    for left_stage in range(1, sequence_length + 1):
        for right_stage in range(1, sequence_length + 1):
            lower_stage = ZZ(min(left_stage, right_stage))
            upper_stage = ZZ(max(left_stage, right_stage))
            distance = finite_sum_distance(
                binary_geometric_truncation(bits, left_stage),
                binary_geometric_truncation(bits, right_stage))
            selected_tail = sum(
                (QQ(bits[index - 1]) / QQ(2 ** index)
                 for index in range(lower_stage + 1, upper_stage + 1)),
                QQ(0))
            full_tail = sum(
                (QQ(1) / QQ(2 ** index)
                 for index in range(lower_stage + 1, upper_stage + 1)),
                QQ(0))
            closed_tail = (
                QQ(1) / QQ(2 ** lower_stage)
                - QQ(1) / QQ(2 ** upper_stage))

            assert distance == selected_tail
            assert selected_tail <= full_tail
            assert full_tail == closed_tail
            assert closed_tail < QQ(1) / QQ(lower_stage)
            stage_pairs_checked += 1
    bit_sequences_checked += 1

assert bit_sequences_checked == 2 ** sequence_length
assert stage_pairs_checked == bit_sequences_checked * sequence_length ** 2
assert bit_sequences_checked > 0
assert stage_pairs_checked > 0
print('binary sequences checked:', bit_sequences_checked)
print('stage pairs checked:', stage_pairs_checked)
print('RESULT: PASS')
