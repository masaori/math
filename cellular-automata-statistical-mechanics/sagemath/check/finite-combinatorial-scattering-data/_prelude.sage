from itertools import product

BOTTOM = None
B = (ZZ(0), ZZ(1))
C = (ZZ(0), ZZ(1))
I = (ZZ(0), ZZ(1))

E = {
    ZZ(0): {
        (ZZ(0), ZZ(0)): (ZZ(1), ZZ(0)),
        (ZZ(0), ZZ(1)): (ZZ(1), ZZ(1)),
        (ZZ(1), ZZ(0)): (ZZ(1), ZZ(1)),
    },
    ZZ(1): {(ZZ(0), ZZ(0)): (ZZ(1), ZZ(1))},
}

SIDE = {
    ZZ(0): {
        (ZZ(0), ZZ(0)): 'L',
        (ZZ(0), ZZ(1)): 'L',
        (ZZ(1), ZZ(0)): 'R',
    },
    ZZ(1): {(ZZ(0), ZZ(0)): 'L'},
}

H = {
    (ZZ(0), ZZ(0)): ZZ(0),
    (ZZ(0), ZZ(1)): ZZ(-1),
    (ZZ(1), ZZ(0)): ZZ(1),
    (ZZ(1), ZZ(1)): ZZ(0),
}

def internal_r(pair):
    return pair

def apply_partial(index, pair):
    return E[index].get(pair, BOTTOM)

def extend_r(value):
    return BOTTOM if value is BOTTOM else internal_r(value)

def expected_energy_difference(index, pair):
    if index != 0:
        return ZZ(0)
    before = SIDE[index][pair]
    after = SIDE[index][internal_r(pair)]
    if before == 'L' and after == 'L':
        return ZZ(1)
    if before == 'R' and after == 'R':
        return ZZ(-1)
    return ZZ(0)

def swap_affine(pair_left, pair_right, energy):
    degree_left, state_left = pair_left
    degree_right, state_right = pair_right
    return ((degree_right + energy, state_right), (degree_left - energy, state_left))
