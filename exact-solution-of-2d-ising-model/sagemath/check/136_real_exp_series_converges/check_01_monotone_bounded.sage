# ---------------------------------------------------------
# <real_exp_series_converges> (1)(2):
#   (1) E_N(a) = Σ_{m=0}^{N} a^m/m! は単調非減少かつ上に有界で収束する。
#   (2) すべての N について E_N(a) ≤ E(a)。
#
# 独立経路: E(a) の値は numpy.exp(a)（級数を素朴に足すのとは別のアルゴリズム）で取る。
# これにより「級数の部分和が別経路で計算した e^a へ増加収束する」という、
# 同語反復でない突き合わせになる。
#
# さらに本文の証明 Step 2 の有界性の評価そのものを検査する:
#   m_0 ≥ 2a なる整数について  Σ_{m=m_0}^{N} a^m/m! ≤ 2 a^{m_0}/m_0!
#   したがって  E_N(a) ≤ E_{m_0-1}(a) + 2 a^{m_0}/m_0! =: C
#
# 反例を探す姿勢: a を 0 から大きい値（Ising 側の ‖K_1 H_1‖ 相当まで）まで広く振る。
#
# 対象: structured-latex real_exp_series_converges
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))
import numpy as np

rep = CheckReport("real_exp_series_converges (1) 単調非減少・上に有界 / (2) E_N ≤ E")

avals = [0.0, 1e-6, 0.1, 0.5, 1.0, 2.0, 5.0, 10.0, 20.0]
# Ising 側の実際の指数の肩のノルム（臨界点近傍を含む）も a として使う
for M in [2, 3]:
    for p in OP_TEST_PARAMS:
        avals.append(fro(1j * float(p['K1']) * H1_op(M, '-')))
        avals.append(fro(1j * float(K_star(p['K2'])) * H2_op(M)))
avals = sorted(set(float(x) for x in avals))
print("a の値: %d 個（最大 %.4f）" % (len(avals), max(avals)))

NMAX = 400
for a in avals:
    # 部分和を逐次計算
    Es = []
    term = 1.0
    s = 1.0
    Es.append(s)
    for m in range(1, NMAX + 1):
        term = term * a / float(m)
        s += term
        Es.append(s)
    E_true = float(np.exp(a))   # 独立経路

    # (1) 単調非減少
    mono = all(Es[N + 1] >= Es[N] - 1e-15 * max(1.0, Es[N]) for N in range(NMAX))
    rep.truth(mono, "(1) E_N(a) は単調非減少 (a=%.6f)" % a)

    # (1) 上に有界（本文 Step 2 の評価 C を実際に構成して確認）
    m0 = max(1, int(np.ceil(2.0 * a)))
    # E_{m0-1}(a) と a^{m0}/m0!
    Em0m1 = E_real_partial(a, m0 - 1)
    t = 1.0
    for m in range(1, m0 + 1):
        t = t * a / float(m)
    C = Em0m1 + 2.0 * t
    ok = all(le_ok(Es[N], C) for N in range(NMAX + 1))
    rep.truth(ok, "(1) Step 2 の上界 C = E_{m0-1}+2a^{m0}/m0! が全 N で有効 (a=%.6f, m0=%d)" % (a, m0))
    # 尾の評価 Σ_{m=m0}^{N} a^m/m! ≤ 2 a^{m0}/m0!
    tail = E_real_partial(a, NMAX) - E_real_partial(a, m0 - 1)
    rep.truth(le_ok(tail, 2.0 * t),
              "(1) Σ_{m=m0}^{N} a^m/m! ≤ 2a^{m0}/m0! (a=%.6f: %.6e ≤ %.6e)" % (a, tail, 2.0 * t))

    # (1) 収束（独立経路との一致）
    rep.close(Es[NMAX], E_true, "(1) E_N(a) → e^a （numpy.exp との一致, a=%.6f）" % a)

    # (2) E_N(a) ≤ E(a)
    ok2 = all(le_ok(Es[N], E_true) for N in range(NMAX + 1))
    rep.truth(ok2, "(2) E_N(a) ≤ E(a) が全 N で成立 (a=%.6f)" % a)

    print("a=%10.6f: E_400=%.12e, e^a=%.12e, C(上界)=%.6e, m0=%d"
          % (a, Es[NMAX], E_true, C, m0))

# a = 0 の縮退: E_N(0) = 1 for all N
rep.close(E_real_partial(0.0, 50), 1.0, "縮退 a=0: E_N(0) = 1")

rep.finish()
