# 式ペア: Z_L(2) ≡ 2 (mod 4) から、奇数 u が存在して Z_L(2) = 2u と書けること。
# 帰属: ZZ。有限な整数計算だけを使う。
load("_prelude.sage")
for L, value in VALUE_CASES:
    assert value % 4 == 2
    half = value // ZZ(2)
    assert value == ZZ(2) * half
    assert half % 2 == 1
    # 2 の指数がちょうど 1 であること（本文の「奇数 u」の言い換え）。
    assert value.valuation(2) == 1
print("RESULT: PASS")
