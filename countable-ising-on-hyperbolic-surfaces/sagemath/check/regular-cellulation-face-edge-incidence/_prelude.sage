# 共通の有限セル分割例。全ての量は有限集合または NN に属する。

EXAMPLES = (
    {
        "name": "two-face triangular sphere",
        "p": NN(3),
        "edges": ("a", "b", "c"),
        "faces": {
            "north": (("north-a", "a"), ("north-b", "b"), ("north-c", "c")),
            "south": (("south-c", "c"), ("south-b", "b"), ("south-a", "a")),
        },
    },
    {
        "name": "one-face square torus",
        "p": NN(4),
        "edges": ("a", "b"),
        "faces": {
            "square": (("a-forward", "a"), ("b-forward", "b"), ("a-reverse", "a"), ("b-reverse", "b")),
        },
    },
)


def occurrence_set(example):
    return Set(
        (face, position)
        for face, word in example["faces"].items()
        for position, edge in word
    )


def edge_fiber(example, selected_edge):
    return Set(
        (face, position)
        for face, word in example["faces"].items()
        for position, edge in word
        if edge == selected_edge
    )


for example in EXAMPLES:
    assert all(NN(len(word)) == example["p"] for word in example["faces"].values())
    assert all(edge_fiber(example, edge).cardinality() == NN(2) for edge in example["edges"])
