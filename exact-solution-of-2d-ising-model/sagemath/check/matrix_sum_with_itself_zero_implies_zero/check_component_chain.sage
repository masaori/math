# 対象ラベル: matrix_sum_with_itself_zero_implies_zero（X + X = O ⇒ X = O）
# 準備の鎖 1_C + 1_C = (1,0) + (1,0) = (1+1, 0+0) = (2,0) = 2_C と 2_C ≠ 0_C を実数の組で確かめ、
# 成分の 11 行の鎖を、各行に書かれた式どおりに組んで隣り合う項が等しいことを確かめる。
# 仮定 X + X = O を使う行（(X + X)_ik → O_ik）以外は不定元の X で確かめ、
# 仮定の行は、仮定を満たす X（成分が零）でだけ成り立ち、不定元の X では成り立たないこと（否定コントロール）を確かめる。
# 帰属: 複素数は QQ(i)（ガウス有理数体。2_C^{-1} = 1/2 を含む）上の多項式環。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")

# 準備の鎖（definition_of_cc の実数の組で）
def cc_add(z, w):
    return (z[0] + w[0], z[1] + w[1])

one = (QQ(1), QQ(0))                 # 1_C = ι(1) = (1,0)（inclusion_rr_to_cc）
two_C = (QQ(2), QQ(0))               # 2_C := ι(2) = (2,0)（inclusion_rr_to_cc の略記）
zero_C = (QQ(0), QQ(0))              # 0_C = (0,0)
prep = [cc_add(one, one),                       # 1_C + 1_C
        cc_add((QQ(1), QQ(0)), (QQ(1), QQ(0))), # (1,0) + (1,0)
        (QQ(1) + 1, QQ(0) + 0),                 # (1+1, 0+0)
        (QQ(2), QQ(0)),                         # (2,0)
        two_C]                                  # 2_C
for t in range(len(prep) - 1):
    assert prep[t] == prep[t + 1]
assert two_C[0] != zero_C[0] and two_C != zero_C    # 2_C = (2,0) ≠ (0,0) = 0_C（第 1 成分 2 ≠ 0）

K.<ii> = QuadraticField(-1)
count = 0
neg_control = 0
for m in [1, 2, 3]:
    for p in [1, 2, 3]:
        names = [f"X_{i}_{k}" for i in range(m) for k in range(p)]
        P = PolynomialRing(K, names)
        X = matrix(P, m, p, P.gens())
        O = matrix(P, m, p, lambda i, k: P(0))     # def_zero_matrix
        two = P(2)                                  # 2_C = ι(2)
        assert P(1) + P(1) == two                   # 準備の鎖
        two_inv = P(K(1) / K(2))                    # 2_C^{-1}
        assert two_inv * two == 1
        XX = body_sum(X, X)                         # def_matrix_sum
        for i in range(m):
            for k in range(p):
                x = X[i, k]
                chain = [
                    (x, False),
                    (1 * x, False),                                     # 1_C は積の単位元
                    ((two_inv * two) * x, False),                       # 2_C^{-1} の取り方
                    (two_inv * (two * x), False),                       # 積の結合律
                    (two_inv * ((P(1) + P(1)) * x), False),             # 1_C + 1_C = 2_C を右辺から左辺へ
                    (two_inv * (1 * x + 1 * x), False),                 # 分配律
                    (two_inv * (x + x), False),                         # 1_C は積の単位元（2 か所）
                    (two_inv * XX[i, k], False),                        # def_matrix_sum
                    (two_inv * O[i, k], True),                          # 仮定 X + X = O
                    (two_inv * P(0), False),                            # def_zero_matrix
                    (P(0), False),                                      # complex_times_zero_is_zero
                    (O[i, k], False),                                   # def_zero_matrix
                ]
                for (a, _), (b, hyp) in zip(chain, chain[1:]):
                    if hyp:
                        assert a != b               # 否定コントロール: 仮定なしでは成り立たない
                        neg_control += 1
                        # 仮定を満たす X（零行列）を代入すると成り立つ
                        sub = {g: 0 for g in P.gens()}
                        assert a.subs(sub) == b.subs(sub)
                    else:
                        assert a == b, (m, p, i, k)
                        count += 1
        # 主張: 仮定 X + X = O の解は X = O だけ（XX の各成分 2x = 0 から x = 0）
        I_ideal = P.ideal(list(XX.list()))
        assert all(g in I_ideal for g in P.gens())
print(f"checked {count} steps, negative control {neg_control} lines over 9 shapes")
print("RESULT: PASS")
