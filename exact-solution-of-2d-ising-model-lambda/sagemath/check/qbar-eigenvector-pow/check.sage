# 対象ラベル: claim_qbar_eigenvector_pow
#   併せて引く定義: def_qbar_matrix_power, def_qbar_vector_smul, def_qbar_matrix,
#                   def_qbar_vector, def_qbar_matrix_action, def_qbar_identity_matrix,
#                   def_qbar_eigenvector, def_root_of_unity_set
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「固有ベクトルへ行列の冪を作用させると、固有値の冪のスカラー倍になる」
# （A·v = z⊙v ならば A^k·v = z^k⊙v）を、小さい L と k について確かめる。
# あわせて、証明の準備の 2 つの等式と、帰納法の 2 つの鎖（出発点の 4 段と一歩の 7 段）を
# 1 段ずつ確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 準備の第 1 の等式。1⊙w = w。
#   3. 準備の第 2 の等式。(y z)⊙w = y⊙(z⊙w)。
#   4. 取った A・v・z が仮定 A·v = z⊙v を満たし、v が零ベクトルでないこと
#      （すなわち v が z に属する固有ベクトルであること）。
#   5. 出発点（k=0）の鎖の 4 段。
#   6. 一歩（k→k+1）の鎖の 7 段。
#   7. 主張そのもの。A^k·v = z^k⊙v が写像の等号として成り立つこと。
#   8. 空虚でないこと。A は対角行列ではなく（固有ベクトル以外は動く）、
#      z^k は k ごとに相異なる。
#   9. 使っている性質。証明は Q̄ について単位元との積と積の結合則しか使っていないので、
#      成分と係数を可換とは限らない環（2 次上三角行列の環）に取っても、
#      スカラーを中心元に取れば主張が成り立つ。

def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]

def identity_matrix_qbar(R, ring):
    return {(t, t1): (ring(1) if t1 == t else ring(0)) for t in R for t1 in R}

def mat_product(R, A, B):
    return {(t, t2): sum(A[(t, t1)] * B[(t1, t2)] for t1 in R) for t in R for t2 in R}

def act(R, A, v):
    # (A·v)(τ) = Σ_{τ'} A_{τ,τ'} v(τ')
    return {t: sum(A[(t, t1)] * v[t1] for t1 in R) for t in R}

def smul(R, z, v):
    # (z⊙v)(τ) = z v(τ)
    return {t: z * v[t] for t in R}

def mat_pow(R, A, k, ring):
    # A^0 = I, A^{k+1} = A A^k（左から掛ける）
    P = identity_matrix_qbar(R, ring)
    for _ in range(k):
        P = mat_product(R, A, P)
    return P

def scalar_pow(z, k, one):
    # z^0 = 1, z^{k+1} = z^k z
    p = one
    for _ in range(k):
        p = p * z
    return p

def eigen_pair(R, z, ring, seeds):
    # v は零でない列ベクトル、A は「z 倍する対角部分」と「v を消す部分」の和。
    # v を消す部分を足しても A·v = z⊙v は保たれるので、A は対角行列にならずに済む。
    v = {t: ring(seeds[i % len(seeds)]) + ring(i + 1) for i, t in enumerate(R)}
    order = list(R)
    n = len(order)
    A = {}
    for i, t in enumerate(order):
        for j, t1 in enumerate(order):
            e = z if t1 == t else ring(0)
            # v を消す部分: 行 i は列 j0 と j1 の 2 成分だけを持ち、
            # v(τ_{j0}) と v(τ_{j1}) を打ち消し合わせる。
            j0 = i % n
            j1 = (i + 1) % n
            if j == j0:
                e = e + v[order[j1]]
            if j == j1:
                e = e - v[order[j0]]
            A[(t, t1)] = e
    return A, v


ZETA = QQbar.zeta(5)
SEEDS = [QQbar(2).sqrt(), QQbar(3) ** (1 / 3), ZETA, QQbar(-7) / QQbar(3),
         QQbar(5).sqrt() - QQbar(1)]

