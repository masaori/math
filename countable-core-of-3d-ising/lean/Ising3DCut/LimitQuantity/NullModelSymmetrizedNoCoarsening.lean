/-
「対称化した極限量に対して粗視化 $q\mapsto\varepsilon_{L,q}(\mathcal Z_L)$ は必要でない」の
Lean 具体版（主張全体）。零モデルについて、二つの既証を一つに束ねる。
- 有限箱では $Z_L(q)\neq Z_L(1/q)$（$L\ge2$、$q>0$、$q\neq1$）：粗視化なしでは
  値そのものは $q\leftrightarrow1/q$ で不変でない（`nullModel_eval_polyOfMultiplicity_ne_eval_inv`）。
- それでも対称化した実数列の極限は $q$ と $1/q$ で一致する
  （`nullModel_symmetrized_real_seq_limit_eq`）。
ℝ へ脱出しているのは実数列の極限（箱の大きさの極限）の一点だけである。
-/
import Ising3DCut.LimitQuantity.NullModelEvalNeInv
import Ising3DCut.LimitQuantity.SymmetrizedRealSeqReciprocalInvariantNullModel

namespace Ising3DCut.LimitQuantity

open Polynomial Filter Topology NullModel

/-- 零モデル：有限箱では $Z_L(q)\neq Z_L(1/q)$ だが、対称化した実数列の極限は
$q$ と $1/q$ で一致する。粗視化は対称性のために必要でない。 -/
theorem nullModel_symmetrized_no_coarsening {L : ℕ} (hL : 2 ≤ L)
    {q : ℚ} (hq : 0 < q) (hq1 : q ≠ 1) (s : ℕ → ℝ) (ℓ ℓ' : ℝ)
    (ha : Tendsto (fun n => nullModelSymmetrizedRealTerm (n + 1) q (s (n + 1))) atTop (𝓝 ℓ))
    (hb : Tendsto (fun n => nullModelSymmetrizedRealTerm (n + 1) (1 / q) (s (n + 1))) atTop (𝓝 ℓ')) :
    (polyOfMultiplicity (Fintype.card (Edge L)) (NullModel.multiplicity L)).eval q ≠
        (polyOfMultiplicity (Fintype.card (Edge L)) (NullModel.multiplicity L)).eval (1 / q) ∧
      ℓ = ℓ' :=
  ⟨nullModel_eval_polyOfMultiplicity_ne_eval_inv hL hq hq1,
    nullModel_symmetrized_real_seq_limit_eq hq s ℓ ℓ' ha hb⟩

end Ising3DCut.LimitQuantity
