# 対象ラベル: claim_root_of_unity_power_sum_invariant
#   併せて引く定義: def_algebraic_numbers, def_root_of_unity_set, def_root_of_unity_mul_map
#   併せて引く主張: claim_qbar_mul_pow（(wz)^m = w^m z^m）、
#                   claim_root_of_unity_mul_map_bijective（θ_w が μ_n の全単射であること）
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張 1 件
# 「μ_n が有限のとき、S_{n,m} = Σ_{z ∈ μ_n} z^m は任意の w ∈ μ_n について w^m S_{n,m} = S_{n,m}
#  を満たす」を確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか（1〜4 は人手証明の鎖の各段に 1 対 1 で対応する）:
#   1. 第 2 の等号。w^m Σ_z z^m = Σ_z w^m z^m（積が有限和へ分配される）。
#   2. 第 3 の等号。Σ_z w^m z^m = Σ_z (w z)^m（claim_qbar_mul_pow を各項へ）。
#   3. 第 5 の等号。Σ_z (θ_w(z))^m = Σ_y y^m（添字の取り替え。θ_w が全単射であること）。
#   4. 主張そのもの。w^m S_{n,m} = S_{n,m}。
#   5. 主張の内容が空でないこと。w^m ≠ 1 となる w が取れる場合には S_{n,m} = 0 が従い、
#      m が n の倍数のときは w^m = 1 なので何も従わない（次の段が使う形の確認である）。
#   6. 使っている性質。証明が使うのは有限和が定まること（加法の結合則・可換則）と、
#      積が有限和へ分配されること、および掛ける操作が全単射であることだけである。
#      そこで、1 の冪根でない有限集合でも「掛ける操作が全単射」でありさえすれば
#      同じ結論が出ることを、Z/7Z の乗法群（3 の冪の全体）で見る。

def pow_rec(y, m, one):
    # 本文の約束: y^0 := 1, y^{j+1} := y^j y
    acc = one
    for _ in range(m):
        acc = acc * y
    return acc


def mu(n):
    # 1 の n 乗根の全体（n >= 1）。有限であることはここでは使う側の仮定である。
    return [QQbar.zeta(n)**j for j in range(n)]


def power_sum(n, m):
    one = QQbar(1)
    return sum((pow_rec(z, m, one) for z in mu(n)), QQbar(0))


def check_distribute(nmax, mmax):
    print("1. 第 2 の等号（w^m Σ_z z^m = Σ_z w^m z^m）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = mu(n)
        for m in range(0, mmax + 1):
            S = sum((pow_rec(z, m, one) for z in roots), QQbar(0))
            for w in roots:
                wm = pow_rec(w, m, one)
                assert wm * S == sum((wm * pow_rec(z, m, one) for z in roots), QQbar(0))
    print("   通過（n=1,...,%d、m=0,...,%d）" % (nmax, mmax))


def check_mul_pow(nmax, mmax):
    print("2. 第 3 の等号（Σ_z w^m z^m = Σ_z (w z)^m）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = mu(n)
        for m in range(0, mmax + 1):
            for w in roots:
                wm = pow_rec(w, m, one)
                for z in roots:
                    assert wm * pow_rec(z, m, one) == pow_rec(w * z, m, one)  # claim_qbar_mul_pow
                assert sum((wm * pow_rec(z, m, one) for z in roots), QQbar(0)) == \
                    sum((pow_rec(w * z, m, one) for z in roots), QQbar(0))
    print("   通過（n=1,...,%d、m=0,...,%d）" % (nmax, mmax))


def check_reindex(nmax, mmax):
    print("3. 第 5 の等号（添字の取り替え。Σ_z (θ_w(z))^m = Σ_y y^m）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = mu(n)
        rootset = set(roots)
        for w in roots:
            image = [w * z for z in roots]          # θ_w による像
            assert set(image) == rootset            # claim_root_of_unity_mul_map_bijective
            assert len(set(image)) == len(roots)
            for m in range(0, mmax + 1):
                assert sum((pow_rec(y, m, one) for y in image), QQbar(0)) == \
                    sum((pow_rec(y, m, one) for y in roots), QQbar(0))
    print("   通過（n=1,...,%d、m=0,...,%d）" % (nmax, mmax))


def check_claim(nmax, mmax):
    print("4. 主張そのもの（w^m S_{n,m} = S_{n,m}）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        for m in range(0, mmax + 1):
            S = power_sum(n, m)
            for w in mu(n):
                assert pow_rec(w, m, one) * S == S
    print("   通過（n=1,...,%d、m=0,...,%d）" % (nmax, mmax))


def check_not_vacuous(nmax, mmax):
    print("5. 主張の内容が空でないこと（w^m ≠ 1 が取れるときは S = 0 が従う）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        for m in range(0, mmax + 1):
            S = power_sum(n, m)
            witnesses = [w for w in mu(n) if pow_rec(w, m, one) != one]
            if witnesses:
                assert m % n != 0
                assert S == QQbar(0)
            else:
                assert m % n == 0
                assert S == QQbar(n)
    print("   通過（n=1,...,%d、m=0,...,%d。m が n の倍数のときだけ和が n に等しい）"
          % (nmax, mmax))


def check_used_properties():
    print("6. 使っている性質（有限和・分配則・掛ける操作の全単射性だけ）")
    # Z/7Z の乗法群は 1 の冪根の集合ではないが、掛ける操作が全単射である。
    # 同じ論法がそのまま通ることを見る（本文の証明が μ_n の中身を使っていない根拠）。
    R = Integers(7)
    G = [R(g) for g in [1, 2, 3, 4, 5, 6]]
    one = R(1)
    for m in range(0, 8):
        S = sum((pow_rec(g, m, one) for g in G), R(0))
        for w in G:
            image = [w * g for g in G]
            assert set(image) == set(G)                    # 掛ける操作が全単射
            assert pow_rec(w, m, one) * S == S             # 同じ結論
    print("   通過（Z/7Z の乗法群でも同じ結論が出る）")


print("== 1 の冪根の全体にわたる冪の和は、1 の冪根の冪を掛けても動かない ==")
check_distribute(6, 8)
check_mul_pow(6, 8)
check_reindex(6, 8)
check_claim(6, 8)
check_not_vacuous(6, 8)
check_used_properties()
print("すべて通過")
