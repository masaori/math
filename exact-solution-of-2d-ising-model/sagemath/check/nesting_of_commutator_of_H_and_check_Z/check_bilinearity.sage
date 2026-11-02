# 対象ラベル: nesting_of_commutator_of_H_and_check_Z
# 証明の準備「交換子の双線型性」[αX, βW] = (αβ)[X, W] の鎖の全行を、α・β と X・W の成分を独立な不定元にして厳密に確かめる。
# 各行は本文の定め方の積（mat_mult）・スカラー倍（def_matrix_scalar_multiple）・差（def_matrix_difference）で作り、
# 最後の値を Sage の `*`・`-` で作った (αβ)(XW - WX) とも比べる。
load("_prelude.sage")

for d in (1, 2, 3):
    names = ['al', 'be'] + [f"x_{r}_{c}" for r in range(d) for c in range(d)] + [f"w_{r}_{c}" for r in range(d) for c in range(d)]
    R = PolynomialRing(KG, names)
    g = R.gens()
    al, be = g[0], g[1]
    X = matrix(R, d, d, g[2:2 + d * d])
    W = matrix(R, d, d, g[2 + d * d:])
    P = body_product
    lines = [
        ("[αX, βW]（交換子の定義の左辺）", comm_body(body_scalar(al, X), body_scalar(be, W))),
        ("(αX)(βW) - (βW)(αX)", body_difference(P(body_scalar(al, X), body_scalar(be, W)), P(body_scalar(be, W), body_scalar(al, X)))),
        ("α(X(βW)) - (βW)(αX)", body_difference(body_scalar(al, P(X, body_scalar(be, W))), P(body_scalar(be, W), body_scalar(al, X)))),
        ("α(β(XW)) - (βW)(αX)", body_difference(body_scalar(al, body_scalar(be, P(X, W))), P(body_scalar(be, W), body_scalar(al, X)))),
        ("(αβ)(XW) - (βW)(αX)", body_difference(body_scalar(al * be, P(X, W)), P(body_scalar(be, W), body_scalar(al, X)))),
        ("(αβ)(XW) - β(W(αX))", body_difference(body_scalar(al * be, P(X, W)), body_scalar(be, P(W, body_scalar(al, X))))),
        ("(αβ)(XW) - β(α(WX))", body_difference(body_scalar(al * be, P(X, W)), body_scalar(be, body_scalar(al, P(W, X))))),
        ("(αβ)(XW) - (βα)(WX)", body_difference(body_scalar(al * be, P(X, W)), body_scalar(be * al, P(W, X)))),
        ("(αβ)(XW) - (αβ)(WX)", body_difference(body_scalar(al * be, P(X, W)), body_scalar(al * be, P(W, X)))),
        ("(αβ)(XW - WX)", body_scalar(al * be, body_difference(P(X, W), P(W, X)))),
        ("(αβ)[X, W]", body_scalar(al * be, comm_body(X, W))),
    ]
    for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
        report(v0 == v1, f"d={d}: {n0} = {n1}")
    report(lines[-1][1] == (al * be) * (X * W - W * X), f"d={d}: 最後の値が Sage の (αβ)(XW - WX) と一致")
    report(lines[0][1] == comm_sage(al * X, be * W), f"d={d}: 最初の値が Sage の [αX, βW] と一致")
    if d >= 2:
        # 対照: 係数を α だけにすると一致しない
        report(lines[0][1] != body_scalar(al, comm_body(X, W)), f"d={d}: 対照 [αX, βW] ≠ α[X, W]")

print("RESULT: PASS")
