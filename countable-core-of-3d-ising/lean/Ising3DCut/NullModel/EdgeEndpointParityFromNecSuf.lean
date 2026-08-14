/-
具体版が必要十分版の特殊化として得られることの明示。

具体版で座標和が 1 増えることから `parity_endpoint1` を得たあと、必要十分版
`endpoint_colors_differ_iff_not` に二端点の偶奇を代入すると、具体版と同じ主張が出る。
これは、最後の段に本質的なのが二値の色と色の否定だけであることを示す。

住処: `Fin`、`Nat`、有限集合 `Bool` のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.EdgeEndpointParity
import Ising3DCut.NecSuf.NullModel.EdgeEndpointParity

namespace Ising3DCut.NullModel

/-- `claim_edge_endpoints_parity` の具体版を必要十分版から導いたもの。 -/
theorem edge_endpoints_parity_differ_from_necSuf {L : ℕ} (e : Edge L) :
    parity (endpoint0 e) ≠ parity (endpoint1 e) := by
  apply (NecSuf.NullModel.endpoint_colors_differ_iff_not
    (parity (endpoint0 e)) (parity (endpoint1 e))).mp
  exact parity_endpoint1 e

end Ising3DCut.NullModel
