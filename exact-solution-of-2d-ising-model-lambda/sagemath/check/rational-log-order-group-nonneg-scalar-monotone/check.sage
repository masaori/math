# 対象ラベル: claim_rational_log_order_group_nonneg_scalar_monotone
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



primes = [2, 3, 5]
coefficients = [QQ(c) for c in ["-1", "0", "1/2", "2/3"]]
vectors = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]
scalars = [QQ(c) for c in ["0", "1", "2", "1/2", "7/4"]]
n = len(vectors)
LE = [[rational_log_order_le(vectors[i], vectors[j]) for j in range(n)] for i in range(n)]
N_all = [denominator_product(lam) for lam in vectors]
nu_all = [witness_of_denominator_product(lam) for lam in vectors]

count_le_pairs = 0
count_claims = 0
count_chain = 0
for i in range(n):
    for j in range(n):
        if not LE[i][j]:
            continue
        count_le_pairs += 1
        lam, mu = vectors[i], vectors[j]
        for c in scalars:
            assert c >= 0
            # 主張: λ ≤ μ、0 ≤ c ⟹ c·λ ≤ c·μ（決定手続きで判定）
            assert rational_log_order_le(qsmul(c, lam), qsmul(c, mu))
            count_claims += 1
            # 証明の鎖: u := num(c) ∈ N、v := den(c) ≥ 1、v·c = u
            u, v = ZZ(c.numerator()), ZZ(c.denominator())
            assert v >= 1 and v * c == u and u >= 0
            # 仮定を読む: 両方の共通分母 N := N_λ N_μ、証人 λ_N, μ_N、λ_N ≤_Λ μ_N
            N = N_all[i] * N_all[j]
            lam_N = zsmul(N_all[j], nu_all[i])
            mu_N = zsmul(N_all[i], nu_all[j])
            assert N >= 1
            assert is_common_denominator(N, lam, lam_N)
            assert is_common_denominator(N, mu, mu_N)
            assert log_order_le(lam_N, mu_N)
            # vN ≥ 1
            assert v * N >= 1
            # 六段: (vN)·(c·λ) = ((vN)c)·λ = ((vc)N)·λ = (uN)·λ = u·(N·λ) = u·ι(λ_N) = ι(uλ_N)
            for vec, vec_N in ((lam, lam_N), (mu, mu_N)):
                s0 = qsmul(v * N, qsmul(c, vec))
                s1 = qsmul((v * N) * c, vec)
                s2 = qsmul((v * c) * N, vec)
                s3 = qsmul(u * N, vec)
                s4 = qsmul(u, qsmul(N, vec))
                s5 = qsmul(u, iota(vec_N))
                s6 = iota(zsmul(u, vec_N))
                assert s0 == s1 == s2 == s3 == s4 == s5 == s6
                assert is_common_denominator(v * N, qsmul(c, vec), zsmul(u, vec_N))
            # 証人の順序: u ≥ 1 なら正整数倍不変性、u = 0 なら両辺 0 と反射律
            if u >= 1:
                assert log_order_le(zsmul(u, lam_N), zsmul(u, mu_N)) == log_order_le(lam_N, mu_N)
            else:
                assert zsmul(u, lam_N) == {} and zsmul(u, mu_N) == {}
            assert log_order_le(zsmul(u, lam_N), zsmul(u, mu_N))
            # 定義: この vN の証人の比較が c·λ ≤ c·μ を与え、決定手続きと一致する
            assert log_order_le(zsmul(u, lam_N), zsmul(u, mu_N)) == rational_log_order_le(qsmul(c, lam), qsmul(c, mu))
            count_chain += 1

print("PASS: rational-log-order-group-nonneg-scalar-monotone (%d vectors, %d pairs with le, %d scalars, %d claim checks, %d chain cases, primes %s)"
      % (n, count_le_pairs, len(scalars), count_claims, count_chain, primes))
