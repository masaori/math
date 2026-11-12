# 対象ラベル: claim_cut_realization_agrees_on_rationals
# 本文の各行を有理数の有限例で厳密に検算する。<_R は実代数的数（AA）の順序で代用する。
# 実数の上限の存在・有理数の稠密性そのものは有限例では検証できず、本文の脱出による。
count = 0
negative = 0
qs = [QQ(-7)/3, QQ(0), QQ(5)/4, QQ(1)/7, QQ(-1)]
grid = [QQ(k) / 12 for k in range(-60, 61)]
for q in qs:
    a = AA(q)
    for r in grid:
        # r < q なら q - r ∈ Q_{>0}、0 <_R q - r、狭義順序の定義で r <_R q。
        if r < q:
            assert q - r > 0
            assert AA(q - r) > 0 and (AA(q) - AA(r)) - 0 == AA(q - r)
            assert AA(r) < a
            count += 3
        # r <_R q なら r < q（q < r・q = r は推移律と三分法の排他性で排除）。
        if AA(r) < a:
            assert not (q < r) and r != q and r < q
            count += 1
        else:
            # 否定の対照: 下切断に入らない有理数は r < q を満たさない。
            assert not (r < q)
            negative += 1
        # 包含写像は狭義順序を保ち反映する: r < q ⟺ ι(r) < ι(q)。
        assert (r < q) == (AA(r) < AA(q))
        count += 1
    # ι(q) は上界: 下切断の元 r について ι(r) < ι(q)。
    for r in grid:
        if r < q:
            assert AA(r) < AA(q)
            count += 1
    # 最小性: y < ι(q) の有理の例 y について、y < ι(r) < ι(q) の有理数 r（中点）が下切断に入る。
    for n in range(1, 41):
        y = q - QQ(1) / n
        r = (y + q) / 2
        assert y < r < q and AA(r) < a
        count += 1
    # 否定の対照: q 自身は下切断に入らない（ι(q) は像の元ではない）。
    assert not (AA(q) < a)
    negative += 1
print('checked', count, 'negative controls', negative)
print('RESULT: PASS')
