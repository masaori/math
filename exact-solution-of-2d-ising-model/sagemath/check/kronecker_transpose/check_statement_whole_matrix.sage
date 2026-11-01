# 対象ラベル: kronecker_transpose
# 主張そのもの: (A_1⊠⋯⊠A_M)^⊤ = A_1^⊤⊠⋯⊠A_M^⊤ を行列全体として比べる。
# 左辺は Sage の tensor_product と transpose、右辺は Sage の transpose と tensor_product で組む。
# 本文の定め方どおりに成分から組んだ両辺でも比べる。帰属: QQ 上の多項式環。
load("_prelude.sage")

for M in M_RANGE:
    R, A = generic_factors(M)
    left = kron_by_sage(A).transpose()
    right = kron_by_sage([B.transpose() for B in A])
    assert left == right
    left_def = transpose_by_definition(R, kron_by_definition(R, A))
    right_def = kron_by_definition(R, [transpose_by_definition(R, B) for B in A])
    assert left_def == right_def
    print(f"M={M}: {2**M} 次の行列として一致")

# 不定元の検算が自明な一致でないことの対照: 一般の A_1⊠A_2 は対称ではない。
R, A = generic_factors(2)
assert kron_by_sage(A).transpose() != kron_by_sage(A)
print("対照: 一般の A_1⊠A_2 は転置と一致しない")
print("RESULT: PASS")
