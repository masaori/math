# 対象ラベル: claim_open_square_density_difference_bound_is_core_over_base_side
#
# 帰属: QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
# 分配関数は要らない（主張は Λ_Q の有理数倍・加法・逆元の等式だけで、密度には触れない）ので、
# 基準辺 a ∈ {1,2,3,5} と正の有理数 q の 8 点（q ≤ 1 も q > 1 も含む。主張は q ≤ 1 を要しない）で検査する。
#
# 検査すること（claim_open_square_density_difference_bound_is_core_over_base_side の証明の中身）:
#   核 Γ(q) := (X + (−Y)) + 2·C（def_open_square_density_difference_bound_core）、
#     X := 2·ι(ℓ_2) + 4·ι(log(1+q))、Y := 4·ι(log q)、C := ι(ℓ_2) + 2·ι(log(1+q))。
#   準備の第一: r·(−λ) = −(r·λ) を素数ごとに五段で（有理数倍の定義・逆元の定義・QQ の四則 r(−u) = −(ru)・
#     有理数倍の定義・逆元の定義）。r := 1/a、λ := Y で読む。
#   準備の第二: (1/a)·X = (2/a)·ι(ℓ_2) + (4/a)·ι(log(1+q))（分配則・結合則・QQ の四則）。
#   準備の第三: (1/a)·(−Y) = −((4/a)·ι(log q))（第一・結合則・QQ の四則）。
#   準備の第四: (1/a)·(2·C) = (2/a)·C（結合則・QQ の四則）。
#   本体: (1/a)·Γ(q) を分配則で三つの項へ配り、第二・第三・第四で読み替えて主張の右辺
#     R := ((2/a)·ι(ℓ_2) + (4/a)·ι(log(1+q))) + (−((4/a)·ι(log q))) + (2/a)·C
#     （claim_open_square_large_sides_density_difference_upper_le_one の右辺）に一致すること。
#   Λ_Q の等号は def_rational_log_order_group の判定どおり、台の各素数の QQ の値の一致で見る。


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


