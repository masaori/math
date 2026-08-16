import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../iterate-monoid-principal-ideal-tail/_prelude.sage'))


def generated_ideal(generator, monoid):
    """J_F(G) = {G composed with K | K in P_F}."""
    return frozenset(compose(generator, K) for K in monoid)


def finite_monoid_data(table):
    """Return the distinct powers representing P_F and their generated ideals."""
    powers, i, j = monoid_and_collision(table)
    monoid = tuple(powers[:j])
    assert len(set(monoid)) == j
    ideals = tuple(generated_ideal(G, monoid) for G in monoid)
    return powers, i, j, monoid, ideals
