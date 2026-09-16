"""反転同一視の前の向きを保った切断候補の厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-noncompressed-membership/construction.sage")


def candidate_reversal_orientation(orbit_key, selector):
    """巡回移動後の語が反転正規化で反転されたかを返す。"""
    _, key_steps, _ = orbit_key
    oriented_steps = rotate_word(key_steps, selector)
    reversed_steps = tuple(reversed(oriented_steps))
    assert oriented_steps != reversed_steps
    return ZZ(oriented_steps > reversed_steps)


def candidate_directed_boundary_descriptor(orbit_key, selector):
    """非圧縮端点所属へ反転正規化前の向きを一ビット加える。"""
    return (
        candidate_reversal_orientation(orbit_key, selector),
        candidate_noncompressed_descriptor(orbit_key, selector),
    )
