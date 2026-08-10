# 対象ラベル: def_qbar_matrix_eval, claim_qbar_matrix_eval_product
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の定義
# 「整係数多項式を成分とする行列の、代数的数における値」（Ev_ξ）と、
# 主張「成分ごとの評価は行列の積を保つ」（Ev_ξ(AB) = Ev_ξ(A) Ev_ξ(B)）を、
# 小さい L について行配位を添字とする行列で確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。整係数多項式環は ZZ['x']、
# 代数的数の全体 Qbar は QQbar（厳密な代数的数の体）で表す。
#
# 何を確かめるか（人手証明の鎖の 6 段に 1 対 1 で対応させる）:
#   1. 添字集合。行配位の全体 R_L が 2^L 個の元をもつこと。
#   2. 鎖の第 1 段。Ev_ξ の定義（成分ごとの代入）。
#   3. 鎖の第 2 段。Z[x] の行列の積の定義。
#   4. 鎖の第 3 段。代入が有限和を保つこと。
#   5. 鎖の第 4 段。代入が積を保つこと。
#   6. 鎖の第 5・6 段。Ev_ξ の定義へ戻し、Qbar の行列の積の定義へまとめること。
#   7. 主張そのもの。Ev_ξ(AB) = Ev_ξ(A) Ev_ξ(B) が全成分で成り立つこと。
#   8. 主張が空虚でないこと。両辺が零行列でない例があること。
#   9. 型の区別。左辺の積は Z[x] の行列の積、右辺の積は Qbar の行列の積であり、
#      評価の前後で別の演算を使っていること（成分が実際に別の集合の元であること）。

Zx = PolynomialRing(ZZ, 'x')
x = Zx.gen()

def row_configs(L):
    # 行配位 τ: Z/LZ -> {+1,-1} を、長さ L のタプルで表す（添字は 0,...,L-1）。
    return [tuple(t) for t in cartesian_product([[1, -1]] * L)]

def mat_product(R, A, B):
    # (AB)_{τ,τ''} = Σ_{τ'} A_{τ,τ'} B_{τ',τ''}（成分の集合によらず同じ形）
    return {(t, t2): sum(A[(t, t1)] * B[(t1, t2)] for t1 in R) for t in R for t2 in R}

def ev_matrix(R, A, xi):
    # (Ev_ξ(A))_{τ,τ'} = (A_{τ,τ'})(ξ)
    return {k: QQbar(A[k](xi)) for k in A}

# 検証に使う整係数多項式（すべて Z[x] の元）と、代入する代数的数（QQbar の厳密な元）。
polys = [Zx(0), Zx(1), Zx(-2), x, x**2 - 1, 3*x**3 + x - 5, x**2 + x + 1, -x + 4]
xis = [QQbar(0), QQbar(2), QQbar(3)/QQbar(5), QQbar(2).sqrt(),
       -QQbar(3).sqrt(), QQbar(-1).sqrt(), QQbar(5).nth_root(3)]

def sample(k):
    return polys[k % len(polys)]

print("== 整係数多項式を成分とする行列の評価と、積の保存 ==")

for L in [1, 2, 3]:
    R = row_configs(L)
    # ---- 1. 添字集合 -------------------------------------------------------
    assert len(R) == 2 ** L, "R_L の元の個数が 2^L でない"

    idx = {t: i for i, t in enumerate(R)}
    A = {(t, t1): sample(3 * idx[t] + 5 * idx[t1] + 1) for t in R for t1 in R}
    B = {(t, t1): sample(7 * idx[t] + 2 * idx[t1] + 4) for t in R for t1 in R}

    AB = mat_product(R, A, B)          # Z[x] の行列の積
    nonzero_seen = False

    for xi in xis:
        EvA = ev_matrix(R, A, xi)
        EvB = ev_matrix(R, B, xi)
        EvAB = ev_matrix(R, AB, xi)
        prod_qbar = mat_product(R, EvA, EvB)   # Qbar の行列の積

        for t in R:
            for t2 in R:
                # ---- 2. 鎖の第 1 段（Ev_ξ の定義） --------------------------
                step1 = AB[(t, t2)](xi)
                assert EvAB[(t, t2)] == step1, "第 1 段（Ev_ξ の定義）が成り立たない"

                # ---- 3. 鎖の第 2 段（Z[x] の行列の積の定義） ----------------
                step2 = sum(A[(t, t1)] * B[(t1, t2)] for t1 in R)(xi)
                assert step1 == step2, "第 2 段（Z[x] の積の定義）が成り立たない"

                # ---- 4. 鎖の第 3 段（代入が有限和を保つ） -------------------
                step3 = sum((A[(t, t1)] * B[(t1, t2)])(xi) for t1 in R)
                assert step2 == step3, "第 3 段（代入が有限和を保つ）が成り立たない"

                # ---- 5. 鎖の第 4 段（代入が積を保つ） -----------------------
                step4 = sum(A[(t, t1)](xi) * B[(t1, t2)](xi) for t1 in R)
                assert step3 == step4, "第 4 段（代入が積を保つ）が成り立たない"

                # ---- 6. 鎖の第 5・6 段（Ev_ξ の定義へ戻す → Qbar の積） ----
                step5 = sum(EvA[(t, t1)] * EvB[(t1, t2)] for t1 in R)
                assert step4 == step5, "第 5 段（Ev_ξ の定義へ戻す）が成り立たない"
                assert step5 == prod_qbar[(t, t2)], "第 6 段（Qbar の積の定義）が成り立たない"

                # ---- 7. 主張そのもの ---------------------------------------
                assert EvAB[(t, t2)] == prod_qbar[(t, t2)], "Ev_ξ(AB) = Ev_ξ(A)Ev_ξ(B) が破れた"

                if EvAB[(t, t2)] != QQbar(0):
                    nonzero_seen = True

    # ---- 8. 主張が空虚でないこと ------------------------------------------
    assert nonzero_seen, "両辺が零行列の例しか無い"

    # ---- 9. 型の区別 -------------------------------------------------------
    assert AB[(R[0], R[0])].parent() is Zx, "左辺の積の成分が Z[x] の元でない"
    assert ev_matrix(R, AB, xis[3])[(R[0], R[0])].parent() is QQbar, \
        "右辺の成分が QQbar の元でない"

    print("L=%d: R_L は %d 元。%d 個の ξ について 6 段すべてと "
          "Ev_ξ(AB) = Ev_ξ(A)Ev_ξ(B) が成り立ち、値は零行列でない" % (L, len(R), len(xis)))

print("すべて通過")
