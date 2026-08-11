# 対象ラベル: claim_qbar_poly_monomial_decomposition
#            def_qbar_poly_evaluation
#
# 主張: 代数的数を係数とする 1 変数多項式環 Qbar[t] において、
#       k > n で ac_k(f) = 0 ならば f = Σ_{k=0}^{n} (ac_k(f))^ t^k である
#       （(a)^ は a を定数多項式として送ったもの）。
#       あわせて代入 aev_w の約束（和と積を保つ、定数と不定元の行き先）を確かめる。
#
# 人手証明の鎖の各段に対応させて、厳密計算（QQbar 係数の多項式環）で確かめる。
# 浮動小数点は使わない。

R.<t> = PolynomialRing(QQbar)


def ac(f, j):
    # ac_j(f)（def_qbar_polynomial_ring の係数）。
    return f[j]


def const(a):
    # (a)^（def_qbar_constant_embedding。代数的数を定数多項式として送る）。
    return R(a)


def pow_rec(f, k):
    # f^k を定義どおり反復で作る（f^0 = 1、f^{j+1} = f^j f）。
    acc = R.one()
    for _ in range(k):
        acc = acc * f
    return acc


def qbar_pow_rec(a, k):
    # Qbar の元の冪も同じ約束で作る。
    acc = QQbar(1)
    for _ in range(k):
        acc = acc * a
    return acc


def aev(w, f, kmax):
    # aev_w(f)（def_qbar_poly_evaluation）。係数が零でない項だけの有限和。
    total = QQbar(0)
    for k in range(0, kmax + 1):
        if ac(f, k) != QQbar(0):
            total = total + ac(f, k) * qbar_pow_rec(w, k)
    return total


SAMPLE_QBAR = [
    QQbar(0),
    QQbar(1),
    QQbar(-1),
    QQbar(2),
    QQbar(sqrt(2)),
    QQbar(I),
    QQbar(sqrt(2)) - QQbar(1),
    QQbar(-3) / QQbar(2),
    QQbar(sqrt(-3)),
]


def sample_polynomials():
    # 検証に使う多項式の標本（次数 0〜4）。
    return [
        R.zero(),
        R.one(),
        t,
        pow_rec(t, 3) - const(QQbar(2)),
        const(QQbar(sqrt(2))) * pow_rec(t, 2) + const(QQbar(I)) * t + const(QQbar(-1)),
        const(QQbar(sqrt(-3))) * pow_rec(t, 4) + const(QQbar(1)),
    ]


def check_evaluation_conventions(kmax):
    # 0. 代入の定義に置いた約束（環準同型であること、定数と不定元の行き先）。
    print("0. 代入 aev_w の約束（和と積を保つ、定数と不定元の行き先）")
    for w in SAMPLE_QBAR:
        assert aev(w, R.zero(), kmax) == QQbar(0)
        assert aev(w, R.one(), kmax) == QQbar(1)
        assert aev(w, t, kmax) == w
        for a in SAMPLE_QBAR:
            assert aev(w, const(a), kmax) == a
        for f in sample_polynomials():
            for g in sample_polynomials():
                assert aev(w, f + g, kmax) == aev(w, f, kmax) + aev(w, g, kmax)
                assert aev(w, f * g, 2 * kmax) == aev(w, f, kmax) * aev(w, g, kmax)
                assert aev(w, -f, kmax) == -aev(w, f, kmax)
    print("   通過（標本 %d 個 × 多項式 %d 個）" % (len(SAMPLE_QBAR), len(sample_polynomials())))


