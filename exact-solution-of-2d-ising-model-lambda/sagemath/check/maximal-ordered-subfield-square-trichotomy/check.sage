# 対象ラベル: claim_maximal_ordered_subfield_square_trichotomy
# AA 上の厳密標本で、正錐の三分法から平方の三分法への各段を検算する。

samples = [AA(0), AA(1), -AA(1), AA(2).sqrt(), -AA(2).sqrt()]
for z in samples:
    cone_cases = [z == 0, z > 0, -z > 0]
    assert sum(cone_cases) == 1
    squares = [False, False]
    if z > 0:
        w = z.sqrt()
        assert w != 0 and w * w == z
        squares[0] = True
    if -z > 0:
        w = (-z).sqrt()
        assert w != 0 and w * w == -z
        squares[1] = True
    assert sum([z == 0, squares[0], squares[1]]) == 1

print("PASS: 5 exact algebraic samples")
