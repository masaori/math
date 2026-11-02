# 対象ラベル: two_by_two_transfer_identity
# 証明の行: 中間目標「B_τ の冪」。p = 0 の B_τ^0 = I = 1_C I = (τ^0)_C I の 3 行と、
#   帰納法の段 B_τ^{2p+1} の鎖 8 行・B_τ^{2p+2} の鎖 9 行を、p = 0..10 で各行ごとに比べ、
#   まとめの B_τ^m = (τ^m)_C b^(m)（m = 0..21）を確かめる。
# 帰属: GAUSSIAN[τ] の 2×2 行列で厳密に（ℝ 脱出なし）。冪は本文 def_exp (1) の A^{m+1} := A^m A で作る。
#   実数の像 a_C は、実数の側の多項式環 QQ[τ] の元を GAUSSIAN[τ] へ写す写像 inc で作る。
#   real_inclusion_preserves_product の行は、QQ[τ] で積を取ってから写した値と、写してから GAUSSIAN[τ] で
#   積を取った値を比べる（Sage の係数の強制変換に任せると両辺が同じ式になるので、写す前後を分けて書く）。
load("_prelude.sage")

B = inc(tr) * SX                                        # B_τ := τ_C σ^x
P = scalar_power_by_definition

# p = 0 の偶数の冪
L = [matrix_power_by_definition(B, 0), I2, inc(QQ_TAU(1)) * I2, inc(P(tr, 0)) * I2]
assert all(L[k] == L[k + 1] for k in range(len(L) - 1)), "B^0 の鎖"
assert P(tr, 0) == 1

for p in range(0, 11):
    tp = P(tr, 2 * p); tp1 = P(tr, 2 * p + 1)
    odd = [
        matrix_power_by_definition(B, 2 * p + 1),           # B_τ^{2p+1}
        matrix_power_by_definition(B, 2 * p) * B,           # B_τ^{2p} B_τ（def_exp (1)）
        (inc(tp) * I2) * B,                                 # 帰納法の仮定
        (inc(tp) * I2) * (inc(tr) * SX),                    # B_τ の定義
        inc(tp) * (I2 * (inc(tr) * SX)),                    # 左の因子からスカラーを出す
        inc(tp) * (inc(tr) * SX),                           # I は左単位元
        (inc(tp) * inc(tr)) * SX,                           # スカラー倍の結合
        inc(tp * tr) * SX,                                  # real_inclusion_preserves_product（QQ[τ] で積を取ってから写す）
        inc(tp1) * SX,                                      # 実数の冪 τ^k τ = τ^{k+1}
    ]
    for k in range(len(odd) - 1):
        assert odd[k] == odd[k + 1], ("奇数の冪の鎖", p, k)
    assert tp * tr == tp1                                   # 実数の冪の行を QQ[τ] の中で
    even = [
        matrix_power_by_definition(B, 2 * p + 2),
        matrix_power_by_definition(B, 2 * p + 1) * B,
        (inc(tp1) * SX) * B,
        (inc(tp1) * SX) * (inc(tr) * SX),
        inc(tp1) * (SX * (inc(tr) * SX)),
        inc(tp1) * (inc(tr) * (SX * SX)),
        inc(tp1) * (inc(tr) * I2),
        (inc(tp1) * inc(tr)) * I2,
        inc(tp1 * tr) * I2,
        inc(P(tr, 2 * p + 2)) * I2,
    ]
    for k in range(len(even) - 1):
        assert even[k] == even[k + 1], ("偶数の冪の鎖", p, k)
    assert inc(tp) * inc(tr) == inc(tp * tr) and inc(tp1) * inc(tr) == inc(tp1 * tr)   # 写す前後で積が一致
    # 否定コントロール: 奇数の冪を I の倍、偶数の冪を σ^x の倍とした式とは一致しない。
    assert matrix_power_by_definition(B, 2 * p + 1) != inc(tp1) * I2
    assert matrix_power_by_definition(B, 2 * p + 2) != inc(P(tr, 2 * p + 2)) * SX
assert SX * SX == I2                                    # pauli_matrix_products の σ^xσ^x = I
for m in range(0, 22):                                  # まとめ: B_τ^m = (τ^m)_C b^(m)
    assert matrix_power_by_definition(B, m) == inc(P(tr, m)) * b_matrix(m)
print("p = 0..10 で B_τ の冪の鎖（偶数 3 行、奇数 8 行、偶数 9 行）の各行が一致し、m = 0..21 で B_τ^m = (τ^m)_C b^(m)")
print("RESULT: PASS")
