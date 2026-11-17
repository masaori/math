# 対象ラベル: claim_quadratic_field_set_is_subfield
# 係数 (1,0) が Q_s の単位元を表す。帰属: QQ、QQbar。
s = QQbar(2).sqrt()
assert QQbar(1) == QQbar(QQ(1)) + QQbar(QQ(0)) * s
print('PASS: 単位元の二次体表示')
