# 対象ラベル: claim_sequence_lower_set_sup_eq_real_limit
# 本文の証明の三つの事実と、上から・下からの式鎖を一行ずつ検算する。
# Λ_ℚ の元は素数から有理数への有限台の辞書で持ち、順序 ≤_{Λ_ℚ} は共通分母 N による
# rat_Λ の比較（ℚ の厳密計算）で判定する。実現値 ρ は log_ℝ を含むので、区間演算 RIF で
# 包み、狭義の不等式は区間が確定した場合だけ真とする（浮動小数点の丸めに頼らない）。
# 実数列の極限・上限の存在は有限検算では証明できない（本文の実数体への脱出が根拠）。
count = 0
def check(cond, label):
    global count
    assert cond, label
    count += 1

PR = [2, 3, 5, 7]
def add(a, b):
    c = dict(a)
    for p, v in b.items():
        c[p] = c.get(p, QQ(0)) + v
    return {p: v for p, v in c.items() if v != 0}
def smul(r, a):
    return {p: QQ(r) * v for p, v in a.items() if QQ(r) * v != 0}
def rat_of(a, N):
    # N·a ∈ Λ の rat_Λ（N は共通分母）
    out = QQ(1)
    for p, v in a.items():
        k = N * v
        assert k in ZZ
        out *= QQ(p) ** ZZ(k)
    return out
def common_den(*xs):
    return lcm([1] + [v.denominator() for a in xs for v in a.values()])
def le(a, b):
    N = common_den(a, b)
    return rat_of(a, N) <= rat_of(b, N)
def rho(a):
    return sum([RIF(v) * RIF(p).log() for p, v in a.items()], RIF(0))
zero = {}
ell2 = {2: QQ(1)}

# 第一の事実: ρ(α) < ρ(β)（区間で確定）なら α ≤_{Λ_ℚ} β。全順序性も同時に確かめる。
import itertools
samples = []
for c2, c3, c5 in itertools.product([QQ(-3)/2, QQ(-1)/3, 0, QQ(1)/2, QQ(5)/4], repeat=3):
    samples.append({p: v for p, v in zip(PR, (c2, c3, c5)) if v != 0})
for a in samples:
    for b in samples[::7]:
        check(le(a, b) or le(b, a), 'total')
        if rho(a) < rho(b):
            check(le(a, b), 'first fact')
            check(not le(b, a), 'first fact strict')

# 第二の事実: ρ(0) = ρ(0·0) = ι(0)ρ(0) = 0·ρ(0) = 0
check(smul(0, zero) == zero, '0*0 = 0')
check(rho(zero) == RIF(0), 'rho(0) = 0')

# 第三の事実: c = ρ(ȷ(ℓ_2)) = log ι(2) > log ι(1) = ρ(ȷ(0)) = 0
check(rat_of(ell2, 1) == 2, 'rat(l2) = 2')
check(rat_of(zero, 1) == 1, 'rat(0) = 1')
c = rho(ell2)
check(c.overlaps(RIF(2).log()), 'c = log 2')
check(RIF(1).log() == 0, 'log 1 = 0')
check(c > 0, 'c > 0')

# 上から: 0 ≤ ε なら 0+μ ≤ ε+μ、ρ(μ) = ρ(0+μ) ≤ ρ(ε+μ) = ρ(μ+ε)
for mu in samples[::5]:
    for eps in samples[::11]:
        if not le(zero, eps):
            continue
        check(add(zero, mu) == mu, 'unit')
        check(le(add(zero, mu), add(eps, mu)), 'add monotone')
        check(add(eps, mu) == add(mu, eps), 'commutative')
        check(not (rho(add(eps, mu)) < rho(mu)), 'monotone realization')

# 下から: 列の極限 I と b < I に対して r, r' を取り、三つの鎖の各行を確かめる
def two_rationals_between(lo, hi):
    # lo < k/D < (k+1)/D < hi となる最小の分母 D の二点（共通分母を小さく保つ）
    for D in range(1, 10**6):
        k = ZZ((lo * D).upper().floor()) + 1
        if RIF(k + 1) / D < hi and RIF(k) / D > lo:
            return QQ(k) / D, QQ(k + 1) / D
    raise ValueError
# 極限 I は t·c（t ∈ ℚ）の形に取る。I/c = t が正確に分かり、列 λ_L := (t + (−1)^L/L)·ℓ_2 が
# I に収束する（ρ(λ_L) = (t + (−1)^L/L)c）ので、収束の仮定の例を有限個の項で確かめられる。
for t in (QQ(1), QQ(-3)/2, QQ(1)/3, QQ(0)):
    I = RIF(t) * c
    for gap in (QQ(1)/3, QQ(1)/7, QQ(1)/50):
        b = I - RIF(gap)
        check(b < I, 'b < I')
        check(b / c < I / c, 'b/c < I/c')
        r, rp = two_rationals_between(b / c, I / c)
        check(b / c < RIF(r) and RIF(r) < RIF(rp) and RIF(rp) < I / c, 'r, r_prime between')
        s = rp - r
        check(s > 0, 's > 0')
        mu = smul(r, ell2); eps = smul(s, ell2)
        # b = (b/c)c < ι(r)c = ρ(r·ȷ(ℓ_2)) = ρ(μ)
        check(((b / c) * c).overlaps(b), 'b = (b/c)c')
        check((b / c) * c < RIF(r) * c, '(b/c)c < r c')
        check(rho(mu).overlaps(RIF(r) * c), 'rho(mu) = r c')
        # ρ(μ+ε) = ρ((r+s)·ȷ(ℓ_2)) = ι(r+s)c = ι(r')c < (I/c)c = I
        check(add(mu, eps) == smul(r + s, ell2), 'distributive')
        check(rho(add(mu, eps)).overlaps(RIF(r + s) * c), 'rho((r+s)l2)')
        check(r + s == rp, 'r + s = r_prime')
        check(RIF(rp) * c < (I / c) * c, 'r_prime c < (I/c)c')
        check(((I / c) * c).overlaps(I), '(I/c)c = I')
        check(rho(add(mu, eps)) < I, 'rho(mu+eps) < I')
        # ρ(ε) = ι(s)c > 0 = ρ(0)、第一の事実で 0 ≤ ε、ε ≠ 0
        check(rho(eps) > 0, 'rho(eps) > 0')
        check(le(zero, eps) and eps != zero, '0 <= eps, eps != 0')
        # 収束する列の例 λ_L := (I の有理近似)·ℓ_2 + (−1)^L/L·ℓ_2 で、ある N 以降 μ+ε ≤ λ_L
        lam = lambda L: smul(t + QQ((-1)**L) / L, ell2)
        Ns = [N for N in range(1, 2000) if all(rho(add(mu, eps)) < rho(lam(L)) for L in range(N, N + 20))]
        check(len(Ns) > 0, 'N exists')
        N = Ns[0]
        check(all(le(add(mu, eps), lam(L)) for L in range(N, N + 20)), 'mu+eps <= lambda_L')
        check(b < rho(mu), 'b < rho(mu)')

# 否定の対照: 不等式の向きを崩した選び方は鎖を通らない
bad_r = t + 1
check(not (RIF(bad_r) * c < I), 'negative control: r above I/c')
check(not le({2: QQ(1)}, {}), 'negative control: l2 <= 0 fails')
check(not (rho({}) < rho({2: QQ(-1)})), 'negative control: rho(0) < rho(-l2) fails')
print('checks:', count)
print('RESULT: PASS')
