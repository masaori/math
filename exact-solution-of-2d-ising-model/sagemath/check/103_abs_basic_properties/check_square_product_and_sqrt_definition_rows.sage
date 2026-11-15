# 対象ラベル: abs_basic_properties
# 非負実数の平方の比較の鎖の両端と、(2) の行を一行ずつ確かめる。
#   u^2 = u·u   （square_of_real_number_is_product、r → u）
#   v·v = v^2   （square_of_real_number_is_product、r → v を右辺から左辺へ）
#   (√(x^2+y^2))^2 = x^2+y^2   （definition_of_sqrt_r_positive の u^2 = s、s → x^2+y^2。AA で厳密）
R.<u, v> = PolynomialRing(QQ)
n = 0
assert u^2 == u * u; n += 1
assert v * v == v^2; n += 1
assert u^2 != u * v            # 対照: 因子を取り違えると平方にならない

samples = [QQ(a) / QQ(b) for a in range(-6, 7) for b in (1, 2, 3)]
for x0 in samples[::2]:
    for y0 in samples[::5]:
        s = AA(x0)^2 + AA(y0)^2
        assert s >= 0
        r = s.sqrt()
        assert r >= 0
        assert r^2 == s; n += 1
        if s != 0:
            assert (-r) ^ 2 == s and -r < 0   # 対照: 負の根は定義の u ≥ 0 を満たさない
print("square-product and sqrt-definition rows of abs_basic_properties: %d equalities" % n)
print("RESULT: PASS")
