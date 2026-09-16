"""端点の非圧縮所属を保った切断候補の厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-consistency/construction.sage")


def endpoint_chosen_membership(endpoint):
    memberships, _ = endpoint
    return tuple(in_chosen for _, _, _, in_chosen in memberships)


def candidate_endpoint_alignments(orbit_key, selector):
    """候補の先頭・末尾へ整合する非圧縮端点を全て返す。"""
    _, key_steps, endpoints = orbit_key
    decoded_steps = reversal_invariant_word(rotate_word(key_steps, selector))
    return tuple(sorted(
        (boundary_position, endpoint)
        for boundary_position, step in ((0, decoded_steps[0]), (1, decoded_steps[-1]))
        for endpoint in endpoints
        if compressed_endpoint_signature(endpoint) == step
    ))


def candidate_noncompressed_descriptor(orbit_key, selector):
    """軌道代表・候補位置・非圧縮端点だけから得る有限記述。"""
    _, key_steps, _ = orbit_key
    decoded_steps = reversal_invariant_word(rotate_word(key_steps, selector))
    alignments = candidate_endpoint_alignments(orbit_key, selector)
    return tuple(
        (boundary_position,
         endpoint_chosen_membership(endpoint),
         decoded_steps)
        for boundary_position, endpoint in alignments
    )
