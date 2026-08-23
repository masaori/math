examples = (
    {"name": "regular hyperbolic quotient cellulation", "p": NN(3), "q": NN(7)},
    {"name": "square torus cellulation", "p": NN(4), "q": NN(4)},
    {"name": "two-face triangular sphere cellulation", "p": NN(3), "q": NN(2)},
)

def integer_product_difference(data):
    p_bar = ZZ(data["p"])
    q_bar = ZZ(data["q"])
    return (p_bar - 2) * (q_bar - 2)
