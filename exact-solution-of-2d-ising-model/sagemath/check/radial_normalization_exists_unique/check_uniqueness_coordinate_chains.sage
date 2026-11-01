# 対象ラベル: radial_normalization_exists_unique
# 本文の一意性の二つの鎖:
#   x_c' = x/r'   (条件 r'x_c' = x の両辺を r' > 0 で割る)
#        = x/r    (r' = r)
#        = x_c    (x_c の定義)
#   y_c' についても同じ三行。
# 具体の点（AA）: r' > 0 と単位円上の点 (x_c', y_c') から x, y を作り、r, x_c, y_c を証明の定め方
# （normalize）で x, y だけから独立に作って、各行の等号を確かめる。
# 第三行は x_c の定め方を代入するだけの行である。
# 一般の点（第一行だけ）: r', X を QQ 上の不定元とする有理関数体 QQ(r',X) で、x := r'X から x/r' = X を確かめる
#   （両辺を r' で割る行であり、単位円の条件は使わない）。第二行は r' = r（check_uniqueness_radius_chain.sage）の
#   代入で、r が正の平方根であることを使うので具体の点（AA）でだけ確かめる。
load("_prelude.sage")

G.<rq, X> = FractionField(PolynomialRing(QQ, ['rq', 'X']))
assert (rq * X) / rq == X

count = 0
for (uc, vc) in UNIT_POINTS:
    for rpv in RADII:
        px, py = rpv * uc, rpv * vc
        pr, pxc, pyc = normalize(px, py)
        assert rpv * uc == px and rpv * vc == py
        assert uc == px / rpv          # 第一行
        assert px / rpv == px / pr     # 第二行
        assert px / pr == pxc          # 第三行
        assert vc == py / rpv
        assert py / rpv == py / pr
        assert py / pr == pyc
        count += 1

print(f"checked {count} cases")
print("RESULT: PASS")
