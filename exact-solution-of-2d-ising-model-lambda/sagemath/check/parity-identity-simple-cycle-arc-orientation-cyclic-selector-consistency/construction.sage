"""巡回軌道代表と端点署名から得る切断位置候補の厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-support-encoding/construction.sage")


def compressed_endpoint_signature(endpoint):
    memberships, wrap_flags = endpoint
    orientation = tuple(in_single for _, _, in_single, _ in memberships)
    doubled = tuple(in_doubled for _, in_doubled, _, _ in memberships)
    return (orientation, wrap_flags, (doubled,))


def endpoint_boundary_selectors(orbit_key):
    """復号語の先頭か末尾が端点署名に一致する切断位置を全て返す。"""
    kind, key_steps, endpoints = orbit_key
    assert kind == "arc"
    endpoint_steps = frozenset(
        compressed_endpoint_signature(endpoint) for endpoint in endpoints)
    selectors = []
    for selector in range(len(key_steps)):
        decoded_steps = reversal_invariant_word(
            rotate_word(key_steps, selector))
        if decoded_steps[0] in endpoint_steps or decoded_steps[-1] in endpoint_steps:
            selectors.append(selector)
    return tuple(selectors)
