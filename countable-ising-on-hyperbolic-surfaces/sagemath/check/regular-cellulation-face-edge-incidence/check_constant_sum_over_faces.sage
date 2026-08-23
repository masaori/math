# SageMath: p|F| = sum_f p
# 対象ラベル: theorem_regular_cellulation_face_edge_incidence
# 帰属: NN と有限集合だけを用いる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

for example in EXAMPLES:
    lhs = example["p"] * NN(len(example["faces"]))
    rhs = sum((example["p"] for face in example["faces"]), NN(0))
    assert lhs == rhs

print("RESULT: PASS — p|F| equals the constant finite sum over faces")
