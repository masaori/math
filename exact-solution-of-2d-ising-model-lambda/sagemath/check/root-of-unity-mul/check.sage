# 対象ラベル: claim_root_of_unity_mul
#   併せて引く定義: def_algebraic_numbers, def_root_of_unity_set
#   併せて引く主張: claim_qbar_mul_pow
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張 1 件
# 「1 の冪根の全体は積で閉じている」（w, z ∈ μ_n ならば wz ∈ μ_n）を確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. μ_n の作り方。QQbar.zeta(n) の冪として作った n 個の元がちょうど
#      { z ∈ QQbar | z^n = 1 } の元であること（以降はこの集合で確かめる）。
#   2. 鎖の 4 段。(wz)^n = w^n z^n = 1·z^n = 1·1 = 1。
#   3. 主張そのもの。w, z ∈ μ_n ならば wz ∈ μ_n。
#   4. n = 0 の場合。μ_0 = QQbar なので、代数的数を任意に 2 つ取っても
#      積が μ_0 に入ること（鎖が n = 0 でもそのまま通ることの確認）。
#   5. 使っている性質。証明が使うのは「n 乗して 1 になる」という等式 2 本と、
#      積の冪が冪の積であること（可換則を含む）だけである。1 の冪根であること
#      そのものは使っていない。単位元が 1 でない場合の類似（μ_n の代わりに
#      「n 乗して単位元になる元の全体」）でも同じ鎖が通ることを、
#      2 次行列環の可換な 2 元で見る。
#      逆に、可換でない 2 元では閉じないことも見る。

def pow_rec(y, n, one):
    # 本文の約束: y^0 := 1, y^{j+1} := y^j y
    acc = one
    for _ in range(n):
        acc = acc * y
    return acc


def mu(n):
    # 1 の n 乗根の全体（n >= 1）
    return [QQbar.zeta(n)**j for j in range(n)]


def check_mu_construction(nmax):
    print("1. μ_n の作り方（n 個の相異なる元がちょうど z^n = 1 を満たす）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = mu(n)
        assert len(set(roots)) == n
        for z in roots:
            assert pow_rec(z, n, one) == one
    print("   通過（n=1,...,%d）" % nmax)


def check_chain(nmax):
    print("2. 鎖の 4 段")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = mu(n)
        for w in roots:
            for z in roots:
                wn = pow_rec(w, n, one)
                zn = pow_rec(z, n, one)
                assert wn == one and zn == one          # 準備（μ_n の定義をほどく）
                s1 = pow_rec(w * z, n, one)
                s2 = wn * zn
                s3 = one * zn
                s4 = one * one
                s5 = one
                for a, b in [(s1, s2), (s2, s3), (s3, s4), (s4, s5)]:
                    assert a == b
    print("   通過（n=1,...,%d の μ_n の全元の組）" % nmax)


def check_claim(nmax):
    print("3. 主張そのもの。w, z ∈ μ_n ならば wz ∈ μ_n")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = mu(n)
        rootset = set(roots)
        for w in roots:
            for z in roots:
                assert pow_rec(w * z, n, one) == one    # すなわち wz ∈ μ_n
                assert w * z in rootset                 # μ_n がちょうど n 元であることも併せて見る
    print("   通過（n=1,...,%d の μ_n の全元の組）" % nmax)


def check_n_zero():
    print("4. n = 0 の場合（μ_0 = QQbar）")
    one = QQbar(1)
    xs = [QQbar(2), QQbar(-3)/5, QQbar(sqrt(2)), QQbar(sqrt(-1)), QQbar(0)]
    for w in xs:
        for z in xs:
            assert pow_rec(w, 0, one) == one and pow_rec(z, 0, one) == one
            assert pow_rec(w * z, 0, one) == one
    print("   通過（代数的数 5 通り × 5 通り）")


def check_used_properties():
    print("5. 使っている性質（1 の冪根であることは使っていない／可換則は外せない）")
    M = MatrixSpace(QQ, 2, 2)
    one = M.one()
    # 可換な 2 元。ともに 4 乗して単位元になる（1 の冪根ではなく行列である）。
    w = M([[0, -1], [1, 0]])          # 90 度回転。w^4 = I
    z = -one                          # z^2 = I なので z^4 = I
    assert w * z == z * w
    assert pow_rec(w, 4, one) == one and pow_rec(z, 4, one) == one
    assert pow_rec(w * z, 4, one) == one        # 同じ鎖がそのまま通る
    # 可換でない 2 元。ともに 2 乗して単位元だが、積は 2 乗しても単位元にならない。
    a = M([[0, 1], [1, 0]])
    b = M([[1, 0], [0, -1]])
    assert a * b != b * a
    assert pow_rec(a, 2, one) == one and pow_rec(b, 2, one) == one
    assert pow_rec(a * b, 2, one) != one
    print("   通過（可換なら 1 の冪根でなくても通り、可換でないと閉じない）")


print("== 1 の冪根の全体は積で閉じている ==")
check_mu_construction(8)
check_chain(8)
check_claim(8)
check_n_zero()
check_used_properties()
print("すべて通過")
