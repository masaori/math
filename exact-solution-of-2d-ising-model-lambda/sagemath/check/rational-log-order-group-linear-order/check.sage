# 対象ラベル: claim_rational_log_order_group_linear_order
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


primes = [2, 3, 5]
coefficients = [QQ(c) for c in ["-1", "-1/2", "0", "1/3", "1/2", "5/4"]]
vectors = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]
n = len(vectors)
LE = [[rational_log_order_le(vectors[i], vectors[j]) for j in range(n)] for i in range(n)]
N_all = [denominator_product(lam) for lam in vectors]
nu_all = [witness_of_denominator_product(lam) for lam in vectors]

# 反射律
for i in range(n):
    assert LE[i][i]

# 反対称律・全順序性（二元）と、同じ N の証人が一致すれば元も一致すること（N ≤ 24）
count_pairs = 0
count_witness_eq = 0
for i in range(n):
    for j in range(n):
        count_pairs += 1
        assert LE[i][j] or LE[j][i]                       # 全順序性
        if LE[i][j] and LE[j][i]:
            assert vectors[i] == vectors[j]               # 反対称律
        for N in range(1, 25):
            wi, wj = witness_at(N, vectors[i]), witness_at(N, vectors[j])
            if wi is not None and wj is not None and wi == wj:
                assert vectors[i] == vectors[j]           # 証人の一致 → 元の一致
                count_witness_eq += 1

# 推移律（三元）と、N_λ N_μ N_ν が三元すべての共通分母であること（証人は claim_common_denominator_multiple のとおり）
count_triples = 0
count_trans = 0
for i in range(n):
    for j in range(n):
        if not LE[i][j]:
            continue
        for k in range(n):
            count_triples += 1
            if LE[j][k]:
                assert LE[i][k]                           # 推移律
                count_trans += 1
# 三元の共通の共通分母（全組は多いので、値の異なる代表 12 本の全三つ組で確かめる）
reps = list(range(0, n, max(1, n // 12)))[:12]
count_three = 0
for i in reps:
    for j in reps:
        for k in reps:
            N = N_all[i] * N_all[j] * N_all[k]
            assert N >= 1
            assert is_common_denominator(N, vectors[i], zsmul(N_all[j] * N_all[k], nu_all[i]))
            assert is_common_denominator(N, vectors[j], zsmul(N_all[i] * N_all[k], nu_all[j]))
            assert is_common_denominator(N, vectors[k], zsmul(N_all[i] * N_all[j], nu_all[k]))
            # 定義の言い換え: この N の証人の比較が決定手続きと一致する
            wi, wj = witness_at(N, vectors[i]), witness_at(N, vectors[j])
            assert log_order_le(wi, wj) == LE[i][j]
            count_three += 1

print("PASS: rational-log-order-group-linear-order (%d vectors, %d pairs, %d witness-equality cases, %d triples with le, %d transitive cases, %d triple common denominators, primes %s)"
      % (n, count_pairs, count_witness_eq, count_triples, count_trans, count_three, primes))
