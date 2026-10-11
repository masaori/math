# 定義と結論を独立な無向到達集合で検算する。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

points = 0
pairs = 0
for sigma, tau, i in fpoi_points():
    support = fpoi_reachable(sigma, i)
    assert fpoi_supports[(sigma, i)] == support
    assert i in support
    points += 1
    for j in range(len(sigma)):
        assert (sigma[j] in support) == (j in support)
        pairs += 1
assert points == 5039 and pairs == 29367
assert fpoi_permutations[0] == ()
print("definition: 874 permutations,", points, "base points,", pairs, "membership equivalences; PASS")
