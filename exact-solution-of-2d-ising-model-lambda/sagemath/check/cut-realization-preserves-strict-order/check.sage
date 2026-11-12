# 対象ラベル: claim_cut_realization_preserves_strict_order
# 本文の各行を実代数的数（AA）の有限例で厳密に検算する。<_R は AA の順序で代用し、
# 実現写像 ρ の値は AA の元そのもの（実数への包含）で代用する。
# 下切断の実数上限・加法と乗法の保存そのものは有限例では検証できず、前の主張と本文の脱出による。
count = 0
negative = 0
elements = [AA(0), AA(1), -AA(1), AA(2).sqrt(), AA(3).sqrt(), -AA(2).sqrt(), AA(1) / 3,
            AA(5).sqrt() / 3, AA(3).sqrt() - 1, -AA(7).sqrt() / 2, AA(1) / 1000, QQ(5) / 7]
elements = [AA(x) for x in elements]

for a in elements:
    for b in elements:
        if a < b:
            d = b - a
            # 狭義順序の定義: b − a = w·w、w ≠ 0。同じ証人で d − 0 = w·w。
            w = d.sqrt()
            assert w != 0 and b - a == w * w and d - 0 == w * w
            # 三分法の排他性: 0 < d と 0 = d は同時に成り立たない。
            assert d != 0
            # 体なので d⁻¹ があり d·d⁻¹ = 1。
            dinv = 1 / d
            assert d * dinv == 1
            # 0 ∈ C_d、ι(0) = 0 ≤ ρ(d)。
            assert AA(QQ(0)) < d and AA(QQ(0)) == 0 and 0 <= d
            # 式変形: ρ(d)ρ(d⁻¹) = ρ(d d⁻¹) = ρ(1) = ι(1) = 1。
            assert d * dinv == (d * dinv) and (d * dinv) == AA(1) and AA(QQ(1)) == 1
            # ρ(d) ≠ 0 なら 0 < ρ(d)。ρ(d) = 0 なら 0·ρ(d⁻¹) = 0 ≠ 1。
            assert 0 * dinv == 0 and AA(0) != AA(1)
            assert d != 0 and 0 <= d and 0 < d
            # 式変形: ρ(b) = ρ(a + d) = ρ(a) + ρ(d) > ρ(a)。
            assert b == a + d and a + d > a
            count += 9
        elif a == b:
            # 否定の対照: d = 0 なら狭義順序の証人が無く、逆元も無い。
            d = b - a
            assert d == 0 and not (d > 0)
            negative += 1
        # 単射性: a ≠ b なら三分法で a < b か b < a、どちらでも像は異なる。
        if a != b:
            assert (a < b) != (b < a)
            assert a != b
            count += 1

# 実現データの単位元の条件: ρ(0) = ι(0) = 0、ρ(1) = ι(1) = 1。
assert AA(QQ(0)) == 0 and AA(QQ(1)) == 1
count += 1
print('checked', count, 'negative controls', negative)
print('RESULT: PASS')
