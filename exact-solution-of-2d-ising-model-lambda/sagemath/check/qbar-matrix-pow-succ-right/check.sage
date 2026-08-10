# 対象ラベル: claim_qbar_matrix_pow_succ_right
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「代数的数を成分とする行列の冪は右から掛けても得られる」（A^{k+1} = A^k A）を、
# 小さい L と k について行配位を添字とする行列で確かめる。
#
# 冪の定義は本文（def_qbar_matrix_power）どおり A^0 := I、A^{k+1} := A A^k（左から掛ける）である。
# 主張は、これが右から掛けた形にも書けることである。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体 Qbar は QQbar で表す。
#
# 何を確かめるか（人手証明は帰納法で、出発点が 5 段・一歩が 4 段の鎖である）:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 出発点の第 1・2 段。A^{0+1} = A A^0 = A I（冪の定義）。
#   3. 出発点の第 3 段。A I = A（単位元。claim_qbar_identity_matrix_unit の右から掛ける側）。
#   4. 出発点の第 4 段。A = I A（単位元。左から掛ける側。左右の 2 つがどちらも要ること）。
#   5. 出発点の第 5 段。I A = A^0 A（冪の定義）。
#   6. 一歩の第 1 段。A^{(k+1)+1} = A A^{k+1}（冪の定義）。
#   7. 一歩の第 2 段。A A^{k+1} = A (A^k A)（帰納法の仮定）。
#   8. 一歩の第 3 段。A (A^k A) = (A A^k) A（結合則。claim_qbar_matrix_product_assoc）。
#   9. 一歩の第 4 段。(A A^k) A = A^{k+1} A（冪の定義）。
#  10. 主張そのもの。A^{k+1} = A^k A が全成分で成り立つこと。
#  11. 主張が空虚でないこと。A^k が零行列でなく、A^{k+1} と A^k が異なること。
#  12. 積の可換性を使っていないこと。成分を非可換環（2 次上三角行列、Z 係数）に
#      取り替えても A^{k+1} = A^k A が成り立つこと。


def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]


# 成分に使う代数的数（QQbar の厳密な元）。有理数のほかに無理数・虚数・3 次の代数的数を混ぜる。
pool = [
    QQbar(1),
    QQbar(-2),
    QQbar(3) / QQbar(5),
    QQbar(2).sqrt(),
    -QQbar(3).sqrt(),
    QQbar(-1).sqrt(),
    QQbar(5) ** (QQ(1) / QQ(3)),
]


def make_matrix(R, offset):
    # R×R から Qbar への写像を、添字の順番から決まる形で作る（乱数を使わない）。
    idx = {t: i for i, t in enumerate(R)}
    return {
        (t, t1): pool[(idx[t] * 3 + idx[t1] * 5 + offset) % len(pool)]
        for t in R
        for t1 in R
    }


def identity_matrix_qbar(R):
    return {(t, t1): (QQbar(1) if t1 == t else QQbar(0)) for t in R for t1 in R}


def product(R, A, B):
    # (AB)_{τ,τ''} = Σ_{τ'} A_{τ,τ'} B_{τ',τ''}
    return {
        (t, t2): sum((A[(t, t1)] * B[(t1, t2)] for t1 in R), QQbar(0))
        for t in R
        for t2 in R
    }


def power_left(R, A, k, one, mul):
    # 本文の定義。A^0 := I、A^{k+1} := A A^k（左から掛ける）。
    P = one(R)
    for _ in range(k):
        P = mul(R, A, P)
    return P


def eq(R, A, B):
    return all(A[(t, t2)] == B[(t, t2)] for t in R for t2 in R)


