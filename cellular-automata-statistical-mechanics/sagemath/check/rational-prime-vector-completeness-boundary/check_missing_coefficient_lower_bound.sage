# 対象ラベル: claim_rational_prime_vector_geometric_truncations_no_limit
# 併せて検証: def_increasing_prime_sequence, def_rational_prime_vector_geometric_truncation_sequence, def_rational_prime_vector_finite_sum_convergence
# 式ペア・判定: 有限台候補の台から外れる素数係数を選び、その係数が与える正の距離下界と開始段階への反例を確かめる。
# 帰属: NN・ZZ・QQ と有限台ベクトル。完備化、無限和、実数体は使わない。
import itertools
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

candidate_primes = tuple(increasing_prime(index) for index in range(1, 5))
candidates_checked = 0
tail_stages_checked = 0
for values in itertools.product((QQ(-1), QQ(0), QQ(1)), repeat=len(candidate_primes)):
    candidate = {
        prime: value
        for prime, value in zip(candidate_primes, values)
        if value != 0
    }
    missing_index = next(
        index for index in range(1, 6)
        if increasing_prime(index) not in support(candidate))
    missing_prime = increasing_prime(missing_index)
    epsilon = QQ(1) / QQ(2 ** missing_index)

    assert missing_prime not in support(candidate)
    assert coefficient(candidate, missing_prime) == 0
    assert epsilon > 0
    for initial_stage in range(1, 9):
        witness_stage = ZZ(max(initial_stage, missing_index))
        truncation = geometric_truncation(witness_stage)
        distance = finite_sum_distance(truncation, candidate)

        assert witness_stage >= initial_stage
        assert witness_stage >= missing_index
        assert coefficient(truncation, missing_prime) == epsilon
        assert abs(coefficient(truncation, missing_prime)
                   - coefficient(candidate, missing_prime)) == epsilon
        assert distance >= epsilon
        tail_stages_checked += 1
    candidates_checked += 1

assert candidates_checked == 3 ** 4
assert tail_stages_checked == candidates_checked * 8
assert candidates_checked > 0
assert tail_stages_checked > 0
print('finite-support candidates checked:', candidates_checked)
print('initial stages checked:', tail_stages_checked)
print('RESULT: PASS')
