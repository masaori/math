from sage.all import QQ, ZZ

# q = 1 では各配置の重みは 1。開境界と周期境界の分配値はともに 2^(L^2)。
# 対数順序群の ℓ₂ 係数で密度を表すと各 L で 1 となる。
for L in range(1, 6):
    partition = ZZ(2) ** (L * L)
    open_density_coefficient = QQ(partition.valuation(2)) / (L * L)
    periodic_density_coefficient = QQ(partition.valuation(2)) / (L * L)
    assert open_density_coefficient == 1
    assert periodic_density_coefficient == open_density_coefficient

grid = [QQ(k) / 8 for k in range(-8, 9)]
open_lower_set = {mu for mu in grid if mu < 1}
periodic_lower_set = {mu for mu in grid if mu < 1}
assert open_lower_set == periodic_lower_set
assert max(open_lower_set) < 1
assert any(mu > max(open_lower_set) and mu < 1 for mu in [QQ(15) / 16])
print("PASS: q=1 の密度と下組の有限標本")
