# <Z_Y_linearly_independent>: {Z_1..Z_M, Y_1..Y_M} が C-線型独立
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("Z_Y_linearly_independent: 特異値による数値ランク")
for M in [2,3,4,5]:
    rows = [Zop(m,M).reshape(-1) for m in range(1,M+1)] + [Yop(m,M).reshape(-1) for m in range(1,M+1)]
    A = np.array(rows)                      # (2M) x (4^M)
    sv = np.linalg.svd(A, compute_uv=False)
    smin, smax = float(sv.min()), float(sv.max())
    print(f"  M={M}: 2M={2*M}, sigma_min={smin:.6e}, sigma_max={smax:.6e}, cond={smax/smin:.3f}")
    rep.truth(np.linalg.matrix_rank(A, tol=1e-8) == 2*M, f"M={M}: 数値ランク = 2M")
    rep.truth(smin > 1e-6, f"M={M}: 最小特異値が 0 から十分離れている")
    # 対比: Z_1 を 2 回入れると必ずランクが落ちる（判定が有意味であることの確認）
    A2 = np.array(rows + [Zop(1,M).reshape(-1)])
    rep.truth(np.linalg.matrix_rank(A2, tol=1e-8) == 2*M, f"M={M}: 重複を足してもランクは増えない")
rep.finish()
