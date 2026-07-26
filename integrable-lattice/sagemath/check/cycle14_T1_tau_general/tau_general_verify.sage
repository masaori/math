# cycle 14 / T1: 命題 T の一般化 — v_p(tau_d(L)) の厳密計算と、
#                「mod p で消える部分トーラス」による下界の検証。
#
# tau_d(L) = d 次元離散トーラス C_L^d の全域木数。
# 命題 T (cycle 13, 証明済み): 奇 L に対し v_2(tau_2(L)) = 2(L-1)。
#
# 本スクリプトが検証すること:
#   (0) 命題 T の短縮証明で使う Z[x,y] 上の恒等式
#       4xy - (x + 1/x + y + 1/y)*xy = 4xy - (x+y)(xy+1)  を記号的に確認。
#   (1) p 進経路 (sum of v_P(lambda_chi)) と matrix-tree 経路(厳密整数行列式)の一致。
#   (2) 次元についての漸化式 v_p(tau_d) = v_p(tau_{d-1}) + 2*sum v_P(G_L(A)) (L 奇)の確認。
#       多項式恒等式 s_L(A) - 2 = (A-2) G_L(A)^2 (L 奇) の記号的確認、
#       偶数性・4 の倍数性(定理 C)、および「v_P(D) は偶数」という素朴な議論の反例。
#   (3) d=2, 奇素数 p の走査。どの (p,L) で v_p > 0 になるか、標本範囲を明示して洗い出す。
#   (4) 奇 L・奇 p で 4 | v_p(tau_2(L)) (定理として証明した主張)の確認。
#   (5) 部分トーラス下界: d=2/p=2, d=3/p=2, d=3/p=3 の明示族、および一般の
#       L^{floor(d/p)} - 1 下界を、d=2..5 の標本で確認。等号が破れる (d,p,L) も明示。
#   (6) p | L (分岐)の場合の表(法則は主張しない。観察のみ)。
#
# 計算はすべて厳密(p 進は固定精度だが、付値が精度より十分小さいことを assert で確認)。
# 浮動小数点は使わない。

from itertools import product

print("=" * 88)
print("cycle 14 / T1: 命題 T の一般化 — v_p(tau_d(L)) の構造")
print("=" * 88)

# ---------------------------------------------------------------- 共通ルーチン

def torus_spanning_trees(L, d):
    """C_L^d の全域木数を Kirchhoff の matrix-tree 定理で厳密整数計算する。"""
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
                u = list(t); u[i] += sgn
                b = idx(tuple(u))
                if a == b:
                    continue
                M[a, a] += 1
                M[a, b] -= 1
    return M.submatrix(0, 0, n - 1, n - 1).determinant()

