# <hatZ_hatY_M_periodicity>: hatZ^{(+)} と hatZ^{(-)} の差が j=1 の項の符号だけであることを、
# 差の式だけでなく「和の式」からも押さえる。
#
# check_01 は差
#     hatZ^(-)_mu - hatZ^(+)_mu = 2 Z_1 e^{-i2pi mu/M}
# を mu = 1..M について見ている。差の式だけでは「j>=2 の項が両符号で共通であること」は
# 直接には出てこない（差が合っていても j>=2 の項が両方で同じだけずれていれば通ってしまう）。
# そこで独立な情報として和
#     hatZ^(+)_mu + hatZ^(-)_mu = 2 sum_{j=2}^{M} Z_j e^{-i2pi j mu/M}
# を、右辺を Zop から素朴に組み直す経路で確かめる。差と和が両方合えば
# j=1 の項と j>=2 の項がそれぞれ本文どおりであることが分かる。
#
# 併せて、負の mu を含む mu ∈ 𝓜 = {-M,…,-1,1,…,M} の全体で見る（check_01 は mu = 1..M のみ）。
# 最後に (+) と (-) が実際に別物であること（差が 0 でないこと）も確かめる。
# これは差の式の非退化性の確認であって、Z_1 が可逆（Z_1^2 = I）であることから従う。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

rep = CheckReport("hatZ_hatY_M_periodicity: hatZ^{(+)} と hatZ^{(-)} の差は j=1 の項の符号のみ")

for M in [2,3,4,5]:
    calM = [m for m in range(-M, M+1) if m != 0]
    for mu in calM:
        zp = hatZ_op(mu, M, '+')
        zm = hatZ_op(mu, M, '-')
        e1 = np.exp(-1j*2*np.pi*mu/M)

        # 差（check_01 の主張を負の mu へ広げたもの）
        rep.close(zp - zm, -2*Zop(1,M)*e1,
                  f"M={M} mu={mu:+d}: hatZ^(+) - hatZ^(-) = -2 Z_1 e^{{-i2pi mu/M}}")

        # 和: j>=2 の項が両符号で共通であること
        tail = np.zeros((2**M, 2**M), dtype=complex)
        for j in range(2, M+1):
            tail = tail + Zop(j,M)*np.exp(-1j*2*np.pi*j*mu/M)
        rep.close(zp + zm, 2*tail,
                  f"M={M} mu={mu:+d}: hatZ^(+) + hatZ^(-) = 2 Σ_{{j>=2}} Z_j e^{{-i2pi j mu/M}}")

        # j=1 の項をそれぞれの符号で取り除くと完全に一致する（＝差は j=1 の項に限る）
        rep.close(zp - (-1)*Zop(1,M)*e1, zm - (+1)*Zop(1,M)*e1,
                  f"M={M} mu={mu:+d}: j=1 の項を除くと両符号で一致")

        # 非退化性: (+) と (-) は別物である。Z_1^2 = I なので差のノルムは 0 にならない。
        d = float(np.max(np.abs(zp - zm)))
        rep.truth(d > 1.0, f"M={M} mu={mu:+d}: hatZ^(+) != hatZ^(-)（最大成分差 {d:.3f}）")

rep.finish()
