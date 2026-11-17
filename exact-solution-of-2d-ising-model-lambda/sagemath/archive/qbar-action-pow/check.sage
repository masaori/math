# 対象ラベル: claim_qbar_action_pow
#   併せて引く定義: def_qbar_matrix_power, def_qbar_action_iterate,
#                   def_qbar_matrix, def_qbar_vector, def_qbar_matrix_action,
#                   def_qbar_matrix_product, def_qbar_identity_matrix
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「行列の冪の作用は、作用を反復したものである」（A^k · v = it^[k]_A(v)）を、
# 小さい L と k について確かめる。あわせて帰納法の 2 つの鎖（出発点の 3 段と
# 一歩の 4 段）を 1 段ずつ確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 冪と作用の反復が定義どおりに作られていること（再帰の 2 式）。
#   3. 出発点の鎖の 3 段（冪の定義・単位行列の作用・作用の反復の定義）。
#   4. 一歩の鎖の 4 段（冪の定義・積の作用・帰納法の仮定・作用の反復の定義）。
#   5. 主張そのもの。A^k · v = it^[k]_A(v) が写像の等号として成り立つこと。
#   6. 空虚でないこと。取っている v は零ベクトルでなく、A^k · v は k ごとに変わる。
#   7. 使っている性質。証明は積の可換性を使っていないので、成分を非可換環
#      （2 次上三角行列の環）に取っても主張が成り立つ。
#      また、冪の一歩を右から掛ける形（A^{k+1} := A^k A）に変えても同じ行列になる
#      （同じ行列の冪どうしは可換なので値は変わらない）。左から掛ける約束が効いているのは
#      証明の形の側だけである。

def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]

def identity_matrix_qbar(R, ring):
    return {(t, t1): (ring(1) if t1 == t else ring(0)) for t in R for t1 in R}

def mat_product(R, A, B):
    # (AB)_{τ,τ''} = Σ_{τ'} A_{τ,τ'} B_{τ',τ''}
    return {(t, t2): sum(A[(t, t1)] * B[(t1, t2)] for t1 in R) for t in R for t2 in R}

def act(R, A, v):
    # (A·v)(τ) = Σ_{τ'} A_{τ,τ'} v(τ')
    return {t: sum(A[(t, t1)] * v[t1] for t1 in R) for t in R}

def mat_pow(R, A, k, ring):
    # A^0 = I, A^{k+1} = A A^k（左から掛ける）
    P = identity_matrix_qbar(R, ring)
    for _ in range(k):
        P = mat_product(R, A, P)
    return P

def mat_pow_right(R, A, k, ring):
    # 比較用: A^0 = I, A^{k+1} = A^k A（右から掛ける）
    P = identity_matrix_qbar(R, ring)
    for _ in range(k):
        P = mat_product(R, P, A)
    return P

def action_iterate(R, A, v, k):
    # it^[0] = v, it^[k+1] = A · it^[k]
    w = dict(v)
    for _ in range(k):
        w = act(R, A, w)
    return w

def sample_matrix(R, ring):
    seeds = [QQbar(2).sqrt(), QQbar(3)**(1/3), QQbar.zeta(5), QQbar(-7)/QQbar(3),
             QQbar(5).sqrt() - QQbar(1), QQbar(0)]
    return {(t, t1): ring(seeds[(i + 2 * j) % len(seeds)] + QQbar(i - j))
            for i, t in enumerate(R) for j, t1 in enumerate(R)}

def sample_vector(R, ring):
    seeds = [QQbar(2).sqrt(), QQbar(3)**(1/3), QQbar.zeta(5), QQbar(-7)/QQbar(3),
             QQbar(5).sqrt() - QQbar(1)]
    return {t: ring(seeds[i % len(seeds)] + QQbar(i)) for i, t in enumerate(R)}


