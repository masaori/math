# 対象ラベル: epsilon_commutes_with_V2
load("../../_shared/row_configurations.sage")   # V1_by_components・V2_by_components（def_transfer_matrix の成分の式）

# 主張 εV_2 = V_2ε を、V_2 を def_transfer_matrix の成分の式で組み、exp(K_2 n)（n = -M..M）を独立な不定元に置いて
# 厳密に確かめる（両方の行配位を全スピン反転しても n = Σ μ(m)μ'(m) が変わらないので成り立つ）。M_col = 1..5。
load("_prelude.sage")
for M in range(1, 6):
    R = PolynomialRing(KG, [f"w{n + M}" for n in range(-M, M + 1)])
    w = dict(zip(range(-M, M + 1), R.gens()))
    V = V2_by_components(M, lambda n: w[n], R)
    E = epsilon(M).change_ring(R)
    assert body_product(E, V) == body_product(V, E)
    print(f"  M_col={M}: εV_2 = V_2ε（成分を不定元に置いて）")
print("RESULT: PASS")
