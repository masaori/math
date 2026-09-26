# <H1_H2_via_hatZ_hatY>: H_1^{(±)} と H_2 を hatZ, hatY で表す
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("H1_H2_via_hatZ_hatY")
for M in [2,3,4,5]:
    for sgn in ['+','-']:
        rhs = sum(hatY_op(j,M) @ hatZ_op(-j,M,sgn) * np.exp(-1j*2*np.pi*j/M) for j in range(1,M+1)) / M
        rep.close(rhs, H1_op(M,sgn), f"M={M} sgn={sgn}: H_1^({sgn}) の hat 表示")
    rhs2 = sum(hatZ_op(-j,M,'-') @ hatY_op(j,M) for j in range(1,M+1)) / M
    rep.close(rhs2, H2_op(M), f"M={M}: H_2 の hat 表示")
    # 定義側の確認: H_1^{(±)} = Y_1Z_2+...+Y_{M-1}Z_M ∓ Y_M Z_1
    for sgn, sv in [('+',-1.0), ('-',+1.0)]:
        direct = sum(Yop(m,M) @ Zop(m+1,M) for m in range(1,M)) + sv*(Yop(M,M) @ Zop(1,M))
        rep.close(H1_op(M,sgn), direct, f"M={M} sgn={sgn}: H_1 の定義式")
    rep.close(H2_op(M), sum(Zop(m,M) @ Yop(m,M) for m in range(1,M+1)), f"M={M}: H_2 の定義式")
rep.finish()
