# 対象ラベル: symmetrized_transfer_matrix_on_sectors
# 証明の第二の鎖 end(BP)(x) = (BP)x = B(Px) = C(Px) = (CP)x = end(CP)(x) の 5 等号と、そこから BP = CP を結ぶ段を、
# 成分を不定元に置いて厳密に確かめる（M_col = 2, 3）。
# 仮定 Bf = Cf（f ∈ F^{(+)}）を満たす一般の組として、C を成分が独立な不定元の行列、B := C + Z(I - P)
# （Z も独立な不定元の行列。f ∈ F^{(+)} なら Pf = f なので (I - P)f = 0）を取り、x を不定元の数ベクトルにする。
# 積は mat_mult の成分の式（x は n 行 1 列）、end は def_end_iso の文言どおりの写像で計算する。
# 対照: B を独立な不定元の行列にすると（仮定を外すと）、第 3→4 行だけが崩れる。
# 結論の段: すべての x で end(BP)(x) = end(CP)(x) から BP = CP（end_is_algebra_isomorphism (1) の単射性）。
#   ここでは BP = CP を成分で直接確かめ、加えて end(X)(f_K) の並びから X の成分が読み戻せること（X ↦ end(X) の単射性の具体の形）を見る。
load("_prelude.sage")
for M in [2, 3]:
    n = 2 ** M
    names = [f"c_{r}_{s}" for r in range(n) for s in range(n)] + [f"z_{r}_{s}" for r in range(n) for s in range(n)] \
        + [f"b_{r}_{s}" for r in range(n) for s in range(n)] + [f"x_{r}" for r in range(n)]
    R = PolynomialRing(KG, names)
    g = R.gens()
    C = matrix(R, n, n, g[0:n * n])
    Z = matrix(R, n, n, g[n * n:2 * n * n])
    Bfree = matrix(R, n, n, g[2 * n * n:3 * n * n])
    x = vector(R, g[3 * n * n:])
    P = projector_plus(M).change_ring(R)
    I = body_identity(R, n)
    B = body_sum(C, body_product(Z, body_difference(I, P)))
    for f in even_vectors(M):                      # 仮定 Bf = Cf（f ∈ F^{(+)}）
        assert mat_vec(B, f.change_ring(R)) == mat_vec(C, f.change_ring(R))
    END = EndByDefinition(M)

    def lines(Bx):
        return [
            END.apply(body_product(Bx, P), x),     # 1: end(BP)(x)
            mat_vec(body_product(Bx, P), x),       # 2: (BP)x
            mat_vec(Bx, mat_vec(P, x)),            # 3: B(Px)
            mat_vec(C, mat_vec(P, x)),             # 4: C(Px)
            mat_vec(body_product(C, P), x),        # 5: (CP)x
            END.apply(body_product(C, P), x),      # 6: end(CP)(x)
        ]
    check_chain(lines(B), f"M_col={M}")
    ln = lines(Bfree)
    broken = [k for k in range(1, len(ln)) if ln[k - 1] != ln[k]]
    assert broken == [3], broken
    # 結論の段
    BP, CP = body_product(B, P), body_product(C, P)
    assert BP == CP
    fb = END._f_basis(R)
    cols_BP = matrix(R, [list(END.apply(BP, fb[K])) for K in END.idx])
    cols_free = matrix(R, [list(END.apply(body_product(Bfree, P), fb[K])) for K in END.idx])
    assert cols_BP == matrix(R, [list(END.apply(CP, fb[K])) for K in END.idx])
    assert cols_free != cols_BP
    print(f"  M_col={M}: 5 等号が成り立ち BP = CP。独立な B では第 3→4 行（仮定 Bf = Cf）だけが崩れる")
print("RESULT: PASS")
