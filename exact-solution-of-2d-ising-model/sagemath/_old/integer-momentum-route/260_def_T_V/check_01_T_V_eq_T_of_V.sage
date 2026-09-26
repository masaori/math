# 260-01: T_{(V)} = T_V （V := (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}）
#
# def_T_V: T_{(V)}(X) := T_{(V_1^{(±)})^{1/2}}( T_{V_2}( T_{(V_1^{(±)})^{1/2}}(X) ) )。
# def_T_g の合成則 T_A ∘ T_B = T_{AB}（255 で検証済み）から、
#   T_{(V)} = T_{(V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}} = T_V
# であるはずである。左辺は「3 回の共役を順に施す」、右辺は「1 個の行列 V で 1 回共役する」
# という別々の計算で、独立に評価できる。
#
# 検証対象は hatZ^{(-)}_μ, hatY_μ（本証明で実際に食わせる元）と Pauli 基底、
# および乱数行列。'+' '-' の両セクター、M と μ を複数回す。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

import itertools
import numpy as np

rep = CheckReport("def_T_V: T_{(V)} = T_V （V = (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}）")

rng = np.random.default_rng(int(254001))

for M in [2, 3, 4]:
    M = int(M)
    D = int(2 ** M)
    for pars in OP_TEST_PARAMS:
        K1, K2 = pars['K1'], pars['K2']
        V2 = V2_op(K2, M)
        for sign in ['+', '-']:
            H = principal_sqrt_of_V1pm(K1, M, sign)
            V = H @ V2 @ H

            def T_of_V(X):
                """3 段の合成として定義どおりに評価する（def_T_V の右辺）。"""
                return T_conj(H, T_conj(V2, T_conj(H, X)))

            def T_V(X):
                """1 個の行列 V による共役（def_T_g の g = V）。"""
                return T_conj(V, X)

            targets = []
            for mu in range(-M, M + 1):
                if mu == 0:
                    continue
                targets.append(("hatZ^(-)_%d" % mu, hatZ_op(mu, M, '-')))
                targets.append(("hatY_%d" % mu, hatY_op(mu, M)))
            for idx in list(itertools.product('0xyz', repeat=M))[:6]:
                targets.append(("sigma^" + ''.join(idx), kron_list([PAULI[a] for a in idx])))
            Xr = rng.normal(size=(D, D)) + 1j * rng.normal(size=(D, D))
            targets.append(("random", Xr))

            for name, X in targets:
                rep.close(T_of_V(X), T_V(X),
                          "M=%d K=(%.4g,%.4g) sign=%s X=%s" % (M, K1, K2, sign, name))

            # (V_1^{(±)})^{1/2} の 2 乗が V_1^{(±)} であること（記号の意味の確認）
            rep.close(H @ H, V1pm_op(K1, M, sign),
                      "M=%d K=(%.4g,%.4g) sign=%s: ((V_1^{(±)})^{1/2})^2 = V_1^{(±)}" % (M, K1, K2, sign))
    print("  M=%d : 全 %d パラメータ × 両セクターで T_{(V)} = T_V を確認" % (M, len(OP_TEST_PARAMS)))

rep.finish()
