# 対象ラベル: real_less_than_is_asymmetric
# a < b ならば b < a は成り立たないことを示す証明の段を確かめる。
# 証明は b < a を仮定し、< の意味（x < y は x ≤ y かつ x ≠ y）から a ≤ b・a ≠ b・b ≤ a を読み出し、
# 反対称律で a = b として a ≠ b に反する、という形である。
# 有理数と代数的実数の標本で、< の意味の読み出し・反対称律・主張を確かめる。
# 帰属: 有理数 QQ、代数的実数 AA。浮動小数点は使わない。

vals = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/7, QQ(1), QQ(5)]
avals = [AA(x) for x in vals] + [AA(2).sqrt(), -AA(3).sqrt(), AA(2).sqrt() - 1]

k = 0
for xs in (vals, avals):
    for x in xs:
        for y in xs:
            # < の意味: x < y ⟺ (x ≤ y かつ x ≠ y)
            assert (x < y) == (x <= y and x != y); k += 1
            # 反対称律: x ≤ y かつ y ≤ x なら x = y
            if x <= y and y <= x:
                assert x == y
            k += 1

s = 0
for xs in (vals, avals):
    for a in xs:
        for b in xs:
            if a < b:
                # 証明の段: a < b から a ≤ b と a ≠ b
                assert a <= b and a != b
                # b < a と仮定したときの b ≤ a は、反対称律と合わせて a = b を与え a ≠ b に反するので、b ≤ a は成り立たない
                assert not (b <= a and a <= b and a != b)
                # 主張
                assert not (b < a); s += 1

# 否定コントロール: < を ≤ に替えると非対称でない（a = b = 0 で 0 ≤ 0 かつ 0 ≤ 0）。
assert QQ(0) <= QQ(0) and QQ(0) <= QQ(0)
# 否定コントロール: 反対称律の無い関係（全関係 x R y がいつも真）では、R から作った「R かつ ≠」は非対称でない。
R_all = lambda x, y: True
lt_all = lambda x, y: R_all(x, y) and x != y
assert lt_all(QQ(0), QQ(1)) and lt_all(QQ(1), QQ(0))

print("< の意味と反対称律を標本 %d 件で、主張を標本 %d 件で確かめた" % (k, s))
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
