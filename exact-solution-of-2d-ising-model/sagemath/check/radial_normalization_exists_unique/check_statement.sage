# 対象ラベル: radial_normalization_exists_unique
# 主張そのもの: (x,y) ∈ R^2 \ {(0,0)} に対し、r x_c = x, r y_c = y, r > 0, (x_c,y_c) ∈ C_unit を満たす
# r, (x_c,y_c) が一意に存在する。
# 存在: 具体の点（AA）で、証明の定め方で作った組が四条件を満たすことを確かめる。
# 一意性: 条件を満たす組 (r', (x_c',y_c')) を r' > 0 と単位円上の点から作り、その組から得た (x,y) に
#   証明の定め方を施すと、もとの組がそのまま返ることを確かめる（条件を満たす組は定め方の組に限る）。
# 一意性のうち、ここで作った組以外の組は検算の範囲外で、人手証明が担う。
load("_prelude.sage")

for (px, py) in SAMPLE_POINTS:
    pr, pxc, pyc = normalize(px, py)
    assert pr * pxc == px and pr * pyc == py and pr > 0 and pxc^2 + pyc^2 == 1

count = 0
for (uc, vc) in UNIT_POINTS:
    for rpv in RADII:
        px, py = rpv * uc, rpv * vc
        assert (px, py) != (0, 0)
        assert normalize(px, py) == (rpv, uc, vc)
        count += 1

print(f"checked {len(SAMPLE_POINTS)} points for existence and {count} cases for uniqueness")
print("RESULT: PASS")
