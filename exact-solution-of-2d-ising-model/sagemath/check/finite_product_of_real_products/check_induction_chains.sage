# 対象ラベル: finite_product_of_real_products（Π_{j=1}^{m}(x_jy_j) = (Π_j x_j)(Π_j y_j)）
# m = 1:     Π_{j≤1}(x_jy_j) = x_1y_1 = (Π_{j≤1}x_j)(Π_{j≤1}y_j)                 (def_finite_product_of_real_numbers)
# m → m+1:   Π_{j≤m+1}(x_jy_j) = (Π_{j≤m}(x_jy_j))(x_{m+1}y_{m+1})              (def_finite_product_of_real_numbers)
#                             = ((Π_{j≤m}x_j)(Π_{j≤m}y_j))(x_{m+1}y_{m+1})         (帰納法の仮定)
#                             = ((Π_{j≤m}x_j)x_{m+1})((Π_{j≤m}y_j)y_{m+1})         (ℝ で (ab)(cd) = (ac)(bd))
#                             = (Π_{j≤m+1}x_j)(Π_{j≤m+1}y_j)                        (def_finite_product_of_real_numbers を 2 箇所へ)
# x_j・y_j を QQ 上の多項式環の不定元に置き（主張は環の等式で、ℝ の元であることは使わない）、有限積は定義どおり左から掛けて、
# m = 1..8 の各段の行を厳密に比べる。帰納法の仮定の行は、前の段で示した等式を使って右辺を作る。
# 帰属: 全て厳密（QQ[x_1, …, y_m]）。浮動小数点はない。

def fprod(xs):
    """def_finite_product_of_real_numbers（左から掛ける）。"""
    p = xs[0]
    for x in xs[1:]:
        p = p * x
    return p


count = 0
negatives = 0
for m in range(1, 9):
    R = PolynomialRing(QQ, [f"x{j}" for j in range(1, m + 1)] + [f"y{j}" for j in range(1, m + 1)])
    x, y = R.gens()[:m], R.gens()[m:]
    xy = [x[j] * y[j] for j in range(m)]
    lines = [fprod(xy[:1]), x[0] * y[0], fprod(x[:1]) * fprod(y[:1])]
    for a, b in zip(lines, lines[1:]):
        assert a == b
        count += 1
    for k in range(1, m):
        assert fprod(xy[:k]) == fprod(x[:k]) * fprod(y[:k])      # 帰納法の仮定（前の段の結論）
        lines = [
            fprod(xy[:k + 1]),
            fprod(xy[:k]) * (x[k] * y[k]),
            (fprod(x[:k]) * fprod(y[:k])) * (x[k] * y[k]),
            (fprod(x[:k]) * x[k]) * (fprod(y[:k]) * y[k]),
            fprod(x[:k + 1]) * fprod(y[:k + 1]),
        ]
        for a, b in zip(lines, lines[1:]):
            assert a == b, (m, k)
            count += 1
    # 否定コントロール: 右辺を (Π x_j) + (Π y_j) にすると外れる。Π(x_j + y_j) とも外れる（m ≥ 1）
    assert fprod(xy) != fprod(x) + fprod(y)
    assert fprod(xy) != fprod([x[j] + y[j] for j in range(m)])
    negatives += 2
print(f"checked {count} lines")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
