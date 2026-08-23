examples = (
    {
        "name": "regular hyperbolic quotient cellulation",
        "p": NN(3),
        "q": NN(7),
        "v": NN(24),
        "e": NN(84),
        "f": NN(56),
    },
    {
        "name": "square torus cellulation",
        "p": NN(4),
        "q": NN(4),
        "v": NN(1),
        "e": NN(2),
        "f": NN(1),
    },
    {
        "name": "two-face triangular sphere cellulation",
        "p": NN(3),
        "q": NN(2),
        "v": NN(3),
        "e": NN(3),
        "f": NN(2),
    },
)

def integer_data(data):
    p_bar = ZZ(data["p"])
    q_bar = ZZ(data["q"])
    e_bar = ZZ(data["e"])
    chi = ZZ(data["v"]) - e_bar + ZZ(data["f"])
    coefficient = 2 * p_bar + 2 * q_bar - p_bar * q_bar
    return p_bar, q_bar, e_bar, chi, coefficient
