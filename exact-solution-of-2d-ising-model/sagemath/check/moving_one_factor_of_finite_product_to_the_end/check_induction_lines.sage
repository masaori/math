# 対象ラベル: moving_one_factor_of_finite_product_to_the_end（ν < j で A_νA_j = A_jA_ν なら ∏_{j=1}^{r} A_j = (∏_{j=1, j≠ν}^{r} A_j)A_ν）
# 定義 def_finite_product_of_matrices_omitting_one_index: s_{r,ν}(j) = j（j < ν）、j + 1（ν ≤ j）、∏_{j≠ν} A_j := ∏_{j=1}^{r-1} A_{s_{r,ν}(j)}。
# 証明の帰納法の各行:
#   r = 2, ν = 1: ∏^2 A = (∏^1 A)A_2 = A_1A_2 = A_2A_1 = A_{s(1)}A_1 = (∏^1 A_{s(j)})A_1 = (∏_{j≠1} A_j)A_1
#   r = 2, ν = 2: ∏^2 A = (∏^1 A)A_2 = A_1A_2 = A_{s(1)}A_2 = (∏^1 A_{s(j)})A_2 = (∏_{j≠2} A_j)A_2
#   r → r+1, ν = r+1: ∏^{r+1}A = (∏^r A)A_{r+1} = (∏^r A_{s_{r+1,r+1}(j)})A_{r+1} = (∏_{j≠r+1}^{r+1} A_j)A_{r+1}
#   r → r+1, ν ≤ r: ∏^{r+1}A = (∏^r A)A_{r+1} = ((∏_{j≠ν}^r A)A_ν)A_{r+1} = (∏_{j≠ν}^r A)(A_νA_{r+1})
#            = (∏_{j≠ν}^r A)(A_{r+1}A_ν) = ((∏_{j≠ν}^r A)A_{r+1})A_ν = ((∏^{r-1}A_{s_{r,ν}(j)})A_{r+1})A_ν
#            = ((∏^{r-1}A_{s_{r,ν}(j)})A_{s_{r+1,ν}(r)})A_ν = ((∏^{r-1}A_{s_{r+1,ν}(j)})A_{s_{r+1,ν}(r)})A_ν
#            = (∏^{r}A_{s_{r+1,ν}(j)})A_ν = (∏_{j≠ν}^{r+1} A_j)A_ν
# 有限積は def_finite_product_of_matrices どおり左へ掛け、積は mat_mult の成分の式で組む。
# 前提を満たす族: A_ν = G（成分が不定元）、ν < j の A_j は G の多項式（係数は不定元）、j < ν の A_j は G と可換でない独立な
# 不定元の行列にする。これで j < ν の組の可換性を使わずに成り立つことを確かめる（ν < j の因子どうしは G の多項式で互いに
# 可換であり、n = 1 では全ての因子が可換なので、それらの組の可換性を使わないことはこの検算では確かめていない）。
# 帰属: QQ 上の多項式環（n = 1, 2, 3、r = 2, 3, 4、全ての ν）。
load("../../_shared/matrix_operations_by_definition.sage")


def finite_product(mats):
    acc = mats[0]                                      # def_finite_product_of_matrices の 1 項
    for A in mats[1:]:
        acc = body_product(acc, A)                     # def_finite_product_of_matrices の帰納
    return acc


def s(r, nu, j):
    # s_{r,ν} : {1,…,r−1} → {1,…,r}（1 始まり）
    assert 1 <= j <= r - 1 and 1 <= nu <= r
    return j if j < nu else j + 1


def omitting(A, r, nu):
    # def_finite_product_of_matrices_omitting_one_index。A[j-1] が A_j
    return finite_product([A[s(r, nu, j) - 1] for j in range(1, r)])


