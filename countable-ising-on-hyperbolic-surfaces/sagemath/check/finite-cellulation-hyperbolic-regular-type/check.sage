# SageMath: 有限セル分割データの双曲正則型集合の厳密検算
# 対象ラベル: def_finite_cellulation_hyperbolic_regular_type_set
# 対象: structured-latex/content/finite-cellulation.ts の「有限セル分割データの双曲正則型集合」
# 帰属: NN の有限集合だけを用いる。


def hyperbolic_regular_types(regular_types):
    result = []
    for p_raw, q_raw in regular_types:
        p = NN(p_raw)
        q = NN(q_raw)
        if p == 0 or q == 0:
            raise ValueError("regular type coordinates must be positive")
        if 2 * (p + q) < p * q:
            result.append((p, q))
    return Set(result)


# {3,7} と {4,5} は双曲型の不等式を満たす。
assert hyperbolic_regular_types(Set([(NN(3), NN(7))])) == Set([(NN(3), NN(7))])
assert hyperbolic_regular_types(Set([(NN(4), NN(5))])) == Set([(NN(4), NN(5))])

# {3,6} と {4,4} は等号の場合なので、狭義不等式を満たさない。
assert hyperbolic_regular_types(Set([(NN(3), NN(6))])) == Set([])
assert hyperbolic_regular_types(Set([(NN(4), NN(4))])) == Set([])

# {3,5} は左辺が 1/2 より大きいので、双曲型ではない。
assert hyperbolic_regular_types(Set([(NN(3), NN(5))])) == Set([])

# 正則型集合が空なら、その部分集合である双曲正則型集合も空である。
assert hyperbolic_regular_types(Set([])) == Set([])

print("RESULT: PASS — exact NN comparisons retained two hyperbolic regular types and removed three non-hyperbolic types")
