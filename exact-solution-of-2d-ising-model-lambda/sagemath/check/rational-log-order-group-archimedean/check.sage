# 対象ラベル: claim_rational_log_order_group_archimedean
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない
#       （主張は Λ_Q の加法・有理数倍・順序と Q の四則だけで書かれており、実数体は現れない）。
#
# 確かめること（μ, ε の標本の各組について、証明の各段をそのまま計算する）:
#   準備の第一: N := N_μ N_ε が μ・ε・0・n·ε の共通分母で、証人が μ_N, ε_N, 0, nε_N であること
#              （N·λ = ι(λ_N) を素数ごとの等号で確かめる）。
#   準備の第二: 0 ≤_Λ μ_N, 0 ≤_Λ ε_N、すなわち 1 ≤ rat_Λ(μ_N), 1 ≤ rat_Λ(ε_N)。
#   準備の第三: ε_N ≠ 0 かつ 1 < rat_Λ(ε_N)。h := rat_Λ(ε_N) − 1 > 0、A := rat_Λ(μ_N)、0 ≤ A − 1。
#   準備の第四: r := (A−1)/h ≥ 0、n := num(r) ∈ N、r ≤ n、A − 1 = r h ≤ n h（四段）。
#   本体:       rat_Λ(μ_N) = A = 1+(A−1) ≤ 1+nh ≤ (1+h)^n = rat_Λ(ε_N)^n = rat_Λ(nε_N)（五段）、
#              μ_N ≤_Λ nε_N、そして μ ≤_{Λ_Q} n·ε（決定手続き。共通分母は最小公倍数で取る）。
# 補助として、n の最小性は主張していないが、n = 0 では成り立たない組があること（μ ≠ 0 のとき）も見る。
# 有限標本の検査であり、普遍量化された主張の証明ではない。


def lamq_add(lam_q, mu_q):
    out = dict(lam_q)
    for p, z in mu_q.items():
        out[p] = out.get(p, QQ(0)) + z
    return {p: z for p, z in out.items() if z != 0}


def lamq_neg(lam_q):
    return {p: -z for p, z in lam_q.items()}


def lamq_sub(lam_q, mu_q):
    return lamq_add(lam_q, lamq_neg(mu_q))


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group）
    return {p: QQ(r) * z for p, z in lam_q.items() if QQ(r) * z != 0}


def zsmul(n, lam):
    # Λ の整数倍（def_log_order_group）
    return {p: ZZ(n) * z for p, z in lam.items() if ZZ(n) * z != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}
    return {p: QQ(z) for p, z in lam.items()}


def rat_of_log(lam):
    # rat_Λ(λ) = ∏ p^{λ(p)}（def_rational_of_log。空積は 1）
    r = QQ(1)
    for p, e in lam.items():
        r *= QQ(p) ** ZZ(e)
    return r


def log_order_le(lam, mu):
    # def_log_order_group_order
    return rat_of_log(lam) <= rat_of_log(mu)


def denominator_product(lam_q):
    # claim_common_denominator_exists の N_λ
    N = ZZ(1)
    for v in lam_q.values():
        N *= v.denominator()
    return N


def witness(N, lam_q):
    # N が λ の共通分母であることを確かめ、証人 λ_N を返す（N·λ = ι(λ_N)）
    scaled = qsmul(N, lam_q)
    assert all(v.denominator() == 1 for v in scaled.values())
    lam_N = {p: ZZ(v) for p, v in scaled.items()}
    assert iota(lam_N) == scaled
    return lam_N


def lcm_denominator(lam_q):
    N = ZZ(1)
    for v in lam_q.values():
        N = lcm(N, v.denominator())
    return N


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き（共通分母は最小公倍数で取る）
    N = lcm(lcm_denominator(lam_q), lcm_denominator(mu_q))
    return log_order_le(witness(N, lam_q), witness(N, mu_q))


ell = lambda p: {ZZ(p): QQ(1)}   # ι(ℓ_p)

