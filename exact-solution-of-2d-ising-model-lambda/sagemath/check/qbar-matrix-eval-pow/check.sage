# 対象ラベル: claim_qbar_matrix_eval_pow
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「成分ごとの評価は行列の冪を保つ」（Ev_ξ(A^k) = (Ev_ξ(A))^k、k >= 1）を、
# 小さい L と k について行配位を添字とする行列で確かめる。
#
# 2 つの冪は別の演算である。
#   Z[x] の側（def_matrix_over_row_configs）: A^1 := A、A^{k+1} := A^k A（右から掛ける。k >= 1 でだけ定める）
#   Qbar の側（def_qbar_matrix_power）      : A^0 := I、A^{k+1} := A A^k（左から掛ける）
# 出発点も一歩の向きも違うので、帰納法の一歩で claim_qbar_matrix_pow_succ_right が要る。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。多項式は ZZ['x']、代数的数は QQbar で表す。
#
# 何を確かめるか（人手証明は k についての帰納法で、出発点が 4 段・一歩が 4 段の鎖である）:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 出発点の第 1 段。Ev_ξ(A^1) = Ev_ξ(A)（Z[x] の冪の定義）。
#   3. 出発点の第 2 段。Ev_ξ(A) = Ev_ξ(A) I（単位元。claim_qbar_identity_matrix_unit の右から掛ける側）。
#   4. 出発点の第 3 段。Ev_ξ(A) I = Ev_ξ(A) (Ev_ξ(A))^0（Qbar の冪の定義。A^0 = I）。
#   5. 出発点の第 4 段。Ev_ξ(A) (Ev_ξ(A))^0 = (Ev_ξ(A))^1（Qbar の冪の定義）。
#   6. 一歩の第 1 段。Ev_ξ(A^{k+1}) = Ev_ξ(A^k A)（Z[x] の冪の定義）。
#   7. 一歩の第 2 段。Ev_ξ(A^k A) = Ev_ξ(A^k) Ev_ξ(A)（claim_qbar_matrix_eval_product）。
#   8. 一歩の第 3 段。帰納法の仮定 Ev_ξ(A^k) = (Ev_ξ(A))^k を当てること。
#   9. 一歩の第 4 段。(Ev_ξ(A))^k Ev_ξ(A) = (Ev_ξ(A))^{k+1}（claim_qbar_matrix_pow_succ_right）。
#  10. 主張そのもの。Ev_ξ(A^k) = (Ev_ξ(A))^k が全成分で成り立つこと。
#  11. 主張が空虚でないこと。A^k の成分に定数でない多項式が現れ、Ev_ξ(A^k) が零行列でないこと。
#  12. 向きの違いが効いていないこと。Qbar の側を右から掛けて作った冪とも一致すること。


Zx = PolynomialRing(ZZ, 'x')
x = Zx.gen()


def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]


# 成分に使う Z[x] の元。定数と 1 次・2 次を混ぜる（乱数を使わない）。
poly_pool = [Zx(1), x, Zx(-2) + x, x ** 2, Zx(3), x ** 2 + Zx(1) - x]

# 代入する代数的数。有理数のほかに無理数・虚数を混ぜる。
xi_pool = [QQbar(2), QQbar(1) / QQbar(3), QQbar(2).sqrt(), QQbar(-1).sqrt()]


def make_matrix(R, offset):
    idx = {t: i for i, t in enumerate(R)}
    return {
        (t, t1): poly_pool[(idx[t] * 3 + idx[t1] * 5 + offset) % len(poly_pool)]
        for t in R
        for t1 in R
    }


def zx_product(R, A, B):
    # Z[x] の行列の積（def_matrix_product）。
    return {
        (t, t2): sum((A[(t, t1)] * B[(t1, t2)] for t1 in R), Zx(0))
        for t in R
        for t2 in R
    }


def zx_power(R, A, k):
    # Z[x] の側の冪（k >= 1）。A^1 := A、A^{k+1} := A^k A（右から掛ける）。
    assert k >= 1
    P = A
    for _ in range(k - 1):
        P = zx_product(R, P, A)
    return P


def qbar_identity(R):
    return {(t, t1): (QQbar(1) if t1 == t else QQbar(0)) for t in R for t1 in R}


def qbar_product(R, A, B):
    # Qbar の行列の積（def_qbar_matrix_product）。
    return {
        (t, t2): sum((A[(t, t1)] * B[(t1, t2)] for t1 in R), QQbar(0))
        for t in R
        for t2 in R
    }