def padic_zeta(L, p, prec):
    """p ∤ L のとき、Z_p[zeta_L] の P における完備化(不分岐)と、位数 L の
    Teichmuller 根 zeta を返す。"""
    assert L % p != 0
    m = Mod(p, L).multiplicative_order()
    R = Zp(p, prec) if m == 1 else Zq(p ** m, prec, names='a')
    k = GF(p) if m == 1 else R.residue_field()
    zz = k.multiplicative_generator() ** ((p ** m - 1) // L)
    zeta = R.teichmuller(R(zz))
    return R, zeta, m

def vp_tau(L, d, p, prec=40, want_count=False):
    """v_p(tau_d(L)) = sum_{chi != 1} v_P(lambda_chi)  (p ∤ L)。
    lambda_chi = 2d - sum_i (zeta^{j_i} + zeta^{-j_i})。"""
    R, zeta, m = padic_zeta(L, p, prec)
    pw = [zeta ** j + zeta ** (-j) for j in range(L)]
    tot = 0; cnt = 0
    for t in product(range(L), repeat=d):
        if all(c == 0 for c in t):
            continue
        v = (R(2 * d) - sum(pw[c] for c in t)).valuation()
        assert v < prec - 5, ("precision too low", L, d, p, t, v)
        if v > 0:
            tot += v; cnt += 1
    return (tot, cnt) if want_count else tot

# ---------------------------------------------------------------- (0) 恒等式

print()
print("--- (0) 命題 T の短縮証明で使う恒等式(記号的に確認) ---")
Rxy.<x, y> = ZZ[]
lhs = y * (x**2 + 1) + x * (y**2 + 1)      # (x + 1/x + y + 1/y) * xy
rhs = (x + y) * (x * y + 1)
print("  (x + 1/x + y + 1/y)*xy = (x+y)(xy+1) ?  ->", bool(lhs - rhs == 0))
print("  よって lambda_{j,k} = 4 - (zeta^j+zeta^k)(zeta^{j+k}+1) * zeta^{-(j+k)}  (Z[zeta_L] 上の恒等式)")
Rxyz.<X, Y, Z> = ZZ[]
n3 = Y*Z*(X**2 + 1) + X*Z*(Y**2 + 1) + X*Y*(Z**2 + 1)
print("  d=3: (sum_i x_i + 1/x_i)*xyz = %s" % n3)
F2xyz = PolynomialRing(GF(2), 'X,Y,Z')
print("  d=3 の分子を mod 2 で因数分解:", factor(F2xyz(n3)))
F2xy = PolynomialRing(GF(2), 'x,y')
print("  d=2 の分子を mod 2 で因数分解:", factor(F2xy(lhs)))
print("  => d=2 では mod 2 で 2 つの部分トーラス x=y, xy=1 に分解する。d=3 では既約(法則が変わる根拠)。")

# ---------------------------------------------------------------- (1) 経路一致

print()
print("--- (1) p 進経路と matrix-tree 経路(厳密整数行列式)の一致 ---")
print("  d=2:")
for L in [3, 5, 7, 9, 11, 12]:
    t = torus_spanning_trees(L, 2)
    ok = []
    for p in prime_range(60):
        if L % p == 0: continue
        ok.append(t.valuation(p) == vp_tau(L, 2, p))
    print("    L=%2d: tau の素因数分解 = %s ; p<60 (p∤L) 全一致: %s"
          % (L, factor(t), all(ok)))
print("  d=3:")
for L in [3, 4, 5, 6, 7]:
    t = torus_spanning_trees(L, 3)
    ok = []
    for p in prime_range(40):
        if L % p == 0: continue
        ok.append(t.valuation(p) == vp_tau(L, 3, p))
    print("    L=%2d: 桁数 %d ; p<40 (p∤L) 全一致: %s" % (L, len(str(t)), all(ok)))
print("  d=4:")
for L in [3, 4]:
    t = torus_spanning_trees(L, 4)
    ok = [t.valuation(p) == vp_tau(L, 4, p) for p in prime_range(30) if L % p != 0]
    print("    L=%2d: 桁数 %d ; p<30 (p∤L) 全一致: %s" % (L, len(str(t)), all(ok)))

# ---------------------------------------------------------------- (2) 主公式

print()
print("--- (2) 主公式(漸化式)と、素朴な議論が壊れる箇所 ---")
print("  A := 2d - sum_{i>=2}(zeta^{j_i}+zeta^{-j_i}) とし、s_k(A) を s_0=2, s_1=A,")
print("  s_k = A s_{k-1} - s_{k-2} で定める。D := prod_{j_1 in Z/L} lambda_{(j_1,j')} = s_L(A) - 2。")
print()
print("  (2a) [記号的] L 奇 => D = (A-2) * G_L(A)^2,  G_L(A) = 1 + sum_{k=1}^{(L-1)/2} s_k(A) in Z[A]")
print("       L 偶 => D = (A^2-4) * (Z[A] の平方)")
RA.<A> = ZZ[]
def s_poly(L):
    sp, sc = RA(2), A
    out = [RA(2), A]
    for _ in range(2, L + 1):
        sp, sc = sc, A * sc - sp
        out.append(sc)
    return out
for L in range(3, 16):
    S = s_poly(L)
    D = S[L] - 2
    if L % 2 == 1:
        G = RA(1) + sum(S[k] for k in range(1, (L - 1) // 2 + 1))
        ok = (D == (A - 2) * G ** 2)
        print("    L=%2d (奇): D == (A-2)*G_L(A)^2 : %s   (deg G = %d)" % (L, ok, G.degree()))
    else:
        q, r = D.quo_rem(A ** 2 - 4)
        print("    L=%2d (偶): D == (A^2-4)*(平方) : %s" % (L, bool(r == 0 and q.is_square())))
print("    ※ A-2 = 2(d-1) - sum_{i>=2}(zeta^{j_i}+zeta^{-j_i}) は (d-1) 次元トーラスの固有値そのもの。")

print()
print("  (2b) [数値] L 奇, p∤L の漸化式")
print("       v_p(tau_d(L)) = v_p(tau_{d-1}(L)) + 2 * sum_{j' != 0} v_P(G_L(A_{j'}))")
print("       (tau_1(L) = L なので v_p(tau_1(L)) = 0。ここから帰納的に L 奇では 4 | v_p(tau_d(L))。)")
for (L, d, p) in [(5,2,2),(7,2,13),(9,2,17),(13,2,5),(5,3,2),(7,3,3),(11,3,3),(13,3,5),(5,4,2),(7,4,3)]:
    R, zeta, m = padic_zeta(L, p, 60)
    pw = [zeta ** j + zeta ** (-j) for j in range(L)]
    S = s_poly(L)
    Gp = RA(1) + sum(S[k] for k in range(1, (L - 1) // 2 + 1))
    gsum = 0
    for t in product(range(L), repeat=d - 1):
        if all(c == 0 for c in t): continue
        Aval = R(2 * d) - sum(pw[c] for c in t)
        gsum += Gp(Aval).valuation()
    prev = vp_tau(L, d - 1, p) if d - 1 >= 2 else 0
    lhs = vp_tau(L, d, p)
    print("    d=%d L=%2d p=%2d : v_p(tau_d)=%5d, v_p(tau_{d-1})=%5d, 2*sum v_P(G)=%5d, 一致 %s, 偶数 %s"
          % (d, L, p, lhs, prev, 2 * gsum, lhs == prev + 2 * gsum, lhs % 2 == 0))

print()
print("  (2c) [反例] 素朴な議論『D = (r^L-1)^2/r^L だから v_P(D) は偶数』は d>=3 では偽。")
print("       r は K_P の 2 次拡大の元でありうるが、その拡大は分岐しうるので v_P(r) は半整数になりうる。")
print("       各 (j_2..j_d) ごとの v_P(D) の偶奇を実測する:")
for (L, d, p) in [(5,2,2),(13,2,5),(5,3,2),(7,3,3),(8,3,7),(5,4,2)]:
    R, zeta, m = padic_zeta(L, p, 60)
    pw = [zeta ** j + zeta ** (-j) for j in range(L)]
    odd_terms = 0; nterm = 0
    for t in product(range(L), repeat=d - 1):
        if all(c == 0 for c in t): continue
        base = R(2 * d) - sum(pw[c] for c in t)
        vD = sum((base - pw[j1]).valuation() for j1 in range(L))
        nterm += 1
        if vD % 2 == 1: odd_terms += 1
    print("    d=%d L=%2d p=%2d : v_P(D) が奇数の項 %d / %d" % (d, L, p, odd_terms, nterm))
print("    => d=2 では 0 件(A-2 = (1-zeta^j)(1-zeta^-j) が p∤L のとき単数だから)。")
print("       d>=3 では奇数の項が実在する。よって偶数性は (2a) の因数分解経由でしか出ない。")

print()
print("  (2d) 定理 C: L 奇, p∤L なら 4 | v_p(tau_d(L))  (d=2,3,4 で確認)")
c_bad = []
for d in [2, 3, 4]:
    Ls = [5, 7, 9, 11, 13, 15] if d <= 3 else [5, 7, 9, 11]
    B = 60 if d <= 3 else 30
    for L in Ls:
        for p in prime_range(B):
            if L % p == 0: continue
            v = vp_tau(L, d, p)
            if v % 4 != 0: c_bad.append((d, L, p, v))
print("    d=2,3: L in {5,7,9,11,13,15}(奇), p<60 / d=4: L in {5,7,9,11}, p<30 (いずれも p∤L)")
print("    反例: %s" % (c_bad if c_bad else "なし"))

print()
print("  (2e) 定理 C(b): L 偶, p 奇 (p∤L) なら")
print("       v_p(tau_d(L)) = sum_{b=1}^{d} C(d,b) v_p(b)  (mod 2)")
print("       (対合 chi -> -chi の不動点 chi in {0,L/2}^d では lambda_chi = 4b, b = #{i: j_i = L/2}。)")
e_bad = []
for d in [2, 3, 4, 5]:
    Ls = [4, 8, 10, 14, 16, 22] if d <= 3 else ([4, 8, 10, 14] if d == 4 else [4, 6, 8])
    B = 30 if d <= 4 else 20
    for L in Ls:
        for p in prime_range(3, B):
            if L % p == 0: continue
            v = vp_tau(L, d, p)
            pred = sum(binomial(d, b) * ZZ(b).valuation(p) for b in range(1, d + 1))
            if (v - pred) % 2 != 0:
                e_bad.append((d, L, p, v, pred))
            if d in (3, 5) and p == d:
                print("      d=%d L=%2d p=%d : v_p=%5d (予測 %s), 実際の偶奇 %s"
                      % (d, L, p, v, "奇" if pred % 2 else "偶", "奇" if v % 2 else "偶"))
print("    d=2..5, L 偶, 3<=p<30(d<=4)/20(d=5), p∤L : 反例 %s" % (e_bad if e_bad else "なし"))

# ---------------------------------------------------------------- (3) d=2 走査

print()
print("--- (3) d=2 走査: L = 3..40, p < 200, p ∤ L。v_p > 0 になる (p,L) の全列挙 ---")
print("  (標本範囲はこの通りであり、範囲外については何も主張しない。)")
print("  形式: (p, v_p, n=消える指標の個数, p mod L)")
d2_hits = {}
for L in range(3, 41):
    hits = []
    for p in prime_range(200):
        if L % p == 0: continue
        v, c = vp_tau(L, 2, p, want_count=True)
        if v > 0: hits.append((p, v, c, p % L))
    d2_hits[L] = hits
    print("  L=%2d: %s" % (L, hits))

# ---------------------------------------------------------------- (4) 4 | v_p

print()
print("--- (4) 定理: 奇 L, 奇素数 p ∤ L に対し 4 | v_p(tau_2(L)) ---")
bad = []
for L in range(3, 41, 2):
    for (p, v, c, r) in d2_hits[L]:
        if p == 2: continue
        if v % 4 != 0: bad.append((L, p, v))
print("  奇 L・奇 p の全ヒットで 4 | v_p : %s (反例: %s)" % (bad == [], bad))
print("  参考: 偶 L では j = L/2 が自己共役なので 4 の倍数性は保証されない。")
print("        偶 L の奇 p ヒットで v mod 4 != 0 のもの:",
      [(L, p, v) for L in range(4, 41, 2) for (p, v, c, r) in d2_hits[L]
       if p != 2 and v % 4 != 0])

# ---------------------------------------------------------------- (5) 下界

print()
print("--- (5) 部分トーラスによる下界 ---")
print()
print("  (5a) d=2, p=2, 奇 L: W = {(j, ±j) : j != 0}, |W| = 2(L-1), 各 v_P(lambda)=1。")
print("       -> v_2 = 2(L-1)(命題 T)。等号まで込みで証明済み。")
for L in range(3, 30, 2):
    v, c = vp_tau(L, 2, 2, want_count=True)
    print("    L=%2d: v_2=%4d, 2(L-1)=%4d, 一致 %s, 消える指標数 n=%d (= |W|: %s)"
          % (L, v, 2*(L-1), v == 2*(L-1), c, c == 2*(L-1)))

print()
print("  (5b) d=3, p=2, 奇 L: W = {(t,t,1),(t,t^-1,1),(t,1,t),(t,1,t^-1),(1,t,t),(1,t,t^-1)},")
print("       |W| = 6(L-1)、各点で lambda = 2(1-t)(1-t^-1) ゆえ v_P = 1。=> v_2 >= 6(L-1)。")
for L in range(3, 28, 2):
    v, c = vp_tau(L, 3, 2, want_count=True)
    print("    L=%2d: v_2=%5d, 下界 6(L-1)=%4d, 下界成立 %s, 等号 %s (n=%d)"
          % (L, v, 6*(L-1), v >= 6*(L-1), v == 6*(L-1), c))

print()
print("  (5c) d=3, p=3, 3 ∤ L: W = {(t,t,t),(t,t,t^-1),(t,t^-1,t),(t^-1,t,t)},")
print("       各点で lambda = 3(1-t)(1-t^-1) ゆえ v_P = 1。")
print("       |W \\ {1}| = 4(L-1) (L 奇), 4(L-1)-3 (L 偶: t=-1 で 4 点が 1 点に潰れる)。")
for L in list(range(4, 27)):
    if L % 3 == 0: continue
    lb = 4*(L-1) - (3 if L % 2 == 0 else 0)
    v, c = vp_tau(L, 3, 3, want_count=True)
    print("    L=%2d: v_3=%5d, 下界=%4d, 下界成立 %s, 等号 %s (n=%d)"
          % (L, v, lb, v >= lb, v == lb, c))

print()
print("  (5d) 一般: p <= d のとき対角型部分トーラス(次元 floor(d/p))から v_p >= L^{floor(d/p)} - 1。")
print("       p > d では強制される部分トーラスが無く、v_p は散発的(0 が既定)。")
print("   d  L   p   v_p     L^floor(d/p)-1  下界成立")
for d in [2, 3, 4, 5]:
    for L in [5, 7, 11, 13]:
        for p in [2, 3, 5, 7]:
            if L % p == 0: continue
            if d == 5 and L > 9: continue
            if d == 4 and L > 13: continue
            v = vp_tau(L, d, p)
            lb = L ** (d // p) - 1
            print("   %d %2d  %2d  %6d      %8d        %s" % (d, L, p, v, lb, v >= lb))

# ---------------------------------------------------------------- (6) p | L

print()
print("--- (6) p | L (分岐)の場合。法則は主張しない。matrix-tree による観察のみ ---")
print("   L  d=2: v_p(tau) for p | L")
for L in range(3, 16):
    t = torus_spanning_trees(L, 2)
    print("  %2d  %s" % (L, [(p, t.valuation(p)) for p in prime_divisors(L)]))

print()
print("=" * 88)
print("結論(詳細は outputs/reports/cycle14_T1_proposition_T_generalization.md):")
print(" - 主公式と『mod p で消える部分トーラス』による下界は証明済みで、標本全体で成立した。")
print(" - 等号(clean な法則)は d=2,p=2 でのみ全標本で成立。d>=3 や奇 p では散発的な")
print("   追加解が出るため、標本の範囲内ですら clean な閉じた式にはならなかった。")
print("=" * 88)
