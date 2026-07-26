# cycle 15 / T3: d=3, p=2 における tau_3(L) の 2 進付値の分解と「追加解」の分類。
#
# tau_3(L) = 3 次元離散トーラス C_L^3 (頂点数 L^3, 次数 6) の全域木数。L は奇数。
# cycle 14 (定理 E 系 E2) は下界 v_2(tau_3(L)) >= 6(L-1) を証明し、
# L = 9,15,17,21,27 で等号が破れることを観察した。本スクリプトはその「追加解」を
# 分類するための計算を行う。証明本体は
#   outputs/reports/cycle15_T3_tau_d3_structure.md
# にある。**計算は証明ではない。** ここで確認するのは、report の定理の前提・帰結の整合性と、
# 証明できていない部分(V_IV)の標本である。
#
# 記号: zeta = 位数 L の 1 のべき根、chi = (j1,j2,j3) in (Z/L)^3、
#       lambda_chi = 6 - sum_i (zeta^{j_i} + zeta^{-j_i})、
#       T(x) = x + x^{-1} (F_2 バーでの「トレース」)。
#
# 検証項目:
#   (0) 3 つの解の族が与える lambda の値を記号的に確認(型 I: 2(1-t)(1-1/t), 型 II: 6, 型 III: 8)。
#       および定理 G の証明中の係数条件 (alpha+beta+gamma=0 かつ 1/a+1/b+1/g=0) の解が
#       {alpha,beta,gamma} = alpha*{1,omega,omega^2} に限ることを GF(4) で総当り確認。
#   (1) 厳密整数経路: 終結式で tau_3(L) を厳密な整数として計算し v_2 を取る(L=3..27 奇)。
#       L=3,5,7 では matrix-tree (厳密整数行列式) とも一致を確認。
#   (2) 消える指標の分類 V = V_I + V_II + V_III + V_IV (L=3..105 奇) と、
#       個数の予測 6(L-1), 8(L-3)[3|L], 48[15|L] との一致(assert)。
#   (3) 各クラスの v_P(lambda) を p 進で計算し、合計が (1) と一致することを確認。
#   (4) 対称性: V(L) 全体の (Z/L)^* 安定化群が <2,-1> であること(= V_IV は P に依存する)、
#       および V_I, V_II, V_III は (Z/L)^* 全体で安定であること。
#   (5) V_IV の点では lambda が有理数でないこと(標本内)。
#
# 計算はすべて厳密(有限体・円分体・整数・固定精度 p 進、付値 < prec-5 を assert)。浮動小数点は使わない。

from itertools import product
import time

print("=" * 92)
print("cycle 15 / T3: d=3, p=2 の追加解の構造 — v_2(tau_3(L)) の分解")
print("=" * 92)

ODD_L_CLASSIFY = list(range(3, 106, 2))   # (2)(3) の標本範囲
ODD_L_EXACT    = list(range(3, 28, 2))    # (1) 厳密整数(終結式)の標本範囲

# ============================================================ 共通ルーチン

RA.<A> = ZZ[]

def s_list(L):
    """s_0=2, s_1=A, s_k = A s_{k-1} - s_{k-2}  (z+1/z=A のとき s_k = z^k + z^{-k})。"""
    out = [RA(2), A]
    for _ in range(2, L + 1):
        out.append(A * out[-1] - out[-2])
    return out

