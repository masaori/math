"""文字によるファイバーの三種別ごとに三分類の部分和が個別に消えるかを検査する（文字和構成のための観察）。

対象: claim_selection_sum_character_evaluation,
      claim_fully_unswitchable_contacts_witness_doubled_edges。

一辺 L=2 の全ファイバー (D, E) と四つのスピン構造 (a, b) について、
選択和の文字評価が与える三種別（選択集合が空 / 文字が非自明 / 文字が自明）ごとに、
ファイバー位相和の三分類の部分和 S_Z（接触なし）, S_X（切り替え可能対あり）,
S_Y（全対切り替え不能）が個別に消えるかを数える。確かめるのは次である。

(1) S_Z + S_X + S_Y = U（既知のファイバー一致。全組で assert する）。
(2) 選択集合が空の組で、S_Z, S_X, S_Y が個別に零になるか。
(3) 文字が非自明な組（U = 0）で、S_Z, S_X, S_Y が個別に零になるか。
(4) 文字が自明な組で、S_Z が単独で U に一致するか。

個別に零なら三分類の各部分ごとに文字と両立する符号反転構造を探せばよく、
零でないなら文字和は三分類を混ぜた全体にしか構成できない。

計算は ZZ と Q(zeta8) の等号だけで行い、浮動小数点は使わない。
"""

load("sagemath/check/path-reversal-selection-complement-orbits/check.sage")


def winding_pairing(first, second):
    first_h, first_v = selection_winding_parities(first)
    second_h, second_v = selection_winding_parities(second)
    return ZZ((first_h * second_v + first_v * second_h) % 2)


def switchable_pairs(phi):
    return {
        pair for pair in contact_pairs(phi)
        if is_switchable_contact_pair(phi, *tuple(pair))
    }


def invariant_class(phi):
    if not contact_pairs(phi):
        return "contact-free"
    if switchable_pairs(phi):
        return "has-switchable"
    return "all-unswitchable"


checked = 0
kind_counts = {"empty": 0, "nontrivial": 0, "trivial": 0}
part_nonzero = {
    (kind, part): 0
    for kind in ("empty", "nontrivial", "trivial")
    for part in ("contact-free", "has-switchable", "all-unswitchable")
}
first_witness = {}
trivial_z_mismatch = 0
for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = {
        selected for selected in selection_subsets
        if selected.issubset(single)
        and is_even_selection_subset(doubled.union(selected))
    }
    translations = {
        subset for subset in selection_subsets
        if subset.issubset(single)
        and is_even_selection_subset(subset)
    }
    if not selectors:
        kind = "empty"
    elif any(winding_pairing(single, translation) == 1
             for translation in translations):
        kind = "nontrivial"
    else:
        kind = "trivial"
    for a in (0, 1):
        for b in (0, 1):
            kind_counts[kind] += 1
            class_sums = {
                "contact-free": K8(0),
                "has-switchable": K8(0),
                "all-unswitchable": K8(0),
            }
            for phi in fiber:
                class_sums[invariant_class(phi)] += phase_contribution(phi, a, b)
            selection_sum = sum(
                (K8(ZZ(-1) ** selection_exponent(a, b, doubled, single, selected))
                 for selected in selectors),
                K8(0),
            )

            # (1) 既知のファイバー一致。
            total = (class_sums["contact-free"] + class_sums["has-switchable"]
                     + class_sums["all-unswitchable"])
            assert total == selection_sum

            # 文字が非自明なら選択和は零である（文字評価の再確認）。
            if kind in ("empty", "nontrivial"):
                assert selection_sum == K8(0)

            # (2)(3)(4) 部分和の個別の消滅。
            for part in ("contact-free", "has-switchable", "all-unswitchable"):
                if class_sums[part] != K8(0):
                    part_nonzero[(kind, part)] += 1
                    if (kind, part) not in first_witness:
                        first_witness[(kind, part)] = (
                            doubled, single, a, b, class_sums[part])
            if kind == "trivial" and class_sums["contact-free"] != selection_sum:
                trivial_z_mismatch += 1
            checked += 1

assert checked == 4 * len(all_fibers)
print(f"PASS: fiber-phase-character-vanishing (pairs={checked})")
print(f"kind counts: {kind_counts}")
for key in sorted(part_nonzero):
    print(f"nonzero {key}: {part_nonzero[key]}")
print(f"trivial-character pairs with S_Z != U: {trivial_z_mismatch}")
for key in sorted(first_witness):
    doubled, single, a, b, value = first_witness[key]
    print(f"first witness {key}: D={sorted(doubled)}, E={sorted(single)}, "
          f"(a,b)=({a},{b}), value={value}")
