# 対象ラベル: claim_quadratic_field_set_is_subfield
# iota(1_Q)+0 = iota(1_Q)+0*s。帰属: QQ、QQbar。
s = QQbar(2).sqrt()
one = QQbar(QQ(1))
assert one + QQbar(0) == one + QQbar(0) * s
print('PASS: 零元との積')
