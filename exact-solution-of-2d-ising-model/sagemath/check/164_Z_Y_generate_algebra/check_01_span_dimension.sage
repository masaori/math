# <Z_Y_generate_algebra>: Z,Y の生成する部分多元環が Mat(2,C)^{otimes M} 全体
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("Z_Y_generate_algebra: 語で張る空間の次元が 4^M に達するか")

def span_dim(vecs, tol=1e-8):
    A = np.array([v.reshape(-1) for v in vecs])
    return int(np.linalg.matrix_rank(A, tol=tol))

for M in [2,3]:
    gens = [Zop(m,M) for m in range(1,M+1)] + [Yop(m,M) for m in range(1,M+1)]
    words = [eye_M(M)]
    seen = list(words)
    target = 4**M
    for depth in range(1, 2*M+2):
        new = []
        for w in words:
            for g in gens:
                new.append(w @ g)
        words = new
        seen.extend(new)
        d = span_dim(seen)
        print(f"  M={M} depth={depth}: 語の総数={len(seen)}, 張る空間の次元={d} / {target}")
        if d == target:
            break
    rep.truth(d == target, f"M={M}: 生成される部分多元環の次元 = 4^M = {target}")
    # 対比: Z だけでは全体を生成しない（生成集合の必要性）
    seenZ = [eye_M(M)]
    ws = [eye_M(M)]
    for depth in range(1, M+2):
        ws = [w @ Zop(m,M) for w in ws for m in range(1,M+1)]
        seenZ.extend(ws)
    dz = span_dim(seenZ)
    print(f"  M={M}: Z のみで張る次元={dz} (< {target} のはず)")
    rep.truth(dz < target, f"M={M}: Z のみでは全体を生成しない")
rep.finish()
