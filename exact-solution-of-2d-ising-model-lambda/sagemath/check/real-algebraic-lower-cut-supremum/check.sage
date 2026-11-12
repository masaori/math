# 対象ラベル: claim_real_algebraic_lower_cut_has_supremum
# 本文の各行を実代数的数（AA）の有限例で厳密に検算する。
# 上限の存在そのもの（実数の完備性）は有限例では検証できず、本文の脱出による。
count = 0
negative = 0
examples = [AA(3)/2, AA(2).sqrt(), -AA(2).sqrt(), AA(0), AA(5).sqrt() - 3]
for a in examples:
    # 挟み込み（ε := 1）: r <_R a <_R s、0 < s - r < 1。幅 1/4 の格子で取り、s - r = 1/2。
    j = floor(4 * a)
    r = QQ(j - 1) / 4
    s = QQ(j + 1) / 4
    assert r < a < s and 0 < s - r < 1
    count += 1
    # r ∈ C_a なので像は空でない。
    assert r < a
    count += 1
    grid = [QQ(k) / 16 for k in range(-80, 81)]
    for t in grid:
        if t < a:
            # t <_R a <_R s と推移律で t <_R s。
            assert t < s
            count += 1
            # s < t なら 0 <_R t - s で s <_R t、t <_R s と合わせて t <_R t（排他性に反する）。
            # ここでは s < t が起きないこと、s = t も起きないことを確かめる。
            assert not (s < t) and t != s
            count += 1
            # 包含写像は順序を保つ: ι(t) < ι(s)（実数の代わりに AA への埋め込みで厳密に比べる）。
            assert AA(t) < AA(s)
            count += 1
        else:
            # 否定の対照: C_a に入らない有理数（t ≥_R a）には上の議論を当てない。
            assert not (t < a)
            negative += 1
    # 否定の対照: s より大きい有理数 t について t - s ∈ Q_{>0} で s <_R t、t <_R s は偽。
    t = s + 1
    assert t - s > 0 and s < t and not (t < s)
    negative += 1
print('checked', count, 'negative controls', negative)
print('RESULT: PASS')
