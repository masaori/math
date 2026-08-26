# 式ペア: c が奇数なら c^{L^3} は奇数、c が偶数なら L^3 >= 2 より 4 | c^{L^3}。
#         どちらも 2 (mod 4) に反するので Z_L(2) = c^{#V_L} は成り立たない。
# 帰属: ZZ。有限な冪と法 4 の整数計算だけを使う。
load("_prelude.sage")
for L in [ZZ(2), ZZ(3), ZZ(4), ZZ(5)]:
    exponent = L**3
    assert exponent >= 2
    for c in [ZZ(k) for k in range(1, 13)]:
        power = c**exponent
        if c % 2 == 1:
            assert power % 2 == 1
        else:
            assert power % 4 == 0
        assert power % 4 != 2

# 実データ: 実際の Z_L(2) が、どの正の自然数の #V_L 乗とも等しくない。
for L, value in VALUE_CASES:
    assert value % 4 == 2
    for c in [ZZ(k) for k in range(1, 13)]:
        assert value != c**(L**3)
print("RESULT: PASS")
