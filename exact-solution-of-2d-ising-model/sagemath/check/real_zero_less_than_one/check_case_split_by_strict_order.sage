# 対象ラベル: real_zero_less_than_one
# 準備の後の場合分け: 全順序（x → 0, y → 1）で 0 ≤ 1 か 1 ≤ 0 に分け、
# 準備の 1 ≠ 0（等号の対称律の対偶）と、第 1 の鎖 0 ≤ 1 ⇒ 0 ≤ 1 ∧ 0 ≠ 1 ⇒ 0 < 1 と、第 2 の鎖 1 ≤ 0 ⇒ 1 ≤ 0 ∧ 1 ≠ 0 ⇒ 1 < 0 の
# 段の形（def_real_strict_order の x < y ⟺ x ≤ y ∧ x ≠ y を右辺から左辺へ、等号の対称律の対偶）を確かめる。
# 帰属: 有理数 QQ、代数的実数 AA。浮動小数点は使わない。
# 範囲外: ℝ の順序の公理からの証明ではない。有理数の標本で、段に当てた形が成り立つことの裏取りである。

vals = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/7, QQ(1), QQ(5)]
m = 0
for x in vals:
    for y in vals:
        assert (x <= y) or (y <= x); m += 1                          # 全順序 x ≤ y ∨ y ≤ x
        assert (x < y) == ((x <= y) and (x != y)); m += 1            # def_real_strict_order の形
        assert (x != y) == (y != x); m += 1                          # 等号の対称律の対偶 x ≠ y ⇒ y ≠ x（両向き）
k = 0
for F in (QQ, AA):
    z, o = F(0), F(1)
    assert (z <= o) or (o <= z); k += 1                              # 全順序（x → 0, y → 1）
    assert z != o; k += 1                                            # 準備の 0 ≠ 1
    assert o != z; k += 1                                            # 対称律の対偶で 1 ≠ 0
    if z <= o:
        assert (z <= o and z != o) == (z < o); k += 1                # 第 1 の鎖の 2 段目（x → 0, y → 1）
        assert z < o; k += 1                                         # 第 1 の鎖の結論が主張 0 < 1
    assert not (o <= z)                                              # 1 ≤ 0 の場合は QQ・AA では起きない
    assert ((o <= z) and (o != z)) == (o < z); k += 1                # 第 2 の鎖の 2 段目の形（x → 1, y → 0）は値によらず成り立つ
# 否定コントロール: ≠ を落とすと ≤ から < は出ない（x = y の標本）。
nc = 0
assert (QQ(1) <= QQ(1)) and not (QQ(1) < QQ(1)); nc += 1
# 否定コントロール: 全順序の片側 0 ≤ 1 だけでは 1 ≤ 0 は出ない（場合分けの両側は別の場合）。
assert (QQ(0) <= QQ(1)) and not (QQ(1) <= QQ(0)); nc += 1

print("有理数の標本で全順序・< の定義の形・≠ の対称を %d 件、QQ と AA で場合分けの段を %d 件確かめた" % (m, k))
print("negative controls (broken lines detected): %d" % nc)
print("RESULT: PASS")
