# 対象ラベル: claim_quadratic_field_set_is_subfield
# iota(1_Q) = iota(1_Q) + 0_Qbar。帰属: QQ、QQbar。
one = QQbar(QQ(1))
assert one == one + QQbar(0)
print('PASS: 加法の単位元')
