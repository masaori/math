# 対象ラベル: claim_rational_log_order_group_realization_monotone
# 帰属: 可算側の段（共通分母の証人、rat_Λ の比較、Λ_ℚ の順序）は ZZ/QQ の厳密計算。
#       実数側の段（ι の順序保存、実対数の単調性、実現写像の値の比較）は、素数の実対数が
#       超越数で厳密には表せないため、区間演算 RealBallField（Arb。丸めを区間で包む厳密な包含）で
#       確かめる。浮動小数点の丸めをそのまま信じる計算はしない。ℝ 脱出を含む主張なので区間演算を使う
#       （理由は overview.md に記す）。区間が重なって判定できない場合は FAIL とする。

from itertools import product

PRIMES = [2, 3, 5, 7]
RBF = RealBallField(256)
LOGP = {p: RBF(p).log() for p in PRIMES}   # log_ℝ(ι(p)) の厳密な包含


def qsmul(r, lam_q):
    return {p: QQ(r) * z for p, z in lam_q.items() if QQ(r) * z != 0}


def rat_of_log(lam):
    # rat_Λ(λ) = Π p^{λ(p)}（def_rational_of_log）。λ は整数係数
    v = QQ(1)
    for p, e in lam.items():
        assert e in ZZ
        v *= QQ(p) ** ZZ(e)
    return v


def common_denominator(lam_q):
    # def_common_denominator / claim_common_denominator_exists: 分母の最小公倍数
    N = ZZ(1)
    for z in lam_q.values():
        N = lcm(N, QQ(z).denominator())
    lamN = {p: ZZ(N * z) for p, z in lam_q.items() if z != 0}
    # 証人の性質 N·λ = ι(λ_N)
    assert qsmul(N, lam_q) == {p: QQ(e) for p, e in lamN.items()}
    return N, lamN


def le_lambda_q(lam_q, mu_q):
    # def_rational_log_order_group_order: 両方の共通分母 N（最小公倍数）で λ_N ≤_Λ μ_N
    Nl, _ = common_denominator(lam_q)
    Nm, _ = common_denominator(mu_q)
    N = lcm(Nl, Nm)
    lamN = {p: ZZ(N * z) for p, z in lam_q.items() if z != 0}
    muN = {p: ZZ(N * z) for p, z in mu_q.items() if z != 0}
    return rat_of_log(lamN) <= rat_of_log(muN), N, lamN, muN


def realize(lam_q):
    # ρ_ℝ(μ) = Σ_{p ∈ supp μ} ι(μ(p)) log_ℝ(ι(p)) の厳密な包含
    return sum((RBF(QQ(z)) * LOGP[p] for p, z in lam_q.items() if z != 0), RBF(0))


def ball_le(a, b):
    # 区間 a の上端 ≤ 区間 b の下端なら a ≤ b が厳密に成り立つ。判定できなければ None
    if a.upper() <= b.lower():
        return True
    if b.upper() < a.lower():
        return False
    return None


checks = 0
coeffs = [QQ(0), QQ(1), QQ(-1), QQ(1) / 2, QQ(-2) / 3, QQ(5) / 4]
samples = []
for c2, c3, c5 in product(coeffs, repeat=3):
    mu = {p: c for p, c in ((2, c2), (3, c3), (5, c5)) if c != 0}
    samples.append(mu)
samples.append({2: QQ(7) / 6, 7: QQ(-3) / 5})
samples.append({3: QQ(-11) / 4, 5: QQ(2), 7: QQ(1) / 3})

pairs = 0
ordered = 0
for lam in samples:
    for mu in samples:
        pairs += 1
        le, N, lamN, muN = le_lambda_q(lam, mu)
        if not le:
            continue
        ordered += 1
        # 証人 N ≥ 1、N·λ = ι(λ_N)、N·μ = ι(μ_N)、λ_N ≤_Λ μ_N（可算側。厳密）
        assert N >= 1
        assert qsmul(N, lam) == {p: QQ(e) for p, e in lamN.items()}
        assert qsmul(N, mu) == {p: QQ(e) for p, e in muN.items()}
        rl, rm = rat_of_log(lamN), rat_of_log(muN)
        assert rl <= rm                                  # 二行目: rat_Λ(λ_N) ≤ rat_Λ(μ_N)（ℚ）
        checks += 4
        # 準備: 0 < ι(N)（区間演算）
        assert RBF(N) > 0
        checks += 1
        # 三行目: ι は順序を保つ（区間演算。有理数の包含どうし）
        assert ball_le(RBF(rl), RBF(rm)) is not False
        # 四行目: 実対数の単調性 log_ℝ(ι(rat(λ_N))) ≤ log_ℝ(ι(rat(μ_N)))
        Ll, Lm = RBF(rl).log(), RBF(rm).log()
        r4 = ball_le(Ll, Lm)
        assert r4 is not False, (lam, mu)
        checks += 2
        # 五行目: ρ(ι_{Λ→Λ_ℚ}(λ_N)) = log_ℝ(ι(rat(λ_N)))（claim_log_order_group_realization_real_log。包含が重なる）
        assert realize({p: QQ(e) for p, e in lamN.items()}).overlaps(Ll)
        assert realize({p: QQ(e) for p, e in muN.items()}).overlaps(Lm)
        # 六行目: ρ(N·λ) = ρ(ι(λ_N))（同じ元）。七行目: ρ(N·λ) = ι(N)·ρ(λ)（包含が重なる）
        assert realize(qsmul(N, lam)).overlaps(RBF(N) * realize(lam))
        assert realize(qsmul(N, mu)).overlaps(RBF(N) * realize(mu))
        checks += 4
        # 結論 ρ(λ) ≤ ρ(μ)。λ = μ なら同じ包含で自明、そうでなければ区間が分離して厳密に判定できること
        if lam == mu:
            checks += 1
            continue
        r = ball_le(realize(lam), realize(mu))
        assert r is True, ("判定不能または反例", lam, mu, realize(lam), realize(mu))
        checks += 1

print("PASS: %d checks (samples=%d, pairs=%d, ordered pairs=%d)" % (checks, len(samples), pairs, ordered))
