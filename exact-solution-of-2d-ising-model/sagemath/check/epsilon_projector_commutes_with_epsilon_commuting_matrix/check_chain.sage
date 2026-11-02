# 対象ラベル: epsilon_projector_commutes_with_epsilon_commuting_matrix
# 証明の 9 行の鎖 P^{(+)}X = ((1/2)(I+ε))X = (1/2)((I+ε)X) = (1/2)(IX+εX) = (1/2)(X+εX) = (1/2)(X+Xε)
#   = (1/2)(XI+Xε) = (1/2)(X(I+ε)) = X((1/2)(I+ε)) = XP^{(+)} を、各行をその括弧の形どおりに本文の定め方
# （mat_mult・def_matrix_sum・def_matrix_scalar_multiple・def_identity_matrix の成分の式）で組んで隣の行と比べる。
# X は εX = Xε を満たす一般の行列として X := Y + εYε（Y は成分が独立な不定元の行列。ε^2 = I なので εX = Xε）を取る。
# 対照: X を独立な不定元の行列にすると（仮定を外すと）、仮定を使う第 5→6 行だけが崩れる。M_col = 1..3。
load("_prelude.sage")
half = KG(1) / 2
for M in range(1, 4):
    n = 2 ** M
    R = PolynomialRing(KG, [f"y_{r}_{s}" for r in range(n) for s in range(n)])
    Y = matrix(R, n, n, R.gens())
    E = epsilon(M).change_ring(R)
    I = body_identity(R, n)
    P = projector_plus(M).change_ring(R)
    Xc = body_sum(Y, body_product(body_product(E, Y), E))
    assert body_product(E, Xc) == body_product(Xc, E)

    def lines(X):
        IpE = body_sum(I, E)
        return [
            body_product(P, X),
            body_product(body_scalar(half, IpE), X),
            body_scalar(half, body_product(IpE, X)),
            body_scalar(half, body_sum(body_product(I, X), body_product(E, X))),
            body_scalar(half, body_sum(X, body_product(E, X))),
            body_scalar(half, body_sum(X, body_product(X, E))),
            body_scalar(half, body_sum(body_product(X, I), body_product(X, E))),
            body_scalar(half, body_product(X, IpE)),
            body_product(X, body_scalar(half, IpE)),
            body_product(X, P),
        ]
    check_chain(lines(Xc), f"M_col={M}")
    ln = lines(Y)
    broken = [k for k in range(1, len(ln)) if ln[k - 1] != ln[k]]
    assert broken == [5], broken
    print(f"  M_col={M}: 9 等号が成り立つ。独立な X では第 5→6 行（仮定 εX = Xε）だけが崩れる")
print("RESULT: PASS")
