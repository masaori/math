# 対象ラベル: trace_power_sandwich
# 証明が使う W の性質は「成分が実数で対称」「正定値（moment_log_convexity の前提）」と「c が R の上限」だけなので、
# P := A^⊤A（A は列の数 d の整数行列で列が一次独立、d = 1..4）の有理行列と、逆立体射影で作った ‖x‖ = 1 の x ∈ QQ^d で
# 証明の行を確かめる。c は P の特性多項式の最大の実根（AA）で、rayleigh_sup_exact が上界であることと到達することを確かめる。
load("_prelude.sage")
load("_lines.sage")

set_random_seed(20261105)
count = 0
for d in range(1, 5):
    for _ in range(3):
        while True:
            A = random_matrix(ZZ, d + 1, d, x=-3, y=4)
            if A.rank() == d:
                break
        P = (A.transpose() * A).change_ring(QQ)
        assert is_real_symmetric(P) and real_rooted_with_signs(P, strict=True)
        nmax = 5
        xs = [vector(QQ, [1 if i == 0 else 0 for i in range(d)])]
        if d >= 2:
            xs.append(rational_unit_vector([QQ.random_element(num_bound=4, den_bound=3) for _ in range(d - 1)]))
        else:
            xs.append(rational_unit_vector([]))
        what = f"d={d}, P={P.list()}"
        for x in xs:
            check_unit_vector_bound(P, x, nmax, f"{what}, x={list(x)}")
        check_varrho_lines(P, nmax, what)
        c = rayleigh_sup_exact(P)
        for n in range(1, nmax + 1):
            Pn = power_by_def_exp(P, n)
            check_symmetry(Pn, what)
            zs = [zero_vector(QQ, d)] + [vector(QQ, [QQ.random_element(num_bound=5, den_bound=3) for _ in range(d)]) for _ in range(2)]
            for z in zs:
                check_psd(P, Pn, n, z, f"{what}, n={n}, z={list(z)}")
            for x in xs:
                for k in range(d):
                    for l in range(d):
                        check_entry_bound(Pn, x, k, l, f"{what}, n={n}")
            # 主張: c^n ≤ T ≤ d c^n（T := Σ_k ((W_ℝ)^n)_kk）
            T = sum(Pn[k, k] for k in range(d))
            le(c**n, T, f"{what}: 主張 c^n ≤ T n={n}")
            le(T, d * c**n, f"{what}: 主張 T ≤ d c^n n={n}")
            # 【上限への移行】: 仮定 c^n > T' を満たす T' := c^n/2, c^n/(n+1) を置き、R の元として c の固有ベクトルの値 t = c で背理法の鎖を確かめる
            for Tp in [c**n / 2, c**n / (n + 1)]:
                check_sup_step(c, Tp, n, c, f"{what}: 上限への移行 n={n}, T'={Tp}")
        count += 1
# 【正の実数の冪の比較】を有理の 0 < r < s で
for (r, s) in [(QQ(1)/3, QQ(1)/2), (QQ(2), QQ(3)), (QQ(5)/7, QQ(9)/4), (QQ(99)/100, QQ(1))]:
    check_power_comparison(r, s, 8, f"r={r}, s={s}")
# 【上限への移行】の算術を有理の (c, T) で
for (c, T, n) in [(QQ(3), QQ(5), 2), (QQ(2), QQ(1)/10, 4), (QQ(7)/5, QQ(2), 3), (QQ(1)/2, QQ(1)/1000, 1)]:
    delta = (c**n - T) / (n * c**(n - 1))
    check_sup_step(c, T, n, (c + (c - delta)) / 2, f"有理の c={c}, T={T}, n={n}")
print(f"P {count} 個、等号 {n_eq} 個、不等号 {n_le} 個")

# 否定コントロール: 検査の関数を前提の外の行列・ベクトルで呼び、期待した行で AssertionError になることを確かめる


def expect_fail(fn, needle):
    try:
        fn()
    except AssertionError as err:
        assert needle in str(err), f"期待と違う行で落ちた: {err}"
        return
    raise RuntimeError(f"落ちるはずの検査が通った: {needle}")


# 否定コントロール 1: 対称でない [[1, 1], [0, 1]] の 2 乗では、【(W_ℝ)^n の成分の対称性】と【(W_ℝ)^n の成分の評価】の対称性の行（6 行目）が外れる
Tm = matrix(QQ, [[1, 1], [0, 1]])
x = vector(QQ, [3/5, 4/5])
expect_fail(lambda: check_symmetry(Tm**2, "非対称"), "【(W_ℝ)^n の成分の対称性】")
expect_fail(lambda: check_entry_bound(Tm**2, x, 0, 1, "非対称"), "【(W_ℝ)^n の成分の評価】 k=0, l=1 6→7 行目")
# 否定コントロール 2: 対称だが正定値でない diag(1, −2) では、z = e_2 で w^⊤Nw > 0 が、x = (3/5, 4/5) で m_1 > 0 が、
# (k, l) = (0, 1) で 0 ≤ v^⊤Nv（= −2/25）が外れる
N = diagonal_matrix(QQ, [1, -2])
expect_fail(lambda: check_psd(N, N, 1, vector(QQ, [0, 1]), "不定値"), "w^⊤(W_ℝ)^nw > 0")
expect_fail(lambda: check_unit_vector_bound(N, x, 1, "不定値"), "m_k > 0 k=1")
expect_fail(lambda: check_entry_bound(N, x, 0, 1, "不定値"), "0 ≤ v^⊤(W_ℝ)^nv")
# 否定コントロール 3: 単位でない x = (1, 1) と P = I（d = 2）では ‖x‖ = 1 の行で落ちる（m_0 = 2、(x^⊤Px)^2 = 4 > Σ_k (P^2)_kk = 2）
x = vector(QQ, [1, 1])
Iq = identity_matrix(QQ, 2)
assert bil(x, Iq, x) == 2 and bil(x, Iq, x)**2 == 4 > (Iq**2).trace()
expect_fail(lambda: check_unit_vector_bound(Iq, x, 2, "単位でない"), "‖x‖ = 1")
print("否定コントロール 3 件（検査の関数が落ちる 6 箇所）")
print("RESULT: PASS")
