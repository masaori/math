# 対象ラベル: claim_qbar_identity_matrix_unit
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「代数的数を成分とする単位行列は積の単位元である」（I A = A かつ A I = A）を、
# 小さい L について行配位を添字とする行列で確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体 Qbar は QQbar
# （厳密な代数的数の体）で表す。
#
# 何を確かめるか（人手証明は 2 本の 7 段の鎖である）:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 左から掛ける側の第 1 段（積の定義）。
#   3. 左から掛ける側の第 2 段（τ'=τ の 1 項を分ける）。
#   4. 左から掛ける側の第 3 段（単位行列の定義。対角では 1、対角の外では 0）。
#   5. 左から掛ける側の第 4・5 段（単位元との積・零元との積）。
#   6. 左から掛ける側の第 6・7 段（零元だけの有限和は零元・零元を足しても変わらない）。
#   7. 右から掛ける側の第 1 段（積の定義）。
#   8. 右から掛ける側の第 2 段（τ'=τ'' の 1 項を分ける）。
#   9. 右から掛ける側の第 3 段（単位行列の定義）。
#  10. 右から掛ける側の第 4・5 段（単位元との積・零元との積）。
#  11. 右から掛ける側の第 6・7 段。
#  12. 主張そのもの。I A = A と A I = A が全成分で成り立つこと。
#  13. 主張が空虚でないこと。A が零行列でなく、単位行列が零行列でないこと。
#  14. 積の可換性を使っていないこと。成分を非可換環（2 次上三角行列、Z 係数）に
#      取り替えても 2 つの等式が成り立つこと。

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
    # (I)_{τ,τ'} = 1 (τ'=τ), 0 (τ'≠τ)
    return {(t, t1): (QQbar(1) if t1 == t else QQbar(0)) for t in R for t1 in R}


def product(R, A, B):
    # (AB)_{τ,τ''} = Σ_{τ'} A_{τ,τ'} B_{τ',τ''}
    return {
        (t, t2): sum((A[(t, t1)] * B[(t1, t2)] for t1 in R), QQbar(0))
        for t in R
        for t2 in R
    }


print("== 代数的数を成分とする単位行列は積の単位元である ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # 1. 添字集合の大きさ
    assert len(R) == 2 ** L, (L, len(R))

    A = make_matrix(R, 0)
    I = identity_matrix_qbar(R)
    IA = product(R, I, A)
    AI = product(R, A, I)

    for t in R:
        for t2 in R:
            # --- 左から掛ける側 ---
            # 2. 第 1 段（積の定義）
            l1 = sum((I[(t, t1)] * A[(t1, t2)] for t1 in R), QQbar(0))
            assert IA[(t, t2)] == l1
            # 3. 第 2 段（τ'=τ の 1 項を分ける）
            l2 = I[(t, t)] * A[(t, t2)] + sum(
                (I[(t, t1)] * A[(t1, t2)] for t1 in R if t1 != t), QQbar(0)
            )
            assert l1 == l2
            # 4. 第 3 段（単位行列の定義）
            assert I[(t, t)] == QQbar(1)
            for t1 in R:
                if t1 != t:
                    assert I[(t, t1)] == QQbar(0)
            l3 = QQbar(1) * A[(t, t2)] + sum(
                (QQbar(0) * A[(t1, t2)] for t1 in R if t1 != t), QQbar(0)
            )
            assert l2 == l3
            # 5. 第 4・5 段（単位元との積・零元との積）
            assert QQbar(1) * A[(t, t2)] == A[(t, t2)]
            for t1 in R:
                assert QQbar(0) * A[(t1, t2)] == QQbar(0)
            l4 = A[(t, t2)] + sum((QQbar(0) for t1 in R if t1 != t), QQbar(0))
            assert l3 == l4
            # 6. 第 6・7 段（零元だけの有限和は零元・零元を足しても変わらない）
            assert sum((QQbar(0) for t1 in R if t1 != t), QQbar(0)) == QQbar(0)
            assert A[(t, t2)] + QQbar(0) == A[(t, t2)]
            assert l4 == A[(t, t2)]

            # --- 右から掛ける側 ---
            # 7. 第 1 段（積の定義）
            r1 = sum((A[(t, t1)] * I[(t1, t2)] for t1 in R), QQbar(0))
            assert AI[(t, t2)] == r1
            # 8. 第 2 段（τ'=τ'' の 1 項を分ける）
            r2 = A[(t, t2)] * I[(t2, t2)] + sum(
                (A[(t, t1)] * I[(t1, t2)] for t1 in R if t1 != t2), QQbar(0)
            )
            assert r1 == r2
            # 9. 第 3 段（単位行列の定義。第 2 添字が第 1 添字に等しいときだけ 1）
            assert I[(t2, t2)] == QQbar(1)
            for t1 in R:
                if t1 != t2:
                    assert I[(t1, t2)] == QQbar(0)
            r3 = A[(t, t2)] * QQbar(1) + sum(
                (A[(t, t1)] * QQbar(0) for t1 in R if t1 != t2), QQbar(0)
            )
            assert r2 == r3
            # 10. 第 4・5 段（単位元との積・零元との積。左からのものとは別の 2 本である）
            assert A[(t, t2)] * QQbar(1) == A[(t, t2)]
            for t1 in R:
                assert A[(t, t1)] * QQbar(0) == QQbar(0)
            r4 = A[(t, t2)] + sum((QQbar(0) for t1 in R if t1 != t2), QQbar(0))
            assert r3 == r4
            # 11. 第 6・7 段
            assert r4 == A[(t, t2)]

    # 12. 主張そのもの
    assert all(IA[k] == A[k] for k in A)
    assert all(AI[k] == A[k] for k in A)
    # 13. 空虚でないこと
    assert any(A[k] != QQbar(0) for k in A)
    assert any(I[k] != QQbar(0) for k in I)

    print(
        "L=%d: R_L は %d 元。全成分で 2 本の鎖の 7 段すべてと I A = A・A I = A が成り立ち、"
        "A も単位行列も零行列でない" % (L, len(R))
    )

# 14. 積の可換性を使っていないこと。
#     成分を非可換環（2 次上三角行列。Z 係数）に取って同じ 2 つの等式を確かめる。
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
    I = nc_identity(R)
    assert all(nc_product(R, I, A)[k] == A[k] for k in A)
    assert all(nc_product(R, A, I)[k] == A[k] for k in A)
    assert any(A[k] != Nc.zero() for k in A)
    print(
        "L=%d: 成分を非可換環（2 次上三角行列）に取っても I A = A・A I = A が成り立つ"
        "（この段が積の可換性を使っていないこと）" % L
    )

print("すべて通過")
