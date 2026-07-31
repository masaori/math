# <real_exp_series_converges> Step 2 の具体的な有界性評価そのものを検査する
#
# 本文 Step 2 は m_0 in Z_{>=1} を m_0 >= 2a に取り、
#   (i) a^{m+1}/(m+1)! <= (1/2) a^m/m!            (m >= m_0)
#   (ii) a^{m_0+k}/(m_0+k)! <= (1/2)^k a^{m_0}/m_0!
#   (iii) Σ_{m=m_0}^{N} a^m/m! <= 2 a^{m_0}/m_0!
#   (iv) E_N(a) <= E_{m_0-1}(a) + 2 a^{m_0}/m_0! =: C   （全 N について）
# として上界 C を構成している。check_01 は (1)-(3) の帰結（単調性・上界の存在・剰余）を
# 見ているが、この C の構成自体は検査していないので、ここで直接確かめる。
#
# a は 0 から大きい値まで振り、Ising 側の指数の肩のノルム ||i K_1 H_1||、||i K_2^* H_2||
# （臨界点近傍のパラメータを含む）も実際の a として使う。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("real_exp_series_converges: Step 2 の上界 C の構成")

def fro(A):
    return float(np.linalg.norm(np.asarray(A, dtype=complex)))
def le_ok(x, y, slack=1e-12):
    x = float(x); y = float(y)
    return x <= y + float(slack)*max(1.0, abs(x), abs(y))
def E_partial(a, N):
    """E_N(a) = Σ_{m=0}^{N} a^m/m! を素朴に足す。"""
    a = float(a); term = 1.0; s = 1.0
    for m in range(1, int(N)+1):
        term = term*a/float(m)
        s += term
    return s
def term_of(a, m):
    """a^m/m!（階乗の桁あふれを避けて逐次計算する）。"""
    a = float(a); t = 1.0
    for k in range(1, int(m)+1):
        t = t*a/float(k)
    return t

avals = [0.0, 1e-6, 0.1, 0.5, 1.0, 2.0, 5.0, 10.0, 20.0]
# Ising 側の実際の指数の肩のノルム（臨界点近傍を含む）も a として使う
for M in [2,3]:
    for p in OP_TEST_PARAMS:
        avals.append(fro(1j*float(p['K1'])*H1_op(M, '-')))
        avals.append(fro(1j*float(K_star(p['K2']))*H2_op(M)))
avals = sorted(set(float(x) for x in avals))
print("a の値: %d 個（最大 %.4f）" % (len(avals), max(avals)))

NMAX = 400
for a in avals:
    m0 = max(1, int(np.ceil(2.0*a)))
    rep.truth(m0 >= 2.0*a - 1e-12, f"m_0 >= 2a の取り方 (a={a:.6f}, m_0={m0})")
    t0 = term_of(a, m0)

    # (i) 比が 1/2 以下（m >= m_0）
    for m in range(m0, m0+20):
        rep.truth(le_ok(term_of(a, m+1), 0.5*term_of(a, m)),
                  f"(i) a^(m+1)/(m+1)! <= (1/2) a^m/m! (a={a:.6f}, m={m})")
    # (ii) k 段の減衰
    for k in [0,1,2,5,10,30]:
        rep.truth(le_ok(term_of(a, m0+k), (0.5**k)*t0),
                  f"(ii) a^(m0+k)/(m0+k)! <= (1/2)^k a^m0/m0! (a={a:.6f}, k={k})")
    # (iii) 尾の評価
    for N in [m0, m0+1, m0+10, NMAX]:
        tail = E_partial(a, N) - E_partial(a, m0-1)
        rep.truth(le_ok(tail, 2.0*t0),
                  f"(iii) Σ_(m=m0)^N a^m/m! <= 2a^m0/m0! (a={a:.6f}, N={N})")
    # (iv) 上界 C が全 N で有効
    C = E_partial(a, m0-1) + 2.0*t0
    ok = all(le_ok(E_partial(a, N), C) for N in range(0, NMAX+1))
    rep.truth(ok, f"(iv) C = E_(m0-1)+2a^m0/m0! が全 N で上界 (a={a:.6f}, m_0={m0})")
    # C は実際に e^a を上から抑えている（独立経路 numpy.exp との突き合わせ）
    rep.truth(le_ok(float(np.exp(a)), C), f"(iv) e^a <= C (a={a:.6f})")
    print("a=%10.6f: m0=%3d, 2a^m0/m0!=%.6e, C=%.6e, e^a=%.6e"
          % (a, m0, 2.0*t0, C, float(np.exp(a))))

rep.finish()
