# 対象ラベル: claim_qbar_matrix_eval_identity
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「成分ごとの評価は単位行列を単位行列へ写す」（Ev_ξ(I) = I^Qbar_L）を、
# 小さい L について行配位を添字とする行列で確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。整係数多項式環は ZZ['x']、
# 代数的数の全体 Qbar は QQbar（厳密な代数的数の体）で表す。
#
# 何を確かめるか（人手証明は 2 つの場合に分かれ、各場合が 4 段の鎖である）:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. τ=τ' の場合の第 1 段。Ev_ξ の定義（成分ごとの代入）。
#   3. τ=τ' の場合の第 2 段。Z[x] の単位行列の定義（対角成分が κ(1)）。
#   4. τ=τ' の場合の第 3 段。代入が Z[x] の単位元を Qbar の単位元へ送ること。
#   5. τ=τ' の場合の第 4 段。Qbar の単位行列の定義（対角成分が 1）。
#   6. τ≠τ' の場合の第 1 段。Ev_ξ の定義（成分ごとの代入）。
#   7. τ≠τ' の場合の第 2 段。Z[x] の単位行列の定義（非対角成分が κ(0)）。
#   8. τ≠τ' の場合の第 3 段。代入が Z[x] の零元を Qbar の零元へ送ること。
#   9. τ≠τ' の場合の第 4 段。Qbar の単位行列の定義（非対角成分が 0）。
#  10. 主張そのもの。Ev_ξ(I) = I^Qbar_L が全成分で成り立つこと。
#  11. 主張が空虚でないこと。Ev_ξ(I) が零行列でないこと（対角成分が 1 なので）。
#  12. 型の区別。評価の前の成分が Z[x] の元、後の成分が Qbar の元であること。

Zx = PolynomialRing(ZZ, 'x')
x = Zx.gen()


def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]


def kappa(n):
    # κ: Z -> Z[x]（定数多項式）。κ(1) が単位元、κ(0) が零元である。
    return Zx(n)


def identity_zx(R):
    # I_{τ,τ'} = κ(1) (τ=τ'), κ(0) (τ≠τ')
    return {(t, t1): (kappa(1) if t == t1 else kappa(0)) for t in R for t1 in R}


def identity_qbar(R):
    # (I^Qbar_L)_{τ,τ'} = 1 (τ'=τ), 0 (τ'≠τ)
    return {(t, t1): (QQbar(1) if t == t1 else QQbar(0)) for t in R for t1 in R}


def ev_matrix(R, A, xi):
    # (Ev_ξ(A))_{τ,τ'} = (A_{τ,τ'})(ξ)
    return {k: QQbar(A[k](xi)) for k in A}


# 代入する代数的数（QQbar の厳密な元）。有理数のほかに無理数・虚数・3 次の代数的数を混ぜる。
xis = [
    QQbar(0),
    QQbar(2),
    QQbar(3) / QQbar(5),
    QQbar(2).sqrt(),
    -QQbar(3).sqrt(),
    QQbar(-1).sqrt(),
    QQbar(5) ** (QQ(1) / QQ(3)),
]

print("== 成分ごとの評価は単位行列を単位行列へ写す ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # 1. 添字集合の大きさ
    assert len(R) == 2 ** L, (L, len(R))

    I_zx = identity_zx(R)
    I_qbar = identity_qbar(R)

    for xi in xis:
        Ev_I = ev_matrix(R, I_zx, xi)

        for t in R:
            for t1 in R:
                if t == t1:
                    # 2. 第 1 段（Ev_ξ の定義）
                    assert Ev_I[(t, t1)] == QQbar(I_zx[(t, t1)](xi))
                    # 3. 第 2 段（Z[x] の単位行列の対角成分は κ(1)）
                    assert I_zx[(t, t1)] == kappa(1)
                    assert I_zx[(t, t1)] == Zx.one()
                    # 4. 第 3 段（代入が単位元を単位元へ送る）
                    assert QQbar(kappa(1)(xi)) == QQbar(1)
                    # 5. 第 4 段（Qbar の単位行列の対角成分は 1）
                    assert I_qbar[(t, t1)] == QQbar(1)
                else:
                    # 6. 第 1 段（Ev_ξ の定義）
                    assert Ev_I[(t, t1)] == QQbar(I_zx[(t, t1)](xi))
                    # 7. 第 2 段（Z[x] の単位行列の非対角成分は κ(0)）
                    assert I_zx[(t, t1)] == kappa(0)
                    assert I_zx[(t, t1)] == Zx.zero()
                    # 8. 第 3 段（代入が零元を零元へ送る）
                    assert QQbar(kappa(0)(xi)) == QQbar(0)
                    # 9. 第 4 段（Qbar の単位行列の非対角成分は 0）
                    assert I_qbar[(t, t1)] == QQbar(0)

        # 10. 主張そのもの
        assert all(Ev_I[k] == I_qbar[k] for k in I_qbar)
        # 11. 空虚でないこと（対角成分が 1 なので零行列ではない）
        assert any(Ev_I[k] != QQbar(0) for k in Ev_I)
        # 12. 型の区別（評価の前は Z[x] の元、後は Qbar の元）
        assert all(v.parent() is Zx for v in I_zx.values())
        assert all(v.parent() is QQbar for v in Ev_I.values())

    print(
        "L=%d: R_L は %d 元。%d 個の ξ について 2 つの場合の 4 段すべてと "
        "Ev_ξ(I) = I^Qbar_L が成り立ち、値は零行列でない" % (L, len(R), len(xis))
    )

print("すべて通過")
