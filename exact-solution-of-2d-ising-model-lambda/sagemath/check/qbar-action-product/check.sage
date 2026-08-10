# 対象ラベル: claim_qbar_action_product
#   併せて引く定義: def_qbar_matrix, def_qbar_matrix_product,
#                   def_qbar_vector, def_qbar_matrix_action
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「行列の積の作用は、作用を 2 度施したものである」（(AB)·v = A·(B·v)）を、
# 小さい L について行配位を添字とする行列と列ベクトルで確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体 Qbar は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか（人手証明の鎖の 8 段に 1 対 1 で対応させる）:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 鎖の第 1・2 段。作用の定義と積の定義（(AB)·v の τ 成分を二重和へ開く）。
#   3. 鎖の第 3・4 段。分配則と積の結合則（各項の書き換え）。
#   4. 鎖の第 5 段。有限和の順序の入れ替え。
#   5. 鎖の第 6・7・8 段。分配則で A の成分を外へ出し、作用の定義へ戻すこと。
#   6. 主張そのもの。(AB)·v = A·(B·v) が全成分で成り立つこと。
#   7. 主張が空虚でないこと。左辺・右辺が零ベクトルでない例があること。
#   8. 使っている性質。可換性を仮定しない環（4 元数環ではなく上三角行列環）でも
#      同じ言明が成り立つこと、すなわちこの証明が積の可換性を使っていないこと。

def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]

def mat_product(R, A, B):
    # (AB)_{τ,τ''} = Σ_{τ'} A_{τ,τ'} B_{τ',τ''}
    return {(t, t2): sum(A[(t, t1)] * B[(t1, t2)] for t1 in R) for t in R for t2 in R}

def act(R, A, v):
    # (A·v)(τ) = Σ_{τ'} A_{τ,τ'} v(τ')
    return {t: sum(A[(t, t1)] * v[t1] for t1 in R) for t in R}

# 検証に使う代数的数（すべて QQbar の厳密な元。有理数でないものを混ぜる）。
alg = [QQbar(0), QQbar(1), QQbar(-2), QQbar(3)/QQbar(5),
       QQbar(2).sqrt(), -QQbar(3).sqrt(), QQbar(-1).sqrt(), QQbar(5).nth_root(3)]

def sample(k):
    return alg[k % len(alg)]

print("== 代数的数を成分とする行列の作用と積の両立 ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # ---- 1. 添字集合 -------------------------------------------------------
    assert len(R) == 2 ** L, "R_L の元の個数が 2^L でない"

    # 行列と列ベクトルを、添字から決まる規則で作る（乱数を使わず再現可能にする）。
    idx = {t: i for i, t in enumerate(R)}
    A = {(t, t1): sample(3 * idx[t] + 5 * idx[t1] + 1) for t in R for t1 in R}
    B = {(t, t1): sample(7 * idx[t] + 2 * idx[t1] + 4) for t in R for t1 in R}
    v = {t: sample(11 * idx[t] + 6) for t in R}

    AB = mat_product(R, A, B)

    for t in R:
        # ---- 2. 鎖の第 1・2 段（作用の定義 → 積の定義） --------------------
        lhs = sum(AB[(t, t2)] * v[t2] for t2 in R)
        step2 = sum(sum(A[(t, t1)] * B[(t1, t2)] for t1 in R) * v[t2] for t2 in R)
        assert lhs == step2, "第 2 段（積の定義）で値が変わった"

        # ---- 3. 鎖の第 3・4 段（分配則 → 結合則） --------------------------
        step3 = sum(sum((A[(t, t1)] * B[(t1, t2)]) * v[t2] for t1 in R) for t2 in R)
        assert step2 == step3, "第 3 段（有限和と元の積についての分配則）で値が変わった"
        step4 = sum(sum(A[(t, t1)] * (B[(t1, t2)] * v[t2]) for t1 in R) for t2 in R)
        assert step3 == step4, "第 4 段（積の結合則）で値が変わった"

        # ---- 4. 鎖の第 5 段（有限和の順序の入れ替え） ----------------------
        step5 = sum(sum(A[(t, t1)] * (B[(t1, t2)] * v[t2]) for t2 in R) for t1 in R)
        assert step4 == step5, "第 5 段（有限和の順序の入れ替え）で値が変わった"

        # ---- 5. 鎖の第 6・7・8 段（分配則 → 作用の定義へ戻す） -------------
        step6 = sum(A[(t, t1)] * sum(B[(t1, t2)] * v[t2] for t2 in R) for t1 in R)
        assert step5 == step6, "第 6 段（元と有限和の積についての分配則）で値が変わった"
        Bv = act(R, B, v)
        step7 = sum(A[(t, t1)] * Bv[t1] for t1 in R)
        assert step6 == step7, "第 7 段（作用の定義）で値が変わった"
        rhs = act(R, A, Bv)[t]
        assert step7 == rhs, "第 8 段（作用の定義）で値が変わった"

    # ---- 6. 主張そのもの ---------------------------------------------------
    left = act(R, AB, v)
    right = act(R, A, act(R, B, v))
    assert left == right, "L=%d で (AB)·v = A·(B·v) が破れた" % L

    # ---- 7. 主張が空虚でないこと -------------------------------------------
    assert any(left[t] != QQbar(0) for t in R), "L=%d で両辺が零ベクトルになっている" % L
    print("L=%d: R_L は %d 元。8 段すべてと (AB)·v = A·(B·v) が成り立ち、値は零ベクトルでない"
          % (L, len(R)))

# ---- 8. 積の可換性を使っていないこと -----------------------------------------
# 成分を非可換環（2 次上三角行列の環。積は非可換）に取っても同じ言明が成り立つ。
NC = MatrixSpace(QQ, 2, 2)
def nc(k):
    return NC([[k % 3, (k + 1) % 4], [0, (k + 2) % 5]])

R = row_configs(2)
idx = {t: i for i, t in enumerate(R)}
A = {(t, t1): nc(3 * idx[t] + 5 * idx[t1] + 1) for t in R for t1 in R}
B = {(t, t1): nc(7 * idx[t] + 2 * idx[t1] + 4) for t in R for t1 in R}
v = {t: nc(11 * idx[t] + 6) for t in R}
assert any(A[(t, t1)] * B[(t1, t2)] != B[(t1, t2)] * A[(t, t1)]
           for t in R for t1 in R for t2 in R), "取った環が可換になっている"
assert act(R, mat_product(R, A, B), v) == act(R, A, act(R, B, v)), \
    "非可換環で (AB)·v = A·(B·v) が破れた"
print("8. 積の可換性を使っていない: 非可換環（2 次上三角行列）でも (AB)·v = A·(B·v) が成り立つ")

print("すべて通過")