def check_preparation(kmax, jmax):
    # 1. 準備の段。ac_j((a)^ t^k) は j = k のとき a、そうでなければ 0。鎖の各段を見る。
    print("1. 準備の段（ac_j((a)^ t^k) の鎖）")
    for a in SAMPLE_QBAR:
        ah = const(a)
        for k in range(0, kmax + 1):
            tk = pow_rec(t, k)
            prod = ah * tk
            for j in range(0, jmax + 1):
                # 第 1 の等号（積の係数の定義）
                assert ac(prod, j) == sum(
                    ac(ah, i) * ac(tk, j - i) for i in range(0, j + 1)
                )
                # 第 2 の等号（i = 0 の項を取り出す）
                rest = sum(ac(ah, i) * ac(tk, j - i) for i in range(1, j + 1))
                assert ac(prod, j) == ac(ah, 0) * ac(tk, j) + rest
                # 第 3 の等号（i ≥ 1 で ac_i((a)^) = 0）
                for i in range(1, j + 1):
                    assert ac(ah, i) == QQbar(0)
                # 第 4・第 5・第 6 の等号（零元との積・零元の有限和・加法の単位元）
                assert rest == QQbar(0)
                # 第 7 の等号（ac_0((a)^) = a）
                assert ac(ah, 0) == a
                # 第 8 の等号（不定元の冪の係数。claim_qbar_poly_indeterminate_power_coefficient）
                assert ac(tk, j) == (QQbar(1) if j == k else QQbar(0))
                # 第 9 の等号（積の単位元・零元との積）と、準備の段そのもの
                assert ac(prod, j) == (a if j == k else QQbar(0))
    print("   通過（a は標本 %d 個、k = 0,...,%d、j = 0,...,%d）" % (len(SAMPLE_QBAR), kmax, jmax))


def check_cases(nmax, jmax):
    # 2. 本体の 2 つの場合（j ≤ n と j > n）の鎖の各段。
    print("2. 本体の鎖（場合 1: j ≤ n、場合 2: j > n）")
    for f in sample_polynomials():
        n = nmax
        assert all(ac(f, k) == QQbar(0) for k in range(n + 1, n + 5))
        terms = [const(ac(f, k)) * pow_rec(t, k) for k in range(0, n + 1)]
        g = R.zero()
        for term in terms:
            g = g + term
        for j in range(0, jmax + 1):
            # 第 1 の等号（和の係数を有限和へ繰り返し当てる）
            assert ac(g, j) == sum(ac(term, j) for term in terms)
            if j <= n:
                # 場合 1。第 2 の等号（k = j の項を取り出す）
                rest = sum(ac(terms[k], j) for k in range(0, n + 1) if k != j)
                assert ac(g, j) == ac(terms[j], j) + rest
                # 第 3 の等号（準備の段を a = ac_j(f)、k = j へ当てる）
                assert ac(terms[j], j) == ac(f, j)
                # 第 4・第 5・第 6 の等号（k ≠ j の項は零・零元の有限和・加法の単位元）
                for k in range(0, n + 1):
                    if k != j:
                        assert ac(terms[k], j) == QQbar(0)
                assert rest == QQbar(0)
                assert ac(g, j) == ac(f, j)
            else:
                # 場合 2。第 2 の等号（0 ≤ k ≤ n < j より k ≠ j なので準備の段）
                for k in range(0, n + 1):
                    assert k != j
                    assert ac(terms[k], j) == QQbar(0)
                # 第 3 の等号（零元の有限和）と第 4 の等号（j > n についての仮定）
                assert ac(g, j) == QQbar(0)
                assert ac(f, j) == QQbar(0)
    print("   通過（多項式 %d 個、n = %d、j = 0,...,%d）" % (len(sample_polynomials()), nmax, jmax))


def check_claim(nmax):
    # 3. 主張そのもの（係数がすべて等しいので多項式として等しい）。
    print("3. 主張そのもの（f = Σ_{k=0}^{n} (ac_k(f))^ t^k）")
    for f in sample_polynomials():
        g = R.zero()
        for k in range(0, nmax + 1):
            g = g + const(ac(f, k)) * pow_rec(t, k)
        assert all(ac(f, j) == ac(g, j) for j in range(0, nmax + 5))
        assert f == g
    print("   通過（多項式 %d 個、n = %d）" % (len(sample_polynomials()), nmax))


def check_usage(nmax):
    # 4. 使い道: 分解の各項へ t^k - w^k の因数分解を当てると、f - (aev_w(f))^ が
    #    (t - (w)^) で割り切れること（次の段で書く因数定理）。
    print("4. 使い道（f から代入の値を引いたものが t - (w)^ で割り切れる）")
    for f in sample_polynomials():
        for w in SAMPLE_QBAR:
            value = aev(w, f, nmax)
            diff = f - const(value)
            quotient, remainder = diff.quo_rem(t - const(w))
            assert remainder == R.zero()
            assert quotient * (t - const(w)) == diff
    print("   通過（多項式 %d 個 × 標本 %d 個）" % (len(sample_polynomials()), len(SAMPLE_QBAR)))


def main():
    check_evaluation_conventions(6)
    check_preparation(4, 6)
    check_cases(4, 7)
    check_claim(4)
    check_usage(4)
    print("すべて通過")


main()
