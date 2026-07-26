# cycle 12 / T2→T1: Onsager–Kaufman の分散関係を「ℚ(x)・円分体上の恒等式」として厳密検証する。
#
# 既知（Onsager 1944 / Kaufman 1949）: L サイト環の 2D Ising 転送行列の 2^L 個の固有値は
#     λ = (x(1−x²))^{L/2} · Π_{k=0}^{L−1} ρ(θ_k)^{s_k/2},  s_k = ±1,
#     ρ(θ) は z² − 2·coshγ(θ)·z + 1 = 0 の根、coshγ(θ) = C(x) − cosθ,  C(x) = (1+x²)²/(2x(1−x²)),
#     θ は NS セクター θ=(2k+1)π/L / R セクター θ=2πk/L、各セクターで符号反転数のパリティが固定。
#
# 本スクリプトが厳密（記号計算・実数なし）に確認すること:
#   (a) 前因子: det T(x) = (x(1−x²))^{L·2^{L−1}}   ← 各固有値の因子 (x(1−x²))^{L/2} の大域的 witness
#   (b) ±γ ペアリング: 固有値集合は λ ↦ P²/λ（P=(x(1−x²))^{L/2}）で閉じる
#         ⇔ cp(P²/λ)·λ^{2^L} = P^{2^L}·cp(λ)  （ℤ[x][λ] の恒等式）
#   (c) 分散関係: charpoly の K(x)（K=ℚ(ζ_{2L}) 円分体）上の 2 次因子 λ²−Aλ+B について
#         W := A²/(2B) − 1 = (r + r^{-1})/2   (r = 2 根の比)
#       が Chebyshev T_n(C(x) − cosθ) = cosh(nγ(θ)) に**一致する**（cosθ は円分体の元）。
#       ⇒ 「2 根の比が e^{nγ(θ)}」＝ Onsager 分散関係そのもの。arccosh も exp も実数の角も使わない。
#   (d) 4 次因子（L=4）は 2 モード ρ_a^{±1}ρ_b^{±1} の対称式として厳密に同定できるか探索する。
#
# 位置づけ: これは既知の Onsager–Kaufman 解の**可算・厳密・形式検証可能な書き換え**であって、
#   新しい厳密解ではない。数値一致ではなく多項式・有理関数の厳密な等号である。

import time

def states(L):
    return [tuple(1 - 2*((i >> j) & 1) for j in range(L)) for i in range(2^L)]

def h(s):
    L = len(s)
    return sum(1 for j in range(L) if s[j] != s[(j+1) % L])

def v(s, t):
    return sum(1 for j in range(len(s)) if s[j] != t[j])

def transfer(L, Rx):
    # Rx = 多項式環（係数体は ℚ または円分体 K）
    x = Rx.gen()
    S = states(L)
    n = len(S)
    return matrix(Rx, n, n, lambda i, j: x^(h(S[j]) + v(S[i], S[j])))

print("=== (a) 前因子 det T(x) = (x(1−x²))^{L·2^{L−1}} ===")
Rq = PolynomialRing(QQ, 'x')
xq = Rq.gen()
for L in [2, 3, 4]:
    T = transfer(L, Rq)
    lhs = T.det()
    rhs = (xq*(1 - xq^2))^(L * 2^(L-1))
    print(f"  L={L}: det T == (x(1−x²))^{{{L * 2^(L-1)}}} : {lhs == rhs}")

