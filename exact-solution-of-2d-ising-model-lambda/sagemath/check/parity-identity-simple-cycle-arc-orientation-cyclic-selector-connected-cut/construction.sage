"""内部語の連結条件と切断後の境界方向を結ぶ厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-orientation-parity/construction.sage")


OPPOSITE_DIRECTION = (1, 0, 3, 2)


def connected_word_traversals(word):
    """二本の単一辺を使い切って語を順に通る全ての向きを返す。"""
    assert word
    traversals = []
    first_orientation = word[0][0]
    assert sum(first_orientation) == 2
    for first_incoming in range(4):
        if first_orientation[first_incoming] == 0:
            continue
        incoming = first_incoming
        outgoing_directions = []
        connected = True
        for orientation, _, _ in word:
            assert sum(orientation) == 2
            if orientation[incoming] == 0:
                connected = False
                break
            choices = tuple(
                direction for direction in range(4)
                if orientation[direction] == 1 and direction != incoming)
            assert len(choices) == 1
            outgoing = choices[0]
            outgoing_directions.append(outgoing)
            incoming = OPPOSITE_DIRECTION[outgoing]
        if connected:
            traversals.append((
                ZZ(first_incoming),
                ZZ(outgoing_directions[-1]),
                tuple(map(ZZ, outgoing_directions[:-1])),
            ))
    return tuple(traversals)


def traversal_boundary_parity(traversal):
    """両端方向と内部接続辺の軸から復元した四方向の出現奇偶。"""
    first_incoming, last_outgoing, internal_outgoing = traversal
    parity = [ZZ(0)] * 4
    parity[first_incoming] += 1
    parity[last_outgoing] += 1
    for outgoing in internal_outgoing:
        parity[outgoing] += 1
        parity[OPPOSITE_DIRECTION[outgoing]] += 1
    return tuple(value % 2 for value in parity)
