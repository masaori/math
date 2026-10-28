"""辺の重複がない閉歩道の位相と二次符号を円分体で厳密検算する。"""
load("sagemath/check/crossing-free-contact-elimination-phase/check.sage")


def seam(walk):
    return (sum(horizontal_seam(edge) for edge in walk) % 2,
            sum(vertical_seam(edge) for edge in walk) % 2)


def quadratic_sign(a, b, walk):
    h, v = seam(walk)
    return (-1) ** (h*v + (1-a)*h + (1-b)*v)


def twist_product(a, b, walk):
    return prod((-1)**(a*horizontal_seam(edge)+b*vertical_seam(edge))
                for edge in walk)


def edge_distinct_crossing_elimination(walk):
    m = len(walk)
    for k in range(m):
        for l in range(k+1, m):
            if (tgt(walk[k]) != tgt(walk[l])
                    or direction_number(walk[(k+1) % m]) != direction_number(walk[k])
                    or direction_number(walk[(l+1) % m]) != direction_number(walk[l])
                    or direction_number(walk[k]) % 2 == direction_number(walk[l]) % 2):
                continue
            first = walk[k+1:l+1]
            second = walk[l+1:] + walk[:k+1]
            assert is_closed_nonbacktracking(first) and is_closed_nonbacktracking(second)
            assert crossing_count(first) + crossing_count(second) < crossing_count(walk)
            return edge_distinct_crossing_elimination(first) + edge_distinct_crossing_elimination(second)
    assert crossing_count(walk) == 0
    return [walk]


checked = 0
crossing_cases = 0
contact_cases = 0
for walk in edge_simple_walks:
    crossing_free_family = edge_distinct_crossing_elimination(walk)
    supports = [set(base_edge(edge) for edge in member) for member in crossing_free_family]
    assert set().union(*supports) == set(base_edge(edge) for edge in walk)
    assert all(supports[i].isdisjoint(supports[j])
               for i in range(len(supports)) for j in range(i+1, len(supports)))
    assert total_turning(walk) == sum(total_turning(member) for member in crossing_free_family)
    assert seam(walk) == tuple(sum(seam(member)[coordinate] for member in crossing_free_family) % 2
                               for coordinate in range(2))
    crossing_intersection = sum(intersection(crossing_free_family[i], crossing_free_family[j])
                                for i in range(len(crossing_free_family))
                                for j in range(i+1, len(crossing_free_family)))
    assert (crossing_count(walk) - len(crossing_free_family) + 1 - crossing_intersection) % 2 == 0
    for member in crossing_free_family:
        simple_family = eliminate_contacts(member)
        assert seam(member) == tuple(sum(seam(child)[coordinate] for child in simple_family) % 2
                                     for coordinate in range(2))
        contact_intersection = sum(intersection(simple_family[i], simple_family[j])
                                   for i in range(len(simple_family)) for j in range(i+1, len(simple_family)))
        for a in (0, 1):
            for b in (0, 1):
                child_factors = prod(quadratic_sign(a, b, child) for child in simple_family)
                assert all(-(-1)**(a*seam(child)[0]+b*seam(child)[1])
                           * zeta**total_turning(child) == quadratic_sign(a, b, child)
                           for child in simple_family)
                lhs_member = -(-1)**(a*seam(member)[0]+b*seam(member)[1]) * zeta**total_turning(member)
                split_factors = prod(-(-1)**(a*seam(child)[0]+b*seam(child)[1])
                                     * zeta**total_turning(child) for child in simple_family)
                assert lhs_member == (-1)**contact_intersection * split_factors
                assert (-1)**contact_intersection * child_factors == quadratic_sign(a, b, member)
        if len(simple_family) > 1:
            contact_cases += 1
    for a in (0, 1):
        for b in (0, 1):
            family_product = prod(quadratic_sign(a, b, member) for member in crossing_free_family)
            assert (-1)**crossing_intersection * family_product == quadratic_sign(a, b, walk)
            lhs = -twist_product(a, b, walk) * zeta**total_turning(walk)
            assert lhs == -(-1)**(a*seam(walk)[0]+b*seam(walk)[1]) * zeta**total_turning(walk)
            split_factors = prod(-(-1)**(a*seam(member)[0]+b*seam(member)[1])
                                 * zeta**total_turning(member) for member in crossing_free_family)
            assert lhs == (-1)**(len(crossing_free_family)-1) * split_factors
            assert lhs == (-1)**crossing_count(walk) * quadratic_sign(a, b, walk)
    if crossing_count(walk) > 0:
        crossing_cases += 1
    checked += 1

assert checked > 0 and crossing_cases > 0 and contact_cases > 0
print("PASS: edge-distinct walk quadratic sign", checked, crossing_cases, contact_cases)
