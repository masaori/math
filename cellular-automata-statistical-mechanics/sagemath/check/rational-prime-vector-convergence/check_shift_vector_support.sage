# 対象ラベル: claim_shift_rationalized_logarithmic_density_vector_converges
# 併せて検証: def_shift_rationalized_logarithmic_density_sequence, def_rational_prime_vector_zero
# 式ペア・判定: 各正の舞台サイズでシフト正規化ベクトルの台は素数二だけで、零ベクトルの台は空である。
# 帰属: NN・ZZ・QQ と有限台ベクトル。実数、無限和、完備化は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stages_checked = 0
coefficients_checked = 0
for length in range(1, 129):
    vector = shift_normalized_vector(ZZ(length))

    assert support(vector) == {ZZ(2)}
    assert coefficient(vector, ZZ(2)) == QQ(1) / QQ(length)
    for prime in PRIMES:
        expected = QQ(1) / QQ(length) if prime == ZZ(2) else QQ(0)
        assert coefficient(vector, prime) == expected
        coefficients_checked += 1
    stages_checked += 1

assert support(zero_vector()) == set()
assert stages_checked == 128
assert coefficients_checked == stages_checked * len(PRIMES)
print('cyclic stages checked:', stages_checked)
print('prime coefficients checked:', coefficients_checked)
print('RESULT: PASS')
