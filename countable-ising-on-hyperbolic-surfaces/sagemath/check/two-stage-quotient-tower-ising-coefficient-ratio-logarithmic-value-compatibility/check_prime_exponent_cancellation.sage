# 対象ラベル: theorem_quotient_tower_two_stage_ising_coefficient_ratio_logarithmic_value_compatibility
# 式ペア: v_p(a/b) = (nu_fine,p(m)-v_p(g))-(nu_coarse,p(m)-v_p(g)) = Delta nu_T(m,p)
# 帰属: a,b,g in ZZ_{>0}; all valuations and their differences in ZZ

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for degree in joint_positive_degrees:
    fine_coefficient, coarse_coefficient = coefficient_pair(degree)
    common_divisor = gcd(fine_coefficient, coarse_coefficient)
    reduced_numerator = fine_coefficient // common_divisor
    reduced_denominator = coarse_coefficient // common_divisor
    assert gcd(reduced_numerator, reduced_denominator) == 1

    candidate_primes = prime_divisors_by_finite_search(fine_coefficient * coarse_coefficient)
    for prime in candidate_primes:
        prime = ZZ(prime)
        common_valuation = prime_valuation_by_repeated_division(common_divisor, prime)
        reduced_ratio_valuation = (
            prime_valuation_by_repeated_division(reduced_numerator, prime)
            - prime_valuation_by_repeated_division(reduced_denominator, prime)
        )
        cancelled_valuation = (
            coefficient_valuation_pair(degree, prime)[0] - common_valuation
        ) - (
            coefficient_valuation_pair(degree, prime)[1] - common_valuation
        )
        assert reduced_ratio_valuation == cancelled_valuation
        assert cancelled_valuation == coefficient_valuation_difference(degree, prime)

print(
    "RESULT: PASS — reduced numerator and denominator valuations cancel the "
    "common-divisor valuation and equal the fine-minus-coarse coefficient "
    "valuation difference at every candidate prime"
)
