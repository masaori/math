"""横断のない閉歩道の接触点分割による位相の帰納法を厳密検算する。"""
load("sagemath/check/crossing-free-contact-split-phase/check.sage")


def seam_parity(walk):
    return (sum(horizontal_seam(edge) for edge in walk) % 2,
            sum(vertical_seam(edge) for edge in walk) % 2)


def eliminate_contacts(walk):
    assert crossing_count(walk) == 0
    parent_count = contact_pair_count(walk)
    for k in range(len(walk)):
        for l in range(k + 1, len(walk)):
            if tgt(walk[k]) != tgt(walk[l]):
                continue
            first = walk[k + 1:l + 1]
            second = walk[l + 1:] + walk[:k + 1]
            assert is_closed_nonbacktracking(first)
            assert is_closed_nonbacktracking(second)
            assert crossing_count(first) == crossing_count(second) == 0
            assert contact_pair_count(first) + contact_pair_count(second) < parent_count
            family_a = eliminate_contacts(first)
            family_b = eliminate_contacts(second)
            family = family_a + family_b
            supports = [set(base_edge(edge) for edge in member) for member in family]
            assert all(supports[i].isdisjoint(supports[j])
                       for i in range(len(family)) for j in range(i + 1, len(family)))
            assert set.union(*supports) == set(base_edge(edge) for edge in walk)
            assert seam_parity(walk) == tuple(
                sum(seam_parity(member)[coordinate] for member in family) % 2
                for coordinate in range(2))

            zeta = CyclotomicField(8).gen()
            local_sign = (-1) ** (1 + intersection(first, second))
            assert zeta ** total_turning(walk) == local_sign * zeta ** (
                total_turning(first) + total_turning(second))
            cross_sum = sum(intersection(alpha, beta)
                            for alpha in family_a for beta in family_b) % 2
            assert cross_sum == intersection(first, second)
            parity = ZZ(len(family) - 1) + sum(
                intersection(family[i], family[j])
                for i in range(len(family)) for j in range(i + 1, len(family)))
            assert zeta ** total_turning(walk) == (-1) ** parity * prod(
                zeta ** total_turning(member) for member in family)
            return family
    assert parent_count == 0
    return [walk]


checked = 0
for walk in edge_simple_walks:
    if crossing_count(walk) != 0:
        continue
    family = eliminate_contacts(walk)
    assert all(contact_pair_count(member) == 0 and crossing_count(member) == 0
               for member in family)
    checked += 1

assert checked > 0
print("PASS: crossing-free contact elimination", checked)
