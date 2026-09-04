"""反転対を持つファイバーでも位相反転部分集合が相殺することを厳密検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/non-phase-reversing-standard-smoothing-involution/construction.sage")

fibers = {}
for phi in nonbacktracking_permutations:
    doubled, single = doubled_and_single_sets(phi)
    if not doubled:
        continue
    key = (frozenset(doubled), frozenset(single))
    fibers.setdefault(key, []).append(phi)

classified = 0
cancelled = 0
equalities = 0
remainder_total = 0
for key, fiber in fibers.items():
    parts = {"contact_free": [], "phase_reversing": [], -4: [], 4: [], "remainder": []}
    for phi in fiber:
        if not contact_pairs(phi):
            parts["contact_free"].append(phi)
        else:
            pair = tuple(ct_min(phi))
            if not is_switchable_contact_pair(phi, pair[0], pair[1]):
                parts["remainder"].append(phi)
            elif in_B(phi):
                parts["phase_reversing"].append(phi)
            else:
                delta = standard_delta(phi)
                parts[delta].append(phi)
        classified += 1

    remainder_total += len(parts["remainder"])

    for a in (0, 1):
        for b in (0, 1):
            def phase_sum(part):
                return sum((contributions[permutation_key(phi)][(a, b)] for phi in part), K8(0))

            total = phase_sum(fiber)
            cancelling = phase_sum(parts["phase_reversing"])
            remaining = (
                phase_sum(parts["contact_free"])
                + phase_sum(parts[-4])
                + phase_sum(parts[4])
                + phase_sum(parts["remainder"])
            )
            cancelled += len(parts["phase_reversing"])
            equalities += 1