def check_core_over_base_side(a, q):
    assert a >= 1 and q > 0
    checks = 0
    r = QQ(1) / QQ(a)                          # 1/a
    ell2 = iota(log_lambda(QQ(2)))             # ι(ℓ_2)
    log_1q = iota(log_lambda(QQ(1) + q))       # ι(log(1+q))
    log_q = iota(log_lambda(q))                # ι(log q)

    X = lamq_add(qsmul(QQ(2), ell2), qsmul(QQ(4), log_1q))   # X := 2·ι(ℓ_2) + 4·ι(log(1+q))
    Y = qsmul(QQ(4), log_q)                                   # Y := 4·ι(log q)
    C = lamq_add(ell2, qsmul(QQ(2), log_1q))                  # C := ι(ℓ_2) + 2·ι(log(1+q))
    Gamma = lamq_add(lamq_add(X, lamq_neg(Y)), qsmul(QQ(2), C))   # Γ(q) := (X + (−Y)) + 2·C（定義）

    # 主張の右辺 R（差の上からの評価の右辺と同じ形）
    U = lamq_add(qsmul(QQ(2) / QQ(a), ell2), qsmul(QQ(4) / QQ(a), log_1q))
    D = qsmul(QQ(4) / QQ(a), log_q)
    R = lamq_add(lamq_add(U, lamq_neg(D)), qsmul(QQ(2) / QQ(a), C))

    # 準備の第一: r·(−λ) = −(r·λ) を素数ごとに五段で（r := 1/a、λ := Y）
    lhs1 = qsmul(r, lamq_neg(Y))
    rhs1 = lamq_neg(qsmul(r, Y))
    for p in set(Y.keys()) | set(lhs1.keys()) | set(rhs1.keys()):
        u = Y.get(p, QQ(0))
        s0 = lhs1.get(p, QQ(0))
        s1 = r * lamq_neg(Y).get(p, QQ(0))       # 有理数倍の定義
        s2 = r * (-u)                            # 逆元の定義
        s3 = -(r * u)                            # QQ の四則 r(−u) = −(ru)
        s4 = -(qsmul(r, Y).get(p, QQ(0)))        # 有理数倍の定義
        s5 = rhs1.get(p, QQ(0))                  # 逆元の定義
        assert s0 == s1 == s2 == s3 == s4 == s5
        checks += 1
    assert lamq_eq(lhs1, rhs1)                   # 準備の第一の結論
    checks += 1

    # 準備の第二: (1/a)·X = (2/a)·ι(ℓ_2) + (4/a)·ι(log(1+q))
    t2a = qsmul(r, X)
    t2b = lamq_add(qsmul(r, qsmul(QQ(2), ell2)), qsmul(r, qsmul(QQ(4), log_1q)))     # 分配則
    t2c = lamq_add(qsmul(r * QQ(2), ell2), qsmul(r * QQ(4), log_1q))                 # 結合則（右から左へ、二箇所同時）
    t2d = lamq_add(qsmul(QQ(2) / QQ(a), ell2), qsmul(QQ(4) / QQ(a), log_1q))         # QQ の四則
    assert lamq_eq(t2a, t2b) and lamq_eq(t2b, t2c) and lamq_eq(t2c, t2d) and lamq_eq(t2d, U)
    checks += 4

    # 準備の第三: (1/a)·(−Y) = −((4/a)·ι(log q))
    t3a = qsmul(r, lamq_neg(Y))
    t3b = lamq_neg(qsmul(r, Y))                                  # 準備の第一
    t3c = lamq_neg(qsmul(r, qsmul(QQ(4), log_q)))                # Y の置き方
    t3d = lamq_neg(qsmul(r * QQ(4), log_q))                      # 結合則（右から左へ）
    t3e = lamq_neg(qsmul(QQ(4) / QQ(a), log_q))                  # QQ の四則
    assert lamq_eq(t3a, t3b) and lamq_eq(t3b, t3c) and lamq_eq(t3c, t3d) and lamq_eq(t3d, t3e) and lamq_eq(t3e, lamq_neg(D))
    checks += 5

    # 準備の第四: (1/a)·(2·C) = (2/a)·C
    t4a = qsmul(r, qsmul(QQ(2), C))
    t4b = qsmul(r * QQ(2), C)                                    # 結合則（右から左へ）
    t4c = qsmul(QQ(2) / QQ(a), C)                                # QQ の四則
    assert lamq_eq(t4a, t4b) and lamq_eq(t4b, t4c)
    checks += 2

    # 本体
    m0 = qsmul(r, Gamma)
    m1 = qsmul(r, lamq_add(lamq_add(X, lamq_neg(Y)), qsmul(QQ(2), C)))            # 定義と置き方
    m2 = lamq_add(qsmul(r, lamq_add(X, lamq_neg(Y))), qsmul(r, qsmul(QQ(2), C)))  # 分配則
    m3 = lamq_add(lamq_add(qsmul(r, X), qsmul(r, lamq_neg(Y))), qsmul(r, qsmul(QQ(2), C)))   # 分配則
    m4 = lamq_add(lamq_add(t2d, qsmul(r, lamq_neg(Y))), qsmul(r, qsmul(QQ(2), C)))          # 準備の第二
    m5 = lamq_add(lamq_add(t2d, t3e), qsmul(r, qsmul(QQ(2), C)))                              # 準備の第三
    m6 = lamq_add(lamq_add(t2d, t3e), t4c)                                                     # 準備の第四と C の置き方
    for s, t in ((m0, m1), (m1, m2), (m2, m3), (m3, m4), (m4, m5), (m5, m6)):
        assert lamq_eq(s, t)
        checks += 1
    assert lamq_eq(m6, R)                                                                      # 主張の右辺
    assert lamq_eq(qsmul(r, Gamma), R)                                                         # 主張そのもの
    checks += 2
    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1), QQ(3) / 2, QQ(7) / 4)
total = 0
for a in (1, 2, 3, 5):
    for q in test_points:
        total += check_core_over_base_side(a, q)

print(f"差の一様な評価に現れる量は核の基準辺分の一倍である（QQ と素因数分解で厳密）: {total} 検査 OK")
