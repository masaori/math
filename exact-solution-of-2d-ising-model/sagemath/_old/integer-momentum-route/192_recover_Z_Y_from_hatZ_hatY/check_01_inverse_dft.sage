# <recover_Z_Y_from_hatZ_hatY>: 逆変換 sum_mu hatY_mu e^{i m 2pi mu/M} = M Y_m など
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("recover_Z_Y_from_hatZ_hatY: 逆離散 Fourier 変換")
for M in [2,3,4,5]:
    for m in range(1, M+1):
        sY = sum(hatY_op(mu,M) * np.exp(1j*m*2*np.pi*mu/M) for mu in range(1, M+1))
        sZ = sum(hatZ_op(mu,M,'-') * np.exp(1j*m*2*np.pi*mu/M) for mu in range(1, M+1))
        rep.close(sY, M*Yop(m,M), f"M={M} m={m}: sum hatY_mu e^{{i m theta}} = M Y_m")
        rep.close(sZ, M*Zop(m,M), f"M={M} m={m}: sum hatZ^(-)_mu e^{{i m theta}} = M Z_m")
        rep.close(sY/M, Yop(m,M), f"M={M} m={m}: Y_m の復元")
        rep.close(sZ/M, Zop(m,M), f"M={M} m={m}: Z_m の復元")
        # hatZ^{(+)} は j=1 の重みが -1 なので、m=1 の項だけ符号が反転する。
        # m >= 2 では hatZ^{(-)} と同じ結果になる（重みが効くのは j=1 の項だけだから）。
        sZp = sum(hatZ_op(mu,M,'+') * np.exp(1j*m*2*np.pi*mu/M) for mu in range(1, M+1))
        if m == 1:
            rep.close(sZp, -M*Zop(1,M), f"M={M} m=1: hatZ^(+) では符号が反転して -M Z_1 になる")
            rep.truth(np.max(np.abs(sZp - M*Zop(m,M))) > 1e-6,
                      f"M={M} m=1: hatZ^(+) では同じ形の逆変換が成り立たない")
        else:
            rep.close(sZp, M*Zop(m,M), f"M={M} m={m}: m>=2 では hatZ^(+) でも M Z_m（j=1 の重みが効かない）")
rep.finish()
