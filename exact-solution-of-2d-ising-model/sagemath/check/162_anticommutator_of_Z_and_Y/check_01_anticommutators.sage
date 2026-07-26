# ---------------------------------------------------------
# <anticommutator_of_Z_and_Y>
#   （006_Z_Y_anticommutation.mjs / Z_Y_anticommutation_001_claim_anticommutation_relations_Z_and_Y）
#
# 主張:
#   [Z_mu, Z_nu]_+ = 2 I delta^M_{(mu,nu)}
#   [Z_mu, Y_nu]_+ = 0
#   [Y_mu, Y_nu]_+ = 2 I delta^M_{(mu,nu)}
#
# 独立経路: 左辺は Jordan--Wigner 文字列
#     Z_m = sigma^x (x) ... (x) sigma^x (x) sigma^z (x) I (x) ... (x) I
#   を 2^M x 2^M のクロネッカー積として直接組み立て、行列積で XY + YX を数値評価する。
#   右辺は delta^M（<def_delta_M>）から独立に構成する。本文の証明が使う
#   「1 サイトだけ食い違う」という場合分けの議論には依存しない。
#
# 範囲: M = 2,3,4,5、mu,nu は 1..M の全組（対角も含む）。
#       さらに添字の M 周期延長（mu = M+1, M+2, 負の添字）でも成り立つことを確かめる。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

import numpy as np

rep = CheckReport("<anticommutator_of_Z_and_Y>: Z と Y の反交換関係")

for M in [2, 3, 4, 5]:
    Id = eye_M(M)
    for mu in range(1, M + 1):
        for nu in range(1, M + 1):
            d = delta_M(mu, nu, M)
            rep.close(acomm(Zop(mu, M), Zop(nu, M)), 2.0 * d * Id,
                      "M=%d [Z_%d,Z_%d]_+ = 2 I delta" % (M, mu, nu))
            rep.close(acomm(Zop(mu, M), Yop(nu, M)), np.zeros((2 ** M, 2 ** M), dtype=complex),
                      "M=%d [Z_%d,Y_%d]_+ = 0" % (M, mu, nu))
            rep.close(acomm(Yop(mu, M), Yop(nu, M)), 2.0 * d * Id,
                      "M=%d [Y_%d,Y_%d]_+ = 2 I delta" % (M, mu, nu))

# --- 添字の M 周期延長（Z_{M+1} = Z_1 など）でも同じ式が成り立つこと ---
for M in [2, 3, 4, 5]:
    Id = eye_M(M)
    for mu in [-1, 0, M + 1, M + 2, 2 * M + 1]:
        for nu in range(1, M + 1):
            d = delta_M(mu, nu, M)
            rep.close(acomm(Zop(mu, M), Zop(nu, M)), 2.0 * d * Id,
                      "M=%d（周期延長）[Z_%d,Z_%d]_+" % (M, mu, nu))
            rep.close(acomm(Zop(mu, M), Yop(nu, M)), np.zeros((2 ** M, 2 ** M), dtype=complex),
                      "M=%d（周期延長）[Z_%d,Y_%d]_+" % (M, mu, nu))
            rep.close(acomm(Yop(mu, M), Yop(nu, M)), 2.0 * d * Id,
                      "M=%d（周期延長）[Y_%d,Y_%d]_+" % (M, mu, nu))

# --- 反例探し: delta が本当に効いていること ---
# mu != nu で右辺を 2I に置き換えると成り立たない（= 主張は「常に 2I」ではない）。
for M in [2, 3, 4, 5]:
    Id = eye_M(M)
    for mu in range(1, M + 1):
        for nu in range(1, M + 1):
            if mu == nu:
                continue
            e = float(np.max(np.abs(acomm(Zop(mu, M), Zop(nu, M)) - 2.0 * Id)))
            rep.truth(e > 1.0,
                      "M=%d mu=%d nu=%d: [Z,Z]_+ は 2I ではない（差 %.2f）" % (M, mu, nu, e))

rep.finish()
