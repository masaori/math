# 対象ラベル: claim_open_square_density_difference_bound_core_nonneg_le_one
#
# 帰属: QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
# 分配関数は要らない（主張は Λ_Q の元 Γ(q) の符号だけで、密度には触れない）ので、
# 正の有理数 q ≤ 1 の 7 点で証明の各段を検査し、あわせて q > 1 の 2 点では
# 仮定 q ≤ 1 が落ちると第一の符号 ι(log q) ≤ 0 が成り立たないことを記録する（否定側）。
#
# 検査すること（claim_open_square_density_difference_bound_core_nonneg_le_one の証明の中身）:
#   核 Γ(q) := (X + (−Y)) + 2·C（def_open_square_density_difference_bound_core）、
#     X := 2·ι(ℓ_2) + 4·ι(log(1+q))、Y := 4·ι(log q)、C := ι(ℓ_2) + 2·ι(log(1+q))。
#   準備の第一: ι(log q) ≤ 0（q ≤ 1）、0 ≤ ι(ℓ_2)、0 ≤ ι(log(1+q))（claim_rational_embedded_log_order_iff）。
#   準備の第二: 0 = 2·0 ≤ 2·ι(ℓ_2)、0 = 4·0 ≤ 4·ι(log(1+q)) = 0 + 4·ι(log(1+q)) ≤ 2·ι(ℓ_2) + 4·ι(log(1+q)) = X。
#   準備の第三: Y = 4·ι(log q) ≤ 4·0 = 0、0 = −0 ≤ −Y。
#   準備の第四: 0 ≤ C（既出の一続き）、0 = 2·0 ≤ 2·C。
#   本体: 0 = 0+0 ≤ X+0 = 0+X ≤ (−Y)+X = X+(−Y) = 0+(X+(−Y)) ≤ 2·C+(X+(−Y)) = (X+(−Y))+2·C = Γ(q)。
#   Λ_Q の順序は def_rational_log_order_group_order の判定どおり、共通分母の証人の Λ の比較（rat_Λ の比較）で見る。
#   等号は def_rational_log_order_group の判定どおり、台の各素数の QQ の値の一致で見る。


def log_lambda(q):
    # 正の有理数の対数（def_rational_log）: 素因数分解の指数ベクトル（Λ の有限台辞書）
    assert q > 0
    return {ZZ(p): ZZ(e) for p, e in QQ(q).factor() if e != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}: 各素数の整数値を分母 1 の有理数として読む
    return {p: QQ(z) / QQ(1) for p, z in lam.items()}


def lamq_add(lam_q, mu_q):
    # Λ_Q の加法（def_rational_log_order_group。素数ごとの QQ の加法）
    out = dict(lam_q)
    for p, r in mu_q.items():
        out[p] = out.get(p, QQ(0)) + r
    return {p: r for p, r in out.items() if r != 0}


def lamq_neg(lam_q):
    # Λ_Q の逆元（def_rational_log_order_group。素数ごとの QQ の符号反転）
    return {p: -v for p, v in lam_q.items()}


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group。素数ごとの QQ の積）
    return {p: QQ(r) * v for p, v in lam_q.items() if QQ(r) * v != 0}


def lamq_eq(lam_q, mu_q):
    # Λ_Q の等号の判定（def_rational_log_order_group。台の各素数で QQ の値を比べる）
    primes = set(lam_q.keys()) | set(mu_q.keys())
    return all(lam_q.get(p, QQ(0)) == mu_q.get(p, QQ(0)) for p in primes)


def rat_of_log(lam):
    # rat_Λ（def_rational_of_log）
    r = QQ(1)
    for p, e in lam.items():
        r *= QQ(p) ** ZZ(e)
    return r


def log_order_le(lam, mu):
    # λ ≤_Λ μ :⟺ rat_Λ(λ) ≤ rat_Λ(μ)（def_log_order_group_order）
    return rat_of_log(lam) <= rat_of_log(mu)


