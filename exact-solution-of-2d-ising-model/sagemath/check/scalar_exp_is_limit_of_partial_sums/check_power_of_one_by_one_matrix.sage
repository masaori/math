# 対象ラベル: scalar_exp_is_limit_of_partial_sums
# Step 1（[x]_K^m = [x^m]_K）の帰納法の基底の四行 [x]^0 = I = [I_11] = [1] = [x^0] と、帰納段の六行の等号の鎖を、m = 0,…,12 について確かめる。
#   ([x]^{m+1})_11 = ([x]^m [x])_11 = Σ_{j=1}^{1} ([x]^m)_{1j} ([x])_{j1} = ([x]^m)_11 ([x])_11
#                  = ([x^m])_11 ([x])_11 = x^m x = x^{m+1}
# と、結論の鎖 [x]^{m+1} = [([x]^{m+1})_11] = [x^{m+1}] を確かめる。
# 第一行の左辺は Sage の冪 X^(m+1)（二乗を繰り返す計算）で作り、本文の定め方 A^{m+1} := A^m A とは独立にした。
# 帰属: 係数 QQ（K = R）と QQ(i)（K = C）の上の一変数多項式環。x は不定元。
load("../../_shared/one_by_one_matrix.sage")

M_MAX = 12
for name, F in COEFFICIENT_FIELDS:
    R = PolynomialRing(F, 'x')
    x = R.gen()
    X = one_by_one(R, x)

    # 基底: [x]^0 = I = [I_11] = [1] = [x^0]
    I1 = identity_matrix(R, 1)
    assert matrix_power_by_definition(X, 0) == I1   # 行列の冪の定義 A^0 := I
    assert X^0 == I1                                # Sage の冪（独立な経路）
    assert I1 == one_by_one(R, entry11(I1))         # 1 行 1 列の行列は成分だけで決まる
    assert entry11(I1) == R(1)                      # 単位行列の対角成分は 1
    assert one_by_one(R, R(1)) == one_by_one(R, scalar_power_by_definition(x, 0))  # x^0 := 1

    for m in range(M_MAX + 1):
        hypothesis = (X^m == one_by_one(R, scalar_power_by_definition(x, m)))
        assert hypothesis, (name, m)  # 帰納法の仮定（前の m で示した結論）
        line0 = entry11(X^(m + 1))
        line1 = entry11(matrix_power_by_definition(X, m) * X)        # 行列の冪の定義（def_exp）
        line2 = product_entry_by_definition(X^m, X, 1, 1)           # 行列の積の成分（mat_mult）
        line3 = entry(X^m, 1, 1) * entry(X, 1, 1)                    # 和は j = 1 の 1 項だけ
        line4 = entry11(one_by_one(R, scalar_power_by_definition(x, m))) * entry11(X)  # 帰納法の仮定
        line5 = scalar_power_by_definition(x, m) * x                 # def_one_by_one_matrix
        line6 = scalar_power_by_definition(x, m + 1)                 # 主張の約束 x^{m+1} := x^m x
        assert line0 == line1 == line2 == line3 == line4 == line5 == line6, (name, m)
        # 結論の鎖: [x]^{m+1} = [([x]^{m+1})_11] = [x^{m+1}]
        assert X^(m + 1) == one_by_one(R, entry11(X^(m + 1)))
        assert one_by_one(R, entry11(X^(m + 1))) == one_by_one(R, line6)
        assert line6 == x^(m + 1)
    print(f"{name}: 基底と m = 0,…,{M_MAX} の帰納段の六行が多項式として一致")

# 対照: 2 行 2 列の行列では、冪の (1,1) 成分は (1,1) 成分の冪と一般に一致しない。
# 「和は j = 1 の 1 項だけ」の行が 1 行 1 列であることに依ることを確かめる。
R2 = PolynomialRing(QQ, 'a,b,c,d')
A2 = matrix(R2, 2, 2, R2.gens())
assert entry11(A2^2) != entry11(A2)^2
print("対照: 2 行 2 列では (A^2)_11 ≠ (A_11)^2")
print("RESULT: PASS")
