# 対象ラベル: claim_quadratic_field_set_is_subfield
# 1_Qbar = iota(1_Q)。帰属: QQ、QQbar。
assert QQbar(1) == QQbar(QQ(1))
print('PASS: 単位元の包含')
