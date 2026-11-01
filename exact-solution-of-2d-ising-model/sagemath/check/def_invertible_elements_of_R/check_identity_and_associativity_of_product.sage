# 対象ラベル: def_invertible_elements_of_R
# 証明が引く二つの性質（identity_matrix_is_left_unit_of_mat_mult・identity_matrix_is_right_unit_of_mat_mult の IA = A・AI = A と mat_mult_associative の (AB)C = A(BC)）を、
# この証明に現れる大きさ 2^M で確かめ直す。
# A, B, C の成分は QQ 上の不定元（代入は環準同型なので、成分へ任意の複素数を入れても成り立つ）。
# 積は本文の成分の式で組み、単位行列は δ から組む。単位行列が Sage の identity_matrix と一致することもあわせて見る。
load("_prelude.sage")

for n in SIZES:
    P, (A, B, C) = generic_matrices(n, ["a", "b", "c"])
    I = body_identity(P, n)
    assert I == identity_matrix(P, n)
    assert body_product(I, A) == A
    assert body_product(A, I) == A
    left = body_product(body_product(A, B), C)
    right = body_product(A, body_product(B, C))
    assert left == right
    assert left == A * B * C   # Sage の行列積（独立な経路）とも一致する
    print(f"n = {n}: IA = AI = A, (AB)C = A(BC) を不定元で確かめた")

print("RESULT: PASS")
