# 対象ラベル: theorem_cyclic_stage_uniform_marginals_consistent
# 式ペア・判定: 小窓配位を延長する全大窓配位を列挙し、大窓周辺確率の有限和が小窓周辺確率に一致する。
# 帰属: 有限集合、ZZ、QQ。有理数内の正の分母による除算だけを使い、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

consistency_cases = ZZ(0)
extensions_checked = ZZ(0)
for stage in range(6):
    marginal_tables = {radius: marginal_table(stage, radius) for radius in range(stage + 1)}
    for larger_radius in range(stage + 1):
        larger_window = window(larger_radius)
        larger_observations = configurations(larger_window)
        for smaller_radius in range(larger_radius + 1):
            smaller_window = window(smaller_radius)
            centered_start = larger_radius - smaller_radius
            centered_end = centered_start + len(smaller_window)
            for observation in configurations(smaller_window):
                extensions = tuple(
                    candidate for candidate in larger_observations
                    if candidate[centered_start:centered_end] == observation
                )
                expected_extension_count = ZZ(2) ** ZZ(2 * (larger_radius - smaller_radius))
                assert len(extensions) == expected_extension_count
                direct = marginal_tables[smaller_radius][observation]
                remarginalized = sum(
                    (marginal_tables[larger_radius][extension] for extension in extensions),
                    QQ(0),
                )
                assert remarginalized == direct
                assert direct == QQ(1) / (ZZ(2) ** ZZ(2 * smaller_radius + 1))
                consistency_cases += 1
                extensions_checked += len(extensions)

assert consistency_cases == ZZ(4834)
assert extensions_checked == ZZ(19420)
print('remarginalization identities checked:', consistency_cases)
print('larger-window extensions summed:', extensions_checked)
print('RESULT: PASS')
