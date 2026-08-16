# 対象ラベル: def_rational_log_order_group_sequence_lower_set, claim_rational_log_order_group_sequence_lower_set_downward_closed
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


# ---- 列と下組 ----
# 列 λ_L := ι(ℓ_2) + (1/L)·ι(ℓ_3)（L ≥ 1）。Λ_Q の元の列。ι(ℓ_2) へ上から近づく（極限は Λ_Q の中にあるが、
# 下組の定義は極限を参照しない）。
def seq(L):
    return qadd({2: QQ(1)}, qsmul(QQ(1) / L, {3: QQ(1)}))


L_MAX = 40  # 「N ≤ L を満たすすべての L」は有限範囲 N..L_MAX で検査する（全称そのものは証明で示す）


def in_lower_set_with_witness(mu, eps, N):
    # def_rational_log_order_group_sequence_lower_set の所属を、証人 (ε, N) について検査する
    assert rational_log_order_le(zero, eps) and eps != zero and N >= 1
    return all(rational_log_order_le(qadd(mu, eps), seq(L)) for L in range(N, L_MAX + 1))


primes = [2, 3, 5]
coefficients = [QQ(c) for c in ["-1", "-1/2", "0", "1/3", "3/4"]]
vectors = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]
zero = {}

# 所属の証人が実際にある μ の例: μ := ι(ℓ_2) + (−(1/2)·ι(ℓ_3))、ε := (1/2)·ι(ℓ_3)、N := 1
#   μ + ε = ι(ℓ_2) ≤ ι(ℓ_2) + (1/L)·ι(ℓ_3) = λ_L（L ≥ 1）
mu_in = qadd({2: QQ(1)}, qneg(qsmul(QQ(1) / 2, {3: QQ(1)})))
eps_in = qsmul(QQ(1) / 2, {3: QQ(1)})
N_in = 1
assert in_lower_set_with_witness(mu_in, eps_in, N_in)

# 所属しない例（どの ε, N でも μ + ε ≤ λ_L は成り立たない: μ = ι(ℓ_2)+ι(ℓ_3) > λ_L）: 証人候補を有限個試す
mu_out = qadd({2: QQ(1)}, {3: QQ(1)})
count_out = 0
for eps in vectors:
    if not (rational_log_order_le(zero, eps) and eps != zero):
        continue
    for N in range(1, 6):
        assert not in_lower_set_with_witness(mu_out, eps, N)
        count_out += 1

# 主張: μ ∈ A, μ' ≤ μ ⟹ μ' ∈ A（同じ証人 ε, N で）。証明の二段も検査する
count_le = 0
count_not_le = 0
for mu_p in vectors:
    if not rational_log_order_le(mu_p, mu_in):
        count_not_le += 1
        continue
    count_le += 1
    for L in range(N_in, L_MAX + 1):
        # 一段目: μ' + ε ≤ μ + ε（claim_rational_log_order_group_add_monotone）
        assert rational_log_order_le(qadd(mu_p, eps_in), qadd(mu_in, eps_in))
        # 二段目: μ + ε ≤ λ_L（証人の性質）
        assert rational_log_order_le(qadd(mu_in, eps_in), seq(L))
        # 推移律の結論
        assert rational_log_order_le(qadd(mu_p, eps_in), seq(L))
    # 主張そのもの（同じ証人で所属）
    assert in_lower_set_with_witness(mu_p, eps_in, N_in)

print("PASS: rational-log-order-group-sequence-lower-set (%d vectors, %d with mu' <= mu, %d without, %d non-membership witness candidates, L up to %d)"
      % (len(vectors), count_le, count_not_le, count_out, L_MAX))