print()
print("=== (b) ±γ ペアリング: cp(P²/λ)·λ^{2^L} = P^{2^L}·cp(λ) （P=(x(1−x²))^{L/2}）===")
for L in [2, 4]:      # L 偶数なら P ∈ ℚ[x]（L 奇数は P に平方根が入るので (a) の形で代用）
    T = transfer(L, Rq)
    S = PolynomialRing(Rq, 'lam')
    lam = S.gen()
    cp = T.charpoly('lam')
    n = 2^L
    P = (xq*(1 - xq^2))^(L//2)
    # cp(P²/λ)·λ^n を分母を払って多項式として作る
    coeffs = cp.coefficients(sparse=False)
    lhs = sum(coeffs[i] * P^(2*i) * lam^(n - i) for i in range(n + 1))
    rhs = P^n * cp
    print(f"  L={L}: {lhs == rhs}")

print()
print("=== (c) 分散関係: K(x) 上の 2 次因子の根比 = e^{nγ(θ)} ===")
for L in [2, 3, 4]:
    t0 = time.time()
    K = CyclotomicField(2*L, 'z')
    z = K.gen()
    RK = PolynomialRing(K, 'x')
    x = RK.gen()
    FK = RK.fraction_field()
    T = transfer(L, RK)
    cp = T.charpoly('lam').change_ring(FK)
    fa = cp.factor()
    C = (1 + x^2)^2 / (2*x*(1 - x^2))
    momenta = {'NS': [(z^(2*k+1) + z^(-(2*k+1)))/2 for k in range(L)],
               'R':  [(z^(2*k)   + z^(-(2*k)))/2   for k in range(L)]}
    print(f"  --- L={L} (K=ℚ(ζ_{2*L})): charpoly の K(x) 上の因子次数 = "
          f"{[(f.degree(), m) for f, m in fa]} ; 因数分解 {round(time.time()-t0,1)}s ---")
    print(f"      NS モーメンタ cosθ = {list(set(momenta['NS']))}, "
          f"R モーメンタ cosθ = {list(set(momenta['R']))}")
    for f, m in fa:
        if f.degree() != 2:
            continue
        f = f / f.leading_coefficient()
        A = -f[1]; B = f[0]
        W = FK(A^2/(2*B) - 1)
        hit = None
        for sec in ['NS', 'R']:
            for c in set(momenta[sec]):
                for nn in [1, 2, 3, 4]:
                    if FK(chebyshev_T(nn, C - c)) == W:
                        hit = (sec, c, nn)
        if hit:
            print(f"      2次因子(重複度{m}): 根比 = e^{{{hit[2]}γ(θ)}}, "
                  f"cosθ = {hit[1]} ({hit[0]} セクター) — 厳密一致 True")
        else:
            print(f"      2次因子(重複度{m}): 単一モードの T_n(C−cosθ) には一致せず（下の (d) 参照）")
    # (d) 4 次因子: 2 モードの対称式 λ^4 − e1λ³ + e2λ² − e3λ + e4 との照合
    for f, m in fa:
        if f.degree() != 4:
            continue
        f = f / f.leading_coefficient()
        if L % 2 != 0:
            print("      4次因子: L 奇数のため P に平方根が入る。本スクリプトでは照合しない（未実施）。")
            continue
        P = (x*(1 - x^2))^(L//2)
        found = None
        for sec in ['NS', 'R']:
            cs = list(set(momenta[sec]))
            for ia in range(len(cs)):
                for ib in range(ia, len(cs)):
                    Ca = C - cs[ia]; Cb = C - cs[ib]
                    e1 = 4*P*Ca*Cb
                    e2 = P^2*(2*chebyshev_T(2, Ca) + 2*chebyshev_T(2, Cb) + 2)
                    e3 = P^2*e1
                    e4 = P^4
                    g = f.parent()([e4, -e3, e2, -e1, 1])
                    if g == f:
                        found = (sec, cs[ia], cs[ib])
        if found:
            print(f"      4次因子(重複度{m}): 根 = P·ρ(θ_a)^{{±1}}ρ(θ_b)^{{±1}} と厳密一致 True "
                  f"(cosθ_a={found[1]}, cosθ_b={found[2]}, {found[0]} セクター)")
        else:
            print(f"      4次因子(重複度{m}): 2 モード対称式との一致は見つからず（未同定・正直に記録）")
