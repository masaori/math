# 対象ラベル: epsilon_projector_properties
# 本文 (2) の (⊇) の鎖 P f = (1/2(I+ε))f = … = 1_C f = f（10 行）。
#   f を F^{(+)} の一般の元（εf = f の解空間の QQ 上の基底に不定元の係数を掛けた和）にして厳密に。
#   加えて、f を任意の不定元のベクトル g に置くと、仮定 εf = f を使う第 5 行→第 6 行だけが一致せず、
#   その差がちょうど (1/2)(εg - g) であることを見る。
#   F^{(+)} は ℂ^n の部分集合だが、εf = f は QQ 係数の一次方程式系なので、QQ 上の解空間の基底は ℂ 上の解空間も張る
#   （行列の階数は係数体を広げても変わらない）。ここでは QQ 上の基底を使う。
# 帰属: QQ[c_1,…,c_d] 上の n 行 1 列の行列、Mat(2^M, QQ)。
load("_prelude.sage")

h = QQ(1) / 2


def lines_of_fixed_chain(E, f):
    n = E.nrows()
    R = f.base_ring()
    E = E.change_ring(R)
    I = body_identity(R, n)
    IpE = body_sum(I, E)
    return [
        body_product(projector_body(E), f),                                   # P f
        body_product(body_scalar(h, IpE), f),                                 # (1/2(I+ε))f
        body_scalar(h, body_product(IpE, f)),                                 # 1/2((I+ε)f)
        body_scalar(h, body_sum(body_product(I, f), body_product(E, f))),     # 1/2(If + εf)
        body_scalar(h, body_sum(f, body_product(E, f))),                      # 1/2(f + εf)
        body_scalar(h, body_sum(f, f)),                                       # 1/2(f + f)
        body_scalar(h, body_scalar(2, f)),                                    # 1/2(2f)
        body_scalar(h * 2, f),                                                # (1/2·2)f
        body_scalar(QQ(1), f),                                                # 1_C f
        f,                                                                    # f
    ]


ASSUMPTION_STEP = 5   # 第 5 行 → 第 6 行（仮定 εf = f）

for M in M_COL_RANGE:
    E, P = projector(M)
    n = 2 ** M
    basis = (E - identity_matrix(QQ, n)).right_kernel().basis()
    d = len(basis)
    assert d == 2 ** (M - 1)
    R = PolynomialRing(QQ, [f"c{k}" for k in range(1, d + 1)])
    f = sum((R.gen(k) * matrix(R, n, 1, list(basis[k])) for k in range(d)), matrix(R, n, 1))
    assert body_product(E.change_ring(R), f) == f        # f ∈ F^{(+)}
    lines = lines_of_fixed_chain(E, f)
    check_chain(lines, f"M_col={M}")
    assert P.change_ring(R) * f == f                     # 比べる側: Sage の `*`
    # 任意のベクトルでは仮定の行だけが崩れる
    Rg, g = generic_vector(n, "g")
    lg = lines_of_fixed_chain(E, g)
    Eg = E.change_ring(Rg)
    for k, (a, b) in enumerate(zip(lg, lg[1:]), start=1):
        if k == ASSUMPTION_STEP:
            assert a != b
            assert a - b == h * (Eg * g - g)
        else:
            assert a == b, f"M_col={M}: 第 {k} 行は仮定を使わずに一致するはず"
    print(f"  M_col={M}: F^(+) の一般の元 f（次元 {d}）で鎖の 10 行は隣どうし一致し Pf = f。任意の g では仮定の行だけが差 (1/2)(εg-g) を持つ")

print("RESULT: PASS")
