# <def_pauli_group>, <def_clifford_group>: Pauli 群が積で閉じ、位数が 4*4^M
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import itertools
rep = CheckReport("def_pauli_group / def_clifford_group")
def pauli_group(M):
    out = []
    for k in range(4):
        for combo in itertools.product('0xyz', repeat=M):
            out.append((1j**k) * kron_list([PAULI[a] for a in combo]))
    return out
def in_group(X, mats, tol=1e-8):
    for Y in mats:
        if np.max(np.abs(X - Y)) < tol:
            return True
    return False
for M in [1,2,3]:
    mats = pauli_group(M)
    rep.truth(len(mats) == 4 * 4**M, f"M={M}: #P_M = 4*4^M = {4*4**M}")
    # 相異なる元であること（重複していないこと）
    if M <= 2:
        dup = 0
        for a in range(len(mats)):
            for b in range(a+1, len(mats)):
                if np.max(np.abs(mats[a]-mats[b])) < 1e-9:
                    dup += 1
        rep.truth(dup == 0, f"M={M}: 列挙に重複が無い")
    rng = np.random.default_rng(int(M))
    idx = [int(k) for k in rng.choice(len(mats), size=min(len(mats), 30), replace=False)]
    for a in idx:
        for b in idx[:8]:
            rep.truth(in_group(mats[a] @ mats[b], mats), f"M={M}: 積が P_M に属する")
    rep.truth(in_group(eye_M(M), mats), f"M={M}: 単位元を含む")
    for a in idx[:8]:
        rep.truth(in_group(np.linalg.inv(mats[a]), mats), f"M={M}: 逆元を含む")
rep.finish()
