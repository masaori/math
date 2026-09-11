# 対象ラベル: claim_rational_prime_vector_finite_sum_distance_nonnegative
# 併せて検証: def_rational_prime_vector_zero, def_rational_prime_vector_finite_sum_distance
# 式ペア・判定: 二つの有限台の合併上の有理絶対差を有限加法した値は QQ の非負元である。
# 帰属: 有限集合・ZZ・QQ と有限台ベクトル。実数値ノルム、無限和、完備化は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

vectors = []
for values in itertools.product(range(-2, 3), repeat=len(PRIMES)):
    vectors.append({prime: QQ(value)
                    for prime, value in zip(PRIMES, values)
                    if value != 0})

pairs_checked = 0
summands_checked = 0
for left in vectors:
    for right in vectors:
        union_support = support(left).union(support(right))
        summands = tuple(abs(coefficient(left, prime) - coefficient(right, prime))
                         for prime in union_support)
        distance = finite_sum_distance(left, right)

        assert all(summand.parent() is QQ for summand in summands)
        assert all(summand >= 0 for summand in summands)
        assert distance.parent() is QQ
        assert distance == sum(summands, QQ(0))
        assert distance >= 0
        pairs_checked += 1
        summands_checked += len(summands)

assert zero_vector() == {}
assert support(zero_vector()) == set()
assert pairs_checked == 5 ** (2 * len(PRIMES))
assert pairs_checked > 0
assert summands_checked > 0
print('finite-support vector pairs checked:', pairs_checked)
print('absolute-difference summands checked:', summands_checked)
print('RESULT: PASS')
