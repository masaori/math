# 対象ラベル: claim_qbar_action_add, claim_qbar_action_smul
#   併せて引く定義: def_qbar_vector_add, def_qbar_vector_smul,
#                   def_qbar_matrix, def_qbar_vector, def_qbar_matrix_action
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張 2 件
# 「行列の作用は列ベクトルの和を保つ」（A·(v⊕w) = (A·v)⊕(A·w)）と
# 「行列の作用は列ベクトルのスカラー倍を保つ」（A·(z⊙v) = z⊙(A·v)）を、
# 小さい L について行配位を添字とする行列と列ベクトルで確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 和の鎖の 6 段（作用の定義・和の定義・分配則・項ごとの分割・作用の定義・和の定義）。
#   3. 和についての主張そのもの。A·(v⊕w) = (A·v)⊕(A·w) が全成分で成り立つこと。
#   4. スカラー倍の鎖の 8 段（作用の定義・スカラー倍の定義・結合則・可換性・結合則・
#      分配則・作用の定義・スカラー倍の定義）。
#   5. スカラー倍についての主張そのもの。A·(z⊙v) = z⊙(A·v) が全成分で成り立つこと。
#   6. 主張が空虚でないこと。両辺が零ベクトルでない例があること。
#   7. 使っている性質の差。和を保つことは積の可換性を使っていないので、成分を非可換環
#      （2 次上三角行列の環）に取っても成り立つ。一方スカラー倍を保つことは可換性を
#      使っており、同じ非可換環では実際に破れる例がある。

def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]

def act(R, A, v):
    # (A·v)(τ) = Σ_{τ'} A_{τ,τ'} v(τ')
    return {t: sum(A[(t, t1)] * v[t1] for t1 in R) for t in R}

def vec_add(R, v, w):
    # (v ⊕ w)(τ) = v(τ) + w(τ)
    return {t: v[t] + w[t] for t in R}

def vec_smul(R, z, v):
    # (z ⊙ v)(τ) = z v(τ)
    return {t: z * v[t] for t in R}

# 検証に使う代数的数（すべて QQbar の厳密な元。有理数でないものを混ぜる）。
alg = [QQbar(0), QQbar(1), QQbar(-2), QQbar(3)/QQbar(5),
       QQbar(2).sqrt(), -QQbar(3).sqrt(), QQbar(-1).sqrt(), QQbar(5).nth_root(3)]

def sample(k):
    return alg[k % len(alg)]

print("== 代数的数を成分とする行列の作用が和とスカラー倍を保つこと ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # ---- 1. 添字集合 -------------------------------------------------------
    assert len(R) == 2 ** L, "R_L の元の個数が 2^L でない"

    idx = {t: i for i, t in enumerate(R)}
    A = {(t, t1): sample(3 * idx[t] + 5 * idx[t1] + 1) for t in R for t1 in R}
    v = {t: sample(11 * idx[t] + 6) for t in R}
    w = {t: sample(4 * idx[t] + 3) for t in R}
    z = QQbar(2).sqrt() - QQbar(3) / QQbar(7)

    Av = act(R, A, v)
    Aw = act(R, A, w)

    for t in R:
        # ---- 2. 和の鎖の 6 段 ---------------------------------------------
        lhs = sum(A[(t, t1)] * vec_add(R, v, w)[t1] for t1 in R)   # 第 1 段
        step2 = sum(A[(t, t1)] * (v[t1] + w[t1]) for t1 in R)       # 第 2 段
        step3 = sum(A[(t, t1)] * v[t1] + A[(t, t1)] * w[t1] for t1 in R)  # 第 3 段
        step4 = (sum(A[(t, t1)] * v[t1] for t1 in R)
                 + sum(A[(t, t1)] * w[t1] for t1 in R))             # 第 4 段
        step5 = Av[t] + Aw[t]                                       # 第 5 段
        step6 = vec_add(R, Av, Aw)[t]                               # 第 6 段
        assert lhs == step2 == step3 == step4 == step5 == step6, "和の鎖のどこかで値が変わった"

        # ---- 4. スカラー倍の鎖の 8 段 --------------------------------------
        slhs = sum(A[(t, t1)] * vec_smul(R, z, v)[t1] for t1 in R)  # 第 1 段
        s2 = sum(A[(t, t1)] * (z * v[t1]) for t1 in R)              # 第 2 段
        s3 = sum((A[(t, t1)] * z) * v[t1] for t1 in R)              # 第 3 段
        s4 = sum((z * A[(t, t1)]) * v[t1] for t1 in R)              # 第 4 段
        s5 = sum(z * (A[(t, t1)] * v[t1]) for t1 in R)              # 第 5 段
        s6 = z * sum(A[(t, t1)] * v[t1] for t1 in R)                # 第 6 段
        s7 = z * Av[t]                                              # 第 7 段
        s8 = vec_smul(R, z, Av)[t]                                  # 第 8 段
        assert slhs == s2 == s3 == s4 == s5 == s6 == s7 == s8, "スカラー倍の鎖のどこかで値が変わった"

    # ---- 3・5. 主張そのもの（写像としての等号） -----------------------------
    assert act(R, A, vec_add(R, v, w)) == vec_add(R, Av, Aw), "和を保つことが破れた"
    assert act(R, A, vec_smul(R, z, v)) == vec_smul(R, z, Av), "スカラー倍を保つことが破れた"

    # ---- 6. 主張が空虚でないこと -------------------------------------------
    assert any(Av[t] != 0 for t in R), "A·v が零ベクトルなので例として弱い"
    assert any(vec_add(R, Av, Aw)[t] != 0 for t in R), "両辺が零ベクトルになっている"

    print("L=%d: R_L は %d 元。和の鎖 6 段・スカラー倍の鎖 8 段と 2 つの主張が成り立ち、"
          "値は零ベクトルでない" % (L, len(R)))

# ---- 7. 使っている性質の差（非可換環で試す） -------------------------------
# 2 次上三角行列の環（可換でない）を成分に取る。
Rng = MatrixSpace(QQ, 2, 2)

def tri(a, b, d):
    return Rng([[a, b], [0, d]])

L = 2
R = row_configs(L)
idx = {t: i for i, t in enumerate(R)}
An = {(t, t1): tri(idx[t] + 1, idx[t1] + 2, idx[t] + idx[t1] + 1) for t in R for t1 in R}
vn = {t: tri(idx[t] + 1, 3, 2) for t in R}
wn = {t: tri(2, idx[t] + 1, 5) for t in R}
zn = tri(1, 2, 3)

# 和を保つことは可換性を使っていないので、非可換環でも成り立つ。
assert act(R, An, vec_add(R, vn, wn)) == vec_add(R, act(R, An, vn), act(R, An, wn)), \
    "非可換環で和を保つことが破れた（証明が可換性を使っていないはずである）"

# 環が実際に非可換であること。
assert tri(1, 2, 3) * tri(4, 5, 6) != tri(4, 5, 6) * tri(1, 2, 3), "取った環が可換だった"

# スカラー倍を保つことは可換性を使っているので、非可換環では破れる。
assert act(R, An, vec_smul(R, zn, vn)) != vec_smul(R, zn, act(R, An, vn)), \
    "非可換環でもスカラー倍を保っている（可換性が本当に要るかを見直すこと）"

print("7. 和の側は非可換環でも成り立ち（可換性を使っていない）、"
      "スカラー倍の側は非可換環で破れる（可換性を使っている）")
print("すべて通過")
