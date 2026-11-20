# 節「虚数単位を足した体に根を持つこと」の二つの主張の段を、標本で一行ずつ確かめる。
# 対象ラベル: claim_positive_natural_two_power_odd_decomposition,
#             claim_subfield_polynomial_root_in_imaginary_unit_extension
# 帰属: 分解は自然数。多項式は有理係数の多項式の分解体（虚数単位を含む数体）の厳密な元。
# F を実代数的数の体、K = F(ω) を代数的数の全体と読むので、K への所属はこの検査では自明であり、
# 確かめるのは等号・係数・根の番号・分解の段である。浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

def is_odd(n):
    return n % 2 == 1

# 一以上の自然数の分解: 強い帰納法の二つの場合の式鎖
decomp = {}
for d in range(1, 513):
    j = d // 2
    check(d == j + j or d == j + j + 1, "ℕ の元は j + j か j + j + 1")
    if d == j + j + 1:
        k, m = 0, d
        check(d == 1 * d and 1 * d == 2^0 * d, "奇数の場合の式鎖 d = 1·d = 2^0·d")
    else:
        check(j >= 1 and j < d, "偶数の場合: j ≥ 1 かつ j < d")
        kp, mp = decomp[j]
        check(j == 2^kp * mp, "帰納法の仮定 j = 2^{k'}·m'")
        check(d == j + j and j + j == 2^kp * mp + 2^kp * mp
              and 2^kp * mp + 2^kp * mp == (2^kp + 2^kp) * mp
              and (2^kp + 2^kp) * mp == (2^kp * 2) * mp
              and (2^kp * 2) * mp == 2^(kp + 1) * mp, "偶数の場合の五行の式鎖")
        k, m = kp + 1, mp
    check(is_odd(m) and d == 2^k * m, "d = 2^k·m、m は奇数")
    decomp[d] = (k, m)

S.<x> = QQ[]
# 有理係数（F に含まれる）で最高次の係数が一の多項式の標本（次数 1〜8、2 進付値 0〜3。分解体が小さいものを選ぶ）
samples = [x - 3, x^2 + 1, x^3 - 2, x^4 + 1, x^5 - 1, x^6 + x^3 + 1, x^7 - 1, x^8 - 1,
           x^2 - 2*x + 5, x^3 - 3*x + 1, x^4 - 10*x^2 + 1, x^6 - 1]
for f0 in samples:
    d = f0.degree()
    check(f0.leading_coefficient() == 1 and d >= 1, "ac_d(f) = 1、d ≥ 1")
    k, m = decomp[d]
    Lf = (f0 * (x^2 + 1)).splitting_field('z')
    omega = (x^2 + 1).roots(Lf)[0][0]
    check(omega * omega == -1, "ω^2 = -1")
    R.<t> = PolynomialRing(Lf)
    f = R(f0.list())
    alpha = []
    for rt, mult in f0.roots(Lf):
        alpha += [rt] * mult
    check(len(alpha) == d and prod(t - a for a in alpha) == f, "f = ∏_{r<d}(t - α(r))")
    check(len(alpha) == 2^k * m, "番号の数は 2^k·m")
    # 出発点の段: 奇数個の因子の積で ac_{m'}(Π) = (-1)^0·es_0 = 1、上の係数は零、根は因子の根
    for mprime in [1, 3, 5, 7]:
        if mprime > d:
            continue
        beta = alpha[:mprime]
        Pi = prod(t - b for b in beta)
        check(Pi[mprime] == Pi[mprime - 0] and Pi[mprime - 0] == (-1)^0 * 1 and (-1)^0 * 1 == 1,
              "ac_{m'}(Π) の三行の式鎖")
        check(all(Pi[kk] == 0 for kk in range(mprime + 1, mprime + 4)), "k > m' で ac_k(Π) = 0")
        for z, _ in Pi.roots():
            idx = [r for r in range(mprime) if beta[r] == z]
            check(len(idx) >= 1 and all(r < mprime for r in idx), "Π の根は β(r)（r < m'）")
    # 一歩の段の指数: (k+1) - 1 = k、d = 2^{k+1}·m' の形
    for kk in range(0, 4):
        check((kk + 1) - 1 == kk and (kk + 1) >= 1, "指数 k + 1 ≥ 1、(k+1) - 1 = k")
    # 主張の最後の式鎖: z = α(i) で aev_z(f) = ∏(z - α(r)) = (z - α(i))·∏_{r≠i} = 0
    for i in range(d):
        z = alpha[i]
        v1 = f(z)
        v2 = prod(z - a for a in alpha)
        rest = prod(z - alpha[r] for r in range(d) if r != i)
        check(v1 == v2, "aev_z(f) = ∏(z - α(r))")
        check(v2 == (z - alpha[i]) * rest, "番号 i の因子を分ける")
        check((z - alpha[i]) * rest == 0 * rest and 0 * rest == 0, "z - α(i) = 0 と零元との積")

print("passes:", passes)
if failures:
    print("FAIL", len(failures))
    for msg in sorted(set(failures)):
        print("  ", msg)
else:
    print("PASS", passes)
