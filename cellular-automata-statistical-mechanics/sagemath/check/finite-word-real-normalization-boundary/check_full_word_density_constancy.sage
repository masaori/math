# 対象ラベル: claim_full_two_symbol_word_realized_density_constant
# 全二元語族について、log_Lambda(2^n)=n log_Lambda(2) と規格化値の一定性を検査する。
# QQ 値は標準単射 QQ -> RR で本文の実数値の有限例になる。等号判定は QQ 内で厳密に行う。
# 帰属: NN、ZZ、QQ、有限台整数ベクトル。浮動小数点、実対数、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

weight_tables = (
    {ZZ(2): QQ(0)},
    {ZZ(2): QQ(1)},
    {ZZ(2): -QQ(3) / 5},
    {ZZ(2): QQ(11) / 7},
)
logarithm_of_two = prime_log_positive_integer(ZZ(2))

logarithm_identity_count = ZZ(0)
density_identity_count = ZZ(0)
for length in range(1, 129):
    logarithmic_count = prime_log_positive_integer(full_binary_word_count(length))
    assert logarithmic_count == natural_multiple(length, logarithm_of_two)
    logarithm_identity_count += 1

    for prime_weights in weight_tables:
        expected = rational_realization(logarithm_of_two, prime_weights)
        assert realized_density(length, prime_weights) == expected
        density_identity_count += 1

assert logarithm_identity_count == ZZ(128)
assert density_identity_count == ZZ(512)
print('finite logarithm identities checked:', logarithm_identity_count)
print('constant finite densities checked:', density_identity_count)
print('RESULT: PASS')
