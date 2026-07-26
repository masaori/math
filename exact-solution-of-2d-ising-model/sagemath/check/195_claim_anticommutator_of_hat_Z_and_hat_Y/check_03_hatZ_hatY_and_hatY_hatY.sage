# anticommutator_of_hat_Z_and_hat_Y (3/4, 4/4):
#   [hatZ^{(±)}_mu, hatY_nu]_+ = 0
#   [hatY_mu, hatY_nu]_+ = 2M delta^M_{mu+nu,0} I
#
# 原文はこの 2 式を「同様」として証明を省いているので、数値検証の価値が高い。
# μ+ν が M の倍数になる場合とならない場合の両方を含める。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("anticommutator: [hatZ,hatY]_+ = 0 と [hatY,hatY]_+ = 2M δ I")

M_LIST = [2, 3, 4, 5]
n_deg = 0
n_nondeg = 0

for M in M_LIST:
    Mi = int(M)
    calM = [m for m in range(-Mi, Mi + 1) if m != 0]
    Z = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
    for mu in calM:
        for nu in calM:
            for sign in ['+', '-']:
                rep.close(acomm(hatZ_op(mu, M, sign), hatY_op(nu, M)), Z,
                          "M=%d sign=%s mu=%+d nu=%+d: [hatZ,hatY]_+ = 0" % (M, sign, mu, nu))
            rep.close(acomm(hatY_op(mu, M), hatY_op(nu, M)),
                      2.0 * float(Mi) * delta_M(mu + nu, 0, Mi) * eye_M(Mi),
                      "M=%d mu=%+d nu=%+d: [hatY,hatY]_+" % (M, mu, nu))
            if (mu + nu) % Mi == 0:
                n_deg += 1
            else:
                n_nondeg += 1

print("  μ+ν ≡ 0 (mod M) の組: %d 件、そうでない組: %d 件" % (n_deg, n_nondeg))
rep.truth(n_deg > 0 and n_nondeg > 0, "両方の場合をカバーしている")

# 土台となる Z, Y の反交換関係（<anticommutator_of_Z_and_Y>）も併せて確認しておく。
# これが成り立たなければ上の 4 式の証明が成立しない。
for M in M_LIST:
    Mi = int(M)
    for j in range(1, Mi + 1):
        for k in range(1, Mi + 1):
            rep.close(acomm(Zop(j, M), Zop(k, M)),
                      2.0 * delta_M(j, k, Mi) * eye_M(Mi), "M=%d [Z_%d,Z_%d]_+" % (M, j, k))
            rep.close(acomm(Yop(j, M), Yop(k, M)),
                      2.0 * delta_M(j, k, Mi) * eye_M(Mi), "M=%d [Y_%d,Y_%d]_+" % (M, j, k))
            rep.close(acomm(Zop(j, M), Yop(k, M)),
                      _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex),
                      "M=%d [Z_%d,Y_%d]_+ = 0" % (M, j, k))

rep.finish()