print("== 代数的数を成分とする行列の冪は右から掛けても得られる ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # 1. 添字集合の大きさ
    assert len(R) == 2 ** L, (L, len(R))

    A = make_matrix(R, 0)
    I = identity_matrix_qbar(R)

    # --- 出発点（k=0）---
    P0 = power_left(R, A, 0, identity_matrix_qbar, product)
    P1 = power_left(R, A, 1, identity_matrix_qbar, product)
    # 2. 第 1・2 段（冪の定義）
    assert eq(R, P0, I)
    assert eq(R, P1, product(R, A, P0))
    assert eq(R, product(R, A, P0), product(R, A, I))
    # 3. 第 3 段（A I = A）
    assert eq(R, product(R, A, I), A)
    # 4. 第 4 段（A = I A）
    assert eq(R, A, product(R, I, A))
    # 5. 第 5 段（I A = A^0 A）
    assert eq(R, product(R, I, A), product(R, P0, A))
    assert eq(R, P1, product(R, P0, A))

    # --- 一歩と主張（k=0,...,4）---
    for k in range(5):
        Pk = power_left(R, A, k, identity_matrix_qbar, product)
        Pk1 = power_left(R, A, k + 1, identity_matrix_qbar, product)
        Pk2 = power_left(R, A, k + 2, identity_matrix_qbar, product)
        # 6. 一歩の第 1 段（冪の定義）
        assert eq(R, Pk2, product(R, A, Pk1))
        # 7. 一歩の第 2 段（帰納法の仮定 A^{k+1} = A^k A を当てる）
        assert eq(R, Pk1, product(R, Pk, A))
        assert eq(R, product(R, A, Pk1), product(R, A, product(R, Pk, A)))
        # 8. 一歩の第 3 段（結合則）
        assert eq(
            R,
            product(R, A, product(R, Pk, A)),
            product(R, product(R, A, Pk), A),
        )
        # 9. 一歩の第 4 段（冪の定義）
        assert eq(R, product(R, A, Pk), Pk1)
        assert eq(R, product(R, product(R, A, Pk), A), product(R, Pk1, A))
        # 10. 主張そのもの
        assert eq(R, Pk2, product(R, Pk1, A))
        # 11. 空虚でないこと
        assert any(Pk[key] != QQbar(0) for key in Pk)
        if k >= 1:
            assert not eq(R, Pk1, Pk)

    print(
        "L=%d: R_L は %d 元。k=0,...,4 の全成分で出発点の 5 段・一歩の 4 段と "
        "A^{k+1} = A^k A が成り立ち、A^k は零行列でない" % (L, len(R))
    )

# 12. 積の可換性を使っていないこと。
#     成分を非可換環（2 次上三角行列。Z 係数）に取って同じ等式を確かめる。
#     行列の積そのものも非可換なので、A^{k+1} = A^k A は自明ではない
#     （左から掛ける冪と右から掛ける冪が一致するのは、掛ける相手が同じ A だからである）。
Nc = MatrixSpace(ZZ, 2, 2)
nc_pool = [
    Nc([[1, 1], [0, 1]]),
    Nc([[0, 1], [0, 0]]),
    Nc([[2, 0], [0, -1]]),
    Nc([[1, -3], [0, 2]]),
]
assert nc_pool[0] * nc_pool[2] != nc_pool[2] * nc_pool[0]  # 実際に非可換である


def make_nc_matrix(R, offset):
    idx = {t: i for i, t in enumerate(R)}
    return {
        (t, t1): nc_pool[(idx[t] * 3 + idx[t1] * 5 + offset) % len(nc_pool)]
        for t in R
        for t1 in R
    }


def nc_identity(R):
    return {(t, t1): (Nc.one() if t1 == t else Nc.zero()) for t in R for t1 in R}


def nc_product(R, A, B):
    return {
        (t, t2): sum((A[(t, t1)] * B[(t1, t2)] for t1 in R), Nc.zero())
        for t in R
        for t2 in R
    }


for L in [1, 2, 3]:
    R = row_configs(L)
    A = make_nc_matrix(R, 0)
    for k in range(5):
        Pk = power_left(R, A, k, nc_identity, nc_product)
        Pk1 = power_left(R, A, k + 1, nc_identity, nc_product)
        assert all(Pk1[key] == nc_product(R, Pk, A)[key] for key in Pk1)
        assert any(Pk[key] != Nc.zero() for key in Pk)
    print(
        "L=%d: 成分を非可換環（2 次上三角行列）に取っても k=0,...,4 で A^{k+1} = A^k A が"
        "成り立つ（この段が積の可換性を使っていないこと）" % L
    )

print("すべて通過")
