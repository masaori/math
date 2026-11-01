# 対象ラベル: radial_normalization_exists_unique
# 本文の準備の場合分け: (x,y) ≠ (0,0) なので x ≠ 0 または y ≠ 0。
#   x ≠ 0 のとき  x^2+y^2 ≥ x^2  (y^2 ≥ 0)
#                        > 0    (x ≠ 0 なので x^2 > 0)
#   y ≠ 0 のとき  x, y を入れ替えた同じ二行。
# 具体の点（AA）で、当てはまる場合ごとに二行の不等式を厳密に比べ、結論 x^2+y^2 > 0 を確かめる。
# 対照として (0,0) では和が 0 になり、仮定 (x,y) ≠ (0,0) が要ることを確かめる。
load("_prelude.sage")

cases = 0
for (px, py) in SAMPLE_POINTS:
    assert px != 0 or py != 0
    if px != 0:
        assert py^2 >= 0
        assert px^2 + py^2 >= px^2
        assert px^2 > 0
        cases += 1
    if py != 0:
        assert px^2 >= 0
        assert px^2 + py^2 >= py^2
        assert py^2 > 0
        cases += 1
    assert px^2 + py^2 > 0
    assert px^2 + py^2 != 0

assert AA(0)^2 + AA(0)^2 == 0

print(f"checked {len(SAMPLE_POINTS)} points ({cases} cases)")
print("RESULT: PASS")
