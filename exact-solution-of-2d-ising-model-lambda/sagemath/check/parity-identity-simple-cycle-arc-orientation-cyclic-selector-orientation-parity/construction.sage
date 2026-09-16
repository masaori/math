"""内部語の向きビットの巡回・反転不変な奇偶を取り出す厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-endpoint-predicate/construction.sage")


def orientation_coordinate_parities(orbit_key):
    """内部語の各向き座標を全語位置で加えた奇偶を返す。"""
    _, key_steps, _ = orbit_key
    return tuple(
        ZZ(sum(step[0][coordinate] for step in key_steps) % 2)
        for coordinate in range(4)
    )


def all_orientation_coordinates_odd(orbit_key):
    """四つの向き座標の出現数が全て奇数かを一ビットで返す。"""
    return ZZ(orientation_coordinate_parities(orbit_key) == (1, 1, 1, 1))
