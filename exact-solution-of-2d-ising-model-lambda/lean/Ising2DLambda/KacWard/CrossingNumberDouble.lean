/-
「添字対の横断」（`def_index_pair_crossing`）の具体版。
通過の添字を `Fin m`、通過の頂点と局所データを添字からの写像で持つ。
住処は有限集合の数え上げ（ℕ）であり、ℝ / ℂ は現れない。
-/
import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.KacWard.TransverseCrossing

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 添字対の横断（`def_index_pair_crossing`）: 通過の頂点が等しく、
二つの通過がその頂点で横断すること。 -/
def IndexCrossing {m : ℕ} {V : Type} (vertex : Fin m → V)
    (visit : Fin m → LocalVisit) (k l : Fin m) : Prop :=
  vertex k = vertex l ∧ TransverseCrossing (visit k) (visit l)

instance {m : ℕ} {V : Type} [DecidableEq V] (vertex : Fin m → V)
    (visit : Fin m → LocalVisit) (k l : Fin m) :
    Decidable (IndexCrossing vertex visit k l) := by
  unfold IndexCrossing TransverseCrossing
  infer_instance

/-- 横断の対称性（人手証明の第二段が使う形）: 頂点の等式の対称性と
`transverse_crossing_symmetric` を合わせる。 -/
theorem indexCrossing_symm {m : ℕ} {V : Type} (vertex : Fin m → V)
    (visit : Fin m → LocalVisit) (k l : Fin m)
    (h : IndexCrossing vertex visit k l) : IndexCrossing vertex visit l k :=
  ⟨h.1.symm, (transverse_crossing_symmetric (visit k) (visit l)).mp h.2⟩

end Ising2DLambda.KacWard
