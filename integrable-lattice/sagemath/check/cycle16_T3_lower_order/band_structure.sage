# cycle 16 / T3 Pure（第 2 スクリプト）: 退化帯の上で付値がどう振る舞うかを直接見る。
#
# 対応する証明本体: outputs/reports/cycle16_T3_lower_order_and_degeneracy.md
#
# lower_order.sage は「公式が合うか」を照合する。こちらは「なぜ ell=2 だけ n ell^n が出るのか」
# を分離するために、退化帯 Band の上での点ごとの付値 v_ell(E(zeta,xi)) の M 依存性を測る。
#
# 記号（cycle14 report §5, §8 に従う）
#   D = det L、mu = v_ell(content D)、E = ell^{-mu} D、g = E(1+T,1+S)、k = ord(g mod ell)
#   H = (g mod ell) の最低次斉次部分、z_H = H の P^1(F_ell) 有理零点の個数
#   位数 ell^i の zeta と位数 ell^j の xi について M = max(i,j)
#   非退化予言（補題 8.4）: v_ell(E(zeta,xi)) = k / phi(ell^M)
#
# 検証するのは以下の 4 個。
#
#   Step A  トーラス（bouquet (1,0),(0,1)）の恒等式
#             zeta + zeta^{-1} + xi + xi^{-1} = g^{-b} (1 + g^{b-a}) (1 + g^{a+b})
#           を Laurent 環／円分体で確認する（report の (5.2') の根拠）。
#   Step B  ell = 2 トーラスの非対角点（i != j）で v_2(D) = 2^{2-M} = k/phi(2^M)、
#           すなわち非退化予言どおりであること。退化は対角 i = j だけで起きる。
#   Step C  ell = 2 トーラスの Sigma_n の 3 分解（対角 / 非対角 / 合計）を n ごとに数え上げ、
#           report で証明した
#             非対角の M 段 = 2^{M+1}、対角の M 段 = (M+1)2^M - 4 (M>=2)、Sigma_1 段は個別、
#             Sigma_n = 2n 2^n + 4 2^n - 4n - 1
#           を確認する。これが ord_2(kappa_n) = 2n 2^n + 4 2^n - 6n - 1 の内訳である。
#   Step D  **本スクリプトの核心**: ell 奇（5, 13, 17, 29）のトーラスの退化帯の上で、
#           v_ell(E) * phi(ell^M) を M ごとに出す。
#           非退化点なら常に k = 2。帯の点でこれが
#             (i) M によらない定数 k' > k に落ち着く  -> 余分は ell^n のオーダー（n ell^n は出ない）
#             (ii) M とともに増大する                 -> n ell^n が出る
#           のどちらかを判定する。ell = 2 は (ii)（v が定数 2 に飽和するので v*phi = 2^M と増大）、
#           ell 奇は (i) であることを見る。
#
# 実行: sage band_structure.sage

import sys
import time

sys.stdout.reconfigure(line_buffering=True)

Lzw = LaurentPolynomialRing(ZZ, ['z', 'w']); zL, wL = Lzw.gens()
RTS = PolynomialRing(ZZ, ['T', 'S']); Tg, Sg = RTS.gens()

T0 = time.time()
def el():
    return "[%7.1fs]" % (time.time() - T0)

# --------------------------------------------------------------------------
# 共通部品（lower_order.sage と同じ定義を再掲。両スクリプトは独立に動く）
# --------------------------------------------------------------------------

def volt_laplacian(m, edges):
    L = matrix(Lzw, m, m)
    for (u, v, (a, b)) in edges:
        mon = zL**a * wL**b
        if u == v:
            L[u, u] += 2 - mon - mon**(-1)
        else:
            L[u, u] += 1; L[v, v] += 1
            L[u, v] -= mon; L[v, u] -= mon**(-1)
    return L

def detL(m, edges):
    return volt_laplacian(m, edges).det()

def content_of(F):
    cs = [ZZ(c) for c in F.coefficients()]
    return gcd(cs) if cs else ZZ(0)

def clear_monomial_L(D):
    """Laurent 多項式 D から単項式因子を除いた多項式部分を (T,S) 展開用に返す。"""
    ex = list(D.dict().keys())
    r = min(e[0] for e in ex); s = min(e[1] for e in ex)
    Rzw = PolynomialRing(ZZ, ['z', 'w']); zg, wg = Rzw.gens()
    P = Rzw({(e[0] - r, e[1] - s): ZZ(c) for (e, c) in D.dict().items()})
    return P

def lowest_form(D, ell):
    P = clear_monomial_L(D)
    Rzw = P.parent(); zg, wg = Rzw.gens()
    f = RTS(P.subs({zg: 1 + Tg, wg: 1 + Sg}))
    Fl = GF(ell)
    fb = f.change_ring(Fl)
    if fb == 0:
        return (None, None)
    k = min(e[0] + e[1] for (e, c) in fb.dict().items() if c != 0)
    RTSl = PolynomialRing(Fl, ['T', 'S'])
    H = RTSl({e: c for (e, c) in fb.dict().items() if e[0] + e[1] == k and c != 0})
    return (k, H)

