# 対象ラベル: matrix_norm_vector_bound（第 2 列以降の成分の絶対値の平方が 0 であることと、内側の和を第 1 列の項に縮める等式）
# 鎖の各行を、行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
#   2 ≤ j ≤ n: |(AW)_ij|^2 = |0|^2 = 0^2 = 0·0 = 0、|W_ij|^2 = |0|^2 = 0^2 = 0·0 = 0
#     |0| = 0 は matrix_norm_triangle_inequality の Step 1、0^2 = 0·0 は square_of_real_number_is_product（r → 0）、
#     0·0 = 0 は real_times_zero_is_zero（x → 0）
#   Σ_{j=1}^{n} |X_ij|^2 = |X_i1|^2（finite_sum_of_real_numbers_with_single_nonzero_term（m → n, k → 1））
# K = ℂ の絶対値は def_abs_arg の √(x^2 + y^2)、K = ℝ は実数の絶対値。|·|^2 の平方は def_power_of_real_number の冪。
# 帰属: QQ 上の多項式環（第 1 列の成分の実部・虚部は不定元）と QQ。浮動小数点は使わない。


def real_power(a, m):
    p = a.parent()(1)                                               # a^0 := 1
    for _ in range(m):
        p = p * a                                                   # a^{m+1} := a^m a
    return p


def left_sum(terms):
    s = terms[0]                                                    # Σ_{j=1}^{1} t_j := t_1
    for t in terms[1:]:
        s = s + t                                                   # Σ_{j=1}^{r+1} t_j := (Σ_{j=1}^{r} t_j) + t_{r+1}
    return s


count = 0
# |0| = 0（K = ℝ: 実数の絶対値、K = ℂ: √(0^2 + 0^2) = √0 = 0）
abs_zero_R = abs(QQ(0))
abs_zero_C_sq = QQ(0) ** 2 + QQ(0) ** 2                             # |0_C|^2 の根号の中
assert abs_zero_R == 0 and abs_zero_C_sq == 0 and sqrt(abs_zero_C_sq) == 0
count += 1
# 0 の平方の鎖: |0|^2 = 0^2 = 0·0 = 0
chain = [
    real_power(QQ(abs_zero_R), 2),                                  # |0|^2
    real_power(QQ(0), 2),                                           # 0^2（|0| = 0）
    QQ(0) * QQ(0),                                                  # 0·0（square_of_real_number_is_product）
    QQ(0),                                                          # 0（real_times_zero_is_zero）
]
for t in range(len(chain) - 1):
    assert chain[t] == chain[t + 1], ("zero square", t)
count += 1
# 内側の和の縮約: 第 1 列の |X_i1|^2 を不定元の多項式で、第 2 列以降を 0 で置き、左から足す
for n in [1, 2, 3, 4]:
    P = PolynomialRing(QQ, ["x", "y"])
    x, y = P.gens()
    first_R = real_power(x, 2)                                      # K = ℝ の |X_i1|^2 = X_i1^2（square_of_real_absolute_value）
    first_C = x ** 2 + y ** 2                                       # K = ℂ の |X_i1|^2（def_abs_arg）
    for first in [first_R, first_C]:
        terms = [first] + [P(0)] * (n - 1)                          # j ≥ 2 の項は上の鎖で 0
        assert left_sum(terms) == first == sum(terms), ("collapse", n)
        count += 1
print(f"checked {count} chains")
# 対照: 第 2 列に 0 でない成分 1 を置くと、内側の和は第 1 列の項に縮まない
P = PolynomialRing(QQ, "x"); x = P.gen()
assert left_sum([x ** 2, real_power(P(1), 2)]) != x ** 2
print("negative control: column 2 entry 1 breaks the collapse")
print("RESULT: PASS")
