# 対象ラベル: sinh_strictly_increasing
# 主張そのものを、格子点 x = k/4（k = -40,…,40）で隣どうしの sinh のボールが狭義に増えることで確かめる。
# 対照として cosh は負の側で減るので、同じ検査が落ちることを確かめる。
load("../../_shared/hyperbolic_by_definition.sage")
grid = [QQ(k) / 4 for k in range(-40, 41)]
vals = [sinh_ball(t) for t in grid]
assert all(vals[i] < vals[i + 1] for i in range(len(vals) - 1))
cvals = [cosh_ball(t) for t in grid]
assert not all(cvals[i] < cvals[i + 1] for i in range(len(cvals) - 1))
print(f"{len(grid)} 個の格子点で sinh のボールが狭義に増え、cosh では増えない（対照）")
print("RESULT: PASS")