def qbar_power_left(R, A, k):
    # Qbar の側の冪（def_qbar_matrix_power）。A^0 := I、A^{k+1} := A A^k（左から掛ける）。
    P = qbar_identity(R)
    for _ in range(k):
        P = qbar_product(R, A, P)
    return P


def qbar_power_right(R, A, k):
    # 向きを変えた冪（A^0 := I、A^{k+1} := A^k A）。12 の確認にだけ使う。
    P = qbar_identity(R)
    for _ in range(k):
        P = qbar_product(R, P, A)
    return P


def ev(R, xi, A):
    # 成分ごとの代入（def_qbar_matrix_eval）。
    return {key: QQbar(A[key](xi)) for key in A}


def eq_qbar(R, A, B):
    return all(A[(t, t2)] == B[(t, t2)] for t in R for t2 in R)


print("== 成分ごとの評価は行列の冪を保つ ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # 1. 添字集合の大きさ
    assert len(R) == 2 ** L, (L, len(R))

    A = make_matrix(R, 0)
    I = qbar_identity(R)

    for xi in xi_pool:
        EA = ev(R, xi, A)

        # --- 出発点（k=1）---
        # 2. 第 1 段（Z[x] の冪の定義。A^1 = A）
        assert eq_qbar(R, ev(R, xi, zx_power(R, A, 1)), EA)
        # 3. 第 2 段（Ev(A) = Ev(A) I）
        assert eq_qbar(R, EA, qbar_product(R, EA, I))
        # 4. 第 3 段（Ev(A) I = Ev(A) (Ev A)^0）
        assert eq_qbar(R, qbar_power_left(R, EA, 0), I)
        assert eq_qbar(R, qbar_product(R, EA, I), qbar_product(R, EA, qbar_power_left(R, EA, 0)))
        # 5. 第 4 段（Ev(A) (Ev A)^0 = (Ev A)^1）
        assert eq_qbar(R, qbar_product(R, EA, qbar_power_left(R, EA, 0)), qbar_power_left(R, EA, 1))
        assert eq_qbar(R, ev(R, xi, zx_power(R, A, 1)), qbar_power_left(R, EA, 1))

        # --- 一歩と主張（k=1,...,4）---
        for k in range(1, 5):
            Ak = zx_power(R, A, k)
            Ak1 = zx_power(R, A, k + 1)
            Pk = qbar_power_left(R, EA, k)
            Pk1 = qbar_power_left(R, EA, k + 1)
            # 6. 一歩の第 1 段（Z[x] の冪の定義。A^{k+1} = A^k A）
            assert all(Ak1[key] == zx_product(R, Ak, A)[key] for key in Ak1)
            assert eq_qbar(R, ev(R, xi, Ak1), ev(R, xi, zx_product(R, Ak, A)))
            # 7. 一歩の第 2 段（評価が積を保つこと）
            assert eq_qbar(R, ev(R, xi, zx_product(R, Ak, A)), qbar_product(R, ev(R, xi, Ak), EA))
            # 8. 一歩の第 3 段（帰納法の仮定）
            assert eq_qbar(R, ev(R, xi, Ak), Pk)
            assert eq_qbar(R, qbar_product(R, ev(R, xi, Ak), EA), qbar_product(R, Pk, EA))
            # 9. 一歩の第 4 段（冪は右から掛けても得られること）
            assert eq_qbar(R, qbar_product(R, Pk, EA), Pk1)
            # 10. 主張そのもの
            assert eq_qbar(R, ev(R, xi, Ak), Pk)
            assert eq_qbar(R, ev(R, xi, Ak1), Pk1)
            # 11. 空虚でないこと
            assert any(Ak[key].degree() >= 1 for key in Ak)
            assert any(Pk[key] != QQbar(0) for key in Pk)
            # 12. 向きの違いが効いていないこと
            assert eq_qbar(R, Pk, qbar_power_right(R, EA, k))

    print(
        "L=%d: R_L は %d 元。ξ は %d 個、k=1,...,4 の全成分で出発点の 4 段・一歩の 4 段と "
        "Ev_ξ(A^k) = (Ev_ξ(A))^k が成り立ち、A^k には定数でない成分がある"
        % (L, len(R), len(xi_pool))
    )

print("すべて通過")
