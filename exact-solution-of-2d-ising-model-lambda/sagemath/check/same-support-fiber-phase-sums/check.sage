"""台（D ∪ E）を固定して集約した三分類の部分和と選択和の関係を厳密検査する。

対象: claim_fully_unswitchable_contacts_witness_doubled_edges,
      claim_weighted_path_reversal_selection_orbit_sums。

選択和の側は偶部分グラフ対 (P, Q) の P ∩ Q = D, P △ Q = E による分類であり、
和集合 P ∪ Q = D ∪ E はファイバーをまたいで共有される。そこで一辺 L=2 の全ファイバーを
台 F = D ∪ E で束ね、各台と四つのスピン構造について次を確かめる。

(1) 台の分解 F = D ⊔ E（E は偶）のうち、置換が一つも無い分解の選択和 U が零になるか
    （零でない分解があれば、ファイバー単位の一致 K = U は空のファイバーで破れる）。
(2) 三分類の部分和 S_Z, S_X, S_Y を同じ台の全ファイバーで合計したとき、
    切り替え可能部分の集約 ΣS_X が零になるか。
(3) 全対切り替え不能な残余の集約 ΣS_Y が零になるか
    （零なら、ファイバーは保たず台だけを保つ符号反転対合で残余を消せる可能性が残り、
      零でないなら台固定の集約も相殺の単位にならない）。

計算は ZZ と Q(zeta8) の等号だけで行い、浮動小数点は使わない。
"""

load("sagemath/check/fully-unswitchable-fiber-phase-sums/check.sage")

support_groups = {}
for (doubled, single), fiber in all_fibers.items():
    support = frozenset(doubled.union(single))
    support_groups.setdefault(support, []).append((doubled, single, fiber))


def selection_sum(a, b, doubled, single):
    return sum(
        (K8(ZZ(-1) ** selection_exponent(a, b, doubled, single, selected))
         for selected in selection_subsets
         if selected.issubset(single)
         and is_even_selection_subset(doubled.union(selected))),
        K8(0),
    )


support_checks = 0
empty_decompositions = 0
empty_nonzero_selection = 0
x_aggregate_nonzero = 0
y_aggregate_nonzero = 0
z_aggregate_mismatch = 0
first_empty_nonzero = None
first_y_aggregate_nonzero = None
for support, members in sorted(support_groups.items()):
    realized = {(doubled, single) for doubled, single, fiber in members}
    decompositions = [
        (frozenset(part), frozenset(support.difference(part)))
        for part in Subsets(set(support))
        if is_even_selection_subset(support.difference(part))
    ]
    assert realized.issubset(set(decompositions))

    for a in (0, 1):
        for b in (0, 1):
            # (1) 置換の無い分解の選択和。
            for doubled, single in decompositions:
                if (doubled, single) in realized:
                    continue
                empty_decompositions += 1
                value = selection_sum(a, b, doubled, single)
                if value != K8(0):
                    empty_nonzero_selection += 1
                    if first_empty_nonzero is None:
                        first_empty_nonzero = (doubled, single, a, b, value)

            aggregate = {
                "contact-free": K8(0),
                "has-switchable": K8(0),
                "all-unswitchable": K8(0),
            }
            selection_total = K8(0)
            for doubled, single, fiber in members:
                for phi in fiber:
                    aggregate[invariant_class(phi)] += phase_contribution(phi, a, b)
                selection_total += selection_sum(a, b, doubled, single)

            # 各ファイバーの一致 K = U を台の上で合計した恒等式。
            total = (aggregate["contact-free"] + aggregate["has-switchable"]
                     + aggregate["all-unswitchable"])
            assert total == selection_total

            # (2) 切り替え可能部分の集約。
            if aggregate["has-switchable"] != K8(0):
                x_aggregate_nonzero += 1

            # (3) 全対切り替え不能な残余の集約。
            if aggregate["all-unswitchable"] != K8(0):
                y_aggregate_nonzero += 1
                if first_y_aggregate_nonzero is None:
                    first_y_aggregate_nonzero = (support, a, b,
                                                 aggregate["all-unswitchable"])

            # 参考: 接触なし部分の集約が選択和の集約と一致するか。
            if aggregate["contact-free"] != selection_total:
                z_aggregate_mismatch += 1

            support_checks += 1

assert support_checks == 4 * len(support_groups)
assert len(support_groups) == 104
assert empty_decompositions == 0
assert empty_nonzero_selection == 0
assert x_aggregate_nonzero == 132
assert y_aggregate_nonzero == 248
assert z_aggregate_mismatch == 380
print("PASS: L=%d の台 %d 個×四スピン構造 %d 組で、台固定の集約を検査" % (L, len(support_groups), support_checks))
print("置換の無い分解: %d 組、うち選択和が非零: %d" % (empty_decompositions, empty_nonzero_selection))
if first_empty_nonzero is not None:
    print("置換の無い分解で選択和が非零の最初の例 (D, E, a, b, U):", first_empty_nonzero)
print("集約 ΣS_X が非零: %d 組、集約 ΣS_Y が非零: %d 組、集約 ΣS_Z と ΣU の不一致: %d 組"
      % (x_aggregate_nonzero, y_aggregate_nonzero, z_aggregate_mismatch))
if first_y_aggregate_nonzero is not None:
    print("集約 ΣS_Y が非零の最初の例 (台, a, b, ΣS_Y):", first_y_aggregate_nonzero)
