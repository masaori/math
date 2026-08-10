# 対象ラベル: claim_qbar_matrix_product_assoc
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「代数的数を成分とする行列の積は結合的である」（(AB)C = A(BC)）を、
# 小さい L について行配位を添字とする行列で確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体 Qbar は QQbar
# （厳密な代数的数の体）で表す。
#
# 何を確かめるか（人手証明は 8 段の鎖である。2 から 9 が 1 対 1 で対応する）:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 第 1 段。積の定義（外側の τ'' についての和）。
#   3. 第 2 段。積の定義（内側の τ' についての和へ開く）。
#   4. 第 3 段。有限和と元の積についての分配則（右から掛ける側）。
#   5. 第 4 段。積の結合則（成分ごと、Qbar の元 3 つについて）。
#   6. 第 5 段。有限和の順序の入れ替え。
#   7. 第 6 段。元と有限和の積についての分配則（左から掛ける側）。
#   8. 第 7 段。積の定義（BC の成分へ畳む）。
#   9. 第 8 段。積の定義（A(BC) の成分へ畳む）。
#  10. 主張そのもの。(AB)C = A(BC) が全成分で成り立つこと。
#  11. 主張が空虚でないこと。両辺が零行列でないこと。
#  12. 積の可換性を使っていないこと。成分を非可換環（2 次上三角行列）に取っても結合則が成り立つこと。

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


def product(R, A, B):
    # (AB)_{τ,τ''} = Σ_{τ'} A_{τ,τ'} B_{τ',τ''}
    return {
        (t, t2): sum((A[(t, t1)] * B[(t1, t2)] for t1 in R), QQbar(0))
        for t in R
        for t2 in R
    }


print("== 代数的数を成分とする行列の積は結合的である ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # 1. 添字集合の大きさ
    assert len(R) == 2 ** L, (L, len(R))

    A = make_matrix(R, 0)
    B = make_matrix(R, 1)
    C = make_matrix(R, 2)

    AB = product(R, A, B)
    BC = product(R, B, C)
    ABC_left = product(R, AB, C)
    ABC_right = product(R, A, BC)

    for t in R:
        for t3 in R:
            # 2. 第 1 段（積の定義）
            s1 = sum((AB[(t, t2)] * C[(t2, t3)] for t2 in R), QQbar(0))
            assert ABC_left[(t, t3)] == s1
            # 3. 第 2 段（内側の和へ開く）
            s2 = sum(
                (
                    sum((A[(t, t1)] * B[(t1, t2)] for t1 in R), QQbar(0)) * C[(t2, t3)]
                    for t2 in R
                ),
                QQbar(0),
            )
            assert s1 == s2
            # 4. 第 3 段（有限和と元の積についての分配則）
            s3 = sum(
                (
                    sum(
                        ((A[(t, t1)] * B[(t1, t2)]) * C[(t2, t3)] for t1 in R),
                        QQbar(0),
                    )
                    for t2 in R
                ),
                QQbar(0),
            )
            assert s2 == s3
            # 5. 第 4 段（積の結合則。成分ごとに Qbar の元 3 つについて確かめる）
            for t1 in R:
                for t2 in R:
                    assert (A[(t, t1)] * B[(t1, t2)]) * C[(t2, t3)] == A[(t, t1)] * (
                        B[(t1, t2)] * C[(t2, t3)]
                    )
            s4 = sum(
                (
                    sum(
                        (A[(t, t1)] * (B[(t1, t2)] * C[(t2, t3)]) for t1 in R),
                        QQbar(0),
                    )
                    for t2 in R
                ),
                QQbar(0),
            )
            assert s3 == s4
            # 6. 第 5 段（有限和の順序の入れ替え）
            s5 = sum(
                (
                    sum(
                        (A[(t, t1)] * (B[(t1, t2)] * C[(t2, t3)]) for t2 in R),
                        QQbar(0),
                    )
                    for t1 in R
                ),
                QQbar(0),
            )
            assert s4 == s5
            # 7. 第 6 段（元と有限和の積についての分配則）
            s6 = sum(
                (
                    A[(t, t1)]
                    * sum((B[(t1, t2)] * C[(t2, t3)] for t2 in R), QQbar(0))
                    for t1 in R
                ),
                QQbar(0),
            )
            assert s5 == s6
            # 8. 第 7 段（BC の成分へ畳む）
            s7 = sum((A[(t, t1)] * BC[(t1, t3)] for t1 in R), QQbar(0))
            assert s6 == s7
            # 9. 第 8 段（A(BC) の成分へ畳む）
            assert s7 == ABC_right[(t, t3)]

    # 10. 主張そのもの
    assert all(ABC_left[k] == ABC_right[k] for k in ABC_left)
    # 11. 空虚でないこと（両辺が零行列でない）
    assert any(ABC_left[k] != QQbar(0) for k in ABC_left)
    assert any(ABC_right[k] != QQbar(0) for k in ABC_right)

    print(
        "L=%d: R_L は %d 元。全成分で鎖の 8 段すべてと (AB)C = A(BC) が成り立ち、"
        "両辺は零行列でない" % (L, len(R))
    )

# 12. 積の可換性を使っていないこと。
#     成分を非可換環（2 次上三角行列。Z 係数）に取って同じ計算を回す。
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


def nc_product(R, A, B):
    return {
        (t, t2): sum((A[(t, t1)] * B[(t1, t2)] for t1 in R), Nc.zero())
        for t in R
        for t2 in R
    }


for L in [1, 2, 3]:
    R = row_configs(L)
    A = make_nc_matrix(R, 0)
    B = make_nc_matrix(R, 1)
    C = make_nc_matrix(R, 2)
    left = nc_product(R, nc_product(R, A, B), C)
    right = nc_product(R, A, nc_product(R, B, C))
    assert all(left[k] == right[k] for k in left)
    assert any(left[k] != Nc.zero() for k in left)
    print(
        "L=%d: 成分を非可換環（2 次上三角行列）に取っても (AB)C = A(BC) が成り立つ"
        "（この段が積の可換性を使っていないこと）" % L
    )

print("すべて通過")
