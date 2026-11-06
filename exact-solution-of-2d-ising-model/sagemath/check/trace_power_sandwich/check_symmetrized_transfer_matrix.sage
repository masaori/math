# 対象ラベル: trace_power_sandwich
# 本文の W = (BV_2)B（def_symmetrized_transfer_matrix）で証明の行を一行ずつ確かめる。
# K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}）と選ぶと W は QQ の行列になる。c(M_col) は W の特性多項式の最大の実根（AA）。
# ℝ への脱出は K_1・K_2 の選び方と c・ノルム（AA の代数的数）の値だけで、等号・不等号は QQ と AA の厳密計算である。
load("_prelude.sage")
load("_lines.sage")

set_random_seed(20261105)
for M in [2, 3]:
    d = 2**M
    nmax = 4 if M == 2 else 3
    for xx in [QQ(2), QQ(3)]:
        for yy in [QQ(2), QQ(3)]:
            W = W_exact(M, xx, yy)
            assert W.nrows() == d and is_real_symmetric(W) and real_rooted_with_signs(W, strict=True)
            what = f"M_col={M}, K_2=log {xx}, K_1=2log {yy}"
            xs = [vector(QQ, [1 if i == 0 else 0 for i in range(d)]),
                  rational_unit_vector([QQ.random_element(num_bound=4, den_bound=3) for _ in range(d - 1)])]
            for x in xs:
                check_unit_vector_bound(W, x, nmax, f"{what}, x={list(x)}")
            check_varrho_lines(W, nmax, what)
            c = rayleigh_sup_exact(W)
            for n in range(1, nmax + 1):
                Wn = power_by_def_exp(W, n)
                check_symmetry(Wn, what)
                for z in [zero_vector(QQ, d), vector(QQ, [QQ.random_element(num_bound=5, den_bound=3) for _ in range(d)])]:
                    check_psd(W, Wn, n, z, f"{what}, n={n}")
                for x in xs:
                    for k in range(d):
                        for l in range(d):
                            check_entry_bound(Wn, x, k, l, f"{what}, n={n}")
                T = sum(Wn[k, k] for k in range(d))                # T := Σ_k ((W_ℝ)^n)_kk
                le(c**n, T, f"{what}: 主張 c^n ≤ T n={n}")
                le(T, 2**M * c**n, f"{what}: 主張 T ≤ 2^M c^n n={n}")
                check_sup_step(c, c**n / 2, n, c, f"{what}: 上限への移行 n={n}")
    print(f"M_col = {M}: 等号 {n_eq} 個、不等号 {n_le} 個（累計）")
print(f"等号 {n_eq} 個、不等号 {n_le} 個")
print("RESULT: PASS")
