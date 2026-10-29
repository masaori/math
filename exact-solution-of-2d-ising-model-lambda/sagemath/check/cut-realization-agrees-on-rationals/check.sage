# 対象ラベル: claim_cut_realization_agrees_on_rationals
# 有限例では下切断の有理順序との一致と、上限への有理近似を確かめる。
for q in [QQ(-7)/3, QQ(0), QQ(5)/4]:
    a = AA(q)
    for r in [q-1, q-QQ(1)/2, q, q+QQ(1)/2]:
        assert (AA(r) < a) == (r < q)
    for n in range(1, 65):
        r = q - QQ(1)/n
        assert r < q
        assert AA(r) < a
        assert q-r == QQ(1)/n
        assert QQ(1)/n > 0
print('RESULT: PASS')
