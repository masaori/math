# anticommutator_of_hat_Z_and_hat_Y (2/4)  ← 補正項の符号と係数を厳密に検証する
#   [hatZ^{(±)}_mu, hatZ^{(∓)}_nu]_+
#     = 2M delta^M_{mu+nu,0} I + ( -2 exp(-i (2π/M)(mu+nu)) · 2 I )   （複号同順）
#
# 「複号同順」は (上,下) = ('+','-') と ('-','+') の 2 通り。両方を回す。
# μ+ν が M の倍数の場合／ならない場合の両方を必ず含める。
#
# 反例探し: 補正項の係数を -2·2 = -4 から ±2, -4 の符号反転, 位相の符号反転などに
# 変えた変種が破れることも確認し、係数・符号が一意であることを示す。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("anticommutator: [hatZ^{(±)}_mu, hatZ^{(∓)}_nu]_+ の補正項")

M_LIST = [2, 3, 4, 5]
PAIRS = [('+', '-'), ('-', '+')]   # 複号同順の 2 通り
n_deg = 0
n_nondeg = 0

for M in M_LIST:
    Mi = int(M)
    calM = [m for m in range(-Mi, Mi + 1) if m != 0]
    for (s1, s2) in PAIRS:
        for mu in calM:
            for nu in calM:
                lhs = acomm(hatZ_op(mu, M, s1), hatZ_op(nu, M, s2))
                phase = _np.exp(-1j * (2 * _np.pi / float(Mi)) * float(mu + nu))
                rhs = (2.0 * float(Mi) * delta_M(mu + nu, 0, Mi) * eye_M(Mi)
                       + (-2.0 * phase * 2.0 * eye_M(Mi)))
                rep.close(lhs, rhs,
                          "M=%d (%s,%s) mu=%+d nu=%+d" % (M, s1, s2, mu, nu))
                if (mu + nu) % Mi == 0:
                    n_deg += 1
                else:
                    n_nondeg += 1

print("  μ+ν ≡ 0 (mod M) の組: %d 件、そうでない組: %d 件" % (n_deg, n_nondeg))
rep.truth(n_deg > 0 and n_nondeg > 0, "両方の場合をカバーしている")

# --- 反例探し: 補正項の係数・符号の変種が破れること ---
VARIANTS = [
    ("係数を +4 にする", +4.0, -1.0),
    ("係数を -2 にする", -2.0, -1.0),
    ("係数を -8 にする", -8.0, -1.0),
    ("位相の符号を反転する", -4.0, +1.0),
]
n_skipped = 0
for M in [3, 4, 5]:
    Mi = int(M)
    for (s1, s2) in PAIRS:
        for (mu, nu) in [(1, 1), (1, 2), (1, -1), (2, -2), (Mi, -Mi)]:
            lhs = acomm(hatZ_op(mu, M, s1), hatZ_op(nu, M, s2))
            true_term = -4.0 * _np.exp(-1j * (2 * _np.pi / float(Mi)) * float(mu + nu))
            for (name, coef, psign) in VARIANTS:
                var_term = coef * _np.exp(psign * 1j * (2 * _np.pi / float(Mi)) * float(mu + nu))
                if abs(var_term - true_term) < 1e-12:
                    # この (μ,ν) では変種が本文の式と数値的に一致してしまい判定できない
                    n_skipped += 1
                    continue
                rhs = (2.0 * float(Mi) * delta_M(mu + nu, 0, Mi) * eye_M(Mi)
                       + var_term * eye_M(Mi))
                r = float(_np.max(_np.abs(lhs - rhs)))
                rep.truth(r > 1e-6,
                          "M=%d (%s,%s) μ=%+d ν=%+d 変種「%s」は破れる（残差 %.3f）"
                          % (M, s1, s2, mu, nu, name, r))
print("  変種判定: %d 件は本文の式と数値的に一致するため判定不能としてスキップ" % n_skipped)

rep.finish()