for L in [1, 2, 3]:
    R = row_configs(L)

    # 1. 添字集合
    assert len(R) == 2**L, (L, len(R))

    I = identity_matrix_qbar(R, QQbar)
    A = sample_matrix(R, QQbar)
    v = sample_vector(R, QQbar)

    # 6. 空虚でないこと
    assert any(v[t] != QQbar(0) for t in R)

    # 2. 再帰の 2 式（冪と作用の反復）
    assert mat_pow(R, A, 0, QQbar) == I
    assert action_iterate(R, A, v, 0) == v
    for k in range(4):
        assert mat_pow(R, A, k + 1, QQbar) == mat_product(R, A, mat_pow(R, A, k, QQbar))
        assert action_iterate(R, A, v, k + 1) == act(R, A, action_iterate(R, A, v, k))

    # 3. 出発点の鎖の 3 段
    base1 = act(R, mat_pow(R, A, 0, QQbar), v)   # A^0 · v
    base2 = act(R, I, v)                          # I · v      （第 1 段）
    base3 = v                                     # v          （第 2 段）
    base4 = action_iterate(R, A, v, 0)            # it^[0](v)  （第 3 段）
    assert base1 == base2 and base2 == base3 and base3 == base4

    for k in range(4):
        # 4. 一歩の鎖の 4 段
        s0 = act(R, mat_pow(R, A, k + 1, QQbar), v)                 # A^{k+1} · v
        s1 = act(R, mat_product(R, A, mat_pow(R, A, k, QQbar)), v)  # (A A^k) · v（第 1 段）
        s2 = act(R, A, act(R, mat_pow(R, A, k, QQbar), v))          # A · (A^k · v)（第 2 段）
        s3 = act(R, A, action_iterate(R, A, v, k))                  # A · it^[k](v)（第 3 段。帰納法の仮定）
        s4 = action_iterate(R, A, v, k + 1)                         # it^[k+1](v)（第 4 段）
        assert s0 == s1 and s1 == s2 and s2 == s3 and s3 == s4

        # 5. 主張そのもの
        assert act(R, mat_pow(R, A, k + 1, QQbar), v) == action_iterate(R, A, v, k + 1)

    # 6. 空虚でないこと（k ごとに値が変わっている）
    vals = [tuple(act(R, mat_pow(R, A, k, QQbar), v)[t] for t in R) for k in range(4)]
    assert len(set(vals)) == len(vals)

    print("L =", L, ": A^k·v = it^[k](v) を k = 0,...,4 で確認（鎖の 3 段と 4 段も一致）")

# 7a. 使っている性質: 成分を非可換環に取っても成り立つ（積の可換性を使っていない）
Rng = MatrixSpace(QQ, 2, 2)
for L in [1, 2, 3]:
    R = row_configs(L)
    nc = [Rng([[1, 1], [0, 2]]), Rng([[0, 3], [0, 1]]), Rng([[2, 0], [0, 5]]),
          Rng([[1, 7], [0, 1]]), Rng([[3, 2], [0, 4]]), Rng([[1, 0], [0, 1]]),
          Rng([[0, 1], [0, 0]]), Rng([[4, 4], [0, 4]])]
    A = {(t, t1): nc[(i + 3 * j) % len(nc)] for i, t in enumerate(R) for j, t1 in enumerate(R)}
    v = {t: nc[i % len(nc)] for i, t in enumerate(R)}
    for k in range(4):
        assert act(R, mat_pow(R, A, k, Rng), v) == action_iterate(R, A, v, k)
print("非可換環（2 次上三角行列）を成分に取っても A^k·v = it^[k](v) が成り立つ（可換性を使っていない）")

# 7b. 左から掛ける約束は値ではなく証明の形のためであること:
#     右から掛ける再帰（A^{k+1} := A^k A）も同じ行列を与える（同じ行列の冪どうしは
#     成分が非可換でも可換なので値は変わらない）。左から掛ける約束が効いているのは、
#     帰納法の一歩で外す因子が左になり claim_qbar_action_product をそのまま当てられる、
#     という証明の形の側だけである。
for L in [2, 3]:
    R = row_configs(L)
    nc = [Rng([[1, 1], [0, 2]]), Rng([[0, 3], [0, 1]]), Rng([[2, 0], [0, 5]]),
          Rng([[1, 7], [0, 1]]), Rng([[3, 2], [0, 4]]), Rng([[1, 0], [0, 1]]),
          Rng([[0, 1], [0, 0]]), Rng([[4, 4], [0, 4]])]
    A = {(t, t1): nc[(i + 3 * j) % len(nc)] for i, t in enumerate(R) for j, t1 in enumerate(R)}
    v = {t: nc[i % len(nc)] for i, t in enumerate(R)}
    for k in range(5):
        assert mat_pow_right(R, A, k, Rng) == mat_pow(R, A, k, Rng)
        assert act(R, mat_pow_right(R, A, k, Rng), v) == action_iterate(R, A, v, k)
print("右から掛ける再帰（A^{k+1} := A^k A）も同じ行列を与える（左から掛ける約束は値ではなく証明の形のため）")

print("すべて成立。実数体・複素数体は使っていない（QQbar の厳密計算）。")
