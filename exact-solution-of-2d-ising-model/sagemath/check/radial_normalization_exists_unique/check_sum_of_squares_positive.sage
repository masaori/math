# 対象ラベル: radial_normalization_exists_unique
# 本文の準備の場合分け: (x,y) ≠ (0,0) なので x ≠ 0 または y ≠ 0。
#   x ≠ 0 のとき  0 ≤ x^2・0 ≤ y^2（real_square_is_nonnegative）、x x ≠ 0（real_product_of_nonzero_is_nonzero）、
#                 x^2 ≠ 0（x^2 = x x を右辺から左辺へ等しいものの代入）。これらから
#                 x^2+y^2 = y^2+x^2   (加法の交換律)
#                         ≥ 0+x^2     (0 ≤ y^2 に順序と加法の両立、t → x^2)
#                         = x^2       (0 + x = x)
#                 0 ≤ x^2 ∧ x^2 ≤ x^2+y^2 ⇒ 0 ≤ x^2+y^2（推移律）。
#                 0 = x^2+y^2 と仮定すると x^2 ≤ 0、0 ≤ x^2 と反対称律で x^2 = 0 となり x^2 ≠ 0 に反する。
#                 よって 0 ≠ x^2+y^2、def_real_strict_order で 0 < x^2+y^2。
#   y ≠ 0 のとき  同じ準備を y で置き、x^2+y^2 ≥ 0+y^2 = y^2 から同じ形で 0 < x^2+y^2。
# 具体の点（AA）で、当てはまる場合ごとに各行を厳密に比べる。
# 背理法の段は、仮定 0 = x^2+y^2 が具体の点で偽であること（その仮定のもとの各含意は、
# 仮定を満たす点が無いので点の上では確かめられない）と、対照の (0,0) で仮定が成り立つとき
# 含意の各行（x^2 ≤ 0、x^2 = 0）がそのとおりに成り立つことを確かめる。
# 対照として (0,0) では和が 0 になり、仮定 (x,y) ≠ (0,0) が要ることを確かめる。
load("_prelude.sage")

def check_case(v, o_sq, s):
    """v ≠ 0 の場合。o_sq は他方の座標の平方、s は本文どおりの和 x^2+y^2。"""
    assert s == v^2 + o_sq
    assert v * v != 0
    assert v^2 == v * v and v^2 != 0
    assert v^2 >= 0 and o_sq >= 0
    assert v^2 <= s
    assert 0 <= v^2 and v^2 <= s and 0 <= s
    assert not (0 == s)
    assert 0 != s
    assert 0 <= s and 0 != s and 0 < s

cases = 0
for (px, py) in SAMPLE_POINTS:
    assert px != 0 or py != 0
    if px != 0:
        assert px^2 + py^2 == py^2 + px^2
        assert py^2 + px^2 >= 0 + px^2
        assert 0 + px^2 == px^2
        check_case(px, py^2, px^2 + py^2)
        cases += 1
    if py != 0:
        assert px^2 + py^2 >= 0 + py^2
        assert 0 + py^2 == py^2
        check_case(py, px^2, px^2 + py^2)
        cases += 1
    assert px^2 + py^2 > 0

# 対照 (0,0): 仮定 0 = x^2+y^2 が成り立ち、背理法の含意の各行がそのとおりに成り立つ（x^2 ≠ 0 だけが偽）。
z = AA(0)
assert 0 == z^2 + z^2
assert z^2 <= 0 and 0 <= z^2 and z^2 == 0
assert not (z^2 != 0)

print(f"checked {len(SAMPLE_POINTS)} points ({cases} cases)")
print("RESULT: PASS")
