# 対象ラベル: claim_shift_rationalized_logarithmic_density_converges_rationally
# 併せて検証: def_shift_rationalized_logarithmic_density_sequence,
# claim_cyclic_stage_shift_logarithmic_density_obstruction,
# claim_positive_integer_reciprocal_converges_rationally
# 式ペア・判定: シフト不動点数二から得る正規化列の素数二係数 q_sh(L) は逆数列 1/L に一致する。
# 帰属: 有限集合・NN・ZZ・QQ。浮動小数点、実対数、実数、位相、完備化は使わない。
import itertools


def configurations(length):
    return tuple(itertools.product((ZZ(0), ZZ(1)), repeat=length))


def shift_image(configuration):
    length = len(configuration)
    return tuple(configuration[(cell + 1) % length] for cell in range(length))


stages_checked = 0
configurations_checked = 0
for length in range(1, 17):
    domain = configurations(length)
    fixed = tuple(configuration for configuration in domain
                  if shift_image(configuration) == configuration)
    logarithmic_count = {
        ZZ(prime): ZZ(exponent)
        for prime, exponent in ZZ(len(fixed)).factor()
    }
    logarithmic_count_prime_two_coefficient = logarithmic_count.get(ZZ(2), ZZ(0))
    shift_coefficient = QQ(logarithmic_count_prime_two_coefficient) / QQ(length)
    reciprocal = QQ(1) / QQ(length)

    assert ZZ(len(fixed)) == ZZ(2)
    assert logarithmic_count == {ZZ(2): ZZ(1)}
    assert logarithmic_count_prime_two_coefficient == ZZ(1)
    assert shift_coefficient.parent() is QQ
    assert shift_coefficient == reciprocal
    assert abs(shift_coefficient - QQ(0)) == QQ(1) / QQ(length)
    configurations_checked += len(domain)
    stages_checked += 1

assert stages_checked == 16
assert configurations_checked == 131070
assert stages_checked > 0
assert configurations_checked > 0
print('cyclic stages checked:', stages_checked)
print('configurations classified:', configurations_checked)
print('RESULT: PASS')
