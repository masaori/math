# 対象ラベル: claim_imaginary_unit_outside_ordered_subfield
# F=QQ、C_F=QQ_{>0} の標本で本文の各段を厳密に検算する。
F = QQ
omega = QQbar(-1).sqrt()
assert omega * omega == -1
assert not (QQ(0) > 0)
one = QQ(1) * QQ(1)
assert one > 0
minus_one = -QQ(1)
assert one + minus_one == 0
assert not (minus_one > 0)
assert omega != 0
assert omega * omega == minus_one
assert omega not in F
print("PASS imaginary-unit-outside-ordered-subfield")