def common_denominator(lam_q):
    # 各素数での値の分母の最小公倍数（def_common_denominator の意味で共通分母である）
    N = ZZ(1)
    for v in lam_q.values():
        N = lcm(N, v.denominator())
    return ZZ(N)


def witness_of_common_denominator(lam_q, N):
    # def_common_denominator の一意な証人 λ_N ∈ Λ（N·λ = ι(λ_N)）
    nu = {}
    for p, v in lam_q.items():
        val = ZZ(N * v)
        assert QQ(val) == N * v
        if val != 0:
            nu[p] = val
    return nu


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き（両方の共通分母 N での証人の Λ の比較）
    N = lcm(common_denominator(lam_q), common_denominator(mu_q))
    return log_order_le(witness_of_common_denominator(lam_q, N),
                        witness_of_common_denominator(mu_q, N))


ZERO = {}   # Λ_Q の零写像


def check_core_nonneg(q):
    assert 0 < q <= 1
    checks = 0
    ell2 = iota(log_lambda(QQ(2)))             # ι(ℓ_2)
    log_1q = iota(log_lambda(QQ(1) + q))       # ι(log(1+q))
    log_q = iota(log_lambda(q))                # ι(log q)

    X = lamq_add(qsmul(QQ(2), ell2), qsmul(QQ(4), log_1q))   # X := 2·ι(ℓ_2) + 4·ι(log(1+q))
    Y = qsmul(QQ(4), log_q)                                   # Y := 4·ι(log q)
    C = lamq_add(ell2, qsmul(QQ(2), log_1q))                  # C := ι(ℓ_2) + 2·ι(log(1+q))
    Gamma = lamq_add(lamq_add(X, lamq_neg(Y)), qsmul(QQ(2), C))   # Γ(q) := (X + (−Y)) + 2·C（定義）

    # 準備の第一: 符号を三つ（claim_rational_embedded_log_order_iff。log 1 = 0、ι(0) = 0、log 2 = ℓ_2）
    assert lamq_eq(iota(log_lambda(QQ(1))), ZERO)            # log 1 = 0、ι(0) = 0
    assert rational_log_order_le(log_q, ZERO)                # ι(log q) ≤ 0（q ≤ 1）
    assert rational_log_order_le(ZERO, ell2)                 # 0 ≤ ι(ℓ_2)（1 ≤ 2）
    assert rational_log_order_le(ZERO, log_1q)               # 0 ≤ ι(log(1+q))（1 ≤ 1+q）
    checks += 4

    # 準備の第二: 0 ≤ X
    a0 = qsmul(QQ(2), ZERO)                                  # 2·0
    assert lamq_eq(ZERO, a0)                                 # 0 = 2·0（有理数倍）
    a1 = qsmul(QQ(2), ell2)
    assert rational_log_order_le(a0, a1)                     # 2·0 ≤ 2·ι(ℓ_2)（非負有理数倍の順序保存）
    b0 = qsmul(QQ(4), ZERO)
    assert lamq_eq(ZERO, b0)                                 # 0 = 4·0
    b1 = qsmul(QQ(4), log_1q)
    assert rational_log_order_le(b0, b1)                     # 4·0 ≤ 4·ι(log(1+q))
    b2 = lamq_add(ZERO, b1)
    assert lamq_eq(b1, b2)                                   # = 0 + 4·ι(log(1+q))（単位元）
    b3 = lamq_add(a1, b1)
    assert rational_log_order_le(b2, b3)                     # ≤ 2·ι(ℓ_2) + 4·ι(log(1+q))（加法単調性、0 ≤ 2·ι(ℓ_2)）
    assert lamq_eq(b3, X)                                    # = X
    assert rational_log_order_le(ZERO, X)                    # 準備の第二の結論（推移律）
    checks += 8

    # 準備の第三: Y ≤ 0、0 = −0 ≤ −Y
    c0 = qsmul(QQ(4), log_q)
    assert lamq_eq(Y, c0)                                    # Y = 4·ι(log q)（置き方）
    c1 = qsmul(QQ(4), ZERO)
    assert rational_log_order_le(c0, c1)                     # ≤ 4·0（非負有理数倍の順序保存、ι(log q) ≤ 0）
    assert lamq_eq(c1, ZERO)                                 # = 0（有理数倍）
    assert rational_log_order_le(Y, ZERO)                    # Y ≤ 0（推移律）
    d0 = lamq_neg(ZERO)
    assert lamq_eq(ZERO, d0)                                 # 0 = −0（逆元。各素数で −0 = 0）
    assert rational_log_order_le(d0, lamq_neg(Y))            # −0 ≤ −Y（逆元の順序反転）
    assert rational_log_order_le(ZERO, lamq_neg(Y))          # 準備の第三の結論
    checks += 7

    # 準備の第四: 0 ≤ C（既出の一続き）、0 = 2·0 ≤ 2·C
    e0 = qsmul(QQ(2), ZERO)
    e1 = qsmul(QQ(2), log_1q)
    e2 = lamq_add(ZERO, e1)
    e3 = lamq_add(ell2, e1)
    assert lamq_eq(ZERO, e0) and rational_log_order_le(e0, e1) and lamq_eq(e1, e2)
    assert rational_log_order_le(e2, e3) and lamq_eq(e3, C)
    assert rational_log_order_le(ZERO, C)                    # 0 ≤ C
    f0 = qsmul(QQ(2), ZERO)
    assert lamq_eq(ZERO, f0)                                 # 0 = 2·0
    f1 = qsmul(QQ(2), C)
    assert rational_log_order_le(f0, f1)                     # 2·0 ≤ 2·C
    assert rational_log_order_le(ZERO, f1)                   # 準備の第四の結論
    checks += 9

    # 本体
    m0 = lamq_add(ZERO, ZERO)
    assert lamq_eq(ZERO, m0)                                 # 0 = 0 + 0（単位元）
    m1 = lamq_add(X, ZERO)
    assert rational_log_order_le(m0, m1)                     # ≤ X + 0（加法単調性、0 ≤ X）
    m2 = lamq_add(ZERO, X)
    assert lamq_eq(m1, m2)                                   # = 0 + X（交換則）
    m3 = lamq_add(lamq_neg(Y), X)
    assert rational_log_order_le(m2, m3)                     # ≤ (−Y) + X（加法単調性、0 ≤ −Y）
    m4 = lamq_add(X, lamq_neg(Y))
    assert lamq_eq(m3, m4)                                   # = X + (−Y)（交換則）
    m5 = lamq_add(ZERO, m4)
    assert lamq_eq(m4, m5)                                   # = 0 + (X + (−Y))（単位元）
    m6 = lamq_add(qsmul(QQ(2), C), m4)
    assert rational_log_order_le(m5, m6)                     # ≤ 2·C + (X + (−Y))（加法単調性、0 ≤ 2·C）
    m7 = lamq_add(m4, qsmul(QQ(2), C))
    assert lamq_eq(m6, m7)                                   # = (X + (−Y)) + 2·C（交換則）
    assert lamq_eq(m7, Gamma)                                # = Γ(q)（核の定義）
    assert rational_log_order_le(ZERO, Gamma)                # 主張そのもの（推移律）
    checks += 10
    return checks


def check_first_sign_fails_above_one(q):
    # 否定側の記録: q > 1 では第一の符号 ι(log q) ≤ 0 が成り立たない（仮定 q ≤ 1 が要ることの確認）
    assert q > 1
    log_q = iota(log_lambda(q))
    assert not rational_log_order_le(log_q, ZERO)
    return 1


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1), QQ(5) / 7)
total = 0
for q in test_points:
    total += check_core_nonneg(q)
for q in (QQ(3) / 2, QQ(7) / 4):
    total += check_first_sign_fails_above_one(q)

print(f"核は非負である（QQ と素因数分解で厳密）: {total} 検査 OK")
