# 対象ラベル: def_rational_log_order_group_order
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


def witnesses(lam_q, max_N):
    # λ の共通分母 N ≤ max_N とその一意な証人 λ_N
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
MAX_N = 24

W_all = {i: witnesses(lam, MAX_N) for i, lam in enumerate(vectors)}
N_all = [denominator_product(lam) for lam in vectors]
nu_all = [witness_of_denominator_product(lam) for lam in vectors]

count_pairs = 0
count_common = 0
count_le = 0
for i, lam in enumerate(vectors):
    for j, mu in enumerate(vectors):
        # 両方の共通分母（N ≤ MAX_N）を列挙する
        common = sorted(set(W_all[i]) & set(W_all[j]))
        assert len(common) >= 1
        # 定義（ある N）と言い換え（すべての N）の一致
        exists_form = any(log_order_le(W_all[i][N], W_all[j][N]) for N in common)
        forall_form = all(log_order_le(W_all[i][N], W_all[j][N]) for N in common)
        assert exists_form == forall_form
        # 決定手続き: N_λN_μ の証人は N_μ λ_{N_λ}, N_λ μ_{N_μ}（claim_common_denominator_multiple）
        M = N_all[i] * N_all[j]
        lam_M = zsmul(N_all[j], nu_all[i])
        mu_M = zsmul(N_all[i], nu_all[j])
        assert is_common_denominator(M, lam, lam_M)
        assert is_common_denominator(M, mu, mu_M)
        canonical = log_order_le(lam_M, mu_M)
        assert canonical == exists_form
        if M in common:
            assert W_all[i][M] == lam_M and W_all[j][M] == mu_M
        # 参考: 期待どおり、有理数の値ごとの比較ではなく rat_Λ の比較で決まっている
        count_pairs += 1
        count_common += len(common)
        if exists_form:
            count_le += 1

print("PASS: rational-log-order-group-order (%d vectors, %d pairs, %d common-denominator checks, %d pairs with le, primes %s)"
      % (len(vectors), count_pairs, count_common, count_le, primes))
