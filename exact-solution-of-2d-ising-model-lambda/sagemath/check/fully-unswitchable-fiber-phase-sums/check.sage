"""三分類ごとのファイバー位相和と選択和の関係を厳密検査する（帰納の設計のための観察）。

対象: claim_weighted_path_reversal_selection_orbit_sums,
      claim_fully_unswitchable_contacts_witness_doubled_edges。

一辺 L=2 の全ファイバー (D, E) と四つのスピン構造 (a, b) について、
ファイバー位相和を三分類（接触なし / 切り替え可能対あり / 全対切り替え不能）ごとの
部分和 S_Z, S_X, S_Y へ分け、選択和 U と比較する。確かめるのは次の三つである。

(1) S_Z + S_X + S_Y = U（既知のファイバー一致の三分類による分解）。
(2) 切り替え可能対を持つ部分の和 S_X が全ての組で零になるか。
(3) 全対切り替え不能な部分の和 S_Y が全ての組で零になるか
    （零なら D の縮約ではなく符号反転対合を探すべきであり、
      非零なら縮約帰納で S_Y を扱う必要がある）。

計算は ZZ と Q(zeta8) の等号だけで行い、浮動小数点は使わない。
"""

load("sagemath/check/path-reversal-selection-complement-orbits/check.sage")


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
x_nonzero = 0
y_nonzero = 0
z_mismatch = 0
first_y_nonzero = None
first_z_mismatch = None
for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = {
        selected for selected in selection_subsets
        if selected.issubset(single)
        and is_even_selection_subset(doubled.union(selected))
    }
    for a in (0, 1):
        for b in (0, 1):
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

            # (1) 三分類による分解は既知のファイバー一致と整合する。
            total = (class_sums["contact-free"] + class_sums["has-switchable"]
                     + class_sums["all-unswitchable"])
            assert total == selection_sum

            # (2) 切り替え可能対を持つ部分の和。
            if class_sums["has-switchable"] != K8(0):
                x_nonzero += 1

            # (3) 全対切り替え不能な部分の和。
            if class_sums["all-unswitchable"] != K8(0):
                y_nonzero += 1
                if first_y_nonzero is None:
                    first_y_nonzero = (doubled, single, a, b,
                                       class_sums["all-unswitchable"])

            # 参考: 接触なし部分の和が選択和と一致するか。
            if class_sums["contact-free"] != selection_sum:
                z_mismatch += 1
                if first_z_mismatch is None:
                    first_z_mismatch = (doubled, single, a, b,
                                        class_sums["contact-free"], selection_sum)
            checked += 1

assert checked == 4 * len(all_fibers)
print("PASS: L=%d の全ファイバー×スピン構造 %d 組で三分類の部分和の分解を検査。"
      "S_X 非零 %d 組、S_Y 非零 %d 組、S_Z と選択和の不一致 %d 組"
      % (L, checked, x_nonzero, y_nonzero, z_mismatch))
if first_y_nonzero is not None:
    print("S_Y 非零の最初の例:", first_y_nonzero)
if first_z_mismatch is not None:
    print("S_Z != U の最初の例:", first_z_mismatch)