mus = [
    {},                                                    # 0
    ell(2),                                                # ι(ℓ_2)
    qsmul(QQ(2), ell(2)),                                  # 2ι(ℓ_2)
    qsmul(QQ(1) / 2, ell(3)),                              # (1/2)ι(ℓ_3)
    lamq_sub(ell(2), qsmul(QQ(1) / 2, ell(3))),            # ι(ℓ_2)−(1/2)ι(ℓ_3)（2 > √3）
    qsmul(QQ(1) / 3, ell(5)),                              # (1/3)ι(ℓ_5)
    lamq_add(ell(3), qsmul(QQ(1) / 2, ell(2))),            # ι(ℓ_3)+(1/2)ι(ℓ_2)
]
epsilons = [
    ell(2),                                                # ι(ℓ_2)
    qsmul(QQ(1) / 2, ell(2)),                              # (1/2)ι(ℓ_2)
    qsmul(QQ(1) / 3, ell(2)),                              # (1/3)ι(ℓ_2)
    lamq_sub(ell(3), ell(2)),                              # ι(log(3/2))
    qsmul(QQ(1) / 2, lamq_sub(ell(5), qsmul(2, ell(2)))),  # (1/2)ι(log(5/4))
    lamq_sub(qsmul(QQ(3), ell(2)), qsmul(QQ(1) / 2, ell(7))),  # 3ι(ℓ_2)−(1/2)ι(ℓ_7)（8 > √7）
]

count = 0
n_max = ZZ(0)
N_LIMIT = 20000
skipped = []
for mu in mus:
    assert rational_log_order_le({}, mu)                    # 0 ≤ μ
    for eps in epsilons:
        assert rational_log_order_le({}, eps) and eps != {}   # 0 ≤ ε, ε ≠ 0
        # 準備の第一
        N = denominator_product(mu) * denominator_product(eps)
        assert N >= 1
        mu_N, eps_N = witness(N, mu), witness(N, eps)
        assert witness(N, {}) == {}                          # 0_N = 0
        # 準備の第二
        assert log_order_le({}, mu_N) and log_order_le({}, eps_N)
        assert rat_of_log({}) == 1
        A = rat_of_log(mu_N)
        assert 1 <= A and 1 <= rat_of_log(eps_N)
        # 準備の第三
        assert eps_N != {}
        assert not log_order_le(eps_N, {})
        assert 1 < rat_of_log(eps_N)
        h = rat_of_log(eps_N) - 1
        assert h > 0 and 0 <= A - 1
        # 準備の第四
        r = (A - 1) / h
        assert r >= 0
        n = r.numerator()
        assert n >= 0 and n in ZZ
        if n > N_LIMIT:
            # (1+h)^n と rat_Λ(nε_N) の分子・分母が桁あふれするので、この組は本体の冪の検査を外す
            # （n の値だけ記録する。準備の第一〜第四までは上で確かめた）
            skipped.append((mu, eps, n))
            continue
        n_max = max(n_max, n)
        assert QQ(n) / r.denominator() <= n
        assert A - 1 == r * h                                # 一段目
        assert r * h == QQ(n) / r.denominator() * h          # 二段目
        assert QQ(n) / r.denominator() * h <= n * h          # 三段目
        # 本体（五段）
        assert rat_of_log(mu_N) == A
        assert A == 1 + (A - 1)
        assert 1 + (A - 1) <= 1 + n * h
        assert 1 + n * h <= (1 + h) ** n                     # claim_rational_bernoulli_inequality
        assert (1 + h) ** n == rat_of_log(eps_N) ** n
        assert rat_of_log(eps_N) ** n == rat_of_log(zsmul(n, eps_N))   # 正整数倍は冪へ
        assert log_order_le(mu_N, zsmul(n, eps_N))
        # N は n·ε の共通分母で証人は nε_N（五段の鎖の両端）
        assert qsmul(N, qsmul(n, eps)) == iota(zsmul(n, eps_N))
        assert witness(N, qsmul(n, eps)) == zsmul(n, eps_N)
        # 結論
        assert rational_log_order_le(mu, qsmul(n, eps))
        if mu != {}:
            assert not rational_log_order_le(mu, qsmul(0, eps))   # n = 0 では追い越せない
        count += 1

for mu, eps, n in skipped:
    print("  冪の検査を外した組（n が大きすぎる）: μ =", mu, " ε =", eps, " n =", n)
print("PASS: claim_rational_log_order_group_archimedean  ", count, "組  n の最大", n_max, " 外した組", len(skipped))
