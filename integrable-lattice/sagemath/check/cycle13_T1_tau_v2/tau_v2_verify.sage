# cycle 13 / T1: 観察 T の決着 — v_2(tau(L)) の厳密計算と、証明の各ステップの検証
#
# tau(L) = L×L トーラス(周期境界の正方格子)の全域木数。
# 観察 T: 奇 L に対し v_2(tau(L)) = 2(L-1)。
#
# 本スクリプトは次を検証する。
#   (1) tau(L) を Kirchhoff の matrix-tree 定理で厳密整数計算し、v_2 を求める(奇偶の両方)。
#   (2) 証明で使う分解 tau(L) = prod_{j=1}^{L-1} (r_j^L + r_j^{-L} - 2) を厳密に確認する。
#   (3) 証明の核 v(m_j) = 1 を、m_j の満たす2次方程式の Newton 多角形から確認する。
#   (4) 偶 L で証明が破れる箇所を具体的に確認する。

print("=" * 78)
print("cycle 13 / T1: 観察 T (奇 L で v_2(tau(L)) = 2(L-1)) の決着")
print("=" * 78)

def torus_spanning_trees(L):
    """L×L トーラスの全域木数を Kirchhoff の matrix-tree 定理で厳密整数計算する。"""
    n = L * L
    idx = lambda i, j: (i % L) * L + (j % L)
    M = matrix(ZZ, n, n)
    for i in range(L):
        for j in range(L):
            a = idx(i, j)
            for (di, dj) in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                b = idx(i + di, j + dj)
                if a == b:
                    continue
                M[a, a] += 1
                M[a, b] -= 1
    return M.submatrix(0, 0, n - 1, n - 1).determinant()

print()
print("--- (1) tau(L) の厳密計算と v_2 ---")
print(" L  parity  v_2(tau(L))  2(L-1)  一致  桁数")
odd_ok = True
odd_range = [3, 5, 7, 9, 11, 13, 15, 17]
even_range = [2, 4, 6, 8, 10, 12, 14]
for L in sorted(odd_range + even_range):
    t = torus_spanning_trees(L)
    v = t.valuation(2)
    par = "odd " if L % 2 else "even"
    match = (v == 2 * (L - 1)) if L % 2 else None
    if L % 2 and not match:
        odd_ok = False
    print("%2d  %s   v_2=%4d      %4d   %s   %d"
          % (L, par, v, 2 * (L - 1), str(match), len(str(t))))
print()
print("奇 L=3..17 で観察 T が全一致: %s" % odd_ok)
print("偶 L では 2(L-1) と一致しない(上表)。観察 T は奇 L 限定の主張である。")

print()
print("--- (2) 分解 tau(L) = prod_{j=1}^{L-1} (r_j^L + r_j^{-L} - 2) の厳密確認 ---")
print("  A_j = 4 - (z^j + z^-j), r_j + 1/r_j = A_j とし、s_n = r^n + r^-n を")
print("  s_n = A s_{n-1} - s_{n-2}, s_0=2, s_1=A で生成する(整数係数の漸化)。")
print("  D_j = s_L(A_j) - 2 として prod_j D_j が tau(L) に一致するかを円分体上で確認する。")
for L in [3, 4, 5, 6, 7, 9]:
    K = CyclotomicField(L)
    zeta = K.gen()
    prod_D = K(1)
    for j in range(1, L):
        A = K(4) - (zeta**j + zeta**(-j))
        s_prev, s_cur = K(2), A          # s_0, s_1
        for _ in range(2, L + 1):
            s_prev, s_cur = s_cur, A * s_cur - s_prev
        prod_D *= (s_cur - K(2))
    tau = torus_spanning_trees(L)
    ok = (prod_D == K(tau))
    print("  L=%2d: prod_j D_j == tau(L) ? %s" % (L, ok))