for L in [1, 2, 3]:
    R = row_configs(L)

    # 1. 添字集合
    assert len(R) == 2 ** L, (L, len(R))

    I = identity_matrix_qbar(R, QQbar)

    for z in [QQbar(2).sqrt(), ZETA, QQbar(-3), QQbar(1)]:
        A, v = eigen_pair(R, z, QQbar, SEEDS)

        # 2. 準備の第 1 の等式。1⊙w = w
        assert smul(R, QQbar(1), v) == v

        # 3. 準備の第 2 の等式。(y z)⊙w = y⊙(z⊙w)
        for y in [QQbar(2).sqrt(), ZETA, QQbar(-3)]:
            assert smul(R, y * z, v) == smul(R, y, smul(R, z, v))

        # 4. 仮定（v が z に属する固有ベクトルであること）
        assert act(R, A, v) == smul(R, z, v)
        assert any(v[t] != QQbar(0) for t in R)

        # 5. 出発点の鎖の 4 段
        b0 = act(R, mat_pow(R, A, 0, QQbar), v)        # A^0 · v
        b1 = act(R, I, v)                               # I · v      （第 1 段）
        b2 = v                                          # v          （第 2 段）
        b3 = smul(R, QQbar(1), v)                       # 1⊙v        （第 3 段）
        b4 = smul(R, scalar_pow(z, 0, QQbar(1)), v)     # z^0⊙v      （第 4 段）
        assert b0 == b1 and b1 == b2 and b2 == b3 and b3 == b4

        for k in range(4):
            zk = scalar_pow(z, k, QQbar(1))

            # 6. 一歩の鎖の 7 段
            s0 = act(R, mat_pow(R, A, k + 1, QQbar), v)                    # A^{k+1} · v
            s1 = act(R, mat_product(R, A, mat_pow(R, A, k, QQbar)), v)     # (A A^k) · v（第 1 段）
            s2 = act(R, A, act(R, mat_pow(R, A, k, QQbar), v))             # A · (A^k · v)（第 2 段）
            s3 = act(R, A, smul(R, zk, v))                                 # A · (z^k⊙v)（第 3 段。帰納法の仮定）
            s4 = smul(R, zk, act(R, A, v))                                 # z^k⊙(A·v)（第 4 段）
            s5 = smul(R, zk, smul(R, z, v))                                # z^k⊙(z⊙v)（第 5 段）
            s6 = smul(R, zk * z, v)                                        # (z^k z)⊙v（第 6 段）
            s7 = smul(R, scalar_pow(z, k + 1, QQbar(1)), v)                # z^{k+1}⊙v（第 7 段）
            assert s0 == s1 and s1 == s2 and s2 == s3
            assert s3 == s4 and s4 == s5 and s5 == s6 and s6 == s7

            # 7. 主張そのもの
            assert act(R, mat_pow(R, A, k + 1, QQbar), v) == \
                smul(R, scalar_pow(z, k + 1, QQbar(1)), v)

        # 8. 空虚でないこと（A は対角行列ではない。固有ベクトル以外は動かされる）
        assert any(A[(t, t1)] != QQbar(0) for t in R for t1 in R if t != t1)

    # 8. 空虚でないこと（z^k は k ごとに相異なる。冪が実際に動いている）
    z = QQbar(2).sqrt()
    assert len({scalar_pow(z, k, QQbar(1)) for k in range(5)}) == 5

    print("L =", L, ": A^k·v = z^k⊙v を 4 つの固有値と k = 0,...,4 で確認"
          "（準備の 2 等式・出発点の 4 段・一歩の 7 段も一致）")

# 9. 使っている性質: Q̄ について使うのは単位元との積と積の結合則だけなので、
#    成分を可換とは限らない環（2 次上三角行列の環）に取り、スカラーを中心元
#    （単位行列のスカラー倍）に取っても主張が成り立つ。
Rng = MatrixSpace(QQ, 2, 2)
for L in [1, 2, 3]:
    R = row_configs(L)
    z = Rng([[3, 0], [0, 3]])   # 中心元
    u = Rng([[1, 5], [0, 2]])   # 零でない成分（可換とは限らない環の元）
    order = list(R)
    n = len(order)
    # v は全成分が同じ元 u。A は「z 倍する対角部分」と「v を消す部分」の和である
    # （行 i は列 i と列 i+1 に E と -E を置く。E*u + (-E)*u = 0 は可換性を使わない）。
    v = {t: u for t in order}
    E = Rng([[0, 1], [0, 4]])
    A = {}
    for i, t in enumerate(order):
        for j, t1 in enumerate(order):
            e = z if t1 == t else Rng(0)
            if j == i % n:
                e = e + E
            if j == (i + 1) % n:
                e = e - E
            A[(t, t1)] = e
    assert act(R, A, v) == smul(R, z, v)
    for k in range(4):
        assert act(R, mat_pow(R, A, k, Rng), v) == smul(R, scalar_pow(z, k, Rng(1)), v)
print("可換とは限らない環（2 次上三角行列）を成分に取り、スカラーを中心元に取っても "
      "A^k·v = z^k⊙v が成り立つ（体であることも逆元も使っていない）")

print("すべて成立。実数体・複素数体は使っていない（QQbar の厳密計算）。")
