"""経路反転の不動点が単純通過辺を持たないことを厳密検査する。

対象: claim_path_reversal_fixed_point_no_single_traversal。

一辺 L=2 の全非後退置換について、経路反転の不動点では単純通過の辺集合が
空であることを検査する。さらに単純通過辺集合が非空な全ファイバーと
四つのスピン構造・両符号について、経路反転が不動点を持たず、
符号別軌道の元の個数が全て二であることを検査する。
浮動小数点は使わない。
"""

load("sagemath/check/path-reversal-selection-complement-orbits/check.sage")

fixed_point_count = 0
fixed_point_checks = 0
for phi in nonbacktracking_permutations:
    fixed_point_checks += 1
    if path_reversal(phi) == phi:
        fixed_point_count += 1
        doubled, single = doubled_and_single_sets(phi)
        assert not single, "不動点に単純通過辺がある"

orbit_checks = 0
nonempty_single_fibers = 0
for (doubled, single), fiber in all_fibers.items():
    if not single:
        continue
    nonempty_single_fibers += 1
    for phi in fiber:
        assert path_reversal(phi) != phi, "E が非空のファイバーに不動点がある"
    for a in (0, 1):
        for b in (0, 1):
            for sign in (K8(1), K8(-1)):
                signed_permutations = {
                    permutation_key(phi): phi for phi in fiber
                    if phase_contribution(phi, a, b) == sign
                }
                orbits = involution_orbits(
                    signed_permutations,
                    lambda key: permutation_key(
                        path_reversal(signed_permutations[key])),
                )
                for orbit in orbits:
                    assert len(orbit) == 2, "E が非空なのに一元軌道がある"
                    orbit_checks += 1

assert fixed_point_checks == len(nonbacktracking_permutations)
assert nonempty_single_fibers > 0
assert orbit_checks > 0
print("PASS: L=%d 非後退置換 %d 個の不動点 %d 個は全て単純通過辺なし、"
      "E 非空 %d ファイバーの符号別軌道 %d 個は全て二元"
      % (L, fixed_point_checks, fixed_point_count,
         nonempty_single_fibers, orbit_checks))
