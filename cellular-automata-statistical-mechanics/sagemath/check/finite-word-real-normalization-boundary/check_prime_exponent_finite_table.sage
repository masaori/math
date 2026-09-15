# 対象ラベル: def_finite_word_realized_logarithmic_density
# 正の有限二元語個数だけが対数順序群の素数指数表へ入ることを検査する。
# 帰属: NN、ZZ、有限台整数ベクトル。浮動小数点、実対数、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

length_count = ZZ(0)
coefficient_count = ZZ(0)
for length in range(1, 65):
    count = full_binary_word_count(length)
    logarithmic_count = prime_log_positive_integer(count)

    assert count == ZZ(2) ** length
    assert count > 0
    assert logarithmic_count == {ZZ(2): ZZ(length)}
    assert all(coefficient != 0 for coefficient in logarithmic_count.values())

    length_count += 1
    coefficient_count += len(logarithmic_count)

assert length_count == ZZ(64)
assert coefficient_count == length_count
print('positive word lengths checked:', length_count)
print('nonzero prime coefficients checked:', coefficient_count)
print('RESULT: PASS')
