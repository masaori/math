# 対象ラベル: claim_qbar_smul_sum
#   併せて引く定義: def_qbar_vector, def_qbar_vector_smul, def_qbar_vector_sum,
#                   def_qbar_vector_add, def_qbar_zero_vector, def_algebraic_numbers
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張 1 件
# 「スカラー倍は列ベクトルの有限和を保つ」（z ⊙ (⊕_{i∈s} v_i) = ⊕_{i∈s} (z ⊙ v_i)）を、
# 小さい L について行配位を添字とする列ベクトルで確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 鎖の 5 段（スカラー倍の定義・有限和の定義・元と有限和の積についての分配則・
#      スカラー倍の定義・有限和の定義）。
#   3. 主張そのもの。z ⊙ (⊕_{i∈s} v_i) = ⊕_{i∈s} (z ⊙ v_i) が全成分で成り立つこと。
#   4. 空の添字集合。s = ∅ のとき両辺が零ベクトルであること。
#   5. 主張が空虚でないこと。両辺が零ベクトルでない例があること。
#   6. 使っている性質。証明は積の可換性も結合則も使っていないので、成分を非可換環
#      （2 次上三角行列の環）に取っても成り立つ。ただし左から掛ける形（z を左に置く）で
#      あることが効く。右から掛ける形 (⊕ v_i) * z = ⊕ (v_i * z) も別の分配則から成り立つが、
#      本文が主張しているのは左から掛ける側だけなので、そちらを確かめる。
#   7. 作用の版（claim_qbar_action_sum）との違い。この段は各点ごとに独立な等式なので、
#      点の型（R_L）の有限性を使っていない。項の個数を保ったまま R_L を大きくしても、
#      各点の等式がそのまま成り立つことを見る（Lean の必要十分版が Fintype κ を
#      仮定していない根拠である）。

def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]

def vec_smul(R, z, v):
    # (z ⊙ v)(τ) = z v(τ)
    return {t: z * v[t] for t in R}

def vec_add(R, v, w):
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

print("== スカラー倍が列ベクトルの有限和を保つこと ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # ---- 1. 添字集合 -------------------------------------------------------
    assert len(R) == 2 ** L, "R_L の元の個数が 2^L でない"

    idx = {t: i for i, t in enumerate(R)}

    for zk in range(len(alg)):
        z = sample(zk)
        for n in [0, 1, 2, 3, 5]:
            s = list(range(n))
            vs = {i: {t: sample(7 * i + 11 * idx[t] + 6) for t in R} for i in s}
            zvs = {i: vec_smul(R, z, vs[i]) for i in s}

            for t in R:
                # ---- 2. 鎖の 5 段 -----------------------------------------
                step1 = z * vec_sum(R, s, vs, QQbar(0))[t]                     # 第 1 段
                step2 = z * sum((vs[i][t] for i in s), QQbar(0))               # 第 2 段
                step3 = sum((z * vs[i][t] for i in s), QQbar(0))               # 第 3 段
                step4 = sum((zvs[i][t] for i in s), QQbar(0))                  # 第 4 段
                step5 = vec_sum(R, s, zvs, QQbar(0))[t]                        # 第 5 段
                assert step1 == step2 == step3 == step4 == step5, \
                    "スカラー倍の鎖のどこかで値が変わった"

            # ---- 3. 主張そのもの（写像としての等号） -----------------------
            assert vec_smul(R, z, vec_sum(R, s, vs, QQbar(0))) \
                == vec_sum(R, s, zvs, QQbar(0)), \
                "スカラー倍が有限和を保つことが破れた"

    # ---- 4. 空の添字集合 ---------------------------------------------------
    z = sample(4)
    empty_sum = vec_sum(R, [], {}, QQbar(0))
    assert empty_sum == zero_vec(R, QQbar(0)), "空の添字集合での有限和が零ベクトルでない"
    assert vec_smul(R, z, empty_sum) == zero_vec(R, QQbar(0)), \
        "零ベクトルのスカラー倍が零ベクトルでない"

    # ---- 5. 主張が空虚でないこと -------------------------------------------
    s = [0, 1, 2]
    vs = {i: {t: sample(7 * i + 11 * idx[t] + 6) for t in R} for i in s}
    both = vec_smul(R, z, vec_sum(R, s, vs, QQbar(0)))
    assert any(both[t] != 0 for t in R), "両辺が零ベクトルになっている"

    print("L=%d: R_L は %d 元。スカラー 8 通り × 項の個数 0,1,2,3,5 のすべてで鎖の 5 段と"
          "主張が成り立ち、空の添字集合では両辺が零ベクトルである" % (L, len(R)))

# ---- 6. 使っている性質（非可換環で試す） -----------------------------------
# 2 次上三角行列の環（可換でない）を成分に取る。証明は積の可換性も結合則も使っていない
# ので、左から掛ける形はここでも成り立つはずである。
Rng = MatrixSpace(QQ, 2, 2)

def tri(a, b, d):
    return Rng([[a, b], [0, d]])

L = 2
R = row_configs(L)
idx = {t: i for i, t in enumerate(R)}
sn = [0, 1, 2]
vsn = {i: {t: tri(i + 1, idx[t] + 3, 2 * i + 2) for t in R} for i in sn}
zn = tri(2, 5, 3)
zero_n = Rng(0)

assert tri(1, 2, 3) * tri(4, 5, 6) != tri(4, 5, 6) * tri(1, 2, 3), "取った環が可換だった"

assert (vec_smul(R, zn, vec_sum(R, sn, vsn, zero_n))
        == vec_sum(R, sn, {i: vec_smul(R, zn, vsn[i]) for i in sn}, zero_n)), \
    "非可換環で有限和を保つことが破れた（証明が可換性を使っていないはずである）"

print("6. 非可換環（2 次上三角行列）を成分に取っても成り立つ（可換性も結合則も使っていない）")

# ---- 7. 点の型の有限性を使っていないこと -----------------------------------
# 各点ごとに独立な等式なので、点の集合を R_L から取り替えても（大きくしても）
# 各点の等式はそのまま成り立つ。作用の版（claim_qbar_action_sum）は点にわたる有限和を
# 取るため点の型の有限性が要るのに対し、この段は要らないことの確認である。
big = row_configs(5) + [("extra", k) for k in range(3)]   # R_5 に無関係な点を足した集合
idx_b = {t: i for i, t in enumerate(big)}
s = [0, 1, 2, 3]
z = sample(5)
vs = {i: {t: sample(7 * i + 11 * idx_b[t] + 6) for t in big} for i in s}
assert (vec_smul(big, z, vec_sum(big, s, vs, QQbar(0)))
        == vec_sum(big, s, {i: vec_smul(big, z, vs[i]) for i in s}, QQbar(0))), \
    "点の集合を取り替えると破れた（各点ごとに独立な等式のはずである）"

print("7. 点の集合を行配位の全体から取り替えても成り立つ（点の型の有限性を使っていない）")
print("すべて通過")
