data = {
    "name": "regular hyperbolic quotient cellulation",
    "p": NN(3),
    "q": NN(7),
    "v": NN(24),
    "e": NN(84),
    "f": NN(56),
}

p = data["p"]
q = data["q"]
v = data["v"]
e = data["e"]
f = data["f"]

p_bar = ZZ(p)
q_bar = ZZ(q)
e_bar = ZZ(e)
chi = ZZ(v) - ZZ(e) + ZZ(f)
coefficient = 2 * p_bar + 2 * q_bar - p_bar * q_bar
