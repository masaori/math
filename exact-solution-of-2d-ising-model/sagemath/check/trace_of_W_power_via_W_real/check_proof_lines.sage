# 対象ラベル: trace_of_W_power_via_W_real
# 具体の W（W_real_is_symmetric の検算と同じ厳密な経路。M_col = 2, 3、x, y ∈ {2, 3}）について、
# W^q の成分が実数であること、(W^q)_ℝ = (W_ℝ)^q、4 行の鎖
# tr(W^q) = Σ_k (W^q)_kk = Σ_k (((W^q)_ℝ)_kk)_ℂ = Σ_k (((W_ℝ)^q)_kk)_ℂ = (Σ_k ((W_ℝ)^q)_kk)_ℂ を q = 0..4 で確かめる。
load("../W_real_is_symmetric/_W_exact.sage")


def varrho(B):
    assert all(z.imag() == 0 for z in B.list())                        # def_matrix_with_real_entries
    return matrix(AA, B.nrows(), B.ncols(), lambda p, q: AA(B[p, q].real()))


count = 0
for M in [2, 3]:
    for x in [QQ(2), QQ(3)]:
        for y in [QQ(2), QQ(3)]:
            WC, WR = W_complex_and_real(M, x, y)
            d = WC.nrows()
            WCq = identity_matrix(QQbar, d); WRq = identity_matrix(AA, d)  # def_exp (1) の X^0 := I
            for q in range(5):
                WqR = varrho(WCq)
                assert WqR == WRq                                          # (W^q)_ℝ = (W_ℝ)^q
                line1 = WCq.trace()
                line2 = sum(WCq[k, k] for k in range(d))
                line3 = sum(iota(WqR[k, k]) for k in range(d))
                line4 = sum(iota(WRq[k, k]) for k in range(d))
                line5 = iota(sum(WRq[k, k] for k in range(d)))
                assert line1 == line2 == line3 == line4 == line5, (M, x, y, q)
                count += 1
                WCq = WCq * WC; WRq = WRq * WR                             # def_exp (1) の X^{m+1} := X^mX
# 否定コントロール: 対角でない成分の和はトレースと一般に異なる
assert sum(WC[0, l] for l in range(WC.nrows())) != WC.trace()
print(f"{count} 組の (M_col, x, y, q) で 4 行の鎖と (W^q)_ℝ = (W_ℝ)^q を確かめた。否定コントロール 1 件")
print("RESULT: PASS")
