# 対象ラベル: scalar_exp_zero
# 証明の準備を確かめる。O = [0]_K と、m ≥ 1 についての五行の鎖
#   ([0]^m)_11 = ([0]^{m-1}[0])_11 = Σ_{j=1}^{1} ([0]^{m-1})_{1j}([0])_{j1} = ([0]^{m-1})_11 ([0])_11
#              = ([0]^{m-1})_11 · 0 = 0
# と、その帰結 [0]^m = [([0]^m)_11] = [0] = O を、m = 1,…,30 で確かめる。
# 第一辺は Sage の冪 Z^m（二乗を繰り返す計算）で作り、本文の冪の定め方 A^m := A^{m-1} A とは独立にした。
# 帰属: QQ（K = R）と QQ(i)（K = C）。浮動小数点は使わない。
load("../../_shared/one_by_one_matrix.sage")

M_MAX = 30
for name, F in COEFFICIENT_FIELDS:
    O = zero_matrix(F, 1, 1)
    Z = one_by_one(F, F(0))
    assert O == Z
    for m in range(1, M_MAX + 1):
        line0 = entry11(Z^m)
        line1 = entry11(matrix_power_by_definition(Z, m - 1) * Z)          # 行列の冪の定義（def_exp）
        line2 = product_entry_by_definition(Z^(m - 1), Z, 1, 1)           # 行列の積の成分（mat_mult）
        line3 = entry11(Z^(m - 1)) * entry11(Z)                            # 和は j = 1 の 1 項だけ
        line4 = entry11(Z^(m - 1)) * F(0)                                  # def_one_by_one_matrix
        line5 = F(0)                                                       # 0 を掛けると 0
        assert line0 == line1 == line2 == line3 == line4 == line5, (name, m)
        assert Z^m == one_by_one(F, line0) == Z == O
    # 対照: m = 0 では [0]^0 = I ≠ O（準備が m ≥ 1 に限ることに意味がある）
    assert Z^0 == identity_matrix(F, 1) != O
    print(f"{name}: m = 1,…,{M_MAX} で五行が一致し、[0]^m = O")
print("RESULT: PASS")
