# 対象ラベル: claim_cut_realization_preserves_strict_order
# 有理数を二つ挟む厳密な有限例。実数上限の一般命題は検証しない。
examples = [
    (AA(2).sqrt(), AA(3).sqrt()),
    (-AA(3).sqrt(), -AA(2).sqrt()),
    (AA(1) / 3, AA(5).sqrt()),
]
for a, b in examples:
    d = b-a
    assert d > 0
    n = 1
    while QQ(1) / n >= d:
        n *= 2
    c = QQ(1) / n
    assert 0 < c < d
    m = n
    while QQ(2) / m >= c / 3:
        m *= 2
    r = QQ(floor(m*a)-1) / m
    s = QQ(floor(m*a)+1) / m
    t = s+c/3
    assert r < a < s and 0 < s-r < c/3
    assert s-a < s-r < c/3
    assert t-a == (s-a)+c/3
    assert t-a < 2*c/3 < c < d
    assert a < s < t < b
print('RESULT: PASS')
