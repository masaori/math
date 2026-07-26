# anticommutator_of_hat_Z_and_hat_Y (1/4):
#   [hatZ^{(±)}_mu, hatZ^{(±)}_nu]_+ = 2M delta^M_{mu+nu,0} I   （複号同順）
#
# 独立経路:
#   左辺: hatZ_op を行列として作り、行列積で反交換子を直接評価
#   右辺: 2M delta^M I（閉じた表示）
# mu+nu が M の倍数になる場合とならない場合の両方を必ず含める。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("anticommutator: [hatZ^{(±)}_mu, hatZ^{(±)}_nu]_+ = 2M δ^M_{μ+ν,0} I")

M_LIST = [2, 3, 4, 5]
n_deg = 0
n_nondeg = 0

for M in M_LIST:
    Mi = int(M)
    calM = [m for m in range(-Mi, Mi + 1) if m != 0]
    for sign in ['+', '-']:
        for mu in calM:
            for nu in calM:
                lhs = acomm(hatZ_op(mu, M, sign), hatZ_op(nu, M, sign))
                rhs = 2.0 * float(Mi) * delta_M(mu + nu, 0, Mi) * eye_M(Mi)
                rep.close(lhs, rhs, "M=%d sign=%s mu=%+d nu=%+d" % (M, sign, mu, nu))
                if (mu + nu) % Mi == 0:
                    n_deg += 1
                else:
                    n_nondeg += 1

print("  μ+ν ≡ 0 (mod M) の組: %d 件、そうでない組: %d 件" % (n_deg, n_nondeg))
rep.truth(n_deg > 0 and n_nondeg > 0, "両方の場合をカバーしている")

rep.finish()
