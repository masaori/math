# 対象ラベル: scalar_limit_is_unique
# 証明の準備の二つの鎖を、K = R（係数 QQ）と K = C（係数 QQ(i)）の両方で確かめる。
#   [u]_K - [v]_K = [([u]_K - [v]_K)_11]_K = [([u]_K)_11 - ([v]_K)_11]_K = [u - v]_K
#   ‖[w]_K‖ = √(Σ_{i,j=1}^{1} |([w]_K)_ij|^2) = √(|([w]_K)_11|^2) = √(|w|^2) = |w|
# 第一の鎖は K 上の多項式環 K[u, v] の不定元で（各行を本文どおりの作り方で別々に作る）。
# 第二の鎖は具体の w で、|w| を AA で厳密に取る（K = R は実数の絶対値 max(w,-w)、K = C は abs_basic_properties (1) の √(x^2+y^2)）。
load("../../_shared/one_by_one_matrix.sage")

for name, F in COEFFICIENT_FIELDS:
    R = PolynomialRing(F, 'u,v')
    u, v = R.gens()
    U, V = one_by_one(R, u), one_by_one(R, v)
    line1 = U - V                                                # Sage の行列の差
    line2 = one_by_one(R, entry11(U - V))                        # [([u]-[v])_11]
    line3 = one_by_one(R, entry11(U) - entry11(V))               # [([u])_11 - ([v])_11]（成分の差）
    line4 = one_by_one(R, u - v)                                 # [u - v]
    assert line1 == line2 == line3 == line4, name
    # 対照: [u] + [v] は [u - v] と一致しない（差の行が和と取り違えていないこと）
    assert U + V != line4
    print(f"{name}: [u]_K - [v]_K = [([u]-[v])_11]_K = [([u])_11 - ([v])_11]_K = [u - v]_K が多項式環で成り立つ")


def abs_K(w, F):
    """K = R なら実数の絶対値、K = C なら abs_basic_properties (1) の √(x^2+y^2)。値は AA。"""
    if F is QQ:
        return AA(max(w, -w))
    return AA(QQ(w[0])^2 + QQ(w[1])^2).sqrt()


def body_norm(A, F):
    """def_matrix_norm の ‖A‖ = √(Σ_i Σ_j |a_ij|^2)。"""
    total = sum(abs_K(entry(A, i, j), F)^2 for i in range(1, A.nrows() + 1) for j in range(1, A.ncols() + 1))
    r = AA(total).sqrt()
    assert r >= 0 and r^2 == total
    return r


ii = GAUSSIAN.gen()
samples = {
    "K = R（係数 QQ）": [QQ(0), QQ(1), QQ(-3) / 7, QQ(10)^30, QQ(-22) / 5],
    "K = C（係数 QQ(i)）": [GAUSSIAN(0), -ii, 3 / 7 - 2 * ii, GAUSSIAN(-22) / 5, 10^30 * ii, -1 + ii],
}
for name, F in COEFFICIENT_FIELDS:
    for w in samples[name]:
        W = one_by_one(F, w)
        absw = abs_K(w, F)
        chain = [body_norm(W, F), AA(abs_K(entry11(W), F)^2).sqrt(), AA(absw^2).sqrt(), absw]
        assert all(c == chain[0] for c in chain), (name, w)
        # 最後の行の根拠: |w| は |w|^2 の非負の平方根で、それはただ一つ。もう一つの平方根 -|w| は w ≠ 0 で負。
        assert absw >= 0 and (w == 0 or -absw < 0)
    print(f"{name}: {len(samples[name])} 点で ‖[w]_K‖ = √(Σ|([w]_K)_ij|^2) = √(|([w]_K)_11|^2) = √(|w|^2) = |w| が AA で厳密に成り立つ")
print("RESULT: PASS")
