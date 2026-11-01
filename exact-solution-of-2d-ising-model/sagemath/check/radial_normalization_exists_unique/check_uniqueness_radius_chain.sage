# 対象ラベル: radial_normalization_exists_unique
# 本文の一意性の鎖（三行）と r' = r:
#   x^2+y^2 = (r'x_c')^2+(r'y_c')^2        (条件 r'x_c' = x, r'y_c' = y)
#           = (r')^2((x_c')^2+(y_c')^2)    (R の四則)
#           = (r')^2                       ((x_c')^2+(y_c')^2 = 1)
#   r' = sqrt(x^2+y^2)^{(R≥0)}   (r' ≥ 0 かつ (r')^2 = x^2+y^2 を満たすものはただ一つ)
#      = r                     (r の定義)
# 一意性の鎖の第一行は、条件 r'x_c' = x, r'y_c' = y を代入するだけの行である。
# 一般の点: r', x_c', y_c' を QQ 上の不定元とし、単位円の関係 (x_c')^2+(y_c')^2 = 1 で割った商環 L に置く。
#   条件どおり x := r'x_c', y := r'y_c' とおいて各行を別々に組み、等号を確かめる。
#   第三行の等号は L の関係式だけから従い、多項式環（関係式なし）では成り立たないことも確かめる。
# 具体の点（AA）: r' > 0 と単位円上の点を選んで x, y を作り、三行と r' の鎖を確かめる。
#   r' の鎖の第一行は、r' ≥ 0 かつ (r')^2 = x^2+y^2 を確かめたうえで、AA の平方根（独立な経路）と比べる。
#   第二行は r の定義を代入するだけの行で、normalize の r も同じ AA の平方根なので、比較は代入の確認に留まる。
#   対照として -r' も平方は x^2+y^2 だが正でないことを確かめる（正であることが一意性に要る）。
load("_prelude.sage")

P3.<rp, xp, yp> = PolynomialRing(QQ)
L = P3.quotient(xp^2 + yp^2 - 1)
Lrp, Lxp, Lyp = L(rp), L(xp), L(yp)
gx, gy = Lrp * Lxp, Lrp * Lyp       # 条件 r'x_c' = x, r'y_c' = y
g0 = gx^2 + gy^2
g1 = (Lrp * Lxp)^2 + (Lrp * Lyp)^2
g2 = Lrp^2 * (Lxp^2 + Lyp^2)
g3 = Lrp^2
assert g0 == g1
assert g1 == g2
assert g2 == g3
assert rp^2 * (xp^2 + yp^2) != rp^2   # 第三行は単位円の関係式を使う

count = 0
for (uc, vc) in UNIT_POINTS:
    assert uc^2 + vc^2 == 1
    for rpv in RADII:
        assert rpv > 0
        px, py = rpv * uc, rpv * vc
        a0 = px^2 + py^2
        a1 = (rpv * uc)^2 + (rpv * vc)^2
        a2 = rpv^2 * (uc^2 + vc^2)
        a3 = rpv^2
        assert a0 == a1
        assert a1 == a2
        assert a2 == a3
        assert rpv >= 0 and rpv^2 == px^2 + py^2
        sq = (px^2 + py^2).sqrt()
        assert rpv == sq                     # r' の鎖の第一行
        pr, _, _ = normalize(px, py)
        assert sq == pr                      # r' の鎖の第二行（r の定義の代入）
        assert (-rpv)^2 == px^2 + py^2 and not (-rpv > 0)
        count += 1

print(f"checked the generic point and {count} cases")
print("RESULT: PASS")