print()
print("--- (3) 証明の核: v(m_j) = 1 の確認 ---")
print("  r_j = zeta^j (1 + m_j) と置くと m_j は")
print("    zeta^j m^2 + (3 zeta^j + zeta^-j - 4) m - 2 (1-zeta^j)(1-zeta^-j) = 0")
print("  を満たす。奇 L では 2 は Z[zeta_L] で不分岐、1-zeta^j は 2 で単数、")
print("  線型係数も 2 で単数、定数項の付値はちょうど 1。よって Newton 多角形から")
print("  2根の付値は 0 と 1 で、m_j ≡ 0 (mod p) 側の根は v(m_j) = 1。")
print()
for L in [3, 5, 7, 9, 11, 13]:
    K = CyclotomicField(L)
    zeta = K.gen()
    P = K.primes_above(2)[0]
    fdeg = P.residue_class_degree()
    e = P.ramification_index()
    lines = []
    all_ok = True
    for j in range(1, L):
        a = zeta**j
        b = 3 * zeta**j + zeta**(-j) - 4
        c = -2 * (1 - zeta**j) * (1 - zeta**(-j))
        va, vb, vc = a.valuation(P), b.valuation(P), c.valuation(P)
        ok = (va == 0 and vb == 0 and vc == 1)
        all_ok = all_ok and ok
        lines.append((j, va, vb, vc, ok))
    print("  L=%2d: 2 の分岐指数 e=%d(不分岐なら 1), 剰余次数 f=%d" % (L, e, fdeg))
    print("        全 j=1..%d で v(lead)=0, v(linear)=0, v(const)=1 : %s"
          % (L - 1, all_ok))
    if not all_ok:
        print("        内訳:", lines)

print()
print("--- (4) 偶 L で証明が破れる箇所 ---")
print("  奇 L の証明は次の2点を使う。")
print("    (i) 1 - zeta^j が 2 で単数(2 が Z[zeta_L] で不分岐であることによる)")
print("    (ii) v(L) = 0 なので u^L - 1 = L m + C(L,2) m^2 + ... の主要項が L m")
print("  偶 L ではどちらも壊れる。実際に確認する。")
for L in [4, 6, 8]:
    K = CyclotomicField(L)
    zeta = K.gen()
    P = K.primes_above(2)[0]
    e = P.ramification_index()
    j0 = L // 2
    val = (1 - zeta**j0).valuation(P) if (1 - zeta**j0) != 0 else None
    print("  L=%2d: 2 の分岐指数 e=%d (>1 なら分岐), v_P(1 - zeta^(L/2)) = %s, v_2(L) = %d"
          % (L, e, str(val), ZZ(L).valuation(2)))
print("  ⇒ 偶 L では (i)(ii) がともに成立せず、証明は適用できない。")
print("     (1) の表が示すとおり実際に v_2(tau(L)) ≠ 2(L-1) である。")

print()
print("=" * 78)
print("結論: 観察 T は奇 L=3..17 で厳密に成立し、証明の各前提((3) の付値条件)も")
print("      全 j で満たされることを確認した。偶 L では前提が壊れ、結論も成立しない。")
print("=" * 78)

print()
print("--- (5) 独立経路: 終結式による tau(L) の再計算(合成奇数・大きい L を含む) ---")
print("  D(x) := s_L(4 - x - x^-1) - 2 を Z[x]/(x^L-1) 上で漸化式から構成し、")
print("  tau(L) = prod_{j=1}^{L-1} D(zeta^j) = Res( (x^L-1)/(x-1), D(x) ) を")
print("  整数終結式として計算する((3.2) の別経路。matrix-tree 経路と独立)。")
R.<x> = ZZ[]
print("   L  v_2(tau(L))  2(L-1)  一致  (合成数なら因数分解)")
for L in [3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 25, 27, 33, 35]:
    Rq = R.quotient(x**L - 1)
    xb = Rq.gen()
    A = Rq(4) - xb - xb**(L - 1)          # x^-1 = x^(L-1) mod x^L-1
    s_prev, s_cur = Rq(2), A
    for _ in range(2, L + 1):
        s_prev, s_cur = s_cur, A * s_cur - s_prev
    D = (s_cur - Rq(2)).lift()
    f = sum(x**i for i in range(L))        # (x^L-1)/(x-1), monic
    tau_res = f.resultant(D)
    v = ZZ(tau_res).valuation(2)
    fac = "" if L in Primes() else "= %s" % factor(L)
    print("  %2d      %4d      %4d   %s  %s"
          % (L, v, 2 * (L - 1), str(v == 2 * (L - 1)), fac))
print("  ⇒ 合成奇数(9,15,21,25,27,33,35)でも成立。証明は L の素数性を使っていない。")
print("     L=19 も一致(matrix-tree 経路では未計算だった値)。")

