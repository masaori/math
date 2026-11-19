# 対象ラベル: claim_sum_of_squares_root_nonnegative_sign
# 有理数の組について、二つの平方の和の代数的な根の符号選択を厳密検算する。

for a, b in [(QQ(0), QQ(0)), (QQ(3), QQ(4)), (QQ(-3), QQ(4)),
             (QQ(0), QQ(5)), (QQ(2), QQ(0))]:
    target = a*a + b*b
    for sign in [1, -1]:
        d = sign*QQbar(target).sqrt()
        assert d*d == target
        if d == 0:
            c = d
            assert c == 0
        elif AA(d) > 0:
            c = d
            assert AA(c) > 0
        else:
            assert AA(d) < 0
            c = -d
            assert AA(c) > 0
        assert c*c == d*d
        assert c*c == target
print("PASS: 5 exact algebraic pairs and both root signs; every equality checked")
