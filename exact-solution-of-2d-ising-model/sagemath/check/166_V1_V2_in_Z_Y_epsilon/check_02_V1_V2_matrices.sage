# <V1_V2_in_Z_Y_epsilon>: 行列としての V_1, V_2 の一致
# 左辺は <def_transfer_matrix_symbols> の定義（sigma^z sigma^z / sigma^x）から、
# 右辺は Z, Y, eps から独立に構成して比較する。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("V1_V2_in_Z_Y_epsilon: V_1, V_2 の行列としての一致")
for M in [2,3,4,5]:
    for p in OP_TEST_PARAMS:
        K1, K2 = p['K1'], p['K2']
        K2s = K_star(K2)
        s2 = np.sinh(2*K2)
        H1x = sum(Yop(m,M) @ Zop(m+1,M) for m in range(1,M)) - eps_op(M) @ Yop(M,M) @ Zop(1,M)
        H2x = sum(Zop(m,M) @ Yop(m,M) for m in range(1,M+1))
        rep.close(V1_op(K1,M), _expm(1j*K1*H1x), f"M={M} K1={K1}: V_1")
        rep.close(V2_op(K2,M), (2*s2)**(M/2) * _expm(1j*K2s*H2x), f"M={M} K2={K2}: V_2")
        # 規格化因子を落とすと一致しない（因子が本質的であることの確認）
        if M >= 2:
            rep.truth(np.max(np.abs(V2_op(K2,M) - _expm(1j*K2s*H2x))) > 1e-6,
                      f"M={M} K2={K2}: (2s_2)^{{M/2}} を落とすと不一致（因子の必要性）")
rep.finish()
