"""ファイバー位相和の三つの整数の符号付き数え上げへの分解を厳密検査する。

対象: claim_fiber_phase_integer_decomposition。

一辺 L=2 の全ファイバーと四つのスピン構造について、位相反転部分を除いた位相和が、
接触の無い部分、回転差 4 の部分の二倍、残余の三つの正負符号の個数差に等しいことを
Q(zeta8) と ZZ の厳密演算で検査する。浮動小数点は使わない。
"""

load("sagemath/check/kac-ward-fiber-phase-part-decomposition/check.sage")

checked = 0
for (doubled, single), fiber in all_fibers.items():
    parts = {"contact_free": [], "phase_reversing": [], -4: [], 4: [], "remainder": []}
    for phi in fiber:
        pairs = contact_pairs(phi)
        if not pairs:
            parts["contact_free"].append(phi)
        else:
            pair = tuple(ct_min(phi))
            if not is_switchable_contact_pair(phi, pair[0], pair[1]):
                parts["remainder"].append(phi)
            elif in_B(phi):
                parts["phase_reversing"].append(phi)
            else:
                delta = standard_delta(phi)
                assert delta in (-4, 4)
                parts[delta].append(phi)

    for a in (0, 1):
        for b in (0, 1):
            signed_differences = {}
            for name in ("contact_free", 4, "remainder"):
                positive = ZZ(0)
                negative = ZZ(0)
                for phi in parts[name]:
                    value = contributions[permutation_key(phi)][(a, b)]
                    assert value in (K8(1), K8(-1))
                    if value == K8(1):
                        positive += 1
                    else:
                        negative += 1
                signed_differences[name] = positive - negative

            total = phase_part_sum(fiber, a, b)
            integer_decomposition = (
                signed_differences["contact_free"]
                + 2 * signed_differences[4]
                + signed_differences["remainder"]
            )
            assert total == K8(integer_decomposition)
            assert integer_decomposition in ZZ
            checked += 1

assert checked == 4 * len(all_fibers)
print("PASS: L=%d の全 %d ファイバー×四スピン構造 %d 組で、"
      "ファイバー位相和の三つの整数の符号付き数え上げへの分解を検査"
      % (L, len(all_fibers), checked))
