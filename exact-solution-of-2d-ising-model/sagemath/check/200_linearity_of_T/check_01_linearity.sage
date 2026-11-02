# <linearity_of_T>: 任意の可逆な有限複素行列 g に対して T_g が C-線型
# 本文の鎖の六行を、各行に書かれた括弧どおりに、積・和・スカラー倍を本文の定義（mat_mult・def_matrix_sum・
# def_matrix_scalar_multiple）の成分の式で組んで一行ずつ比べる。T_g(h) は (gh)g^{-1} と読む。
# 主張は Sage 組み込みの演算（独立な経路）で組んだ g(aX+bW)g^{-1} とも比べる。
load("../../_shared/operators.sage")
load("../../_shared/matrix_operations_by_definition.sage")
rep = CheckReport("linearity_of_T")
K.<ii> = QuadraticField(-1)

mul = body_product
add = body_sum
smul = body_scalar

def T(g, gi, h):
    """def_T_g の T_g(h) = (gh)g^{-1}。"""
    return mul(mul(g, h), gi)

for n in [2,4,8]:
    for trial in range(3):
        a = K(trial + 1 + (trial + 2)*ii)
        b = K(-(trial + 2) + (2*trial + 1)*ii)
        Xr = matrix(K, n, n, lambda j, k: K((j + 1)*(k + trial + 2) + (j - k)*ii))
        Wr = matrix(K, n, n, lambda j, k: K((j - k - trial) + (j + 2)*(k + 1)*ii))
        # 非零対角成分を持つ上三角行列なので、可逆性は厳密に保証される。
        g = matrix(K, n, n, lambda j, k:
                   K(0) if j > k else K(j + trial + 2 + ii) if j == k
                   else K(j + k + trial + 1 + (k - j)*ii))
        gi = g.inverse()
        assert mul(g, gi) == identity_matrix(K, n) and mul(gi, g) == identity_matrix(K, n)

        aX, bW = smul(a, Xr), smul(b, Wr)
        lines = [
            T(g, gi, add(aX, bW)),                                             # T_g(aX+bW)
            mul(mul(g, add(aX, bW)), gi),                                      # def_T_g
            mul(add(mul(g, aX), mul(g, bW)), gi),                              # mat_mult_distributes_over_sum_in_right_factor
            add(mul(mul(g, aX), gi), mul(mul(g, bW), gi)),                     # mat_mult_distributes_over_sum_in_left_factor
            add(mul(smul(a, mul(g, Xr)), gi), mul(smul(b, mul(g, Wr)), gi)),   # scalar_multiple_factors_out_of_right_factor（2 か所）
            add(smul(a, mul(mul(g, Xr), gi)), smul(b, mul(mul(g, Wr), gi))),   # scalar_multiple_factors_out_of_left_factor（2 か所）
            add(smul(a, T(g, gi, Xr)), smul(b, T(g, gi, Wr))),                 # def_T_g（2 か所）
        ]
        names = ["T_g の定義", "右の因子の和への分配", "左の因子の和への分配",
                 "右の因子のスカラー倍を外へ", "左の因子のスカラー倍を外へ", "T_g の定義へ戻す"]
        prefix = f"n={n}, trial={trial}"
        for t in range(len(lines) - 1):
            rep.truth(lines[t] == lines[t + 1], f"{prefix}: {names[t]}")
        # 比べる側: Sage 組み込みの演算
        rep.truth(lines[0] == g * (a*Xr + b*Wr) * gi and lines[-1] == a*(g*Xr*gi) + b*(g*Wr*gi),
                  f"{prefix}: 主張を Sage の演算と比べる")
        # 対照: b の項を落とした右辺とは一致しない
        rep.truth(lines[0] != smul(a, T(g, gi, Xr)), f"{prefix}: 否定コントロール")
rep.finish()
