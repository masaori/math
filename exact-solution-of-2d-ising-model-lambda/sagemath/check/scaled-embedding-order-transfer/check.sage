# 対象ラベル: claim_scaled_embedding_order_transfer
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
coefficients = [ZZ(c) for c in [-1, 0, 1, 2]]
vectors = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]
n = len(vectors)
Ls = [ZZ(1), ZZ(2), ZZ(3)]

count_pairs = 0
count_common_denominator = 0
count_chain = 0
count_iff = 0
for L in Ls:
    N = L ** 2
    assert N >= 1
    r = QQ(1) / QQ(N)
    scaled = [qsmul(r, iota(lam)) for lam in vectors]
    for i in range(n):
        lam = vectors[i]
        s = scaled[i]
        # 準備の三段の鎖: L^2·((1/L^2)·ι(λ)) = (L^2·(1/L^2))·ι(λ) = 1·ι(λ) = ι(λ)
        step1 = qsmul(N, s)
        step2 = qsmul(QQ(N) * r, iota(lam))
        assert step1 == step2                      # 有理数倍の結合則
        assert QQ(N) * r == QQ(1)                  # Q の約分
        step3 = qsmul(QQ(1), iota(lam))
        assert step2 == step3
        assert step3 == iota(lam)                  # 1·λ = λ
        count_chain += 1
        # N=L^2 は (1/L^2)·ι(λ) の共通分母で証人は λ
        assert is_common_denominator(N, s, lam)
        assert witness_at(N, s) == lam             # 証人の一意性
        count_common_denominator += 1
    for i in range(n):
        for j in range(n):
            lam, mu = vectors[i], vectors[j]
            lhs = rational_log_order_le(scaled[i], scaled[j])   # 決定手続きで ≤_{Λ_Q}
            rhs = log_order_le(lam, mu)                          # ≤_Λ
            # 主張: (1/L^2)·ι(λ) ≤_{Λ_Q} (1/L^2)·ι(μ) ⟺ λ ≤_Λ μ
            assert lhs == rhs
            count_iff += 1
            # N=L^2 における証人の比較（∀ 形の言い換え）が判定と一致
            assert log_order_le(witness_at(N, scaled[i]), witness_at(N, scaled[j])) == lhs
            count_pairs += 1

print("PASS: L 値", len(Ls), "本、ベクトル", n, "本、鎖の検査", count_chain,
      "件、共通分母の検査", count_common_denominator, "件、同値の検査", count_iff,
      "件、証人の比較の一致", count_pairs, "件")
