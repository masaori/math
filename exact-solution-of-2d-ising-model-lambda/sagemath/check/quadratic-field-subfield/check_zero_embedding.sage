# 対象ラベル: claim_quadratic_field_set_is_subfield
# iota(1_Q)+0*s = iota(1_Q)+iota(0_Q)*s。帰属: QQ、QQbar。
s = QQbar(2).sqrt()
one = QQbar(QQ(1))
assert one + QQbar(0) * s == one + QQbar(QQ(0)) * s
print('PASS: 零元の包含')
