# 対象ラベル: def_finite_word_realized_logarithmic_density
# 正の語長の有理像が非零であり、正の語個数の素数指数表の実現値を除算できることを検査する。
# QQ 値は標準単射 QQ -> RR で本文の実数値の有限例になる。等号判定は QQ 内で厳密に行う。
# 帰属: NN、ZZ、QQ、有限台整数ベクトル。零除算、浮動小数点、実対数、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

weight_tables = (
    {ZZ(2): QQ(0)},
    {ZZ(2): QQ(1)},
    {ZZ(2): -QQ(3) / 5},
    {ZZ(2): QQ(11) / 7},
)

division_count = ZZ(0)
for prime_weights in weight_tables:
    for length in range(1, 129):
        count = full_binary_word_count(length)
        denominator = QQ(length)
        logarithmic_count = prime_log_positive_integer(count)
        numerator = rational_realization(logarithmic_count, prime_weights)

        assert count > 0
        assert denominator > 0
        assert denominator != 0
        quotient = numerator / denominator
        assert quotient * denominator == numerator
        division_count += 1

assert len(weight_tables) == ZZ(4)
assert division_count == ZZ(512)
print('positive-length exact divisions checked:', division_count)
print('RESULT: PASS')
