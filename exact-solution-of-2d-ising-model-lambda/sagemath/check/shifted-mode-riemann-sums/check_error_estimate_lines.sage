# 対象ラベル: claim_shifted_mode_riemann_sums
# 小区画の誤差評価の式鎖の各行のうち、有限の等式を記号計算で検算する。
# 一様連続性・区間積分の加法性と評価は実数体の解析の定理で、有限検算では証明できない。
var('L k l c eps theta1 theta2', domain='real')
h = 2*pi/L
# 一行目の端点: 0 = 0*h_L、2π = L*h_L
assert bool(0*h == 0)
assert bool(L*h == 2*pi)
# 二行目: (k+1)h_L - k h_L = h_L と、定数の累次区間積分は h_L*h_L 倍
assert bool(((k+1)*h - k*h) == h)
inner = integrate(c, theta2, l*h, (l+1)*h)
outer = integrate(inner, theta1, k*h, (k+1)*h)
assert bool((outer - h*h*c).simplify_full() == 0)
# 一行目の定数項の書換え: h_L^2 f = h_L*h_L*f
assert bool(h**2*c == h*h*c)
# 六行目: L^2 個の同じ項の和
for LL in range(1, 6):
    hh = 2*pi/LL
    s = sum(sum(eps/(8*pi**2)*hh*hh for ll in range(LL)) for kk in range(LL))
    assert bool((s - eps/(8*pi**2)*(LL*hh)**2).simplify_full() == 0)
# 七行目と八行目: L h_L = 2π、(ε/(8π²))(2π)² = ε/2
assert bool((eps/(8*pi**2)*(L*h)**2 - eps/(8*pi**2)*(2*pi)**2).simplify_full() == 0)
assert bool((eps/(8*pi**2)*(2*pi)**2 - eps/2).simplify_full() == 0)
# 一様評価の前提: 小区画の点と標本点の各座標の差は h_L 以下（具体の L とずれで端点を確かめる）
for LL in range(1, 6):
    hh = 2*pi/LL
    for a in (0, 1):
        for kk in range(LL):
            t = hh*(kk + QQ(a)/2)
            for x in (kk*hh, (kk+1)*hh):
                assert bool(abs(x - t) <= hh)
print('RESULT: PASS')
