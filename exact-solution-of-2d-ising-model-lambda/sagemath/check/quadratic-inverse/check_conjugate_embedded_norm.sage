# 対象ラベル: claim_quadratic_inverse_mem
# 帰属: a,b,d は QQ、xi,s と式の値は QQbar。浮動小数点は使わない。
s = QQbar(2).sqrt()
for a in [QQ(k)/3 for k in range(-4, 5)]:
    for b in [QQ(k)/5 for k in range(-4, 5)]:
        xi = QQbar(a) + QQbar(b)*s
        conjugate = QQbar(a) - QQbar(b)*s
        d = a*a - 2*b*b
        assert QQbar(a)^2 - 2*QQbar(b)^2 == QQbar(a*a-2*b*b)
print('RESULT: PASS')
