# 対象ラベル: claim_common_denominator_multiple（あわせて claim_common_common_denominator_exists）
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


def is_common_denominator(N, lam_q, lam_N):
    # def_common_denominator: N·λ = ι(λ_N)
    return qsmul(N, lam_q) == iota(lam_N)


def denominator_product(lam_q):
    # claim_common_denominator_exists の N_λ := ∏_{p∈S_λ} den(λ(p))（空積は 1）
    N = ZZ(1)
    for v in lam_q.values():
        N *= v.denominator()
    return N


def witness_of_denominator_product(lam_q):
    # claim_common_denominator_exists の証人 ν(p) = (N_λ/den)·num
    N = denominator_product(lam_q)
    nu = {}
    for p, v in lam_q.items():
        val = ZZ(N // v.denominator()) * ZZ(v.numerator())
        if val != 0:
            nu[p] = val
    return nu


def witnesses(lam_q, max_N):
    # λ の共通分母 N ≤ max_N とその（一意な）証人 λ_N を列挙する
    out = {}
    for N in range(1, max_N + 1):
        scaled = qsmul(N, lam_q)
        if all(v.denominator() == 1 for v in scaled.values()):
            out[ZZ(N)] = {p: ZZ(v) for p, v in scaled.items()}
    return out


primes = [2, 3, 5]
coefficients = [QQ(c) for c in ["-3/2", "-1", "-1/2", "0", "1/3", "1/2", "1", "5/4"]]
vectors = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]
MAX_N = 12
MAX_K = 4

count_vectors = 0
count_multiple = 0
for lam in vectors:
    W = witnesses(lam, MAX_N)
    assert len(W) >= 1  # 係数の分母は 2,3,4 なので最小公倍数 12 以下に共通分母が在る
    for N, lam_N in W.items():
        assert is_common_denominator(N, lam, lam_N)
        for k in range(1, MAX_K + 1):
            kN = ZZ(k) * N
            k_lam_N = zsmul(k, lam_N)
            # 主張: kN は共通分母で、証人は k·λ_N
            assert is_common_denominator(kN, lam, k_lam_N)
            # 鎖の各段: (kN)·λ = k·(N·λ) = k·ι(λ_N) = ι(k·λ_N)
            step1 = qsmul(kN, lam)
            step2 = qsmul(k, qsmul(N, lam))
            step3 = qsmul(k, iota(lam_N))
            step4 = iota(k_lam_N)
            assert step1 == step2 == step3 == step4
            # 一意性: kN の証人が k·λ_N に限ること（kN ≤ MAX_N なら列挙とも一致）
            if kN in W:
                assert W[kN] == k_lam_N
            count_multiple += 1
    count_vectors += 1

# claim_common_common_denominator_exists: N_λ N_μ は λ と μ の両方の共通分母
count_pairs = 0
for lam in vectors:
    N_lam = denominator_product(lam)
    nu_lam = witness_of_denominator_product(lam)
    assert is_common_denominator(N_lam, lam, nu_lam)
    for mu in vectors:
        N_mu = denominator_product(mu)
        nu_mu = witness_of_denominator_product(mu)
        assert is_common_denominator(N_mu, mu, nu_mu)
        M = N_lam * N_mu
        assert M == N_mu * N_lam                                        # ℕ の積の可換性
        assert is_common_denominator(M, lam, zsmul(N_mu, nu_lam))       # k = N_μ, N = N_λ
        assert is_common_denominator(M, mu, zsmul(N_lam, nu_mu))        # k = N_λ, N = N_μ
        count_pairs += 1

print("PASS: common-denominator-multiple (%d vectors, %d (N,k) cases, %d pairs, primes %s)"
      % (count_vectors, count_multiple, count_pairs, primes))