print()
print("--- (6) 偶 L の観察 T': v_2(tau(L)) = (2s+4)L - (6s+1), s = v_2(L) ---")
print("  (5) と同じ終結式経路で偶 L を L=2..160 の全偶数(80 例)について計算し、")
print("  上式と照合する。s が同じなら L の奇部分に依らないことを見る。")
print("  注: これは数値観察であって証明ではない(偶 L では (3)(4) の前提が壊れる)。")

def tau_by_resultant(L):
    """tau(L) を終結式 Res((x^L-1)/(x-1), D(x)) として厳密整数計算する((5) と同じ経路)。"""
    Rq = R.quotient(x**L - 1)
    xb = Rq.gen()
    A = Rq(4) - xb - xb**(L - 1)
    s_prev, s_cur = Rq(2), A
    for _ in range(2, L + 1):
        s_prev, s_cur = s_cur, A * s_cur - s_prev
    D = (s_cur - Rq(2)).lift()
    f = sum(x**i for i in range(L))
    return ZZ(f.resultant(D))

even_mismatch = []
by_s = {}
for L in range(2, 161, 2):
    v = tau_by_resultant(L).valuation(2)
    s = ZZ(L).valuation(2)
    pred = (2 * s + 4) * L - (6 * s + 1)
    if v != pred:
        even_mismatch.append((L, v, pred))
    by_s.setdefault(s, []).append(L)

print("  検査した偶 L: 2..160 の全偶数 = %d 例" % len(range(2, 161, 2)))
print("   L  s=v_2(L)  v_2(tau(L))  (2s+4)L-(6s+1)  一致")
for L in [2, 4, 6, 8, 10, 12, 14, 16, 24, 32, 48, 64, 96, 128, 160]:
    v = tau_by_resultant(L).valuation(2)
    s = ZZ(L).valuation(2)
    pred = (2 * s + 4) * L - (6 * s + 1)
    print("  %3d     %d       %6d         %6d      %s" % (L, s, v, pred, str(v == pred)))
print("  不一致の L: %s" % (even_mismatch if even_mismatch else "なし(80/80 一致)"))
print("  s ごとの L の分布: %s" % {s: (min(v), max(v), len(v)) for s, v in sorted(by_s.items())})
print("  ⇒ s=1 の族は L=2,6,10,...,158 の 40 例で同一の式に乗る。")
print("     すなわち v_2(tau(L)) は L の奇部分に依らず s=v_2(L) だけで決まる(観察)。")
print("  L=2^n(n=1..7) に特殊化すると (2n+4)2^n-(6n+1) = 2n*2^n+4*2^n-6n-1 となり、")
print("  cycle14_T3_Zl2_tower_criterion.md 式 (9.1) と一致する:")
for n in range(1, 8):
    L = 2**n
    print("    n=%d: v_2(tau(2^n)) = %4d, (9.1) = %4d"
          % (n, tau_by_resultant(L).valuation(2), 2 * n * 2**n + 4 * 2**n - 6 * n - 1))

print()
print("--- (7) OEIS A212800 の登録値との突き合わせ(外部一次情報との独立照合) ---")
print("  A212800 = (n,n)-torus grid graph の全域木数。raw text 記録の a(1..11) と比較する。")
oeis = [1, 32, 11664, 42467328, 1562500000000, 587312954081280000,
        2266101334892340404752384, 89927963805390785392395474173952,
        36735015407753190053984060991247792275456,
        154528563849617762057150663767149772800000000000000,
        6695315138840257072470706538467584763944601124280722177130496]
oeis_ok = True
for n in range(2, 12):
    t = tau_by_resultant(n)
    ok = (t == oeis[n - 1])
    oeis_ok = oeis_ok and ok
    print("  n=%2d: 一致 %s (v_2 = %d)" % (n, str(ok), t.valuation(2)))
print("  a(2..11) が全一致: %s" % oeis_ok)
print("  ⇒ 本スクリプトの tau(L) は OEIS A212800 と同じ量である(規約も含めて一致)。")
print("     A212800 の全文(2025-02-16 版, %I〜%A)には 2 進付値も tau=L^2 R^4 型分解も")
print("     記載が無い(記載は Kreweras 1978 への参照と Kotesovec 2021 の漸近式のみ)。")
