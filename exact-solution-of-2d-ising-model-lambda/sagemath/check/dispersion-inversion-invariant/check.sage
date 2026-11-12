# 対象ラベル: claim_dispersion_inversion_invariant
# 本文の各行を厳密に検算する: ϖ ≠ 0 の三行、逆元の冪の三行、分散因子の四行（横・縦）。
# 有理関数体と QQbar だけを使う。実数体・複素数体・浮動小数点は使わない。
R.<w, z> = PolynomialRing(QQ)
F = R.fraction_field()
P.<x> = PolynomialRing(F)

def delta(u, v, ring):
    X = ring.gen()
    return (1 + X^2)^2 - X*(1 - X^2)*(u + 1/u + v + 1/v)

lines = 0
negatives = 0

# 分散因子の四行（横）を記号のまま検算する。
w_inv = 1/F(w)
steps_h = [
    delta(w_inv, F(z), P),
    (1 + x^2)^2 - x*(1 - x^2)*(w_inv + 1/w_inv + z + 1/z),
    (1 + x^2)^2 - x*(1 - x^2)*(w_inv + w + z + 1/z),
    (1 + x^2)^2 - x*(1 - x^2)*(w + w_inv + z + 1/z),
    delta(F(w), F(z), P),
]
for a, b in zip(steps_h, steps_h[1:]):
    assert a == b
    lines += 1
assert F(w) * w_inv == 1           # 根拠: ϖ·ϖ⁻¹ = 1 より ϖ⁻¹ の逆元は ϖ
lines += 1
# 縦の四行
z_inv = 1/F(z)
steps_v = [
    delta(F(w), z_inv, P),
    (1 + x^2)^2 - x*(1 - x^2)*(w + 1/w + z_inv + 1/z_inv),
    (1 + x^2)^2 - x*(1 - x^2)*(w + 1/w + z_inv + z),
    (1 + x^2)^2 - x*(1 - x^2)*(w + 1/w + z + z_inv),
    delta(F(w), F(z), P),
]
for a, b in zip(steps_v, steps_v[1:]):
    assert a == b
    lines += 1
assert F(z) * z_inv == 1
lines += 1
# 否定の対照: 逆元を符号反転に替えると分散因子は変わる
assert delta(-F(w), F(z), P) != delta(F(w), F(z), P)
negatives += 1

T.<t> = PolynomialRing(QQbar)
Q.<y> = PolynomialRing(QQbar)
for L in range(1, 7):
    for a in (0, 1):
        sign = QQbar((-1)^a)
        assert sign * sign == 1            # 根拠: (−1)^a·(−1)^a = 1
        lines += 1
        roots = [r for r, mult in (t^L - sign).roots(QQbar)]
        assert len(roots) == L
        for r in roots:
            # ϖ ≠ 0 の三行（ϖ = 0 を代入した形が (−1)^a に一致しないこと）
            assert sign == r^L
            assert QQbar(0)^L == 0
            assert sign != 0
            assert r != 0
            lines += 4
            # 逆元の冪の三行
            assert (1/r)^L == (r^L)^(-1)
            assert (r^L)^(-1) == sign^(-1)
            assert sign^(-1) == sign
            lines += 3
            assert (1/r) in roots          # 逆元も同じモード集合に属する
            lines += 1
        # 分散因子の四行を実際のモードで（横・縦は同じ集合の中で取る）
        for r in roots:
            for u in roots:
                assert delta(1/r, u, Q) == delta(r, u, Q)
                assert delta(r, 1/u, Q) == delta(r, u, Q)
                lines += 2
                if r != -r and delta(-r, u, Q) != delta(r, u, Q):
                    negatives += 1
# 否定の対照: L = 0 では z = 0 も z^0 = 1 を満たす（L ≥ 1 の仮定が要る）
assert QQbar(0)^0 == 1
negatives += 1
print('lines:', lines, 'negatives:', negatives)
print('RESULT: PASS')
