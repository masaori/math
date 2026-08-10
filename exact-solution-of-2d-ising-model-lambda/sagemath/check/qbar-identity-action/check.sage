# 対象ラベル: claim_qbar_identity_action
#   併せて引く定義: def_qbar_identity_matrix, def_qbar_matrix, def_qbar_vector,
#                   def_qbar_matrix_action
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「単位行列の作用は列ベクトルを動かさない」（I^Qbar_L · v = v）を、小さい L について
# 確かめる。あわせて人手証明の鎖の 7 段を 1 段ずつ確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 単位行列の成分が定義どおりであること（対角で 1、対角の外で 0）。
#   3. 鎖の 7 段（作用の定義・1 項を分ける・単位行列の定義・単位元との積・零元との積・
#      零元だけの有限和・零元との和）。
#   4. 主張そのもの。I·v = v が写像の等号として成り立つこと。
#   5. 空虚でないこと。取っている v は零ベクトルではない（成分が相異なる代数的数）。
#   6. 使っている性質。証明は積の可換性も加法の逆元も逆元の存在も使っていないので、
#      成分を非可換環（2 次上三角行列の環）に取っても主張が成り立つ。
#      一方、単位行列の定義から対角成分を 1 以外に取ると主張は破れる（仮定が効いている）。

def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]

def identity_matrix_qbar(R, ring):
    # 単位行列 (I)_{τ,τ'} = 1 (τ'=τ), 0 (τ'≠τ)
    return {(t, t1): (ring(1) if t1 == t else ring(0)) for t in R for t1 in R}

def act(R, A, v):
    # (A·v)(τ) = Σ_{τ'} A_{τ,τ'} v(τ')
    return {t: sum(A[(t, t1)] * v[t1] for t1 in R) for t in R}

def sample_vector(R, ring):
    # 成分が相異なる列ベクトル v。代数的数を使う（√2, ∛3, 1 の冪根など）。
    seeds = [QQbar(2).sqrt(), QQbar(3)**(1/3), QQbar.zeta(5), QQbar(-7)/QQbar(3),
             QQbar(5).sqrt() - QQbar(1)]
    return {t: ring(seeds[i % len(seeds)] + QQbar(i)) for i, t in enumerate(R)}


ok = True

for L in [1, 2, 3, 4]:
    R = row_configs(L)

    # 1. 添字集合
    assert len(R) == 2**L, (L, len(R))
    assert len(set(R)) == len(R)

    I = identity_matrix_qbar(R, QQbar)
    v = sample_vector(R, QQbar)

    # 2. 単位行列の成分
    for t in R:
        for t1 in R:
            assert I[(t, t1)] == (QQbar(1) if t1 == t else QQbar(0))

    # 5. 空虚でないこと（v は零ベクトルでない）
    assert any(v[t] != QQbar(0) for t in R)

    for t in R:
        # 鎖の第 1 段: 作用の定義
        step1 = sum(I[(t, t1)] * v[t1] for t1 in R)
        assert act(R, I, v)[t] == step1

        # 第 2 段: 有限和から τ'=τ の 1 項を分ける
        step2 = I[(t, t)] * v[t] + sum(I[(t, t1)] * v[t1] for t1 in R if t1 != t)
        assert step1 == step2

        # 第 3 段: 単位行列の定義
        step3 = QQbar(1) * v[t] + sum(QQbar(0) * v[t1] for t1 in R if t1 != t)
        assert step2 == step3

        # 第 4 段: 単位元との積
        step4 = v[t] + sum(QQbar(0) * v[t1] for t1 in R if t1 != t)
        assert step3 == step4

        # 第 5 段: 零元との積
        step5 = v[t] + sum(QQbar(0) for t1 in R if t1 != t)
        assert step4 == step5

        # 第 6 段: 零元だけの有限和は零元である
        step6 = v[t] + QQbar(0)
        assert step5 == step6

        # 第 7 段: 零元を足しても変わらない
        step7 = v[t]
        assert step6 == step7

    # 4. 主張そのもの（写像の等号）
    assert act(R, I, v) == v
    print("L =", L, ": I·v = v を", len(R), "成分すべてで確認（鎖の 7 段も一致）")

# 6a. 使っている性質: 成分を非可換環に取っても成り立つ（積の可換性を使っていない）
Rng = MatrixSpace(QQ, 2, 2)
for L in [1, 2, 3]:
    R = row_configs(L)
    I = identity_matrix_qbar(R, Rng)
    nc = [Rng([[1, 1], [0, 2]]), Rng([[0, 3], [0, 1]]), Rng([[2, 0], [0, 5]]),
          Rng([[1, 7], [0, 1]]), Rng([[3, 2], [0, 4]]), Rng([[1, 0], [0, 1]]),
          Rng([[0, 1], [0, 0]]), Rng([[4, 4], [0, 4]])]
    v = {t: nc[i % len(nc)] for i, t in enumerate(R)}
    assert act(R, I, v) == v
print("非可換環（2 次上三角行列）を成分に取っても I·v = v が成り立つ（可換性を使っていない）")

# 6b. 仮定が効いていること: 対角成分を 1 以外にすると破れる
R = row_configs(2)
I_bad = identity_matrix_qbar(R, QQbar)
t0 = R[0]
I_bad[(t0, t0)] = QQbar(2)
v = sample_vector(R, QQbar)
assert act(R, I_bad, v) != v
print("対角成分を 1 から動かすと I·v = v は破れる（単位元であることが効いている）")

print("すべて成立。実数体・複素数体は使っていない（QQbar の厳密計算）。")
