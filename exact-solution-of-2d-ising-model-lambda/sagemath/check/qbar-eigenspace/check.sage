# 対象ラベル: claim_qbar_eigenspace_add, claim_qbar_eigenspace_smul
#   併せて引く定義: def_qbar_zero_vector, def_qbar_eigenvector, def_qbar_eigenvalue,
#                   def_qbar_eigenspace, def_qbar_vector_add, def_qbar_vector_smul,
#                   def_qbar_matrix, def_qbar_vector, def_qbar_matrix_action
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張 2 件
# 「固有空間は和で閉じる」（v,w ∈ E_A(z) ⟹ v⊕w ∈ E_A(z)）と
# 「固有空間はスカラー倍で閉じる」（v ∈ E_A(z) ⟹ c⊙v ∈ E_A(z)）を、
# 小さい L について確かめる。
#
# 行列 A にはシフト行列 U（成分は 0 と 1）を取る。U の作用は (U·v)(τ) = v(S(τ)) なので、
# 1 つの軌道 O の上で v(S^[r](τ0)) := ζ^{-r}（ζ は 1 の |O| 乗根）と置き、
# 軌道の外で 0 と置いたものが固有値 ζ^{-1} に属する固有ベクトルになる。
# これは章の筋（シフト行列の固有値が 1 の L 乗根であること）と同じ対象である。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体は SageMath の
# QQbar（厳密な代数的数の体）で表す。実数体にも複素数体にも入っていない。
#
# 何を確かめるか:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 作った v・w が固有ベクトルであること（A·v = z⊙v かつ v ≠ o_L）。
#      すなわち主張が空虚でないこと。
#   3. 和の鎖の 7 段（作用が和を保つ・和の定義・固有空間の条件・スカラー倍の定義・
#      分配則・和の定義・スカラー倍の定義）。
#   4. 和についての主張そのもの。v⊕w ∈ E_A(z) が写像の等号として成り立つこと。
#   5. スカラー倍の鎖の 9 段（作用がスカラー倍を保つ・スカラー倍の定義・固有空間の条件・
#      スカラー倍の定義・結合則・可換性・結合則・スカラー倍の定義・スカラー倍の定義）。
#   6. スカラー倍についての主張そのもの。c⊙v ∈ E_A(z) が写像の等号として成り立つこと。
#   7. 固有空間が零ベクトルを含むこと（固有ベクトルの定義から v ≠ o_L を外した理由。
#      外さないとスカラー倍で閉じない: c = 0 と取ると 0⊙v = o_L である）。
#   8. 使っている性質の差。和で閉じることの鍵は分配則で、積の可換性を使っていない。
#      スカラー倍で閉じることは c と z の順を入れ替える段で可換性を使っており、
#      成分を非可換環（2 次上三角行列の環）に取るとその段が実際に破れる。

def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]

def shift(t):
    # 巡回シフト (S(τ))(y) = τ(y+1)
    return tuple(t[(i + 1) % len(t)] for i in range(len(t)))

def act(R, A, v):
    # (A·v)(τ) = Σ_{τ'} A_{τ,τ'} v(τ')
    return {t: sum(A[(t, t1)] * v[t1] for t1 in R) for t in R}

def vec_add(R, v, w):
    # (v ⊕ w)(τ) = v(τ) + w(τ)
    return {t: v[t] + w[t] for t in R}

def vec_smul(R, z, v):
    # (z ⊙ v)(τ) = z v(τ)
    return {t: z * v[t] for t in R}

def zero_vec(R, ring):
    # 零ベクトル o_L
    return {t: ring(0) for t in R}

def orbit(t):
    # τ の軌道 O(τ)（反復した巡回シフトで到達できる行配位の全体）を、
    # τ, S(τ), S^[2](τ), ... の順に並べて返す。
    o = [t]
    s = shift(t)
    while s != t:
        o.append(s)
        s = shift(s)
    return o

def orbits(R):
    seen = set()
    out = []
    for t in R:
        if t in seen:
            continue
        o = orbit(t)
        seen.update(o)
        out.append(o)
    return out

def eigenvector_on_orbit(R, o, zeta):
    # 軌道 o の上で v(S^[r](τ0)) := ζ^{-r}、軌道の外で 0 と置く。
    v = {t: QQbar(0) for t in R}
    for r, t in enumerate(o):
        v[t] = zeta ** (-r)
    return v

print("== 固有空間が和とスカラー倍で閉じること ==")

