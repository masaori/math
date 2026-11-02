# 対象ラベル: matrix_commuting_with_each_factor_commutes_with_finite_product（全ての j で XA_j = A_jX なら X∏A_j = (∏A_j)X）
# 証明の帰納法の各行:
#   r = 1:   X∏_{j=1}^1 A_j = XA_1 = A_1X = (∏_{j=1}^1 A_j)X
#   r → r+1: X∏^{r+1}A = X((∏^r A)A_{r+1}) = (X∏^r A)A_{r+1} = ((∏^r A)X)A_{r+1} = (∏^r A)(XA_{r+1})
#            = (∏^r A)(A_{r+1}X) = ((∏^r A)A_{r+1})X = (∏^{r+1}A)X
# 有限積は def_finite_product_of_matrices どおり A_1 から左へ掛け（空の積は使わない）、積は mat_mult の成分の式で組む。
# 前提を満たす族: X の成分を不定元とし、A_j := a_j I + b_j X + c_j X^2（a_j, b_j, c_j も不定元）とする。
# 帰属: QQ 上の多項式環（n = 1, 2, 3、r = 1, 2, 3）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")


def finite_product(mats):
    acc = mats[0]                                   # ∏_{j=1}^{1} A_j := A_1
    for A in mats[1:]:
        acc = body_product(acc, A)                  # ∏_{j=1}^{r+1} A_j := (∏_{j=1}^{r} A_j) A_{r+1}
    return acc


count = 0
for n in [1, 2, 3]:
    for r in range(1, 4):
        scal = [f"{c}{j}" for j in range(1, r + 1) for c in "abc"]
        P, sc, mats = generic_ring([("X", n, n)], scalars=scal)
        X = mats[0]
        Id = body_identity(P, n)
        X2 = body_product(X, X)
        A = [body_sum(body_sum(body_scalar(sc[3 * k], Id), body_scalar(sc[3 * k + 1], X)), body_scalar(sc[3 * k + 2], X2))
             for k in range(r)]
        for Aj in A:
            assert body_product(X, Aj) == body_product(Aj, X)       # 前提 XA_j = A_jX
        if r == 1:
            lines = [body_product(X, finite_product(A)), body_product(X, A[0]), body_product(A[0], X),
                     body_product(finite_product(A), X)]
        else:
            Pr = finite_product(A[:-1])
            last = A[-1]
            lines = [
                body_product(X, finite_product(A)),
                body_product(X, body_product(Pr, last)),
                body_product(body_product(X, Pr), last),
                body_product(body_product(Pr, X), last),
                body_product(Pr, body_product(X, last)),
                body_product(Pr, body_product(last, X)),
                body_product(body_product(Pr, last), X),
                body_product(finite_product(A), X),
            ]
        for U, V in zip(lines, lines[1:]):
            assert U == V, (n, r)
            count += 1
        # 独立な経路: Sage の積
        assert X * prod(A) == prod(A) * X
# 否定コントロール: 一つの因子を X と可換でない不定元の行列に替えると主張が外れる（n = 2, r = 2）
P, _, mats = generic_ring([("Y", 2, 2), ("B", 2, 2), ("C", 2, 2)])
Y, B, C = mats
assert body_product(Y, finite_product([body_product(Y, Y), C])) != body_product(finite_product([body_product(Y, Y), C]), Y)
print(f"checked {count} lines")
print("RESULT: PASS")
