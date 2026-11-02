# ---------------------------------------------------------
# SageMath: 証明の「成分の一致」の鎖に足した二行（対角の場合）
#   exp((K_1)_C d(μ)_C) = exp((K_1 d(μ))_C) = (exp(K_1 d(μ)))_C
# 第一の等号（real_inclusion_preserves_product）: K_1 を QQ の不定元 K、d を整数として、対の積で厳密に。
# 第二の等号（complex_exp_of_real_argument）: 両辺とも def_scalar_exp の部分和の極限なので、部分和どうしを厳密に比べる。
#   x := K_1 d を有理数に取り、各 N について、ℂ を QQ(i) で持った Σ_{p=0}^{N} (x_C)^p/p! と、
#   QQ で計算した Σ_{p=0}^{N} x^p/p! を包含 r ↦ r + 0i で送った値が一致することを確かめる（N = 0..30）。
#   部分和が一致すれば極限も一致する（極限の一意性）ことは人手証明が担う。
#   補助として、極限そのものを ComplexBallField と RealBallField（200 ビット）のボールで比べる（ℝ への脱出を含む値）。
# 対象ラベル: first_transfer_matrix_pauli_form
# ---------------------------------------------------------
RK.<K> = PolynomialRing(QQ)
count = 0
for d in range(-6, 7):
    a, b = (K, 0), (d, 0)
    prodpair = (a[0] * b[0] - a[1] * b[1], a[0] * b[1] + a[1] * b[0])
    assert prodpair == (K * d, 0)
    count += 1

QI.<I> = QuadraticField(-1)
X_VALUES = [QQ(1) / 20, QQ(4406868) / 10**7, QQ(13) / 10, QQ(-7) / 3, QQ(0)]
for K1 in X_VALUES:
    for d in range(-6, 7):
        x = K1 * d
        xc = QI(x) + 0 * I                          # x_C
        acc_c, term_c = QI(0), QI(1)
        acc_r, term_r = QQ(0), QQ(1)
        for p in range(0, 31):
            if p > 0:
                term_c = term_c * xc / p
                term_r = term_r * x / p
            acc_c += term_c
            acc_r += term_r
            assert acc_c == QI(acc_r)               # 部分和どうしが包含で一致
            assert acc_c.imag() == 0
        count += 1

RBF = RealBallField(200)
CBF = ComplexBallField(200)
for K1 in X_VALUES:
    for d in range(-6, 7):
        x = K1 * d
        lhs = CBF(RBF(x), RBF(0)).exp()
        rhs = RBF(x).exp()
        assert lhs.real().overlaps(rhs) and lhs.imag().contains_zero()
print(f"checked {count} cases (exact partial sums N = 0..30, and ball limits)")
print("RESULT: PASS")
