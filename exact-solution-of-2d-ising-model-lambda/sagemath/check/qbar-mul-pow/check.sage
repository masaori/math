# 対象ラベル: claim_qbar_mul_pow
#   併せて引く定義: def_algebraic_numbers, def_root_of_unity_set
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張 1 件
# 「代数的数の積の冪は、冪の積である」（(wz)^n = w^n z^n）を確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 冪の約束。y^0 = 1 と y^{j+1} = y^j y を、本文と同じ再帰で組んだ冪が
#      SageMath の冪と一致すること（以降はこの再帰版で確かめる）。
#   2. 出発点の鎖の 4 段（n=0 の場合）。
#   3. 一歩の鎖の 9 段（帰納法の仮定を使う段を含む）。
#   4. 主張そのもの。(wz)^n = w^n z^n が n=0,...,8 で成り立つこと。
#   5. 応用の形。w, z を 1 の L 乗根に取ると wz も 1 の L 乗根であること
#      （この主張を使う先である。μ_L が積で閉じること）。
#   6. 使っている性質。証明が使うのは積の単位元・結合則・および z^n と w の
#      可換則だけである。可換則が外せないことを、非可換な成分（2 次行列環）で
#      w z ≠ z w の例を作って (wz)^2 ≠ w^2 z^2 となることで見る。
#      逆に、可換な 2 元なら非可換環の中でも成り立つことも見る。

def pow_rec(y, n, one):
    # 本文の約束: y^0 := 1, y^{j+1} := y^j y
    acc = one
    for _ in range(n):
        acc = acc * y
    return acc


def check_pow_convention():
    print("1. 冪の約束（y^0 = 1, y^{j+1} = y^j y）が SageMath の冪と一致する")
    ys = [QQbar(2), QQbar(-3)/5, QQbar(sqrt(2)), QQbar(sqrt(-1)), QQbar(5)**(1/3)]
    for y in ys:
        for n in range(9):
            assert pow_rec(y, n, QQbar(1)) == y**n
    print("   通過（5 個の代数的数 × n=0,...,8）")


def check_base_chain(ws, zs):
    print("2. 出発点（n=0）の鎖の 4 段")
    one = QQbar(1)
    for w in ws:
        for z in zs:
            lhs = pow_rec(w * z, 0, one)
            assert lhs == one                                    # 第 1 段
            assert one == one * one                              # 第 2 段
            assert one * one == pow_rec(w, 0, one) * one         # 第 3 段
            assert pow_rec(w, 0, one) * one == pow_rec(w, 0, one) * pow_rec(z, 0, one)  # 第 4 段
    print("   通過（w %d 通り × z %d 通り）" % (len(ws), len(zs)))


def check_step_chain(ws, zs, nmax):
    print("3. 一歩の鎖の 9 段")
    one = QQbar(1)
    for w in ws:
        for z in zs:
            for n in range(nmax + 1):
                wn = pow_rec(w, n, one)
                zn = pow_rec(z, n, one)
                # 帰納法の仮定
                assert pow_rec(w * z, n, one) == wn * zn
                s1 = pow_rec(w * z, n + 1, one)
                s2 = pow_rec(w * z, n, one) * (w * z)
                s3 = (wn * zn) * (w * z)
                s4 = wn * (zn * (w * z))
                s5 = wn * ((zn * w) * z)
                s6 = wn * ((w * zn) * z)
                s7 = wn * (w * (zn * z))
                s8 = (wn * w) * (zn * z)
                s9 = pow_rec(w, n + 1, one) * (zn * z)
                s10 = pow_rec(w, n + 1, one) * pow_rec(z, n + 1, one)
                for a, b in [(s1, s2), (s2, s3), (s3, s4), (s4, s5), (s5, s6),
                             (s6, s7), (s7, s8), (s8, s9), (s9, s10)]:
                    assert a == b
    print("   通過（w %d 通り × z %d 通り × n=0,...,%d）" % (len(ws), len(zs), nmax))


def check_claim(ws, zs, nmax):
    print("4. 主張そのもの (wz)^n = w^n z^n")
    one = QQbar(1)
    for w in ws:
        for z in zs:
            for n in range(nmax + 1):
                assert pow_rec(w * z, n, one) == pow_rec(w, n, one) * pow_rec(z, n, one)
    print("   通過（w %d 通り × z %d 通り × n=0,...,%d）" % (len(ws), len(zs), nmax))


def check_application():
    print("5. 応用の形。μ_L が積で閉じること")
    one = QQbar(1)
    for L in range(1, 9):
        roots = [QQbar.zeta(L)**j for j in range(L)]
        assert len(set(roots)) == L
        for w in roots:
            for z in roots:
                assert pow_rec(w, L, one) == one and pow_rec(z, L, one) == one
                assert pow_rec(w * z, L, one) == pow_rec(w, L, one) * pow_rec(z, L, one)
                assert pow_rec(w * z, L, one) == one   # すなわち wz ∈ μ_L
    print("   通過（L=1,...,8 の μ_L の全元の組）")


def check_noncommutative():
    print("6. 使っている性質（可換則は外せないが、可換な 2 元なら非可換環でも成り立つ）")
    M = MatrixSpace(QQ, 2, 2)
    one = M.one()
    w = M([[0, 1], [0, 0]])
    z = M([[0, 0], [1, 0]])
    assert w * z != z * w
    assert pow_rec(w * z, 2, one) != pow_rec(w, 2, one) * pow_rec(z, 2, one)
    # 可換な 2 元（一方がスカラー行列）なら非可換環の中でも成り立つ
    a = M([[1, 2], [0, 3]])
    b = 5 * one
    assert a * b == b * a
    for n in range(6):
        assert pow_rec(a * b, n, one) == pow_rec(a, n, one) * pow_rec(b, n, one)
    print("   通過（非可換な 2 元では破れ、可換な 2 元では成り立つ）")


print("== 代数的数の積の冪は冪の積である ==")
ws = [QQbar(2), QQbar(-3)/5, QQbar(sqrt(2)), QQbar(sqrt(-1)), QQbar(1)]
zs = [QQbar(7)/3, QQbar(-1), QQbar(sqrt(-3)), QQbar(5)**(1/3), QQbar(0)]
check_pow_convention()
check_base_chain(ws, zs)
check_step_chain(ws, zs, 6)
check_claim(ws, zs, 8)
check_application()
check_noncommutative()
print("すべて通過")
