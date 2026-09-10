# 対象ラベル: claim_cyclic_stage_shift_logarithmic_density_obstruction
# 併せて検証: def_cyclic_stage_logarithmic_density_domain
# 式ペア・判定: L b=log_Lambda(2) の整数係数解は L=1 に限り存在し、L>=2 では係数 1 を割れない。
# 帰属: ZZ・NN と有限台整数ベクトル Lambda。浮動小数点、実数除算、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

logarithmic_count = prime_vector(ZZ(2))
domain_prefix = set()
stages_checked = 0
for length in range(1, 129):
    divisible = is_divisible_vector(logarithmic_count, ZZ(length))
    if divisible:
        quotient = tuple((prime, coefficient // ZZ(length))
                         for prime, coefficient in logarithmic_count)
        assert tuple(prime for prime, _ in quotient) == tuple(
            prime for prime, _ in logarithmic_count)
        assert all(ZZ(length) * quotient_coefficient == coefficient
                   for (_, coefficient), (_, quotient_coefficient)
                   in zip(logarithmic_count, quotient))
        domain_prefix.add(length)
    else:
        assert any(ZZ(coefficient) % ZZ(length) != 0
                   for _, coefficient in logarithmic_count)
    assert divisible == (length == 1)
    stages_checked += 1

assert domain_prefix == {1}
assert stages_checked > 0
print('stage sizes checked:', stages_checked)
print('defined density stages:', sorted(domain_prefix))
print('RESULT: PASS')
