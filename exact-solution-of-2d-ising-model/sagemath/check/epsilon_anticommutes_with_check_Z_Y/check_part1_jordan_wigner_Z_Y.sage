# 対象ラベル: epsilon_anticommutes_with_check_Z_Y（主張 (1)）
# 証明の (1) は epsilon_anticommutes_with_jordan_wigner_Z・epsilon_anticommutes_with_jordan_wigner_Y を m → j で引くだけなので、
# その引用が主張 (1) の形（εZ_j = -(Z_jε)、εY_j = -(Y_jε)）を与えることを M_col = 2..5、全ての j で確かめる。
# ε・Z_j・Y_j は本文の定め方（def_global_spin_flip_matrix・def_jordan_wigner_Z_matrices・def_jordan_wigner_Y_matrices。
# サイトの Pauli 行列を def_kronecker の成分の式で作り、mat_mult の成分の式で左から掛ける）で作り、Sage の積でも作って一致を確かめる
# （_shared/pauli_sites_exact.sage の epsilon・jw）。成分は QQ(i)。厳密計算。
# 否定コントロール: εZ_j = Z_jε（可換）は成り立たない（反可換子の等号が自明でないこと）。
load("../../_shared/pauli_sites_exact.sage")
load("_prelude.sage")

rep = Report("epsilon_anticommutes_with_check_Z_Y (1): εZ_j = -(Z_jε)、εY_j = -(Y_jε)")
for M in range(2, 6):
    E = epsilon(M)
    for j in range(1, M + 1):
        for a, nm in (('z', 'Z'), ('y', 'Y')):
            W = jw(M, j, a)
            rep.check(body_product(E, W) == body_negation(body_product(W, E)), f"M={M} j={j}: ε{nm}_j = -({nm}_jε)")
            rep.negative(body_product(E, W) != body_product(W, E), f"M={M} j={j}: ε{nm}_j ≠ {nm}_jε")
    print(f"  M_col={M}: 済（累計 {rep.n} 件）", flush=True)
rep.finish()
