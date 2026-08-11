# 対象ラベル: def_root_of_unity_mul_map, claim_root_of_unity_mul_map_bijective
#   併せて引く定義: def_algebraic_numbers, def_root_of_unity_set
#   併せて引く主張: claim_root_of_unity_mul（写像の行き先が μ_n に収まること）、
#                   claim_root_of_unity_pow（w^{n-1} が μ_n に属すること）
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の定義 1 件
# 「1 の冪根を掛ける写像 θ^{(n)}_w(z) = w z」と主張 1 件
# 「n ≥ 1 のとき θ^{(n)}_w は全単射であり、逆写像は θ^{(n)}_{w^{n-1}} である」を確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 写像が定まること（行き先が μ_n に収まること）。定義の well-defined 性である。
#   2. 準備の鎖。w^{n-1} ∈ μ_n であること、w^{n-1} w = w^{(n-1)+1} = w^n = 1 の 3 段。
#   3. 第 1 の往復。θ_{w^{n-1}}(θ_w(z)) = z を、鎖の各段
#      w^{n-1}(w z) = (w^{n-1} w) z = 1·z = z として確かめる。
#   4. 第 2 の往復。θ_w(θ_{w^{n-1}}(z)) = z を、鎖の各段
#      w(w^{n-1} z) = (w w^{n-1}) z = (w^{n-1} w) z = 1·z = z として確かめる。
#   5. 主張そのもの。θ_w が μ_n の全単射であること（単射性・全射性を別々に、
#      さらに写像を実際に列挙して置換であることを見る）。
#   6. n ≥ 1 が外せないこと。n = 0 のときは μ_0 = QQbar で w = 0 が取れ、
#      掛ける操作は全単射でない。
#   7. 使っている性質。証明が使うのは結合則・可換則・単位元と、両側の逆元の存在だけである。
#      そこで (a) 1 の冪根でない集合（2 の冪の全体は逆元を欠くので全単射にならない）、
#      (b) 可換でないモノイド（2 次行列環）でも、両側の逆元を持つ元なら通ること、を見る。

def pow_rec(y, n, one):
    # 本文の約束: y^0 := 1, y^{j+1} := y^j y
    acc = one
    for _ in range(n):
        acc = acc * y
    return acc


def mu(n):
    # 1 の n 乗根の全体（n >= 1）
    return [QQbar.zeta(n)**j for j in range(n)]


def check_well_defined(nmax):
    print("1. 写像が定まること（θ_w(z) = w z の行き先が μ_n に収まる）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = set(mu(n))
        for w in roots:
            for z in roots:
                assert pow_rec(w * z, n, one) == one   # claim_root_of_unity_mul
                assert w * z in roots
    print("   通過（n=1,...,%d）" % nmax)


def check_preparation(nmax):
    print("2. 準備（w^{n-1} ∈ μ_n と、w^{n-1} w = w^{(n-1)+1} = w^n = 1）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = set(mu(n))
        for w in roots:
            v = pow_rec(w, n - 1, one)
            assert v in roots                          # claim_root_of_unity_pow
            assert v * w == pow_rec(w, (n - 1) + 1, one)  # 第 1 段。冪の約束。
            assert pow_rec(w, (n - 1) + 1, one) == pow_rec(w, n, one)  # 第 2 段。(n-1)+1 = n。
            assert pow_rec(w, n, one) == one           # 第 3 段。w ∈ μ_n。
    print("   通過（n=1,...,%d）" % nmax)


def check_round_trip_first(nmax):
    print("3. 第 1 の往復（θ_{w^{n-1}}(θ_w(z)) = z）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = set(mu(n))
        for w in roots:
            v = pow_rec(w, n - 1, one)
            for z in roots:
                assert v * (w * z) == (v * w) * z      # 結合則。
                assert (v * w) * z == one * z          # 準備の等式。
                assert one * z == z                   # 単位元。
                assert v * (w * z) == z
    print("   通過（n=1,...,%d）" % nmax)


def check_round_trip_second(nmax):
    print("4. 第 2 の往復（θ_w(θ_{w^{n-1}}(z)) = z）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = set(mu(n))
        for w in roots:
            v = pow_rec(w, n - 1, one)
            for z in roots:
                assert w * (v * z) == (w * v) * z      # 結合則。
                assert (w * v) * z == (v * w) * z      # 可換則。
                assert (v * w) * z == one * z          # 準備の等式。
                assert one * z == z                   # 単位元。
                assert w * (v * z) == z
    print("   通過（n=1,...,%d）" % nmax)


def check_bijective(nmax):
    print("5. 主張そのもの（θ_w は μ_n の全単射で、逆写像は θ_{w^{n-1}}）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = mu(n)
        rootset = set(roots)
        for w in roots:
            v = pow_rec(w, n - 1, one)
            image = [w * z for z in roots]
            # 単射性。像が相異なる。
            assert len(set(image)) == len(roots)
            # 全射性。像が μ_n を覆う。
            assert set(image) == rootset
            # 逆写像であること。
            for z in roots:
                assert v * (w * z) == z
                assert w * (v * z) == z
    print("   通過（n=1,...,%d）" % nmax)


def check_n_positive():
    print("6. n ≥ 1 が外せないこと（n = 0 では μ_0 = QQbar で w = 0 が取れる）")
    # μ_0 = { z ∈ QQbar | z^0 = 1 } = QQbar なので 0 ∈ μ_0 である。
    one = QQbar(1)
    w = QQbar(0)
    assert pow_rec(w, 0, one) == one          # w^0 = 1、すなわち w ∈ μ_0
    # 0 を掛ける操作は単射でない（1 と 2 の像が一致する）。
    assert w * QQbar(1) == w * QQbar(2)
    assert QQbar(1) != QQbar(2)
    print("   通過（0 を掛ける操作は単射でない）")


def check_used_properties():
    print("7. 使っている性質（両側の逆元だけが要る。可換性は必要十分版では不要）")
    one = QQbar(1)
    # (a) 2 の冪の全体は 1 を含み積で閉じているが、2 の逆元を含まない。
    #     2 を掛ける操作は S = {2^k | k ≥ 0} から S への単射だが全射でない（1 が像に無い）。
    S = [pow_rec(QQbar(2), k, one) for k in range(12)]
    image = [QQbar(2) * s for s in S]
    assert one not in image
    # (b) 可換でないモノイド（2 次行列環）。90 度回転は両側の逆元（3 乗）を持つ。
    M2 = MatrixSpace(QQbar, 2)
    idm = M2.identity_matrix()
    rot = M2([[0, -1], [1, 0]])
    swap = M2([[0, 1], [1, 0]])
    assert rot * swap != swap * rot            # このモノイドは可換ではない
    S4 = [pow_rec(rot, k, idm) for k in range(4)]
    inv = pow_rec(rot, 3, idm)
    assert inv * rot == idm
    assert rot * inv == idm
    image4 = [rot * s for s in S4]
    assert len(set(tuple(m.list()) for m in image4)) == 4          # 単射
    assert set(tuple(m.list()) for m in image4) == set(tuple(m.list()) for m in S4)  # 全射
    print("   通過（逆元が無いと全射性が破れ、可換でなくても両側の逆元があれば通る）")


print("== 1 の冪根を掛ける写像は全単射である ==")
check_well_defined(8)
check_preparation(8)
check_round_trip_first(8)
check_round_trip_second(8)
check_bijective(8)
check_n_positive()
check_used_properties()
print("すべて通過")