def rational_zeros(H, ell):
    Tl, Sl = H.parent().gens()
    out = []
    if H.subs({Tl: 0, Sl: 1}) == 0:
        out.append('(0:1)')
    for c in GF(ell):
        if H.subs({Tl: 1, Sl: c}) == 0:
            out.append('(1:%s)' % c)
    return out

_CYC = {}
def cyc_data(ell, n):
    key = (ell, n)
    if key not in _CYC:
        K = CyclotomicField(ell**n)
        P = K.prime_above(ell)
        _CYC[key] = (K, K.gen(), P, P.ramification_index())
    return _CYC[key]

def point_val(D, ell, n, a, b):
    (K, g, P, e) = cyc_data(ell, n)
    val = D.subs({zL: g**ZZ(a), wL: g**ZZ(b)})
    if val == 0:
        return oo
    return QQ(K(val).valuation(P)) / e

TOR = (1, [(0, 0, (1, 0)), (0, 0, (0, 1))])
Dtor = detL(*TOR)

print("=" * 78)
print("cycle 16 / T3（第 2 スクリプト）: 退化帯の上での付値の M 依存性")
print("SageMath", version())
print("=" * 78)
print("トーラスの D =", Dtor)

# ==========================================================================
# Step A  恒等式 zeta+zeta^{-1}+xi+xi^{-1} = g^{-b}(1+g^{b-a})(1+g^{a+b})
# ==========================================================================
print()
print("### Step A  恒等式 g^a + g^{-a} + g^b + g^{-b} = g^{-b}(1+g^{b-a})(1+g^{a+b}) の確認")
print("    D = 4 - (z + z^{-1} + w + w^{-1}) なので、これが付値計算の出発点。")
print("    これは g が可逆でありさえすれば成り立つ Laurent 単項式の恒等式なので、")
print("    円分体ではなく Z[g^{±1}] の中で厳密に照合する（1 の冪根であることを使わない）。")
Rg = LaurentPolynomialRing(ZZ, 'g'); gg = Rg.gen()
badA = 0; totA = 0
for a in range(-6, 7):
    for b in range(-6, 7):
        lhs = gg**a + gg**(-a) + gg**b + gg**(-b)
        rhs = gg**(-b) * (1 + gg**(b - a)) * (1 + gg**(a + b))
        totA += 1
        if lhs != rhs:
            badA += 1
            print("     破れ (a,b)=(%d,%d)" % (a, b))
print("  Z[g^{±1}] の中で -6 <= a,b <= 6 の全 (a,b) を照合: %d 組、破れ %d 組" % (totA, badA))
print("  -> D(zeta,xi) = 4 - g^{-b}(1+g^{b-a})(1+g^{a+b}) が厳密に成り立つ。%s" % el())

# ==========================================================================
# Step B  ell = 2 トーラスの非対角点は非退化予言どおり
# ==========================================================================
print()
print("### Step B  ell=2 トーラス: 位数が異なる点 (i != j, M = max) では v_2(D) = 2^{2-M} = k/phi(2^M)")
print("    （k = 2、phi(2^M) = 2^{M-1}）。すなわち退化は対角 i=j でのみ起きる。")
badB = 0; totB = 0
for M in range(1, 7):
    (K, g, P, e) = cyc_data(2, M)
    bad = 0; tot = 0
    for a in range(2**M):
        for b in range(2**M):
            if a == 0 and b == 0:
                continue
            va = M if a == 0 else ZZ(a).valuation(2)
            vb = M if b == 0 else ZZ(b).valuation(2)
            i = M - min(va, M); j = M - min(vb, M)
            if i == j:
                continue          # 対角は Step C で扱う
            if max(i, j) != M:
                continue          # レベル M の点だけ（低レベルは M' < M で数える）
            v = point_val(Dtor, 2, M, a, b)
            pred = QQ(2) / euler_phi(2**M)
            tot += 1
            if v != pred:
                bad += 1
                if bad <= 3:
                    print("     破れ M=%d (a,b)=(%d,%d): v=%s pred=%s" % (M, a, b, v, pred))
    totB += tot; badB += bad
    print("     M=%d: 非対角点 %d 個、非退化予言 k/phi(2^M)=%s から外れた点 %d 個"
          % (M, tot, QQ(2) / euler_phi(2**M), bad))
print("  合計 %d 点、破れ %d 点 %s" % (totB, badB, el()))

