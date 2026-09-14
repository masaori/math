# 対象ラベル: claim_shift_rationalized_logarithmic_density_not_eventually_constant
# 併せて検証: def_finite_support_rational_prime_vectors
# 式ペア・判定: 有限台整数ベクトルの有理係数への埋め込みと、正整数による係数ごとの除算は有限台を保つ。
# 帰属: 有限集合・ZZ・QQ と有限台ベクトル。浮動小数点、実数、極限、完備化は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

vectors_checked = 0
divisions_checked = 0
for coefficients in itertools.product(range(-2, 3), repeat=len(PRIMES)):
    integer_vector = {
        prime: ZZ(value)
        for prime, value in zip(PRIMES, coefficients)
        if value != 0
    }
    embedded = rational_embedding(integer_vector)

    assert set(embedded) == set(integer_vector)
    assert all(value.parent() is QQ for value in embedded.values())
    assert all(embedded[prime] == QQ(integer_vector[prime]) for prime in integer_vector)
    vectors_checked += 1

    for length in range(1, 65):
        divided = divide_rational_vector(embedded, ZZ(length))
        assert set(divided) == set(embedded)
        assert all(value.parent() is QQ for value in divided.values())
        assert all(QQ(length) * divided[prime] == embedded[prime] for prime in embedded)
        divisions_checked += 1

assert vectors_checked == 5 ** len(PRIMES)
assert divisions_checked == vectors_checked * 64
assert vectors_checked > 0
assert divisions_checked > 0
print('finite-support vectors checked:', vectors_checked)
print('positive-integer divisions checked:', divisions_checked)
print('RESULT: PASS')
