# 対象ラベル: claim_root_of_unity_pow
#   併せて引く定義: def_algebraic_numbers, def_root_of_unity_set
#   併せて引く主張: claim_root_of_unity_mul
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張 1 件
# 「1 の冪根の冪は 1 の冪根である」（w ∈ μ_n ならば任意の k について w^k ∈ μ_n）を確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 出発点（k = 0）。w^0 = 1 であること、1^n = 1 であること、したがって 1 ∈ μ_n。
#   2. 一歩。w^{k+1} = w^k w であること、w^k ∈ μ_n と w ∈ μ_n から w^{k+1} ∈ μ_n。
#   3. 主張そのもの。w ∈ μ_n ならば w^k ∈ μ_n。
#   4. 応用の形。w^{n-1} が μ_n の元であり、w との積が 1 になること
#      （次のセクションで μ_n の元を掛ける操作の逆写像を作るのに使う形である）。
#   5. 使っている性質。証明が使うのは「μ_n が 1 を含むこと」と「μ_n が積で閉じていること」の
#      2 つだけで、1 の冪根であることそのものは使っていない。そこで
#      (a) 1 の冪根でない集合（2 の冪の全体）でも同じ帰納法が通ること、
#      (b) 可換でないモノイド（2 次行列環）でも通ること、
#      (c) 積で閉じていない集合では破れること、を見る。

def pow_rec(y, n, one):
    # 本文の約束: y^0 := 1, y^{j+1} := y^j y
    acc = one
    for _ in range(n):
        acc = acc * y
    return acc


def mu(n):
    # 1 の n 乗根の全体（n >= 1）
    return [QQbar.zeta(n)**j for j in range(n)]


def check_base(nmax):
    print("1. 出発点（w^0 = 1 と 1^n = 1、したがって 1 ∈ μ_n）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        for w in mu(n):
            assert pow_rec(w, 0, one) == one            # w^0 = 1（冪の約束）
        assert pow_rec(one, n, one) == one              # 1^n = 1（単位元の反復積）
    print("   通過（n=1,...,%d）" % nmax)


def check_step(nmax, kmax):
    print("2. 一歩（w^{k+1} = w^k w と、積で閉じていることの適用）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = set(mu(n))
        for w in roots:
            for k in range(kmax + 1):
                wk = pow_rec(w, k, one)
                assert pow_rec(w, k + 1, one) == wk * w  # 冪の約束
                assert pow_rec(wk, n, one) == one        # 帰納法の仮定 w^k ∈ μ_n
                assert pow_rec(wk * w, n, one) == one    # 積で閉じている
                assert wk * w in roots
    print("   通過（n=1,...,%d、k=0,...,%d）" % (nmax, kmax))


def check_claim(nmax, kmax):
    print("3. 主張そのもの。w ∈ μ_n ならば w^k ∈ μ_n")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = set(mu(n))
        for w in roots:
            for k in range(kmax + 1):
                wk = pow_rec(w, k, one)
                assert pow_rec(wk, n, one) == one
                assert wk in roots
    print("   通過（n=1,...,%d、k=0,...,%d）" % (nmax, kmax))


def check_application(nmax):
    print("4. 応用の形（w^{n-1} ∈ μ_n で、w との積が 1 になる）")
    one = QQbar(1)
    for n in range(1, nmax + 1):
        roots = set(mu(n))
        for w in roots:
            v = pow_rec(w, n - 1, one)
            assert v in roots
            assert v * w == one
            assert w * v == one
    print("   通過（n=1,...,%d）" % nmax)


def check_used_properties(kmax):
    print("5. 使っている性質（1 の冪根であることは使っていない／2 つの条件は外せない）")
    one = QQbar(1)
    # (a) 1 の冪根でない集合。2 の冪の全体は 1 を含み積で閉じている。
    w = QQbar(2)
    powers = set(pow_rec(w, k, one) for k in range(kmax + 1))
    assert one in powers
    for k in range(kmax + 1):
        assert pow_rec(w, k, one) in powers
    # (b) 可換でないモノイド。2 次行列環の 90 度回転（4 乗して単位行列）。
    M2 = MatrixSpace(QQbar, 2)
    idm = M2.identity_matrix()
    rot = M2([[0, -1], [1, 0]])
    swap = M2([[0, 1], [1, 0]])
    assert rot * swap != swap * rot           # このモノイドは可換ではない
    rot_powers = [pow_rec(rot, k, idm) for k in range(4)]
    for k in range(kmax + 1):
        assert pow_rec(rot, k, idm) in rot_powers   # 帰納法はそのまま通る
    # (c) 積で閉じていない集合では破れる。{1, 2} は 1 を含むが積で閉じていない。
    not_closed = [QQbar(1), QQbar(2)]
    assert pow_rec(QQbar(2), 2, one) not in not_closed
    print("   通過（1 の冪根でなくても通り、可換でなくても通り、積で閉じていないと破れる）")


print("== 1 の冪根の冪は 1 の冪根である ==")
check_base(8)
check_step(8, 10)
check_claim(8, 10)
check_application(8)
check_used_properties(10)
print("すべて通過")
