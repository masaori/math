import os

CHECK_DIR = os.path.dirname(os.path.abspath(__file__)) if "__file__" in globals() else "."

SOURCE = "source-end"
TARGET = "target-end"
END_LABELS = (SOURCE, TARGET)
FORWARD = "forward-orientation"
REVERSE = "reverse-orientation"
INITIAL_END = {FORWARD: SOURCE, REVERSE: TARGET}
TERMINAL_END = {FORWARD: TARGET, REVERSE: SOURCE}


def first_boundary_matrix(data):
    vertices = data["vertices"]
    edges = data["edges"]
    endpoints = data["endpoints"]
    return matrix(
        GF(2),
        len(vertices),
        len(edges),
        lambda row, column: sum(
            GF(2).one()
            for end_label in END_LABELS
            if endpoints[edges[column]][end_label] == vertices[row]
        ),
    )


def second_boundary_matrix(data):
    edges = data["edges"]
    faces = data["faces"]
    words = data["words"]
    return matrix(
        GF(2),
        len(edges),
        len(faces),
        lambda row, column: sum(
            GF(2).one()
            for position in words[faces[column]]["positions"]
            if words[faces[column]]["edge_at"][position] == edges[row]
        ),
    )


def matrix_product_entry(data, vertex, face):
    row = data["vertices"].index(vertex)
    column = data["faces"].index(face)
    return (first_boundary_matrix(data) * second_boundary_matrix(data))[row, column]


def expanded_boundary_product(data, vertex, face):
    edges = data["edges"]
    endpoints = data["endpoints"]
    word = data["words"][face]
    return sum(
        sum(
            GF(2).one()
            for end_label in END_LABELS
            if endpoints[edge][end_label] == vertex
        )
        * sum(
            GF(2).one()
            for position in word["positions"]
            if word["edge_at"][position] == edge
        )
        for edge in edges
    )


def reindexed_endpoint_sum(data, vertex, face):
    word = data["words"][face]
    endpoints = data["endpoints"]
    return sum(
        GF(2).one()
        for position in word["positions"]
        for end_label in END_LABELS
        if endpoints[word["edge_at"][position]][end_label] == vertex
    )


def selected_endpoint_sum(data, vertex, face):
    word = data["words"][face]
    endpoints = data["endpoints"]
    return sum(
        GF(2)(
            endpoints[word["edge_at"][position]][INITIAL_END[word["orientation_at"][position]]]
            == vertex
        )
        + GF(2)(
            endpoints[word["edge_at"][position]][TERMINAL_END[word["orientation_at"][position]]]
            == vertex
        )
        for position in word["positions"]
    )


def successor_initial_plus_initial(data, vertex, face):
    word = data["words"][face]
    endpoints = data["endpoints"]
    successor_initial = sum(
        GF(2)(
            endpoints[word["edge_at"][word["successor"][position]]][
                INITIAL_END[word["orientation_at"][word["successor"][position]]]
            ]
            == vertex
        )
        for position in word["positions"]
    )
    initial = sum(
        GF(2)(
            endpoints[word["edge_at"][position]][INITIAL_END[word["orientation_at"][position]]]
            == vertex
        )
        for position in word["positions"]
    )
    return successor_initial + initial


def twice_initial_sum(data, vertex, face):
    word = data["words"][face]
    endpoints = data["endpoints"]
    initial = sum(
        GF(2)(
            endpoints[word["edge_at"][position]][INITIAL_END[word["orientation_at"][position]]]
            == vertex
        )
        for position in word["positions"]
    )
    return initial + initial


def zero_entry(data, vertex, face):
    return GF(2).zero()


def check_pair(left, right):
    for data in EXAMPLES:
        for vertex in data["vertices"]:
            for face in data["faces"]:
                assert left(data, vertex, face) == right(data, vertex, face)


SPHERE = {
    "vertices": ("A", "B", "C"),
    "edges": ("ab", "bc", "ca"),
    "faces": ("front", "back"),
    "endpoints": {
        "ab": {SOURCE: "A", TARGET: "B"},
        "bc": {SOURCE: "B", TARGET: "C"},
        "ca": {SOURCE: "C", TARGET: "A"},
    },
    "words": {
        "front": {
            "positions": ("front-ab", "front-bc", "front-ca"),
            "successor": {"front-ab": "front-bc", "front-bc": "front-ca", "front-ca": "front-ab"},
            "edge_at": {"front-ab": "ab", "front-bc": "bc", "front-ca": "ca"},
            "orientation_at": {"front-ab": FORWARD, "front-bc": FORWARD, "front-ca": FORWARD},
        },
        "back": {
            "positions": ("back-ca", "back-bc", "back-ab"),
            "successor": {"back-ca": "back-bc", "back-bc": "back-ab", "back-ab": "back-ca"},
            "edge_at": {"back-ca": "ca", "back-bc": "bc", "back-ab": "ab"},
            "orientation_at": {"back-ca": REVERSE, "back-bc": REVERSE, "back-ab": REVERSE},
        },
    },
}

LOOP = {
    "vertices": ("A",),
    "edges": ("loop",),
    "faces": ("inside",),
    "endpoints": {"loop": {SOURCE: "A", TARGET: "A"}},
    "words": {
        "inside": {
            "positions": ("inside-loop",),
            "successor": {"inside-loop": "inside-loop"},
            "edge_at": {"inside-loop": "loop"},
            "orientation_at": {"inside-loop": FORWARD},
        },
    },
}

EXAMPLES = (SPHERE, LOOP)
