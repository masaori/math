# 対象ラベル: W_real_is_positive_definite
# 証明の 10 行の鎖 r_ℂ = ξ^*Wξ = ΣΣ conj(ξ_k)W_klξ_l = … = (x^⊤W_ℝx)_ℂ を、具体の W（M_col = 2, 3、x, y ∈ {2, 3}）と
# 実の x（QQ の成分。零でない 6 本）について各行を厳密に（QQbar・AA）組んで隣の行と比べ、x^⊤W_ℝx > 0 を確かめる。
load("../W_real_is_symmetric/_W_exact.sage")

count = 0
for M in [2, 3]:
    n = 2**M
    xs = [vector(QQ, [k + 1 for k in range(n)]),
          vector(QQ, [(-1)**k for k in range(n)]),
          vector(QQ, [1] + [0] * (n - 1)),
          vector(QQ, [0] * (n - 1) + [QQ(-3) / 2]),
          vector(QQ, [k % 3 - 1 for k in range(n)]),
          vector(QQ, [QQ(k * k) / 5 - 1 for k in range(n)])]
    for xx in [QQ(2), QQ(3)]:
        for y in [QQ(2), QQ(3)]:
            WC, WR = W_complex_and_real(M, xx, y)
            for x in xs:
                assert x != 0
                xi = [iota(AA(x[k])) for k in range(n)]                       # ξ_k := (x_k)_ℂ
                assert any(z != 0 for z in xi)                               # ξ ≠ 0
                S = range(n)
                l1 = quadratic_form_value(xi, WC)                            # ξ^*Wξ
                l2 = sum(xi[k].conjugate() * WC[k, l] * xi[l] for k in S for l in S)
                l3 = sum(iota(AA(x[k])).conjugate() * WC[k, l] * iota(AA(x[l])) for k in S for l in S)
                l4 = sum(iota(AA(x[k])) * WC[k, l] * iota(AA(x[l])) for k in S for l in S)
                l5 = sum(iota(AA(x[k])) * iota(WR[k, l]) * iota(AA(x[l])) for k in S for l in S)
                l6 = sum(iota(AA(x[k]) * WR[k, l]) * iota(AA(x[l])) for k in S for l in S)
                l7 = sum(iota(AA(x[k]) * WR[k, l] * AA(x[l])) for k in S for l in S)
                l8 = sum(iota(sum(AA(x[k]) * WR[k, l] * AA(x[l]) for l in S)) for k in S)
                l9 = iota(sum(AA(x[k]) * WR[k, l] * AA(x[l]) for k in S for l in S))
                xWx = sum(AA(x[k]) * WR[k, l] * AA(x[l]) for k in S for l in S)   # def_real_bilinear_value
                l10 = iota(xWx)
                lines = [l1, l2, l3, l4, l5, l6, l7, l8, l9, l10]
                for i in range(len(lines) - 1):
                    assert lines[i] == lines[i + 1], (M, xx, y, x, i + 1)
                # r の取り方: ξ^*Wξ ∈ ℝ_{>0}（W は正定値）。単射性で r = x^⊤W_ℝx
                assert l1.imag() == 0 and l1.real() > 0
                assert AA(l1.real()) == xWx and xWx > 0
                count += 1
# 否定コントロール: 共役を取らない形の値は複素の ξ では ξ^*Wξ と一致しない（複素共役の行が効くこと）
WC, WR = W_complex_and_real(2, QQ(2), QQ(2))
z = [QQbar(I), QQbar(1), QQbar(0), QQbar(0)]
plain = sum(z[k] * WC[k, l] * z[l] for k in range(4) for l in range(4))
assert plain != quadratic_form_value(z, WC)
print(f"{count} 組 (W, x) で 10 行の鎖と x^⊤W_ℝx > 0 を確かめた。否定コントロール 1 件")
print("RESULT: PASS")
