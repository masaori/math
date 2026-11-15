# 対象ラベル: matrix_norm_vector_bound（第 2 列以降の成分 (AW)_ij = 0 の鎖）
# 鎖の各行を、行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
#   (AW)_ij = Σ_k a_ik W_kj = Σ_k a_ik·0 = Σ_k 0
#   K = ℂ のとき Σ_k 0_C = 0_C（finite_sum_of_complex_zeros）
#   K = ℝ のとき Σ_k 0 = ι_{ℤ→ℝ}(n)·0（finite_sum_of_constant_real_number）= 0（real_times_zero_is_zero）
# 和は本文の有限和の定義どおり左から 1 項ずつ足す。ℂ は definition_of_cc のとおり実数の組で持つ。
# 帰属: QQ 上の多項式環（A の成分の実部・虚部は不定元）。


def cc_add(z, w):
    return (z[0] + w[0], z[1] + w[1])                               # definition_of_cc の和


def cc_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])   # definition_of_cc の積


def left_sum(terms, add):
    s = terms[0]                                                    # Σ_{k=1}^{1} t_k = t_1
    for t in terms[1:]:
        s = add(s, t)                                               # Σ_{k=1}^{r+1} t_k = (Σ_{k=1}^{r} t_k) + t_{r+1}
    return s


count = 0
for n in [1, 2, 3, 4]:
    # K = ℝ
    P = PolynomialRing(QQ, [f"a_{k}" for k in range(n)])
    a = P.gens()
    W_col = [P(0)] * n                                              # W の第 j 列（j ≥ 2）
    chain = [
        left_sum([a[k] * W_col[k] for k in range(n)], lambda u, v: u + v),  # Σ a_ik W_kj
        left_sum([a[k] * P(0) for k in range(n)], lambda u, v: u + v),      # Σ a_ik·0
        left_sum([P(0) for k in range(n)], lambda u, v: u + v),             # Σ 0（real_times_zero_is_zero）
        P(n) * P(0),                                                        # ι(n)·0（finite_sum_of_constant_real_number）
        P(0),                                                               # 0（real_times_zero_is_zero）
    ]
    for t in range(len(chain) - 1):
        assert chain[t] == chain[t + 1], ("R", n, t)
    count += 1
    # K = ℂ
    Q = PolynomialRing(QQ, [f"p_{k}" for k in range(n)] + [f"q_{k}" for k in range(n)])
    g = Q.gens()
    ac = [(g[k], g[n + k]) for k in range(n)]
    zc = (Q(0), Q(0))                                               # 0_C = (0,0)
    Wc_col = [zc] * n                                               # W の第 j 列（j ≥ 2）
    chain = [
        left_sum([cc_mul(ac[k], Wc_col[k]) for k in range(n)], cc_add),  # Σ a_ik W_kj
        left_sum([cc_mul(ac[k], zc) for k in range(n)], cc_add),    # Σ a_ik·0_C
        left_sum([zc for k in range(n)], cc_add),                   # Σ 0_C（complex_times_zero_is_zero）
        zc,                                                         # 0_C（finite_sum_of_complex_zeros）
    ]
    for t in range(len(chain) - 1):
        assert chain[t] == chain[t + 1], ("C", n, t)
    count += 1
print(f"checked {count} chains (K = R and K = C, n = 1..4)")
# 対照: 第 j 列に 0 でない成分を置くと (AW)_ij は 0 にならない
P = PolynomialRing(QQ, "a0"); assert P.gen() * P(1) != P(0)
print("negative control: a·1 != 0")
print("RESULT: PASS")
