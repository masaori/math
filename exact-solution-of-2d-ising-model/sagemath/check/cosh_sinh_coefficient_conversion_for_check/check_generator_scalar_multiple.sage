# 対象ラベル: cosh_sinh_coefficient_conversion_for_check
# 証明の準備 (★) ad^m_{αX}(W) = α^m ad^m_X(W) の基底段階と帰納段階の鎖の全行を、α と X・W の成分を独立な不定元にして
# 厳密に確かめる（行列の大きさ d = 1..3、m = 0..M_MAX）。ad の値は def_ad_X_matrix の交換子（comm_body。積・差は本文の成分の式）
# の再帰で作り、鎖の先頭は Sage の演算の再帰（ad_power_sage）とも比べる。
load("_prelude.sage")

M_MAX = {1: 5, 2: 4, 3: 3}


def ad_body(X, W, m):
    out = W
    for _ in range(m):
        out = comm_body(X, out)
    return out


for d in (1, 2, 3):
    names = ['al'] + [f"x_{r}_{c}" for r in range(d) for c in range(d)] + [f"w_{r}_{c}" for r in range(d) for c in range(d)]
    R = PolynomialRing(KG, names)
    g = R.gens()
    al = g[0]
    X = matrix(R, d, d, g[1:1 + d * d])
    W = matrix(R, d, d, g[1 + d * d:])
    aX = body_scalar(al, X)
    # 基底段階
    run_chain([
        ("ad^0_{αX}(W)", ad_body(aX, W, 0)),
        ("W", W),
        ("1_C W", body_scalar(R(1), W)),
        ("α^0 W", body_scalar(pw(al, 0), W)),
        ("α^0 ad^0_X(W)", body_scalar(pw(al, 0), ad_body(X, W, 0))),
    ], f"d={d} 基底")
    for m in range(M_MAX[d]):
        # 帰納法の仮定（m の段の主張）
        report(ad_body(aX, W, m) == body_scalar(pw(al, m), ad_body(X, W, m)), f"d={d}: (★) m={m}（帰納法の仮定）")
        run_chain([
            ("ad^{m+1}_{αX}(W)", ad_body(aX, W, m + 1)),
            ("[αX, ad^m_{αX}(W)]", comm_body(aX, ad_body(aX, W, m))),
            ("[αX, α^m ad^m_X(W)]", comm_body(aX, body_scalar(pw(al, m), ad_body(X, W, m)))),
            ("(α α^m)[X, ad^m_X(W)]", body_scalar(al * pw(al, m), comm_body(X, ad_body(X, W, m)))),
            ("(α^m α)[X, ad^m_X(W)]", body_scalar(pw(al, m) * al, comm_body(X, ad_body(X, W, m)))),
            ("α^{m+1}[X, ad^m_X(W)]", body_scalar(pw(al, m + 1), comm_body(X, ad_body(X, W, m)))),
            ("α^{m+1} ad^{m+1}_X(W)", body_scalar(pw(al, m + 1), ad_body(X, W, m + 1))),
        ], f"d={d} m={m} 帰納段階")
        report(ad_body(aX, W, m + 1) == ad_power_sage(al * X, W, m + 1), f"d={d} m={m}: 鎖の先頭が Sage の ad^{{m+1}}_{{αX}}(W) と一致")
        if d >= 2 and m == 0:
            # 対照: 係数の冪を落とすと一致しない
            report(ad_body(aX, W, 2) != body_scalar(al, ad_body(X, W, 2)), f"d={d}: 対照 ad^2_{{αX}}(W) ≠ α ad^2_X(W)")

print("RESULT: PASS")
