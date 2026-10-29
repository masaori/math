# 対象ラベル: claim_real_algebraic_lower_cut_has_supremum
# 有限個の有理数だけを検査する。上限の存在は本文の実数完備性による。
examples = [AA(3)/2, AA(2).sqrt(), -AA(2).sqrt()]
for a in examples:
    lower = [QQ(j)/16 for j in range(-64, 65) if QQ(j)/16 < a]
    assert lower
    upper = QQ(5)
    assert all(t < upper for t in lower)
    for t in lower:
        assert t < a
print('RESULT: PASS')
