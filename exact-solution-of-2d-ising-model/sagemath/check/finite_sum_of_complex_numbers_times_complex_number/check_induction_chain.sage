# 対象ラベル: finite_sum_of_complex_numbers_times_complex_number（Σ_{j=1}^{m} (y_j w) = (Σ_{j=1}^{m} y_j) w）
# 証明の m = 1 の 2 行の鎖と、帰納法の段の 4 行の鎖を、行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
# y_j, w は K = QQ(i) 上の多項式環の不定元（一般の複素数の代わり）。有限和は左から順に足す（def_finite_sum_of_complex_numbers）。
load("../../_shared/linear_algebra_families.sage")
for m in range(1, 8):
    R = PolynomialRing(K, ["y%d" % j for j in range(1, m + 2)] + ["w"])
    ys = R.gens()[:m + 1]
    w = R.gens()[-1]
    if m == 1:
        chain = [fsum([ys[0] * w]), ys[0] * w, fsum([ys[0]]) * w]
        for t in range(len(chain) - 1):
            ok(chain[t] == chain[t + 1], ("base", t))
    # 帰納法の段: m → m+1（帰納法の仮定 Σ_{j≤m}(y_j w) = (Σ_{j≤m} y_j) w は下で別に確かめる）
    lhs_m = fsum([ys[j] * w for j in range(m)])
    ok(lhs_m == fsum(list(ys[:m])) * w, ("帰納法の仮定", m))
    chain = [
        fsum([ys[j] * w for j in range(m + 1)]),          # Σ_{j=1}^{m+1} (y_j w)
        fsum([ys[j] * w for j in range(m)]) + ys[m] * w,  # def_finite_sum_of_complex_numbers
        fsum(list(ys[:m])) * w + ys[m] * w,               # 帰納法の仮定
        (fsum(list(ys[:m])) + ys[m]) * w,                 # 分配律を右辺から左辺へ
        fsum(list(ys[:m + 1])) * w,                       # def_finite_sum_of_complex_numbers を右辺から左辺へ
    ]
    for t in range(len(chain) - 1):
        ok(chain[t] == chain[t + 1], ("step", m, t))
# 対照: 和に足す形（Σ (y_j + w)）では共通の項 w は外へ一度だけ出るのではない
R = PolynomialRing(K, ["y1", "y2", "w"])
y1, y2, w = R.gens()
ok(fsum([y1 + w, y2 + w]) != fsum([y1, y2]) + w, "対照")
print("checked", count(), "items")
print("RESULT: PASS")
