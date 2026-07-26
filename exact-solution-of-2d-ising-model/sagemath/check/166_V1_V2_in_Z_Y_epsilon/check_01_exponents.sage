# <V1_V2_in_Z_Y_epsilon> の前段: 指数の肩どうしが一致するか
# 行列指数を取る前に比べることで、不一致が出たときに原因を切り分けられる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("V1_V2_in_Z_Y_epsilon: 指数の肩の一致")
for M in [2,3,4,5,6]:
    # V_1 側: K_1 sum_m sigma^z_m sigma^z_{m+1}  vs  i K_1 (Y_1Z_2+...+Y_{M-1}Z_M - eps Y_M Z_1)
    lhs = sum(sz(m,M) @ sz(_wrap(m+1,M),M) for m in range(1,M+1))
    rhs = 1j * (sum(Yop(m,M) @ Zop(m+1,M) for m in range(1,M)) - eps_op(M) @ Yop(M,M) @ Zop(1,M))
    rep.close(lhs, rhs, f"M={M}: sum sigma^z_m sigma^z_{{m+1}} = i(sum Y_mZ_{{m+1}} - eps Y_M Z_1)")
    # 各項ごと（境界を除く）: sigma^z_m sigma^z_{m+1} = i Y_m Z_{m+1}
    for m in range(1, M):
        rep.close(sz(m,M) @ sz(m+1,M), 1j * (Yop(m,M) @ Zop(m+1,M)),
                  f"M={M} m={m}: sigma^z_m sigma^z_{{m+1}} = i Y_m Z_{{m+1}}")
    # 境界項: sigma^z_M sigma^z_1 = -i eps Y_M Z_1
    rep.close(sz(M,M) @ sz(1,M), -1j * (eps_op(M) @ Yop(M,M) @ Zop(1,M)),
              f"M={M}: sigma^z_M sigma^z_1 = -i eps Y_M Z_1（境界に eps が付く理由）")
    # V_2 側: K_2^* sum_m sigma^x_m  vs  i K_2^* sum_m Z_m Y_m
    lhs2 = sum(sx(m,M) for m in range(1,M+1))
    rhs2 = 1j * sum(Zop(m,M) @ Yop(m,M) for m in range(1,M+1))
    rep.close(lhs2, rhs2, f"M={M}: sum sigma^x_m = i sum Z_m Y_m")
    for m in range(1, M+1):
        rep.close(Zop(m,M) @ Yop(m,M), -1j * sx(m,M), f"M={M} m={m}: Z_m Y_m = -i sigma^x_m")
    # eps の積表示（<def_transfer_matrix_symbols> の注記）
    prod = eye_M(M)
    for m in range(1, M+1):
        prod = prod @ (Zop(m,M) @ Yop(m,M))
    rep.close(eps_op(M), (1j**M) * prod, f"M={M}: eps = i^M (Z_1Y_1)(Z_2Y_2)...(Z_MY_M)")
rep.finish()