# ==========================================================================
# Step C  ell = 2 の Sigma_n の内訳
# ==========================================================================
print()
print("### Step C  ell=2 トーラス: Sigma_n = sum_{(zeta,xi)!=(1,1)} v_2(D) の内訳")
print("    report で証明した内訳: レベル M の非対角の和 = 2^{M+1}、")
print("    レベル M の対角の和 = (M+1)2^M - 4 (M>=2)、M=1 の対角は 3。")
print("    合計 Sigma_n = 2n 2^n + 4*2^n - 4n - 1、ord_2(kappa_n) = Sigma_n - 2n。")
diag = {}; offd = {}
NMAXC = 6
for M in range(1, NMAXC + 1):
    (K, g, P, e) = cyc_data(2, M)
    sd = QQ(0); so = QQ(0)
    for a in range(2**M):
        for b in range(2**M):
            if a == 0 and b == 0:
                continue
            va = M if a == 0 else ZZ(a).valuation(2)
            vb = M if b == 0 else ZZ(b).valuation(2)
            i = M - min(va, M); j = M - min(vb, M)
            if max(i, j) != M:
                continue
            v = point_val(Dtor, 2, M, a, b)
            if i == j:
                sd += v
            else:
                so += v
    diag[M] = sd; offd[M] = so
    pdg = QQ(3) if M == 1 else QQ((M + 1) * 2**M - 4)
    pof = QQ(2**(M + 1))
    print("     M=%d: 対角の和 = %s (公式 %s -> %s) / 非対角の和 = %s (公式 %s -> %s)"
          % (M, sd, pdg, sd == pdg, so, pof, so == pof))
print()
for n in range(1, NMAXC + 1):
    Sig = sum(diag[M] + offd[M] for M in range(1, n + 1))
    predS = 2 * n * 2**n + 4 * 2**n - 4 * n - 1
    predO = 2 * n * 2**n + 4 * 2**n - 6 * n - 1
    print("     n=%d: Sigma_n = %s (公式 %d -> %s) / ord_2(kappa_n) = Sigma_n - 2n = %s (公式 %d -> %s)"
          % (n, Sig, predS, Sig == predS, Sig - 2 * n, predO, Sig - 2 * n == predO))
print("  %s" % el())

# ==========================================================================
# Step D  退化帯の上での v * phi(ell^M) の M 依存性（核心）
# ==========================================================================
print()
print("### Step D  退化帯の上での v_ell(E) * phi(ell^M) の M 依存性")
print("    非退化点では常に k。帯の点でこれが M によらない定数なら余分は ell^n オーダーにとどまり、")
print("    M とともに増大するなら n ell^n が出る。")
print()

def band_profile(m, edges, ell, Mmax, sample=None):
    """レベル M の対角点 (i=j=M) を方向ごとに分け、v*phi(ell^M) の値の分布を返す。"""
    D = detL(m, edges)
    mu = ZZ(content_of(clear_monomial_L(D))).valuation(ell)
    E = Lzw(D / ZZ(ell)**mu) if mu > 0 else D
    (k, H) = lowest_form(E, ell)
    zeros = set(rational_zeros(H, ell))
    print("  ell=%2d: k=%d mu=%d H=%s / 有理零点 %s (z_H=%d)"
          % (ell, k, mu, H, sorted(zeros) if zeros else '無し', len(zeros)))
    for M in range(1, Mmax + 1):
        N = ell**M
        ph = euler_phi(N)
        prof_band = {}; prof_gen = {}
        units = [a for a in range(1, N) if a % ell != 0]
        if sample is not None and len(units) > sample:
            units = units[:sample]
        for a in units:
            ai = GF(ell)(a)
            for b in units:
                d = '(1:%s)' % (GF(ell)(b) / ai)
                v = point_val(E, ell, M, a, b)
                key = 'inf' if v is oo else v * ph
                tgt = prof_band if d in zeros else prof_gen
                tgt[key] = tgt.get(key, 0) + 1
        print("     M=%d: 非帯の v*phi の分布 %s / 帯の v*phi の分布 %s"
              % (M, dict(sorted(prof_gen.items(), key=str)),
                 dict(sorted(prof_band.items(), key=str))))

print("  (D-1) ell = 2 のトーラス（退化。帯 = 対角 (1:1)、z_H = 1）")
band_profile(TOR[0], TOR[1], 2, 6)
print("     -> 帯は M とともに層の個数が増える分布になる。最大値 2^M をとる層は")
print("        v = 2 に飽和した点（v*phi = 2*2^{M-1} = 2^M）で、その個数は 2^M。")
print("        飽和は v_2(4) = 2 に由来し、ell 奇では起きない（v_ell(4) = 0）。")
print("        n 2^n 項は、この飽和と『層ごとの寄与が一定で層数が M に比例する』ことの合わせ技で出る")
print("        （report 補題 5.5 の証明と注 5.8 を参照）。")

print()
print("  (D-2) ell = 1 mod 4 のトーラス（退化。H = -(T^2+S^2) が c^2=-1 で零、z_H = 2）")
print("        ell=5 は M=1,2,3 まで見るので、M 依存性の有無をここで判定できる。")
band_profile(TOR[0], TOR[1], 5, 3)
band_profile(TOR[0], TOR[1], 13, 2)
band_profile(TOR[0], TOR[1], 17, 1)
band_profile(TOR[0], TOR[1], 29, 1)

print()
print("  (D-3) ell = 3 mod 4 のトーラス（非退化。比較対照。帯は空なので全点が k=2 のはず）")
for ell in [3, 7, 11]:
    band_profile(TOR[0], TOR[1], ell, 2)

print()
print("=" * 78)
print("%s 終了" % el())
print("=" * 78)
