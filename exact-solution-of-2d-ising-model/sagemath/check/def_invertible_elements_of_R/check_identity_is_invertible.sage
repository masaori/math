# 対象ラベル: def_invertible_elements_of_R
# (i) I I = I であり I^{-1} = I。単位行列は δ から組み、積は本文の成分の式で組む。
# 逆元は Sage の inverse（独立な経路）で求めて I と比べる。帰属: QQ(i)。
load("_prelude.sage")

for n in SIZES:
    I = body_identity(K, n)
    assert body_product(I, I) == I
    assert I.inverse() == I
    print(f"n = {n}: II = I、I^(-1) = I")

print("RESULT: PASS")
