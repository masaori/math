"""横断のない閉歩道の接触点分割における自己横断と回転位相を検算する。"""
load("sagemath/check/edge-simple-contact-split/check.sage")


def crossing_count(walk):
    m = len(walk)
    return sum(ZZ(tgt(walk[k]) == tgt(walk[l])
                  and direction_number(walk[(k+1) % m]) == direction_number(walk[k])
                  and direction_number(walk[(l+1) % m]) == direction_number(walk[l])
                  and direction_number(walk[k]) % 2 != direction_number(walk[l]) % 2)
               for k in range(m) for l in range(k+1, m))


def mixed_crossing_count(first, second):
    return sum(ZZ(tgt(first[k]) == tgt(second[l])
                  and direction_number(first[(k+1) % len(first)]) == direction_number(first[k])
                  and direction_number(second[(l+1) % len(second)]) == direction_number(second[l])
                  and direction_number(first[k]) % 2 != direction_number(second[l]) % 2)
               for k in range(len(first)) for l in range(len(second)))


def intersection(first, second):
    def H(walk, i, j):
        return ZZ(any(base_edge(e) == ("h", i % L, j % L) for e in walk))
    def V(walk, i, j):
        return ZZ(any(base_edge(e) == ("v", i % L, j % L) for e in walk))
    return sum(H(first, i, j)*V(second, i-1, j+1)
               + V(first, i, j)*H(second, i, j)
               for i in range(L) for j in range(L)) % 2


zeta = CyclotomicField(8).gen()
expected_local_cases = {
    (0, 1, 1, 0): (0, 1),
    (0, 2, 1, 3): (-4, 0),
    (0, 2, 3, 1): (4, 0),
    (0, 3, 3, 0): (0, 1),
}


def local_turn(incoming, outgoing):
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[(outgoing-incoming) % 4]


actual_local_cases = {}
for dl in (1, 2, 3):
    for fk in range(4):
        for fl in range(4):
            directions = (0, dl, fk, fl)
            if len({2, (dl+2) % 4, fk, fl}) != 4:
                continue
            if any((outgoing-incoming) % 4 == 2
                   for incoming, outgoing in ((0, fk), (dl, fl), (0, fl), (dl, fk))):
                continue
            if fk == 0 and fl == dl:
                continue
            shift = local_turn(0, fl) + local_turn(dl, fk) - local_turn(0, fk) - local_turn(dl, fl)
            mixed = ZZ(fl == 0 and fk == dl)
            actual_local_cases[directions] = (shift, mixed)
assert actual_local_cases == expected_local_cases

checked = 0
for walk in edge_simple_walks:
    if crossing_count(walk) != 0:
        continue
    for k in range(len(walk)):
        for l in range(k+1, len(walk)):
            if tgt(walk[k]) != tgt(walk[l]):
                continue
            first = walk[k+1:l+1]
            second = walk[l+1:] + walk[:k+1]
            assert crossing_count(first) == crossing_count(second) == 0
            shift = total_turning(first) + total_turning(second) - total_turning(walk)
            mixed = mixed_crossing_count(first, second)
            assert mixed in (0, 1)
            assert mixed % 2 == intersection(first, second)
            assert shift in (-4, 0, 4)
            assert (shift // 4 - (1 + mixed)) % 2 == 0
            assert zeta**total_turning(walk) == (-1)**(1 + intersection(first, second)) * zeta**(total_turning(first) + total_turning(second))
            checked += 1

assert checked > 0
print("PASS: crossing-free contact splits", checked)
