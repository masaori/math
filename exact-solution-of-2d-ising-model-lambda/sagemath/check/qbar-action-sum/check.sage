# 対象ラベル: def_qbar_vector_sum, claim_qbar_action_sum
#   併せて引く定義: def_qbar_matrix, def_qbar_vector, def_qbar_matrix_action,
#                   def_qbar_vector_add, def_qbar_zero_vector
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の定義 1 件
# 「代数的数を成分とする列ベクトルの有限和」（(⊕_{i∈s} v_i)(τ) := Σ_{i∈s} v_i(τ)）と
# 主張 1 件「行列の作用は列ベクトルの有限和を保つ」（A·(⊕_{i∈s} v_i) = ⊕_{i∈s} (A·v_i)）を、
# 小さい L について行配位を添字とする行列と列ベクトルで確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 鎖の 6 段（作用の定義・有限和の定義・元と有限和の積についての分配則・
#      有限和の順序の入れ替え・作用の定義・有限和の定義）。
#   3. 主張そのもの。A·(⊕_{i∈s} v_i) = ⊕_{i∈s} (A·v_i) が全成分で成り立つこと。
#   4. 空の添字集合。s = ∅ のとき有限和が零ベクトルであること、および主張がその場合も
#      成り立つこと（両辺とも零ベクトル）。
#   5. 有限和が 2 元の和（def_qbar_vector_add）の繰り返しと一致すること。
#      成分ごとに定めた有限和が、2 元の和を繰り返した形と同じ元を与えることの確認である。
#   6. 主張が空虚でないこと。両辺が零ベクトルでない例があること。
#   7. 使っている性質。証明は積の可換性も結合則も使っていないので、成分を非可換環
#      （2 次上三角行列の環）に取っても成り立つ。

def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]

def act(R, A, v):
    # (A·v)(τ) = Σ_{τ'} A_{τ,τ'} v(τ')
    return {t: sum(A[(t, t1)] * v[t1] for t1 in R) for t in R}

def vec_add(R, v, w):
    # (v ⊕ w)(τ) = v(τ) + w(τ)
    return {t: v[t] + w[t] for t in R}

def vec_sum(R, s, vs, zero):
    # (⊕_{i∈s} v_i)(τ) = Σ_{i∈s} v_i(τ)。成分ごとの有限和として定める。
    return {t: sum((vs[i][t] for i in s), zero) for t in R}

def zero_vec(R, zero):
    return {t: zero for t in R}

# 検証に使う代数的数（すべて QQbar の厳密な元。有理数でないものを混ぜる）。
alg = [QQbar(0), QQbar(1), QQbar(-2), QQbar(3)/QQbar(5),
       QQbar(2).sqrt(), -QQbar(3).sqrt(), QQbar(-1).sqrt(), QQbar(5).nth_root(3)]

def sample(k):
    return alg[k % len(alg)]

print("== 行列の作用が列ベクトルの有限和を保つこと ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # ---- 1. 添字集合 -------------------------------------------------------
    assert len(R) == 2 ** L, "R_L の元の個数が 2^L でない"

    idx = {t: i for i, t in enumerate(R)}
    A = {(t, t1): sample(3 * idx[t] + 5 * idx[t1] + 1) for t in R for t1 in R}

    # 添字集合 s は 0,...,n-1 とし、n を動かす（n=0 は空集合）。
    for n in [0, 1, 2, 3, 5]:
        s = list(range(n))
        vs = {i: {t: sample(7 * i + 11 * idx[t] + 6) for t in R} for i in s}
        Avs = {i: act(R, A, vs[i]) for i in s}

        for t in R:
            # ---- 2. 鎖の 6 段 ---------------------------------------------
            lhs = sum(A[(t, t1)] * vec_sum(R, s, vs, QQbar(0))[t1] for t1 in R)   # 第 1 段
            step2 = sum(A[(t, t1)] * sum((vs[i][t1] for i in s), QQbar(0))
                        for t1 in R)                                             # 第 2 段
            step3 = sum(sum((A[(t, t1)] * vs[i][t1] for i in s), QQbar(0))
                        for t1 in R)                                             # 第 3 段
            step4 = sum(sum((A[(t, t1)] * vs[i][t1] for t1 in R), QQbar(0))
                        for i in s)                                              # 第 4 段
            step5 = sum((Avs[i][t] for i in s), QQbar(0))                        # 第 5 段
            step6 = vec_sum(R, s, Avs, QQbar(0))[t]                              # 第 6 段
            assert lhs == step2 == step3 == step4 == step5 == step6, \
                "有限和の鎖のどこかで値が変わった"

        # ---- 3. 主張そのもの（写像としての等号） ---------------------------
        assert act(R, A, vec_sum(R, s, vs, QQbar(0))) == vec_sum(R, s, Avs, QQbar(0)), \
            "作用が有限和を保つことが破れた"

        # ---- 5. 2 元の和の繰り返しとの一致 ---------------------------------
        repeated = zero_vec(R, QQbar(0))
        for i in s:
            repeated = vec_add(R, repeated, vs[i])
        assert repeated == vec_sum(R, s, vs, QQbar(0)), \
            "成分ごとの有限和が 2 元の和の繰り返しと一致しない"

    # ---- 4. 空の添字集合 ---------------------------------------------------
    empty_sum = vec_sum(R, [], {}, QQbar(0))
    assert empty_sum == zero_vec(R, QQbar(0)), "空の添字集合での有限和が零ベクトルでない"
    assert act(R, A, empty_sum) == zero_vec(R, QQbar(0)), \
        "零ベクトルへの作用が零ベクトルでない"

    # ---- 6. 主張が空虚でないこと -------------------------------------------
    s = [0, 1, 2]
    vs = {i: {t: sample(7 * i + 11 * idx[t] + 6) for t in R} for i in s}
    both = act(R, A, vec_sum(R, s, vs, QQbar(0)))
    assert any(both[t] != 0 for t in R), "両辺が零ベクトルになっている"

    print("L=%d: R_L は %d 元。項の個数 0,1,2,3,5 のすべてで鎖の 6 段と主張が成り立ち、"
          "空の添字集合では零ベクトル、2 元の和の繰り返しとも一致する" % (L, len(R)))

# ---- 7. 使っている性質（非可換環で試す） -----------------------------------
# 2 次上三角行列の環（可換でない）を成分に取る。証明は積の可換性も結合則も使っていない
# ので、ここでも成り立つはずである。
Rng = MatrixSpace(QQ, 2, 2)

def tri(a, b, d):
    return Rng([[a, b], [0, d]])

L = 2
R = row_configs(L)
idx = {t: i for i, t in enumerate(R)}
An = {(t, t1): tri(idx[t] + 1, idx[t1] + 2, idx[t] + idx[t1] + 1) for t in R for t1 in R}
sn = [0, 1, 2]
vsn = {i: {t: tri(i + 1, idx[t] + 3, 2 * i + 2) for t in R} for i in sn}
zero_n = Rng(0)

assert tri(1, 2, 3) * tri(4, 5, 6) != tri(4, 5, 6) * tri(1, 2, 3), "取った環が可換だった"

assert (act(R, An, vec_sum(R, sn, vsn, zero_n))
        == vec_sum(R, sn, {i: act(R, An, vsn[i]) for i in sn}, zero_n)), \
    "非可換環で有限和を保つことが破れた（証明が可換性を使っていないはずである）"

print("7. 非可換環（2 次上三角行列）を成分に取っても成り立つ（可換性も結合則も使っていない）")
print("すべて通過")
