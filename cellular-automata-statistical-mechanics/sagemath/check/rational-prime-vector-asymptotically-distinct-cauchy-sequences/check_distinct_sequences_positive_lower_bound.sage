# 対象ラベル: claim_rational_prime_vector_asymptotically_distinct_cauchy_sequences_uncountable
# 併せて検証: def_rational_prime_vector_cauchy_sequence_asymptotic_agreement, def_rational_prime_vector_finite_sum_distance
# 式ペア・判定: 相異なる二元列が最初に異なる係数の正有理下界を全後続段階で保つ。
# 帰属: NN・ZZ・QQ と有限台ベクトル。商集合、完備化、実数体は使わない。
import itertools
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

sequences = tuple(itertools.product((ZZ(0), ZZ(1)), repeat=7))
sequence_pairs_checked = 0
tail_stages_checked = 0
for left_index in range(len(sequences)):
    for right_index in range(left_index + 1, len(sequences)):
        left_bits = sequences[left_index]
        right_bits = sequences[right_index]
        differing_index = ZZ(next(
            index for index in range(1, len(left_bits) + 1)
            if left_bits[index - 1] != right_bits[index - 1]))
        epsilon = QQ(1) / QQ(2 ** differing_index)

        assert epsilon > 0
        for stage in range(differing_index, len(left_bits) + 1):
            left_vector = binary_geometric_truncation(left_bits, stage)
            right_vector = binary_geometric_truncation(right_bits, stage)
            differing_prime = increasing_prime(differing_index)
            coefficient_gap = abs(
                coefficient(left_vector, differing_prime)
                - coefficient(right_vector, differing_prime))
            distance = finite_sum_distance(left_vector, right_vector)

            assert coefficient_gap == epsilon
            assert distance >= coefficient_gap
            assert not distance < epsilon
            tail_stages_checked += 1
        sequence_pairs_checked += 1

assert sequence_pairs_checked == len(sequences) * (len(sequences) - 1) // 2
assert tail_stages_checked > sequence_pairs_checked
assert sequence_pairs_checked > 0
print('distinct binary sequence pairs checked:', sequence_pairs_checked)
print('tail stages checked:', tail_stages_checked)
print('RESULT: PASS')