for L in [1, 2, 3, 4]:
    R = row_configs(L)
    # ---- 1. 添字集合 -------------------------------------------------------
    assert len(R) == 2 ** L, "R_L の元の個数が 2^L でない"

    # シフト行列 U_{τ,τ'} = 1 (τ' = S(τ)), 0 (それ以外)
    U = {(t, t1): (QQbar(1) if t1 == shift(t) else QQbar(0)) for t in R for t1 in R}

    # 同じ大きさの軌道が 2 つ以上ある大きさを取り、その 2 つから固有ベクトルを作る
    # （同じ固有値に属する相異なる固有ベクトルを 2 本用意するため）。
    by_size = {}
    for o in orbits(R):
        by_size.setdefault(len(o), []).append(o)
    sizes = sorted([e for e, os in by_size.items() if len(os) >= 2])
    assert sizes, "同じ大きさの軌道が 2 つ以上ある大きさが無い"

    for e in sizes:
        o1, o2 = by_size[e][0], by_size[e][1]
        zeta = QQbar.zeta(e)                 # 1 の原始 e 乗根（厳密な代数的数）
        z = zeta ** (-1)                     # 固有値
        c = QQbar(2).sqrt() - QQbar(3) / QQbar(7)   # スカラー
        v = eigenvector_on_orbit(R, o1, zeta)
        w = eigenvector_on_orbit(R, o2, zeta)
        o_L = zero_vec(R, QQbar)

        Uv = act(R, U, v)
        Uw = act(R, U, w)

        # ---- 2. v・w が固有ベクトルであること（主張が空虚でない） -----------
        assert Uv == vec_smul(R, z, v), "v が固有ベクトルでない"
        assert Uw == vec_smul(R, z, w), "w が固有ベクトルでない"
        assert v != o_L and w != o_L, "固有ベクトルが零ベクトルになっている"
        assert v != w, "同じ固有値に属する相異なる 2 本になっていない"

        vw = vec_add(R, v, w)
        cv = vec_smul(R, c, v)

        for t in R:
            # ---- 3. 和の鎖の 7 段 -----------------------------------------
            a1 = act(R, U, vw)[t]                       # 第 1 段（作用が和を保つ）
            a2 = vec_add(R, Uv, Uw)[t]                  # 第 2 段（和の定義）
            a3 = Uv[t] + Uw[t]                          # 第 3 段（固有空間の条件の直前）
            a4 = vec_smul(R, z, v)[t] + vec_smul(R, z, w)[t]   # 第 3 段（条件を当てた）
            a5 = z * v[t] + z * w[t]                    # 第 4 段（スカラー倍の定義）
            a6 = z * (v[t] + w[t])                      # 第 5 段（分配則）
            a7 = z * vw[t]                              # 第 6 段（和の定義）
            a8 = vec_smul(R, z, vw)[t]                  # 第 7 段（スカラー倍の定義）
            assert a1 == a2 == a3 == a4 == a5 == a6 == a7 == a8, "和の鎖のどこかで値が変わった"

            # ---- 5. スカラー倍の鎖の 9 段 ---------------------------------
            b1 = act(R, U, cv)[t]                       # 第 1 段（作用がスカラー倍を保つ）
            b2 = vec_smul(R, c, Uv)[t]                  # 第 2 段（スカラー倍の定義）
            b3 = c * Uv[t]                              # 第 3 段の直前
            b4 = c * vec_smul(R, z, v)[t]               # 第 3 段（固有空間の条件）
            b5 = c * (z * v[t])                         # 第 4 段（スカラー倍の定義）
            b6 = (c * z) * v[t]                         # 第 5 段（結合則）
            b7 = (z * c) * v[t]                         # 第 6 段（可換性）
            b8 = z * (c * v[t])                         # 第 7 段（結合則）
            b9 = z * cv[t]                              # 第 8 段（スカラー倍の定義）
            b10 = vec_smul(R, z, cv)[t]                 # 第 9 段（スカラー倍の定義）
            assert b1 == b2 == b3 == b4 == b5 == b6 == b7 == b8 == b9 == b10, \
                "スカラー倍の鎖のどこかで値が変わった"

        # ---- 4・6. 主張そのもの（写像としての等号） -------------------------
        assert act(R, U, vw) == vec_smul(R, z, vw), "和で閉じることが破れた"
        assert act(R, U, cv) == vec_smul(R, z, cv), "スカラー倍で閉じることが破れた"
        assert vw != o_L and cv != o_L, "確かめた元が零ベクトルなので例として弱い"

        # ---- 7. 固有空間は零ベクトルを含む（v ≠ o_L を外した理由） ----------
        assert act(R, U, o_L) == vec_smul(R, z, o_L), "零ベクトルが固有空間に入っていない"
        assert vec_smul(R, QQbar(0), v) == o_L, "0 ⊙ v が零ベクトルでない"

    print("L=%d: R_L は %d 元。軌道の大きさ %s のそれぞれで、"
          "和の鎖 7 段・スカラー倍の鎖 9 段と 2 つの主張が成り立つ"
          % (L, len(R), sizes))

# ---- 8. 使っている性質の差（非可換環で試す） -------------------------------
# 2 次上三角行列の環（可換でない）を成分に取り、2 つの鎖の鍵になる段を別々に見る。
Rng = MatrixSpace(QQ, 2, 2)

def tri(a, b, d):
    return Rng([[a, b], [0, d]])

zn = tri(1, 2, 3)
cn = tri(4, 5, 6)
vn = tri(2, 1, 7)

# 環が実際に非可換であること。
assert zn * cn != cn * zn, "取った環が可換だった"

# 和で閉じることの鍵（第 5 段の分配則）は、非可換環でも成り立つ。
wn = tri(3, 1, 2)
assert zn * vn + zn * wn == zn * (vn + wn), \
    "非可換環で分配則が破れた（和で閉じることは可換性を使っていないはずである）"

# スカラー倍で閉じることの鍵（第 6 段の可換性）は、非可換環では破れる。
assert (cn * zn) * vn != (zn * cn) * vn, \
    "非可換環で c と z の順の入れ替えが通ってしまった（例の取り方が弱い）"

print("8. 和で閉じることの鍵（分配則）は非可換環でも成り立ち、"
      "スカラー倍で閉じることの鍵（c と z の入れ替え）は非可換環で破れる")
print("すべて通過")