def psi_G(L):
    """L 奇: psi(A) = s_L(A) - 2 = (A-2) G_L(A)^2  (cycle 14 補題 2)。記号的に確認して返す。"""
    S = s_list(L)
    psi = S[L] - 2
    G = RA(1) + sum(S[k] for k in range(1, (L - 1) // 2 + 1))
    assert psi == (A - 2) * G ** 2, ("lemma2 failed", L)
    return psi, G

def tau2_res(L):
    """tau_2(L) を終結式で厳密整数計算する。
       prod_{(j2,j3)!=0} (4 - t_{j2} - t_{j3}) / L^2 を psi = (A-2)G^2 経由で潰すと tau_2 = Q^2、
       Q = prod_{j} G_L(4 - t_j) = Res_w(psi(w), G_L(4-w))  (psi は w についてモニック)。"""
    psi, G = psi_G(L)
    Rw.<w> = ZZ[]
    Q = Rw(psi(w)).resultant(Rw(G(4 - w)))
    return Q ** 2

def tau3_res(L):
    """tau_3(L) を 2 段の終結式で厳密整数計算する。
       tau_3(L) = tau_2(L) * P^2 / L,  P = prod_{(j2,j3)} G_L(6 - t_{j2} - t_{j3})。"""
    psi, G = psi_G(L)
    Ru.<u> = ZZ[]
    Rv = PolynomialRing(Ru, 'v'); v = Rv.gen()
    F = Rv(psi(v)).resultant(Rv(G(6 - u - v)))     # = prod_{j2} G_L(6-u-t_{j2}) in Z[u]
    Rw.<w> = ZZ[]
    P = Rw(psi(w)).resultant(Rw(F(w)))             # = prod_{j3} F(t_{j3})
    num = tau2_res(L) * P ** 2
    assert num % L == 0, ("integrality", L)
    return num // L

def matrix_tree(L, d):
    """C_L^d の全域木数を Kirchhoff の matrix-tree 定理で厳密整数計算する(独立経路)。"""
    n = L ** d
    def idx(t):
        s = 0
        for c in t:
            s = s * L + (c % L)
        return s
    M = matrix(ZZ, n, n)
    for t in product(range(L), repeat=d):
        a = idx(t)
        for i in range(d):
            for sgn in (1, -1):
                uu = list(t); uu[i] += sgn
                b = idx(tuple(uu))
                if a == b:
                    continue
                M[a, a] += 1
                M[a, b] -= 1
    return M.submatrix(0, 0, n - 1, n - 1).determinant()

def field_mu(L):
    """F_2 バーの中の mu_L。x^L-1 の GF(2) 上の既約因子 h で、根の位数がちょうど L のものを取る。
       (次数 f = ord_L(2) の因子でも根の位数が L の真の約数になりうるので、位数を必ず検査する。)
       h を返すのが重要である: 消える指標の集合 V(L) は 2 の上の素点 P の取り方に依存する(定理 K)ので、
       付値計算に使う p 進環も **同じ h** で作らないと別の P を見てしまい、答えが変わる。"""
    f = Mod(2, L).multiplicative_order()
    Rx.<X> = GF(2)[]
    for h, _ in factor(X ** L - 1):
        if h.degree() != f:
            continue
        k.<zz> = GF(2).extension(h)
        if all(zz ** (L // q) != 1 for q in prime_divisors(L)):
            assert zz ** L == 1
            return f, k, zz, h
    raise ValueError("no primitive factor")

def ord_pm(L):
    """e = min{ e >= 1 : 2^e = +-1 mod L }。T(mu_L) は F_{2^e} に含まれる。"""
    e = 1
    while Mod(2, L) ** e not in (Mod(1, L), Mod(-1, L)):
        e += 1
    return e

# 分類ルーチン ---------------------------------------------------------------

def cls_of(L, j1, j2, j3):
    """消える指標 (j1,j2,j3) != 0 のクラス I / II / III / IV を返す(report §3-§5 の定義)。"""
    if j1 == 0 or j2 == 0 or j3 == 0:
        return 'I'
    if L % 3 == 0:
        om = L // 3
        for s in product([1, -1], repeat=3):
            v = [(s[0] * j1) % L, (s[1] * j2) % L, (s[2] * j3) % L]
            for b0 in v:
                if sorted([(t - b0) % L for t in v]) == sorted([0, om, 2 * om]):
                    return 'II'
    if L % 15 == 0:
        m3, m5 = L // 3, L // 5
        for pos in range(3):
            e3 = [j1, j2, j3][pos]
            rest = [[j1, j2, j3][i] for i in range(3) if i != pos]
            if e3 % m3 != 0 or e3 // m3 not in (1, 2):
                continue
            if any(e % m5 != 0 for e in rest):
                continue
            cl = [min((e // m5) % 5, (-(e // m5)) % 5) for e in rest]   # ±類: 1 or 2
            if sorted(cl) == [1, 2]:
                return 'III'
    return 'IV'

def vanishing(L):
    """v_P(lambda_chi) > 0 となる chi != 0 の全体を、クラス分けして返す。
       定理 A (cycle 14) の d=3, p=2 の場合: v_P(lambda)>0 <=> T(x)+T(y)+T(z)=0 in F_2 バー。"""
    f, k, zz, h = field_mu(L)
    mu = [zz ** j for j in range(L)]
    tr = {}
    for j in range(L):
        tr.setdefault(mu[j] + mu[j] ** (-1), []).append(j)
    out = {'I': [], 'II': [], 'III': [], 'IV': []}
    for j1 in range(L):
        Aj = mu[j1] + mu[j1] ** (-1)
        for j2 in range(L):
            C = Aj + mu[j2] + mu[j2] ** (-1)
            for j3 in tr.get(C, []):
                if (j1, j2, j3) == (0, 0, 0):
                    continue
                out[cls_of(L, j1, j2, j3)].append((j1, j2, j3))
    return f, out, h

def vp_of(L, pts, h, prec=60):
    """与えられた指標たちの v_P(lambda) を、不分岐環 Zq(2^f) 上で厳密に計算する。
       h は field_mu が返した既約多項式。同じ h で Zq を作ることで、分類に使った素点 P と
       同じ P を見ることを保証する(これを外すと別の P の V(L) を見てしまう。定理 K)。"""
    if not pts:
        return 0, {}
    f = Mod(2, L).multiplicative_order()
    RZ.<XZ> = ZZ[]
    hZ = RZ([ZZ(c) for c in h.list()])
    R = Zq(2 ** f, prec, names='a', modulus=hZ)
    zeta = R.teichmuller(R.gen())
    assert zeta ** L == 1, ("teichmuller order", L)
    pw = [zeta ** j + zeta ** (-j) for j in range(L)]
    from collections import Counter
    cnt = Counter(); tot = 0
    for (a, b, c) in pts:
        v = (R(6) - pw[a] - pw[b] - pw[c]).valuation()
        assert v < prec - 5, ("precision too low", L, (a, b, c), v)
        cnt[v] += 1; tot += v
    return tot, dict(cnt)

# ============================================================ (0) 記号的確認

print()
print("--- (0) 3 つの族が与える lambda の値(記号的) ---")

# 型 I: (x, x^{eps}, 1)  ->  lambda = 2(1-x)(1-1/x)
Lx.<xx> = LaurentPolynomialRing(ZZ)
for eps in (1, -1):
    lam = 6 - (xx + xx**-1) - (xx**eps + xx**(-eps)) - 2
    print("  型 I  (x, x^%+d, 1): lambda = %s ;  2(1-x)(1-1/x) と一致: %s"
          % (eps, lam, bool(lam == 2 * (1 - xx) * (1 - xx**-1))))

# 型 II: (u, wu, w^2 u), w^2+w+1=0  ->  lambda = 6
Kw.<w> = CyclotomicField(3)
Lu.<uu> = LaurentPolynomialRing(Kw)
lam2 = 6 - sum((w**i * uu) + (w**i * uu)**-1 for i in range(3))
print("  型 II (u, wu, w^2u): lambda = %s  (恒等的に 6 か: %s)" % (lam2, bool(lam2 == 6)))

# 型 III: (eta, eta^2, w), eta 位数 5, w 位数 3 -> lambda = 8
K15.<z15> = CyclotomicField(15)
eta, om3 = z15 ** 3, z15 ** 5
lam3 = 15 * 0 + 6 - (eta + eta**-1) - (eta**2 + eta**-2) - (om3 + om3**-1)
print("  型 III (eta, eta^2, omega): lambda = %s (= 8 か: %s), v_2 = 3"
      % (lam3, bool(lam3 == 8)))
print("     根拠: 1+eta+eta^2+eta^3+eta^4 = 0 と 1+omega+omega^2 = 0 から Sum = -1 + -1 = -2。")

print()
print("  定理 G の係数条件: GF(4)^* で alpha+beta+gamma=0 かつ 1/alpha+1/beta+1/gamma=0 の解を総当り")
F4 = GF(4, 'g'); g4 = F4.gen()
sols = [(a, b, c) for a in F4 if a != 0 for b in F4 if b != 0 for c in F4 if c != 0
        if a + b + c == 0 and a**-1 + b**-1 + c**-1 == 0]
ok = all(sorted([b / a, c / a]) == sorted([g4, g4**2]) for (a, b, c) in sols)
print("    解の個数 %d、すべて {alpha,beta,gamma} = alpha*{1,w,w^2} の形: %s" % (len(sols), ok))
print("    (一般の F_2 バーでも e_1=e_2=0 より alpha,beta,gamma は T^3 = e_3 の 3 根。report §3 で証明。)")

# ============================================================ (1) 厳密整数経路

print()
print("--- (1) 厳密整数経路: 終結式で tau_3(L) を計算し v_2 を取る ---")
print("    tau_3(L) = tau_2(L) * P^2 / L,  P = prod_{(j2,j3)} G_L(6 - t_{j2} - t_{j3})  (L 奇)")
print("    まず matrix-tree(厳密整数行列式)との一致を L=3,5,7 で確認する。")
for L in [3, 5, 7]:
    print("    L=%d: tau_2 一致 %s, tau_3 一致 %s"
          % (L, tau2_res(L) == matrix_tree(L, 2), tau3_res(L) == matrix_tree(L, 3)))
exact_v2 = {}
print("     L   tau_3(L) の桁数    v_2(tau_3(L))   (計算時間)")
for L in ODD_L_EXACT:
    t0 = time.time()
    t = tau3_res(L)
    exact_v2[L] = t.valuation(2)
    print("    %2d   %14d   %10d      (%.1fs)" % (L, len(str(t)), exact_v2[L], time.time() - t0))

# ============================================================ (2)(3) 分類と付値

print()
print("--- (2)(3) 消える指標の分類と付値 ---")
print("    V_I  : ある座標が 1、残り 2 座標が互いに逆(cycle 14 定理 E)。lambda = 2(1-t)(1-1/t)。")
print("    V_II : 3|L。{x,y,z} = u*{1,w,w^2} (座標反転・置換込み)。lambda = 6。")
print("    V_III: 15|L。{x,y,z} = {eta, eta^2, w} (eta 位数 5, w 位数 3、座標反転・置換込み)。lambda = 8。")
print("    V_IV : 残り(= 散発解)。")
print("    ※ V(L) は 2 の上の素点 P に依存する(定理 K)。分類に使う剰余体と付値に使う p 進環は")
print("       同じ既約多項式から作り、同じ P を見ることを保証している。")
print()
print("      L   f   e | |V_I|  |V_II| |V_III| |V_IV| |   v_2      予測      差 | 各クラスの v_P 分布")
mismatch = []
summary = {}
for L in ODD_L_CLASSIFY:
    e = ord_pm(L)
    f, V, h = vanishing(L)
    # 個数の予測(report 定理 H, I)
    assert len(V['I']) == 6 * (L - 1), (L, 'I', len(V['I']))
    assert len(V['II']) == (8 * (L - 3) if L % 3 == 0 else 0), (L, 'II', len(V['II']))
    assert len(V['III']) == (48 if L % 15 == 0 else 0), (L, 'III', len(V['III']))
    t1, c1 = vp_of(L, V['I'], h); t2, c2 = vp_of(L, V['II'], h)
    t3, c3 = vp_of(L, V['III'], h); t4, c4 = vp_of(L, V['IV'], h)
    assert c1 in ({1: 6 * (L - 1)}, {}) , (L, 'vI', c1)
    assert c2 in ({1: len(V['II'])}, {}), (L, 'vII', c2)
    assert c3 in ({3: 48}, {}), (L, 'vIII', c3)
    v2 = t1 + t2 + t3 + t4
    pred = 6 * (L - 1) + (8 * (L - 3) if L % 3 == 0 else 0) + (144 if L % 15 == 0 else 0)
    summary[L] = (f, e, len(V['IV']), v2, pred, V['IV'])
    if L in exact_v2 and exact_v2[L] != v2:
        mismatch.append((L, exact_v2[L], v2))
    print("    %3d %3d %3d | %5d %6d %6d %6d | %6d %8d %6d | I:%s II:%s III:%s IV:%s"
          % (L, f, e, len(V['I']), len(V['II']), len(V['III']), len(V['IV']),
             v2, pred, v2 - pred, c1, c2, c3, c4))
print()
print("    (1) の厳密整数 v_2 と (3) の p 進和の不一致: %s" % (mismatch if mismatch else "なし"))
print("    ※ 予測 = 6(L-1) + 8(L-3)[3|L] + 144[15|L]。差はちょうど V_IV の寄与である。")

print()
print("  V_IV != 0 となった L と、その代表元(置換・座標反転を法とする):")
for L in ODD_L_CLASSIFY:
    f, e, n4, v2, pred, V4 = summary[L]
    if not V4:
        continue
    reps = set()
    for (a, b, c) in V4:
        reps.add(min(tuple(sorted([(s[0]*a) % L, (s[1]*b) % L, (s[2]*c) % L]))
                     for s in product([1, -1], repeat=3)))
    print("    L=%3d (f=%2d, e=%2d): |V_IV|=%5d, 代表 %2d 個%s"
          % (L, f, e, n4, len(reps), (" : " + str(sorted(reps))) if len(reps) <= 8 else ""))

# ============================================================ (4) 対称性

print()
print("--- (4) 対称性: (Z/L)^* の作用 chi -> a*chi ---")
print("    V(L) 全体は <2,-1> で安定(Frobenius と複素共役)。V_I, V_II, V_III は (Z/L)^* 全体で安定。")
print("    V(L) が (Z/L)^* 全体で安定でないなら、V_IV は 2 の上の素点 P の取り方に依存する。")
for L in [9, 15, 17, 21, 27, 31, 33, 43, 51]:
    f, V, h = vanishing(L)
    allset = set(sum(V.values(), []))
    stab = [a for a in range(1, L) if gcd(a, L) == 1
            and all(((a*x) % L, (a*y) % L, (a*z) % L) in allset for (x, y, z) in allset)]
    gen2 = set()
    x = 1
    for _ in range(2 * L):
        gen2.add(x % L); gen2.add((-x) % L); x = (2 * x) % L
    gen2 = sorted(a for a in gen2 if gcd(a, L) == 1)
    stable_geo = all(
        all(cls_of(L, (a*x) % L, (a*y) % L, (a*z) % L) == cl
            for (x, y, z) in V[cl]) for cl in ('I', 'II', 'III')
        for a in range(1, L) if gcd(a, L) == 1)
    print("    L=%3d: V の安定化群 = %s ; <2,-1> = %s ; 一致 %s ; V_I,V_II,V_III は全 (Z/L)^* 安定 %s"
          % (L, stab, gen2, stab == gen2, stable_geo))

# ============================================================ (5) lambda の有理性

print()
print("--- (5) V_IV の点で lambda が有理数になるか(標本内) ---")
print("    型 II (lambda=6) と型 III (lambda=8) は lambda が有理数なので P に依らない。")
for L in ODD_L_CLASSIFY:
    f, e, n4, v2, pred, V4 = summary[L]
    if not V4:
        continue
    K = CyclotomicField(L); zt = K.gen()
    rat = {}
    for (a, b, c) in V4:
        lam = K(6) - sum(zt ** ee + zt ** (-ee) for ee in (a, b, c))
        if lam in QQ:
            rat[QQ(lam)] = rat.get(QQ(lam), 0) + 1
    print("    L=%3d: |V_IV|=%5d, lambda が有理数の点: %s" % (L, n4, rat if rat else "なし"))

# ============================================================ まとめ

print()
print("=" * 92)
print("結論(詳細は outputs/reports/cycle15_T3_tau_d3_structure.md):")
print(" - 消える指標は V_I, V_II, V_III, V_IV に分かれ、v_2(tau_3(L)) =")
print("     6(L-1) + 8(L-3)[3|L] + 144[15|L] + sum_{V_IV} v_P(lambda)  (L 奇)。")
print("   最初の 3 項は証明済み(定理 G,H,I)。cycle 14 の積み残し L=9,21,27 は V_II で、")
print("   L=15 は V_II + V_III で完全に説明される。L=17 は V_IV(散発解)である。")
print(" - V_IV は <2,-1> で安定だが (Z/L)^* 全体では安定でない(L=17 等で確認)。")
print("   したがって V_IV は P に依存し、L の合同条件では記述できない。")
print(" - **V_IV の個数・付値の閉形は得られていない。標本は L <= 105(奇)。法則は主張しない。**")
print("=" * 92)
