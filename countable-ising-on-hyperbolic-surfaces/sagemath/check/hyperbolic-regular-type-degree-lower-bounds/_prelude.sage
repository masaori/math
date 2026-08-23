examples = (
    {"name": "regular hyperbolic quotient cellulation", "p": NN(3), "q": NN(7)},
    {"name": "dual regular hyperbolic type", "p": NN(7), "q": NN(3)},
    {"name": "regular hyperbolic type with face degree four", "p": NN(4), "q": NN(5)},
    {"name": "regular hyperbolic type with vertex degree four", "p": NN(5), "q": NN(4)},
)

def is_hyperbolic(p, q):
    return 2 * (p + q) < p * q
