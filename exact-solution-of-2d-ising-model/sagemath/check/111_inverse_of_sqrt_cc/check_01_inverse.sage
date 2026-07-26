# <inverse_of_sqrt_cc> と <sqrt_cc_of_inverse>: sqrt(1/z) と 1/sqrt(z) の関係
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(212))
rep = CheckReport("inverse_of_sqrt_cc / sqrt_cc_of_inverse")
zs = [z for z in sample_complex(rng) if abs(z) > 1e-8]
c0 = cp = 0
for z in zs:
    a = arg_def(z)
    lhs = sqrt_def(1/z)
    rhs = 1/sqrt_def(z)
    # arg z = 0 かどうかで分岐が変わるが、arg が 0 の「すぐ上」（例 2e-15）だと
    # 1/z の arg が 2pi の「すぐ下」になり、倍精度ではどちらの分岐か定まらない。
    # 境界は分離して「± のいずれかに一致する」ことだけを見る。
    if a == 0.0:
        # arg z = 0 ちょうど（正の実数）。第1の場合。
        c0 += 1
        rep.close(lhs, rhs, f"z={z} arg=0: sqrt(1/z) = 1/sqrt z")
        rep.close(1/sqrt_def(z), rhs, f"z={z}: (sqrt z)^{{-1}} = 1/sqrt z")
        continue
    if a < 1e-9 or a > 2*math.pi - 1e-9:
        # arg が 0 の「すぐ上」/「2pi のすぐ下」。1/z の arg が反対側の境界に来るため
        # 倍精度ではどちらの分岐か定まらない。± のいずれかに一致することだけを見る。
        ok = (abs(lhs - rhs) < 1e-8*max(1.0,abs(rhs))) or (abs(lhs + rhs) < 1e-8*max(1.0,abs(rhs)))
        rep.truth(ok, f"境界 z={z} arg={a:.3e}: ± のいずれかに一致")
        rep.close(1/sqrt_def(z), rhs, f"z={z}: (sqrt z)^{{-1}} = 1/sqrt z")
        continue
    else:
        cp += 1
        rep.close(lhs, -rhs, f"z={z} 0<arg<2pi: sqrt(1/z) = -1/sqrt z")
    # <sqrt_cc_of_inverse> は同じ内容を (sqrt z)^{-1} の側から述べたもの
    rep.close(1/sqrt_def(z), rhs, f"z={z}: (sqrt z)^{{-1}} = 1/sqrt z")
print(f"  arg=0 の場合 {c0} 件、0<arg<2pi の場合 {cp} 件")
rep.truth(c0 > 0 and cp > 0, "両方の場合を踏んでいる")
rep.finish()