count = 0
for n in [1, 2, 3]:
    for r in [2, 3, 4]:
        for nu in range(1, r + 1):
            scal = [f"{c}{j}" for j in range(1, r + 1) for c in "ab"]
            shapes = [("G", n, n)] + [(f"U{j}", n, n) for j in range(1, nu)]
            P, sc, mats = generic_ring(shapes, scalars=scal)
            G, Us = mats[0], mats[1:]
            Id = body_identity(P, n)
            A = []
            for j in range(1, r + 1):
                if j < nu:
                    A.append(Us[j - 1])
                elif j == nu:
                    A.append(G)
                else:
                    A.append(body_sum(body_scalar(sc[2 * (j - 1)], Id), body_scalar(sc[2 * (j - 1) + 1], body_product(G, G))))
            for j in range(nu + 1, r + 1):
                assert body_product(A[nu - 1], A[j - 1]) == body_product(A[j - 1], A[nu - 1])   # 前提（ν < j）
            a = lambda j: A[j - 1]
            if r == 2 and nu == 1:
                lines = [finite_product(A), body_product(finite_product(A[:1]), a(2)), body_product(a(1), a(2)),
                         body_product(a(2), a(1)), body_product(a(s(2, 1, 1)), a(1)),
                         body_product(finite_product([a(s(2, 1, 1))]), a(1)), body_product(omitting(A, 2, 1), a(1))]
            elif r == 2 and nu == 2:
                lines = [finite_product(A), body_product(finite_product(A[:1]), a(2)), body_product(a(1), a(2)),
                         body_product(a(s(2, 2, 1)), a(2)), body_product(finite_product([a(s(2, 2, 1))]), a(2)),
                         body_product(omitting(A, 2, 2), a(2))]
            elif nu == r:
                q = r - 1                                   # 帰納法の段の r（r+1 = この r）
                lines = [finite_product(A), body_product(finite_product(A[:q]), a(q + 1)),
                         body_product(finite_product([a(s(q + 1, q + 1, j)) for j in range(1, q + 1)]), a(q + 1)),
                         body_product(omitting(A, q + 1, q + 1), a(q + 1))]
            else:
                q = r - 1                                   # 帰納法の段の r（r+1 = この r）、ν ≤ q
                Aq = A[:q]
                om = omitting(Aq, q, nu)
                inner = finite_product([a(s(q, nu, j)) for j in range(1, q)])
                inner_next = finite_product([a(s(q + 1, nu, j)) for j in range(1, q)])
                assert all(s(q + 1, nu, j) == s(q, nu, j) for j in range(1, q))
                assert s(q + 1, nu, q) == q + 1
                lines = [
                    finite_product(A),
                    body_product(finite_product(Aq), a(q + 1)),
                    body_product(body_product(om, a(nu)), a(q + 1)),
                    body_product(om, body_product(a(nu), a(q + 1))),
                    body_product(om, body_product(a(q + 1), a(nu))),
                    body_product(body_product(om, a(q + 1)), a(nu)),
                    body_product(body_product(inner, a(q + 1)), a(nu)),
                    body_product(body_product(inner, a(s(q + 1, nu, q))), a(nu)),
                    body_product(body_product(inner_next, a(s(q + 1, nu, q))), a(nu)),
                    body_product(finite_product([a(s(q + 1, nu, j)) for j in range(1, q + 1)]), a(nu)),
                    body_product(omitting(A, q + 1, nu), a(nu)),
                ]
            for X, Y in zip(lines, lines[1:]):
                assert X == Y, (n, r, nu)
                count += 1
            assert prod(A) == prod([A[j] for j in range(r) if j != nu - 1]) * A[nu - 1]   # 独立な経路: Sage の積
# 否定コントロール: ν < j の組に可換でないものがあると主張が外れる（n = 2, r = 2, ν = 1）
P, _, mats = generic_ring([("A1", 2, 2), ("A2", 2, 2)])
A1, A2 = mats
assert finite_product([A1, A2]) != body_product(omitting([A1, A2], 2, 1), A1)
print(f"checked {count} lines")
print("RESULT: PASS")
