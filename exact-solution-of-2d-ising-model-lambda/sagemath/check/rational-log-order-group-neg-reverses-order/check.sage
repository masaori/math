# 対象ラベル: claim_rational_log_order_group_neg_reverses_order
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。浮動小数点は使わない。

from itertools import product


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group）
    return {p: QQ(r) * z for p, z in lam_q.items() if r * z != 0}


def zsmul(n, lam):
    # Λ の整数倍（def_log_order_group）
    return {p: ZZ(n) * z for p, z in lam.items() if n * z != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}
    return {p: QQ(z) for p, z in lam.items()}


def rat_of_log(lam):
    # rat_Λ(λ) = ∏ p^{λ(p)} ∈ Q_{>0}（def_rational_of_log）
    r = QQ(1)
    for p, e in lam.items():
        r *= QQ(p) ** ZZ(e)
    return r


def log_order_le(lam, mu):
    # λ ≤_Λ μ :⟺ rat_Λ(λ) ≤ rat_Λ(μ)（def_log_order_group_order）
    return rat_of_log(lam) <= rat_of_log(mu)


def is_common_denominator(N, lam_q, lam_N):
    # def_common_denominator: N·λ = ι(λ_N)
    return qsmul(N, lam_q) == iota(lam_N)


def denominator_product(lam_q):
    # claim_common_denominator_exists の N_λ（空積は 1）
    N = ZZ(1)
    for v in lam_q.values():
        N *= v.denominator()
    return N


def witness_of_denominator_product(lam_q):
    # claim_common_denominator_exists の証人
    N = denominator_product(lam_q)
    nu = {}
    for p, v in lam_q.items():
        val = ZZ(N // v.denominator()) * ZZ(v.numerator())
        if val != 0:
            nu[p] = val
    return nu


def witness_at(N, lam_q):
    # N が λ の共通分母なら一意な証人 λ_N、そうでなければ None
    scaled = qsmul(N, lam_q)
    if all(v.denominator() == 1 for v in scaled.values()):
        return {p: ZZ(v) for p, v in scaled.items()}
    return None


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き
    # λ ≤_{Λ_Q} μ ⟺ N_μ λ_{N_λ} ≤_Λ N_λ μ_{N_μ}
    Nl, Nm = denominator_product(lam_q), denominator_product(mu_q)
    return log_order_le(zsmul(Nm, witness_of_denominator_product(lam_q)),
                        zsmul(Nl, witness_of_denominator_product(mu_q)))



def qadd(lam_q, mu_q):
    # Λ_Q の加法（def_rational_log_order_group）。素数ごとに Q の和。0 になった素数は台から外す
    out = {}
    for p in set(lam_q) | set(mu_q):
        v = lam_q.get(p, QQ(0)) + mu_q.get(p, QQ(0))
        if v != 0:
            out[p] = v
    return out


def zadd(lam, mu):
    # Λ の加法（def_log_order_group）
    out = {}
    for p in set(lam) | set(mu):
        v = lam.get(p, ZZ(0)) + mu.get(p, ZZ(0))
        if v != 0:
            out[p] = v
    return out


def qneg(lam_q):
    # Λ_Q の逆元（def_rational_log_order_group）。素数ごとに Q の符号反転
    return {p: -v for p, v in lam_q.items()}


primes = [2, 3, 5]
coefficients = [QQ(c) for c in ["-1", "-1/2", "0", "1/3", "3/4"]]
vectors = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]
n = len(vectors)
zero = {}

count_le_pairs = 0
count_not_le_pairs = 0
for i in range(n):
    for j in range(n):
        lam, mu = vectors[i], vectors[j]
        if not rational_log_order_le(lam, mu):
            # 対偶の側: λ ≰ μ なら −μ ≰ −λ（主張を λ, μ を入れ替えて読んだもの。線形順序なので同値）
            assert not rational_log_order_le(qneg(mu), qneg(lam))
            count_not_le_pairs += 1
            continue
        count_le_pairs += 1
        # 主張: λ ≤ μ ⟹ −μ ≤ −λ（決定手続きで判定）
        assert rational_log_order_le(qneg(mu), qneg(lam))
        # 証明: ν := (−λ)+(−μ) を加法単調性で両辺に足す
        nu = qadd(qneg(lam), qneg(mu))
        assert rational_log_order_le(qadd(lam, nu), qadd(mu, nu))
        # 左辺の三段: λ+((−λ)+(−μ)) = (λ+(−λ))+(−μ) = 0+(−μ) = −μ
        l0 = qadd(lam, qadd(qneg(lam), qneg(mu)))
        l1 = qadd(qadd(lam, qneg(lam)), qneg(mu))
        l2 = qadd(zero, qneg(mu))
        l3 = qneg(mu)
        assert qadd(lam, qneg(lam)) == zero
        assert l0 == l1 == l2 == l3
        # 右辺の四段: μ+((−λ)+(−μ)) = μ+((−μ)+(−λ)) = (μ+(−μ))+(−λ) = 0+(−λ) = −λ
        r0 = qadd(mu, qadd(qneg(lam), qneg(mu)))
        r1 = qadd(mu, qadd(qneg(mu), qneg(lam)))
        r2 = qadd(qadd(mu, qneg(mu)), qneg(lam))
        r3 = qadd(zero, qneg(lam))
        r4 = qneg(lam)
        assert qadd(mu, qneg(mu)) == zero
        assert r0 == r1 == r2 == r3 == r4
        # 整えた両辺の比較が主張そのもの
        assert rational_log_order_le(l3, r4)

print("PASS: rational-log-order-group-neg-reverses-order (%d vectors, %d pairs with le, %d pairs without le, primes %s)"
      % (n, count_le_pairs, count_not_le_pairs, primes))
