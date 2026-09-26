# <commutator_of_H_and_Z_Y> のうち、本文の式と数値が一致しない 2 式。
#
# **本文は修正していない**（本文の編集は別セッションの担当範囲）。
# ここでは「本文の式が一致しないこと」と「どの式なら一致するか」の両方を固定して、
# 後から本文を直したときに、この check が壊れることで気づけるようにする。
#
#  (a) 本文: [H_1^{(±)}, hatZ_mu^{(∓)}] = 2 e^{-i 2 pi mu/M} hatY_mu
#      数値: 一致しない。差はちょうど -4 e^{-i 2 pi mu/M} Y_M。
#      成り立つ形: [H_1^{(±)}, hatZ_mu^{(∓)}] = 2 e^{-i th} hatY_mu - 4 e^{-i th} Y_M
#      根拠: hatZ^{(-)} - hatZ^{(+)} = 2 Z_1 e^{-i th} かつ [H_1^{(±)}, Z_1] = ∓2 Y_M。
#
#  (b) 本文: [H_2, hatZ_mu^{(+)}] = -2 hatY_mu + (1/M) sum_j (-2 e^{-i(2pi/M)(-j+mu)} hatY_j)
#      数値: 一致しない。補正項の係数が -2 ではなく +4 でなければ合わない。
#      成り立つ形: [H_2, hatZ_mu^{(+)}] = -2 hatY_mu + (4/M) sum_j e^{-i(2pi/M)(mu-j)} hatY_j
#                                       = -2 hatY_mu + 4 e^{-i th} Y_1
#      根拠: [H_2, Z_1] = -2 Y_1 と、Y_1 = (1/M) sum_j hatY_j e^{i 2 pi j/M}（<recover_Z_Y_from_hatZ_hatY>）。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("commutator_of_H_and_Z_Y: 本文と一致しない 2 式（不一致を固定する）")
max_gap_a = 0.0; max_gap_b = 0.0
for M in [2,3,4,5]:
    for mu in list(range(-M,0)) + list(range(1,M+1)):
        e_m = np.exp(-1j*2*np.pi*mu/M)
        # (a)
        for sgn in ['+','-']:
            other = '-' if sgn == '+' else '+'
            H1 = H1_op(M, sgn)
            lhs = comm(H1, hatZ_op(mu,M,other))
            text = 2*e_m*hatY_op(mu,M)
            fixed = text - 4*e_m*Yop(M,M)
            gap = float(np.max(np.abs(lhs - text)))
            max_gap_a = max(max_gap_a, gap)
            rep.truth(gap > 1.0, f"M={M} sgn={sgn} mu={mu}: (a) 本文の式とは一致しない（差={gap:.3f}）")
            rep.close(lhs, fixed, f"M={M} sgn={sgn} mu={mu}: (a) 修正形は一致する")
            rep.close(comm(H1, Zop(1,M)), (-2 if sgn=='+' else 2)*Yop(M,M),
                      f"M={M} sgn={sgn}: [H_1^(±), Z_1] = ∓2 Y_M（差の由来）")
        # (b)
        H2 = H2_op(M)
        lhs = comm(H2, hatZ_op(mu,M,'+'))
        text = -2*hatY_op(mu,M) + sum(-2*np.exp(-1j*2*np.pi*(-j+mu)/M)*hatY_op(j,M) for j in range(1,M+1))/M
        fixed = -2*hatY_op(mu,M) + 4*sum(np.exp(-1j*2*np.pi*(mu-j)/M)*hatY_op(j,M) for j in range(1,M+1))/M
        gap = float(np.max(np.abs(lhs - text)))
        max_gap_b = max(max_gap_b, gap)
        rep.truth(gap > 1.0, f"M={M} mu={mu}: (b) 本文の式とは一致しない（差={gap:.3f}）")
        rep.close(lhs, fixed, f"M={M} mu={mu}: (b) 修正形（係数 +4）は一致する")
        rep.close(lhs, -2*hatY_op(mu,M) + 4*e_m*Yop(1,M), f"M={M} mu={mu}: (b) Y_1 を使った同値な形")
        rep.close(comm(H2, Zop(1,M)), -2*Yop(1,M), f"M={M}: [H_2, Z_1] = -2 Y_1（差の由来）")
print(f"  (a) 本文の式との差の最大値: {max_gap_a:.6f}")
print(f"  (b) 本文の式との差の最大値: {max_gap_b:.6f}")
rep.finish()
