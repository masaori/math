# 対象ラベル: claim_rational_log_order_group_realization_smul
# 帰属: QQ 上の多項式環（不定元 ℓ_p は素数 p の実対数 log_ℝ(ι(p)) を表す記号）による厳密計算。
#       実対数の値そのものは計算しない（主張の証明も実対数の性質を一切使わない）。浮動小数点は使わない。

from itertools import product

PRIMES = [2, 3, 5, 7, 11]
R = PolynomialRing(QQ, ["l%d" % p for p in PRIMES])
ELL = {p: R.gen(i) for i, p in enumerate(PRIMES)}


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group）。0 になった素数は台から外す
    return {p: QQ(r) * z for p, z in lam_q.items() if QQ(r) * z != 0}


def supp(lam_q):
    return set(p for p, z in lam_q.items() if z != 0)


def realize(lam_q, S=None):
    # ρ_ℝ(μ) = Σ_{p ∈ supp μ} ι(μ(p))·log_ℝ(ι(p))（def_rational_log_order_group_realization）。
    # S を与えれば台を含む有限集合 S に渡る和
    if S is None:
        S = supp(lam_q)
    assert supp(lam_q) <= set(S)
    return sum((QQ(lam_q.get(p, 0)) * ELL[p] for p in S), R(0))


checks = 0
coeffs = [QQ(0), QQ(1), QQ(-1), QQ(2), QQ(1) / 2, QQ(-3) / 4, QQ(7) / 3]
scalars = [QQ(0), QQ(1), QQ(-1), QQ(3), QQ(1) / 2, QQ(-2) / 5, QQ(9) / 7]

# μ の標本: 台が {2,3,5} の部分集合で係数が coeffs から
samples = []
for c2, c3, c5 in product(coeffs, repeat=3):
    mu = {p: c for p, c in ((2, c2), (3, c3), (5, c5)) if c != 0}
    samples.append(mu)
samples.append({2: QQ(1) / 3, 7: QQ(-5) / 2, 11: QQ(4)})

for mu in samples:
    for r in scalars:
        rmu = qsmul(r, mu)
        # 二段目の前提: supp(r·μ) ⊂ supp(μ)
        assert supp(rmu) <= supp(mu)
        checks += 1
        # 一段目〜二段目: 台に渡る和と supp(μ) に渡る和は同じ値
        lhs = realize(rmu)
        assert lhs == realize(rmu, supp(mu))
        checks += 1
        # 三段目: (r·μ)(p) = r μ(p) を各 p ∈ supp(μ) で
        for p in supp(mu):
            assert rmu.get(p, QQ(0)) == r * mu[p]
            checks += 1
        # 三段目〜六段目を合わせた値: Σ_{p∈supp μ} (r·μ(p)) ℓ_p = r · Σ_{p∈supp μ} μ(p) ℓ_p
        step3 = sum((r * mu[p] * ELL[p] for p in supp(mu)), R(0))
        assert lhs == step3
        assert step3 == r * realize(mu)
        checks += 2
        # 結論
        assert realize(rmu) == r * realize(mu)
        checks += 1

print("PASS: %d checks (samples=%d, scalars=%d)" % (checks, len(samples), len(scalars)))
