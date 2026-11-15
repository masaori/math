# 対象ラベル: real_two_is_nonzero
# 1 行目 0 < 2 ⇒ 0 ≠ 2（< の意味 x < y ⇔ x ≤ y かつ x ≠ y の後半）と、
# 2 行目 0 ≠ 2 ⇒ 2 ≠ 0（等号の対称律の対偶）を確かめる。2 は def_real_two の 1 + 1 として組む。
# 帰属: 有理数 QQ、代数的実数 AA。浮動小数点は使わない。

k = 0
for F in [QQ, AA]:
    two = F(1) + F(1)                                   # def_real_two の 2 := 1 + 1
    assert F(0) < two; k += 1                           # 左の 0 < 2（real_zero_less_than_two）
    assert F(0) <= two and F(0) != two; k += 1          # 1 行目: < の意味の前半・後半。後半 0 ≠ 2 を取る
    assert two != F(0); k += 1                          # 2 行目: 2 ≠ 0
# 推論の形を有理数の標本で確かめる。
vals = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/7, QQ(1), QQ(2), QQ(5)]
m = 0
for x in vals:
    for y in vals:
        if x < y:
            assert x <= y and x != y; m += 1            # < の意味（x → 0, y → 2 を含む）
        if x != y:
            assert y != x; m += 1                       # 等号の対称律の対偶
# 否定コントロール: < を ≤ と取り違えると後半が出ない（0 ≤ 0 だが 0 ≠ 0 は偽）。
assert QQ(0) <= QQ(0) and not (QQ(0) != QQ(0))
# 否定コントロール: 2 を 1 + (−1) と取り違えると 0 < 2 も 2 ≠ 0 も偽。
bad = QQ(1) + QQ(-1)
assert not (QQ(0) < bad) and not (bad != QQ(0))
# 否定コントロール: 前提を外すと結論は出ない（x < y を満たさない組 x = y では x ≠ y が偽）。
assert not (QQ(2) < QQ(2)) and not (QQ(2) != QQ(2))

print("QQ・AA で主張と 2 行を確かめた（計 %d 個）。推論の形を有理数の標本 %d 件で確かめた" % (k, m))
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")
