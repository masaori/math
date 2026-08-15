# SageMath: 正則型の双曲型判定に用いる有理不等式の厳密検算
# 対象ラベル: def_finite_cellulation_hyperbolic_regular_type
# 対象: structured-latex/content/finite-cellulation.ts の「正則型の双曲型判定」
# 帰属: NN、QQ、真偽値だけを用いる。


def hyperbolic_regular_type(p, q, regular_type):
    p = NN(p)
    q = NN(q)
    if p == 0 or q == 0 or not regular_type:
        return False
    return QQ(1) / QQ(p) + QQ(1) / QQ(q) < QQ(1) / QQ(2)


# {3,7} と {4,5} は双曲型の不等式を満たす。
assert hyperbolic_regular_type(3, 7, regular_type=True)
assert hyperbolic_regular_type(4, 5, regular_type=True)

# {3,6} と {4,4} は等号の場合なので、狭義不等式を満たさない。
assert not hyperbolic_regular_type(3, 6, regular_type=True)
assert not hyperbolic_regular_type(4, 4, regular_type=True)

# {3,5} は左辺が 1/2 より大きいので、双曲型ではない。
assert not hyperbolic_regular_type(3, 5, regular_type=True)

# 有理不等式を満たしても、先行する正則型述語が偽なら受理しない。
assert not hyperbolic_regular_type(3, 7, regular_type=False)

print("RESULT: PASS — exact QQ comparisons accepted two hyperbolic types and rejected four failed cases")
