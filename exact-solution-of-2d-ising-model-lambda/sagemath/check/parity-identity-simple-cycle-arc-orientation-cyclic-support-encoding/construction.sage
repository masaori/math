"""弧型を内部語の巡回軌道と切断位置で符号化する厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-boundary-arc-decomposition/construction.sage")


def rotate_word(word, shift):
    assert word
    shift %= len(word)
    return word[shift:] + word[:shift]


def arc_cyclic_orbit_key(arc_type):
    kind, steps, endpoints = arc_type
    assert kind == "arc"
    assert steps
    return ("arc", cyclic_reversal_invariant_word(steps), endpoints)


def arc_cyclic_orbit(arc_type):
    kind, steps, endpoints = arc_type
    assert kind == "arc"
    assert steps
    return frozenset(
        ("arc", reversal_invariant_word(rotate_word(steps, shift)), endpoints)
        for shift in range(len(steps)))


def arc_cyclic_selector(arc_type):
    """軌道代表から元の反転正規形へ戻す最小の巡回移動量。"""
    _, steps, _ = arc_type
    key_steps = arc_cyclic_orbit_key(arc_type)[1]
    selectors = tuple(
        shift for shift in range(len(steps))
        if reversal_invariant_word(rotate_word(key_steps, shift)) == steps)
    assert selectors
    return min(selectors)


def decode_arc_cyclic_encoding(orbit_key, selector):
    kind, key_steps, endpoints = orbit_key
    assert kind == "arc"
    assert key_steps
    return (
        "arc",
        reversal_invariant_word(rotate_word(key_steps, selector)),
        endpoints,
    )
