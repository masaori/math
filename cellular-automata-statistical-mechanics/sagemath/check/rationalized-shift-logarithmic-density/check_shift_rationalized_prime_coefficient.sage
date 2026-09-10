# 対象ラベル: claim_shift_rationalized_logarithmic_density_not_eventually_constant
# 併せて検証: def_shift_rationalized_logarithmic_density_sequence
# 式ペア・判定: 一方向シフトの不動点数から作る正規化列の素数 2 係数は各段階で 1/L になる。
# 帰属: 有限集合・NN・ZZ・QQ と有限台ベクトル。浮動小数点、実対数、実数、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stages_checked = 0
configurations_checked = 0
for length in range(1, 17):
    domain = configurations(length)
    fixed = tuple(configuration for configuration in domain
                  if shift_image(configuration) == configuration)
    logarithmic_count = integer_prime_vector(ZZ(len(fixed)))
    normalized = divide_rational_vector(rational_embedding(logarithmic_count), ZZ(length))

    assert ZZ(len(fixed)) == ZZ(2)
    assert logarithmic_count == {ZZ(2): ZZ(1)}
    assert set(normalized) == {ZZ(2)}
    assert coefficient(normalized, ZZ(2)) == QQ(1) / QQ(length)
    assert QQ(length) * coefficient(normalized, ZZ(2)) == QQ(1)
    configurations_checked += len(domain)
    stages_checked += 1

assert stages_checked == 16
assert configurations_checked == 131070
print('cyclic stages checked:', stages_checked)
print('configurations classified:', configurations_checked)
print('RESULT: PASS')
