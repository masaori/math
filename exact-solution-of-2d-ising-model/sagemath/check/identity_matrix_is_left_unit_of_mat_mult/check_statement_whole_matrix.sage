# 対象ラベル: identity_matrix_is_left_unit_of_mat_mult
# 主張 I A = A を行列全体で比べる。δ から組んだ単位行列が Sage の identity_matrix（独立な経路）と一致することも見る。
# 積は本文の成分の式で組む。帰属: QQ 上の多項式環。
load("_prelude.sage")

for m in DIMS:
    for n in DIMS:
        P, _, (A,) = generic_ring([("a", m, n)])
        assert body_identity(P, m) == identity_matrix(P, m)
        assert body_product(body_identity(P, m), A) == A
print("checked 9 shapes")
print("RESULT: PASS")
