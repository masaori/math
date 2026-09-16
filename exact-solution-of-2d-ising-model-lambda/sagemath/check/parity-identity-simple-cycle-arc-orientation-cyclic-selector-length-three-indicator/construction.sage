"""端点ビットへ語長三の指示ビットを加える厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-endpoint-predicate/construction.sage")


def word_length_is_three(orbit_key):
    """内部語の長さが三であることを一ビットで返す。"""
    return ZZ(len(orbit_key[1]) == 3)
