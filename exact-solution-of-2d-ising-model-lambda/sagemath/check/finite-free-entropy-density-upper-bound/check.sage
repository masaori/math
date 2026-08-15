# 対象ラベル: claim_finite_free_entropy_density_upper_bound
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 検査すること（claim_finite_free_entropy_density_upper_bound の証明の中身）:
#   準備の第一: Z_L(q) ∈ QQ_{>0}、Z_L(q) ≤ 2^{L²}(1+q)^{2L²}。
#   準備の第二: log 2 = ℓ_2（各素数での四段の鎖）。
#   準備の第三: n·ι(ν) = ι(nν)（n = L², 2L²、ν = ℓ_2, log(1+q)）。
#   Λ の鎖: Φ_L(q) = log Z_L(q) ≤_Λ log(2^{L²}(1+q)^{2L²}) = log 2^{L²} + log (1+q)^{2L²}
#            = L² log 2 + 2L² log(1+q) = L² ℓ_2 + 2L² log(1+q)（≤_Λ は rat_Λ を通した QQ の比較）。
#   Λ_Q の鎖: Ψ_L(q) = (1/L²)·ι(Φ_L(q)) ≤_{Λ_Q} (1/L²)·ι(L²ℓ_2 + 2L² log(1+q))
#            = (1/L²)·(ι(L²ℓ_2)+ι(2L² log(1+q))) = (1/L²)·ι(L²ℓ_2) + (1/L²)·ι(2L² log(1+q))
#            = (1/L²)·(L²·ι(ℓ_2)) + (1/L²)·(2L²·ι(log(1+q))) = ((1/L²)L²)·ι(ℓ_2) + ((1/L²)2L²)·ι(log(1+q))
#            = 1·ι(ℓ_2) + 2·ι(log(1+q)) = ι(ℓ_2) + 2·ι(log(1+q))
#     （≤_{Λ_Q} は def_rational_log_order_group_order の決定手続きで判定。
#       加えて、共通分母 N = L² での証人の比較とも一致することを見る = 順序の移送）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def log_lambda(q):
    # 正の有理数の対数（def_rational_log）: 素因数分解の指数ベクトル（Λ の元。値は ZZ、有限台辞書）
    assert q > 0
    return {ZZ(p): ZZ(e) for p, e in QQ(q).factor() if e != 0}


def v_p(p, n):
    # def_prime_exponent: 1 以上の整数 n の素数 p の指数
    assert n >= 1
    return ZZ(ZZ(n).valuation(p))


def lam_add(lam, mu):
    out = dict(lam)
    for p, z in mu.items():
        out[p] = out.get(p, 0) + z
    return {p: z for p, z in out.items() if z != 0}


def lamq_add(lam_q, mu_q):
    out = dict(lam_q)
    for p, a in mu_q.items():
        out[p] = out.get(p, QQ(0)) + a
    return {p: a for p, a in out.items() if a != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}: 各素数の整数値を分母 1 の有理数として読む
    return {p: QQ(z) / QQ(1) for p, z in lam.items()}


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group）
    return {p: QQ(r) * a for p, a in lam_q.items() if QQ(r) * a != 0}


def zsmul(n, lam):
    # Λ の整数倍（def_log_order_group）
    return {p: ZZ(n) * z for p, z in lam.items() if n * z != 0}


def rat_of_log(lam):
    r = QQ(1)
    for p, e in lam.items():
        r *= QQ(p) ** ZZ(e)
    return r


def log_order_le(lam, mu):
    # λ ≤_Λ μ :⟺ rat_Λ(λ) ≤ rat_Λ(μ)（def_log_order_group_order）
    return rat_of_log(lam) <= rat_of_log(mu)


def denominator_product(lam_q):
    N = ZZ(1)
    for v in lam_q.values():
        N *= v.denominator()
    return N


def witness_of_denominator_product(lam_q):
    N = denominator_product(lam_q)
    nu = {}
    for p, v in lam_q.items():
        val = ZZ(N // v.denominator()) * ZZ(v.numerator())
        if val != 0:
            nu[p] = val
    return nu


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き
    Nl, Nm = denominator_product(lam_q), denominator_product(mu_q)
    return log_order_le(zsmul(Nm, witness_of_denominator_product(lam_q)),
                        zsmul(Nl, witness_of_denominator_product(mu_q)))


L_RANGE = [1, 2, 3]
Q_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5), QQ(11)]

