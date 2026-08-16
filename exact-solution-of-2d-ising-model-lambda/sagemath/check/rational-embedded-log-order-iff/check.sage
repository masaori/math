# 対象ラベル: claim_rational_embedded_log_order_iff
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。浮動小数点は使わない。


def log_rat(q):
    # def_rational_log: log q ∈ Λ（分子・分母の素因数分解の指数の差）
    q = QQ(q)
    assert q > 0
    lam = {}
    for p, e in factor(q.numerator()):
        lam[p] = lam.get(p, 0) + ZZ(e)
    for p, e in factor(q.denominator()):
        lam[p] = lam.get(p, 0) - ZZ(e)
    return {p: z for p, z in lam.items() if z != 0}


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


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き
    # λ ≤_{Λ_Q} μ ⟺ N_μ λ_{N_λ} ≤_Λ N_λ μ_{N_μ}
    Nl, Nm = denominator_product(lam_q), denominator_product(mu_q)
    return log_order_le(zsmul(Nm, witness_of_denominator_product(lam_q)),
                        zsmul(Nl, witness_of_denominator_product(mu_q)))


# 標本: 正の有理数（1 を含む。1 より小さいもの・大きいもの・整数・非整数）
sample = [QQ(x) for x in ["1/12", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "9/10",
                          "1", "11/10", "6/5", "5/4", "4/3", "3/2", "5/3", "2", "9/4", "5/2",
                          "3", "10/3", "4", "5", "6", "15/2", "8", "9", "12", "16"]]

# 補助等式 log 1 = 0、ι(0) = 0
assert log_rat(1) == {}
assert iota({}) == {}
# 補助等式 log 2 = ℓ_2
assert log_rat(2) == {2: ZZ(1)}

count_iff = 0
count_chain = 0
one = QQ(1) / QQ(1) ** 2
assert one == QQ(1)                                        # 1/1^2 = 1（Q の四則）
for q in sample:
    for qp in sample:
        lq, lqp = log_rat(q), log_rat(qp)
        lhs = (q <= qp)
        # 一段目: q ≤ q' ⟺ log q ≤_Λ log q'（claim_rational_log_order_iff）
        step1 = log_order_le(lq, lqp)
        assert lhs == step1
        # 二段目: log q ≤_Λ log q' ⟺ (1/1^2)·ι(log q) ≤_{Λ_Q} (1/1^2)·ι(log q')（L := 1 の移送）
        step2 = rational_log_order_le(qsmul(one, iota(lq)), qsmul(one, iota(lqp)))
        assert step1 == step2
        # 三段目・四段目: 1·ι(λ) = ι(λ)
        assert qsmul(one, iota(lq)) == qsmul(QQ(1), iota(lq)) == iota(lq)
        assert qsmul(one, iota(lqp)) == qsmul(QQ(1), iota(lqp)) == iota(lqp)
        count_chain += 1
        # 主張: q ≤ q' ⟺ ι(log q) ≤_{Λ_Q} ι(log q')
        rhs = rational_log_order_le(iota(lq), iota(lqp))
        assert lhs == rhs
        count_iff += 1

# 後で引く三つの読み方（符号）
count_sign = 0
zero = {}
for q in sample:
    if q <= 1:
        assert rational_log_order_le(iota(log_rat(q)), zero)          # ι(log q) ≤ 0
        count_sign += 1
    assert rational_log_order_le(zero, iota(log_rat(1 + q)))          # 0 ≤ ι(log(1+q))
    count_sign += 1
assert rational_log_order_le(zero, iota({2: ZZ(1)}))                  # 0 ≤ ι(ℓ_2)
count_sign += 1

print("PASS: 標本", len(sample), "点、同値の検査", count_iff, "件、鎖の検査", count_chain,
      "件、符号の読み方の検査", count_sign, "件")
