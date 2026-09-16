"""端点局所記述を固定長のビット列へ展開する厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-local-projection/construction.sage")


def flatten_endpoint_bits(value):
    """端点局所記述の入れ子を順序を保ったままビット列へ展開する。"""
    if value in (0, 1):
        return (ZZ(value),)
    assert isinstance(value, tuple)
    return sum((flatten_endpoint_bits(entry) for entry in value), ())


def candidate_endpoint_bits(orbit_key, selector):
    return flatten_endpoint_bits(
        candidate_local_boundary_descriptor(orbit_key, selector))


def endpoint_pair_bits(orbit_key):
    """二端点の全所属ビットと切断旗を端点順に並べる。"""
    _, _, endpoints = orbit_key
    bits = []
    for memberships, wrap_flags in endpoints:
        bits.extend(bit for _, in_doubled, in_single, in_chosen in memberships
                    for bit in (in_doubled, in_single, in_chosen))
        bits.extend(wrap_flags)
    assert all(bit in (0, 1) for bit in bits)
    return tuple(map(ZZ, bits))