ell_2 = {ZZ(2): ZZ(1)}   # 生成元 ℓ_2

count = 0
# 準備の第二: log 2 = ℓ_2（各素数での四段の鎖）
log2 = log_lambda(QQ(2))
assert log2 == ell_2
for p in [ZZ(2), ZZ(3), ZZ(5), ZZ(7), ZZ(11), ZZ(353)]:
    step1 = log2.get(p, ZZ(0))                 # (log 2)(p) = w_p(2)
    step2 = v_p(p, 2) - v_p(p, 1)              # = v_p(2) - v_p(1)
    step3 = v_p(p, 2)                          # v_p(1) = 0
    step4 = ell_2.get(p, ZZ(0))                # = ℓ_2(p)
    assert step1 == step2 == step3 == step4
    count += 1

for L in L_RANGE:
    inv = QQ(1) / QQ(L * L)
    Z = partition_polynomial(L)
    for q in Q_SAMPLES:
        # 準備の第一
        value = QQ(Z(x=q))
        bound = QQ(2) ** (L * L) * (1 + q) ** (2 * L * L)
        assert value in QQ and value > 0 and bound > 0
        assert value <= bound
        count += 1
        # 準備の第三
        lg = log_lambda(1 + q)
        for n, nu in [(L * L, ell_2), (2 * L * L, lg)]:
            assert qsmul(n, iota(nu)) == iota(zsmul(n, nu))
            count += 1
        # Λ の鎖
        phi = log_lambda(value)                                                # Φ_L(q) = log Z_L(q)
        assert log_order_le(phi, log_lambda(bound))                            # ≤_Λ log(2^{L²}(1+q)^{2L²})
        assert log_lambda(bound) == lam_add(log_lambda(QQ(2) ** (L * L)), log_lambda((1 + q) ** (2 * L * L)))  # 加法性
        assert log_lambda(QQ(2) ** (L * L)) == zsmul(L * L, log2)              # 冪
        assert log_lambda((1 + q) ** (2 * L * L)) == zsmul(2 * L * L, lg)      # 冪
        top = lam_add(zsmul(L * L, ell_2), zsmul(2 * L * L, lg))               # L² ℓ_2 + 2L² log(1+q)
        assert lam_add(zsmul(L * L, log2), zsmul(2 * L * L, lg)) == top        # log 2 = ℓ_2
        assert log_order_le(phi, top)
        count += 1
        # Λ_Q の鎖
        psi = qsmul(inv, iota(phi))                                            # Ψ_L(q)
        s1 = qsmul(inv, iota(top))
        assert rational_log_order_le(psi, s1)                                  # 順序の移送（決定手続き）
        assert qsmul(L * L, psi) == iota(phi) and qsmul(L * L, s1) == iota(top)  # N = L² は共通分母、証人は Φ_L(q)、top
        assert log_order_le(phi, top) == rational_log_order_le(psi, s1)         # 証人の比較と一致
        s2 = qsmul(inv, lamq_add(iota(zsmul(L * L, ell_2)), iota(zsmul(2 * L * L, lg))))   # ι は加法を保つ
        assert s1 == s2
        s3 = lamq_add(qsmul(inv, iota(zsmul(L * L, ell_2))), qsmul(inv, iota(zsmul(2 * L * L, lg))))  # 分配則
        assert s2 == s3
        s4 = lamq_add(qsmul(inv, qsmul(L * L, iota(ell_2))), qsmul(inv, qsmul(2 * L * L, iota(lg))))  # 準備の第三
        assert s3 == s4
        s5 = lamq_add(qsmul(inv * (L * L), iota(ell_2)), qsmul(inv * (2 * L * L), iota(lg)))          # 結合則
        assert s4 == s5
        assert inv * (L * L) == 1 and inv * (2 * L * L) == 2                                            # 約分
        s6 = lamq_add(qsmul(QQ(1), iota(ell_2)), qsmul(QQ(2), iota(lg)))
        assert s5 == s6
        rhs = lamq_add(iota(ell_2), qsmul(QQ(2), iota(lg)))                                            # 1·λ = λ
        assert s6 == rhs
        assert rational_log_order_le(psi, rhs)                                                          # 主張
        count += 1

print("PASS: finite-free-entropy-density-upper-bound (%d checks)" % count)
