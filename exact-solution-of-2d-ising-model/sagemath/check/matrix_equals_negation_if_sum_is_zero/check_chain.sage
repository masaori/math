# 対象ラベル: matrix_equals_negation_if_sum_is_zero
# 鎖 X - (-Y) = X + (-(-Y)) = X + Y = O と、matrix_difference_zero_iff_equal から X = -Y を引く段。
# 第 1・2 等号は X, Y を独立な不定元の行列にして厳密に。第 3 等号（仮定 X + Y = O）は Y := -X で実現する。
# 対照: 独立な不定元の Y では X + Y ≠ O で、第 3 等号だけが崩れる。
load("_prelude.sage")

for (m, p) in [(1, 1), (2, 2), (2, 3), (3, 1)]:
    names = [f"{x}_{r}_{s}" for x in "XY" for r in range(m) for s in range(p)]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    X = matrix(R, m, p, g[:m*p])
    Yg = matrix(R, m, p, g[m*p:])
    O = matrix(R, m, p, 0)
    for Y, hyp in [(body_negation(X), True), (Yg, False)]:
        lines = [body_difference(X, body_negation(Y)),
                 body_sum(X, body_negation(body_negation(Y))),
                 body_sum(X, Y),
                 O]
        assert lines[0] == lines[1] and lines[1] == lines[2]
        assert (lines[2] == lines[3]) == hyp
        if hyp:
            assert body_difference(X, body_negation(Y)) == O and X == body_negation(Y)
        else:
            assert X != body_negation(Y)
    print(f"  ({m},{p}): 第 1・2 等号は任意の X, Y で、第 3 等号と結論 X = -Y は X + Y = O のときだけ成り立つ")
print("RESULT: PASS")
