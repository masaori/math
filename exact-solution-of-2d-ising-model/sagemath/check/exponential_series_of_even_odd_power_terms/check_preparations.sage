# 対象ラベル: exponential_series_of_even_odd_power_terms
# 証明の三つの準備（冪の像 (x_C)^n = (x^n)_C の帰納法、a_n・b_n の偶奇の値、実数の差の像 y_C - z_C = (y-z)_C）の全行。
# ℂ は definition_of_cc どおり実数の対で持ち（complex_as_real_pairs.sage）、ℝ の量は QQ 上の多項式環の元とする。
# 不定元での等号は、不定元へ任意の実数を代入しても成り立つ（代入は環準同型）。
load("_prelude.sage")

N_MAX = 12
R = PolynomialRing(QQ, 'x')
x = R.gen()
xC = iota(x, R)

# 準備（冪の像）: 基底段階 3 行と帰納段階 4 行。(x_C)^n は冪の約束（cc_power）で、x^n は ℝ の冪の約束（rpow）で作る。
run_chain([
    ("(x_C)^0", cc_power(xC, 0, R)),
    ("1_C", iota(1, R)),
    ("(1)_C", iota(R(1), R)),
    ("(x^0)_C", iota(rpow(x, 0), R)),
], "冪の像 n=0")
for n in range(N_MAX):
    run_chain([
        ("(x_C)^{n+1}", cc_power(xC, n + 1, R)),
        ("(x_C)^n x_C", cc_mul(cc_power(xC, n, R), xC)),
        ("(x^n)_C x_C（帰納法の仮定）", cc_mul(iota(rpow(x, n), R), xC)),
        ("(x^n x)_C", iota(rpow(x, n) * x, R)),
        ("(x^{n+1})_C", iota(rpow(x, n + 1), R)),
    ], f"冪の像 n={n}→{n+1}")
    report(cc_power(xC, n, R) == iota(rpow(x, n), R), f"冪の像 n={n}: 帰納法の仮定がその段で成り立つ")

# 準備（a_n, b_n の値）: 偶数・奇数で各 3 行ずつ。
for n in range(N_MAX + 1):
    f = QQ(factorial(n))
    a_def = (rpow(x, n) + rpow(-x, n)) / (2 * f)
    b_def = (rpow(x, n) - rpow(-x, n)) / (2 * f)
    sgn = rpow(QQ(-1), n)
    report(rpow(-x, n) == sgn * rpow(x, n), f"n={n}: 実数の冪 (-x)^n = (-1)^n x^n")
    if n % 2 == 0:
        report(sgn == 1, f"n={n}: 偶数より (-1)^n = 1")
        run_chain([("a_n", a_def), ("(x^n+(-1)^n x^n)/(2n!)", (rpow(x, n) + sgn * rpow(x, n)) / (2 * f)),
                   ("(x^n+x^n)/(2n!)", (rpow(x, n) + rpow(x, n)) / (2 * f)), ("x^n/n!", rpow(x, n) / f)], f"n={n} 偶数 a_n")
        run_chain([("b_n", b_def), ("(x^n-(-1)^n x^n)/(2n!)", (rpow(x, n) - sgn * rpow(x, n)) / (2 * f)),
                   ("(x^n-x^n)/(2n!)", (rpow(x, n) - rpow(x, n)) / (2 * f)), ("0", R(0))], f"n={n} 偶数 b_n")
    else:
        report(sgn == -1, f"n={n}: 奇数より (-1)^n = -1")
        run_chain([("a_n", a_def), ("(x^n+(-1)^n x^n)/(2n!)", (rpow(x, n) + sgn * rpow(x, n)) / (2 * f)),
                   ("(x^n+(-1)x^n)/(2n!)", (rpow(x, n) + (-1) * rpow(x, n)) / (2 * f)), ("0", R(0))], f"n={n} 奇数 a_n")
        run_chain([("b_n", b_def), ("(x^n-(-1)^n x^n)/(2n!)", (rpow(x, n) - sgn * rpow(x, n)) / (2 * f)),
                   ("(x^n-(-1)x^n)/(2n!)", (rpow(x, n) - (-1) * rpow(x, n)) / (2 * f)), ("x^n/n!", rpow(x, n) / f)], f"n={n} 奇数 b_n")
    # 対照: 偶奇を取り違えると成り立たない
    if n >= 1:
        report((n % 2 == 0 and a_def != 0) or (n % 2 == 1 and b_def != 0), f"n={n}: 対照 a_n・b_n の偶奇を取り違えると 0 でない")

# 準備（実数の差の像）: 6 行。
S = PolynomialRing(QQ, ['y', 'z'])
y, z = S.gens()
yC, zC = iota(y, S), iota(z, S)
run_chain([
    ("y_C - z_C", cc_sub(yC, zC, S)),
    ("y_C + (-z_C)", cc_add(yC, cc_neg(zC, S))),
    ("y_C + (-1_C) z_C", cc_add(yC, cc_mul(iota(-1, S), zC))),
    ("y_C + (-1)_C z_C", cc_add(yC, cc_mul(iota(S(-1), S), zC))),
    ("y_C + ((-1)z)_C", cc_add(yC, iota((-1) * z, S))),
    ("(y + (-1)z)_C", iota(y + (-1) * z, S)),
    ("(y - z)_C", iota(y - z, S)),
], "実数の差の像")
report(cc_sub(yC, zC, S) != iota(y + z, S), "対照: y_C - z_C ≠ (y+z)_C")
print("RESULT: PASS")
