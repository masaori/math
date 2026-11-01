# 対象ラベル: arctan_argument_in_unit_interval
# |x|^2 = x^2 <= 1+x^2 = s^2 と、そこから |x| <= s を出す背理法の鎖
#   s < |x| と仮定すると: s^2 = s·s <= s·|x| < |x|·|x| = |x|^2
# 一般の点で第二行の差 (1+x^2) - x^2 = 1 を、具体の点で各行と結論 |x| <= s を厳密に確かめる。
# 背理法の鎖は仮定が偽なので具体の点では評価できない。代わりに、仮定を満たす非負の対 0 <= b < a（AA）で、
# 鎖の各行 b^2 = b·b <= b·a < a·a = a^2 が成り立つこと（鎖の推論そのもの）を確かめる。
load("_prelude.sage")

assert (1 + x^2) - x^2 == 1
for px in SAMPLE_X:
    ps = s_of(px)
    assert abs(px)^2 == px^2                        # 第一行
    assert px^2 <= 1 + px^2                         # 第二行
    assert 1 + px^2 == ps^2                         # 第三行
    assert not (ps < abs(px))                       # 背理法の仮定は成り立たない
    assert abs(px) <= ps                            # 結論

PAIRS = [(AA(1), AA(0)), (AA(2), AA(1)), (AA(3).sqrt(), AA(1)), (AA(10)^6, AA(10)^6 - AA(10)^-6), (AA(1)/3, AA(1)/7)]
for (a, b) in PAIRS:
    assert 0 <= b < a and a > 0
    assert b^2 == b * b
    assert b * b <= b * a                           # b >= 0 と b < a の両辺に b を掛ける
    assert b * a < a * a                            # a > 0 と b < a の両辺に a を掛ける
    assert a * a == a^2
    assert b^2 < a^2                                # 鎖の結論
print(f"|x|^2 = x^2 <= 1+x^2 = s^2 and |x| <= s for {len(SAMPLE_X)} points; contradiction chain checked on {len(PAIRS)} pairs 0 <= b < a")
print("RESULT: PASS")
