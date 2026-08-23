# 共通の正則有限セル分割例。全ての量は有限集合または NN に属する。

SOURCE = "source"
TARGET = "target"
FORWARD = "forward"
REVERSE = "reverse"
TERMINAL_END = {FORWARD: TARGET, REVERSE: SOURCE}

EXAMPLES = (
    {
        "name": "two-face triangular sphere",
        "q": NN(2),
        "vertices": ("A", "B", "C"),
        "edges": ("a", "b", "c"),
        "endpoints": {
            "a": {SOURCE: "A", TARGET: "B"},
            "b": {SOURCE: "B", TARGET: "C"},
            "c": {SOURCE: "C", TARGET: "A"},
        },
        "faces": {
            "north": (
                ("north-a", "a", FORWARD),
                ("north-b", "b", FORWARD),
                ("north-c", "c", FORWARD),
            ),
            "south": (
                ("south-c", "c", REVERSE),
                ("south-b", "b", REVERSE),
                ("south-a", "a", REVERSE),
            ),
        },
    },
    {
        "name": "one-face square torus",
        "q": NN(4),
        "vertices": ("v",),
        "edges": ("a", "b"),
        "endpoints": {
            "a": {SOURCE: "v", TARGET: "v"},
            "b": {SOURCE: "v", TARGET: "v"},
        },
        "faces": {
            "square": (
                ("a-forward", "a", FORWARD),
                ("b-forward", "b", FORWARD),
                ("a-reverse", "a", REVERSE),
                ("b-reverse", "b", REVERSE),
            ),
        },
    },
)


def occurrence_set(example):
    return Set(
        (face, position)
        for face, word in example["faces"].items()
        for position, edge, orientation in word
    )


def corner_vertex(example, face, position):
    word = example["faces"][face]
    selected = [entry for entry in word if entry[0] == position]
    assert len(selected) == 1
    _, edge, orientation = selected[0]
    return example["endpoints"][edge][TERMINAL_END[orientation]]


def vertex_corner_set(example, selected_vertex):
    return Set(
        (face, position)
        for face, word in example["faces"].items()
        for position, edge, orientation in word
        if corner_vertex(example, face, position) == selected_vertex
    )


def edge_fiber(example, selected_edge):
    return Set(
        (face, position)
        for face, word in example["faces"].items()
        for position, edge, orientation in word
        if edge == selected_edge
    )


for example in EXAMPLES:
    assert all(
        vertex_corner_set(example, vertex).cardinality() == example["q"]
        for vertex in example["vertices"]
    )
    assert all(
        edge_fiber(example, edge).cardinality() == NN(2)
        for edge in example["edges"]
    )
