# <condition_of_commutativity_of_sqrt_and_product>: sqrt(z1 z2) = ± sqrt z1 sqrt z2
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(210))
rep = CheckReport("condition_of_commutativity_of_sqrt_and_product")
zs = [z for z in sample_complex(rng) if abs(z) > 1e-12]
c1 = c2 = boundary = 0
for z1 in zs[:35]:
    for z2 in zs[:35]:
        a = arg_def(z1) + arg_def(z2)
        lhs = sqrt_def(z1*z2)
        rhs = sqrt_def(z1)*sqrt_def(z2)
        # 境界 arg1+arg2 = 2pi ちょうどは、倍精度でどちらの分岐に落ちるかが定まらない。
        # 主ループからは外し、下の専用ブロックで「± のいずれかに一致する」ことだけを見る。
        if abs(a - 2*math.pi) < 1e-9 or abs(a) < 1e-9 or abs(a - 4*math.pi) < 1e-9:
            boundary += 1
            continue
        if a < 2*math.pi - 1e-12:
            c1 += 1
            rep.close(lhs, rhs, f"arg 和={a:.6f} < 2pi: sqrt(z1z2) = sqrt z1 sqrt z2")
        else:
            c2 += 1
            rep.close(lhs, -rhs, f"arg 和={a:.6f} >= 2pi: sqrt(z1z2) = -sqrt z1 sqrt z2")
        if abs(a - 2*math.pi) < 1e-6:
            boundary += 1
# 境界 arg1+arg2 = 2pi ちょうどを明示的に踏む
for t in [0.3, 1.0, 2.0, 3.0]:
    z1 = complex(math.cos(t), math.sin(t))
    z2 = complex(math.cos(2*math.pi-t), math.sin(2*math.pi-t))
    a = arg_def(z1)+arg_def(z2)
    boundary += 1
    lhs, rhs = sqrt_def(z1*z2), sqrt_def(z1)*sqrt_def(z2)
    ok = (abs(lhs-rhs) < 1e-8) or (abs(lhs+rhs) < 1e-8)
    rep.truth(ok, f"境界 t={t}: arg 和={a:.12f} で ± のいずれかに一致")
    print(f"  境界 t={t}: arg1+arg2={a:.12f}, sqrt(z1z2)-sqrt z1 sqrt z2 = {abs(lhs-rhs):.3e}, 和 = {abs(lhs+rhs):.3e}")
print(f"  第1の場合 {c1} 件、第2の場合 {c2} 件、境界近傍 {boundary} 件")
rep.truth(c1 > 0 and c2 > 0, "両方の場合を踏んでいる")
rep.finish()
