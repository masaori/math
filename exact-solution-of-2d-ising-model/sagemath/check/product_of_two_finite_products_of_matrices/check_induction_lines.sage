# 対象ラベル: product_of_two_finite_products_of_matrices（j < i で A_iB_j = B_jA_i なら (∏A_j)(∏B_j) = ∏(A_jB_j)）
# 証明の帰納法の各行:
#   r = 1:   (∏^1 A)(∏^1 B) = A_1B_1 = ∏^1(A_jB_j)
#   r → r+1: (∏^{r+1}A)(∏^{r+1}B) = ((∏^r A)A_{r+1})((∏^r B)B_{r+1}) = (((∏^r A)A_{r+1})∏^r B)B_{r+1}
#            = ((∏^r A)(A_{r+1}∏^r B))B_{r+1} = ((∏^r A)((∏^r B)A_{r+1}))B_{r+1} = (((∏^r A)∏^r B)A_{r+1})B_{r+1}
#            = ((∏^r(A_jB_j))A_{r+1})B_{r+1} = (∏^r(A_jB_j))(A_{r+1}B_{r+1}) = ∏^{r+1}(A_jB_j)
# 有限積は def_finite_product_of_matrices どおり左へ掛け、積は mat_mult の成分の式で組む。
# 前提を満たす族: G の成分を不定元とし、A_2, …, A_r と B_1, …, B_{r-1} を G の多項式（係数は不定元）とする。
# A_1 と B_r は前提に現れない（j < i の組に A_1・B_r は入らない）ので、G と可換でない独立な不定元の行列にする。
# これで、A_1・B_r を含む組の可換性を使わずに成り立つことを確かめる（ほかの因子はどれも G の多項式で互いに可換）。
# 帰属: QQ 上の多項式環（n = 1, 2, 3、r = 1, 2, 3）。
load("../../_shared/matrix_operations_by_definition.sage")


def finite_product(mats):
    acc = mats[0]
    for A in mats[1:]:
        acc = body_product(acc, A)
    return acc


count = 0
for n in [1, 2, 3]:
    for r in range(1, 4):
        scal = [f"{c}{j}" for j in range(1, r + 1) for c in "abpq"]
        P, sc, mats = generic_ring([("G", n, n), ("U", n, n), ("V", n, n)], scalars=scal)
        G, U, V = mats
        Id = body_identity(P, n)
        poly = lambda a, b: body_sum(body_scalar(a, Id), body_scalar(b, G))
        A = [U] + [poly(sc[4 * k], sc[4 * k + 1]) for k in range(1, r)]
        B = [poly(sc[4 * k + 2], sc[4 * k + 3]) for k in range(r - 1)] + [V]
        for i in range(r):
            for j in range(i):
                assert body_product(A[i], B[j]) == body_product(B[j], A[i])   # 前提（j < i）
        AB = [body_product(A[j], B[j]) for j in range(r)]
        if r == 1:
            lines = [body_product(finite_product(A), finite_product(B)), body_product(A[0], B[0]), finite_product(AB)]
        else:
            PA, PB, PAB = finite_product(A[:-1]), finite_product(B[:-1]), finite_product(AB[:-1])
            a, b = A[-1], B[-1]
            lines = [
                body_product(finite_product(A), finite_product(B)),
                body_product(body_product(PA, a), body_product(PB, b)),
                body_product(body_product(body_product(PA, a), PB), b),
                body_product(body_product(PA, body_product(a, PB)), b),
                body_product(body_product(PA, body_product(PB, a)), b),
                body_product(body_product(body_product(PA, PB), a), b),
                body_product(body_product(PAB, a), b),
                body_product(PAB, body_product(a, b)),
                finite_product(AB),
            ]
        for X, Y in zip(lines, lines[1:]):
            assert X == Y, (n, r)
            count += 1
        assert prod(A) * prod(B) == prod(AB)        # 独立な経路: Sage の積
# 否定コントロール: j < i の組に可換でないものがあると主張が外れる（n = 2, r = 2、A_2 と B_1 を独立な不定元に）
P, _, mats = generic_ring([("A1", 2, 2), ("A2", 2, 2), ("B1", 2, 2), ("B2", 2, 2)])
A1, A2, B1, B2 = mats
assert body_product(finite_product([A1, A2]), finite_product([B1, B2])) != finite_product([body_product(A1, B1), body_product(A2, B2)])
print(f"checked {count} lines")
print("RESULT: PASS")
