/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版に M := ℤ、w := (fun k => sgn_O(Ψ^{O,τ₀}_k))、u := -1、n := e(τ₀) を代入すると、
具体版の等式が出る。代入する仮定は次の 2 つだけである。

  出発点 w 0 = 1        ← orbitPermSign_id（Ψ₀ = id_O の符号は +1）
  一歩 w (k+1) = u * w k ← orbitPermSign_comp（符号の乗法性）と
                           orbitTransposition_sign_of_ne（互換の符号は -1）、
                           および rowShiftIterate_ne_self_of_lt_period（τ₀ ≠ S^[k+1](τ₀)）

このことは、この段の帰納法そのものが次を使っていないという主張の裏取りになっている。
行配位であること・巡回シフト・軌道・最小周期・互換であること・順序 ≺・値が ℤ であること・
u = -1 であること・積の可換性・台の有限性。

住処: ℕ と ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionCompositeSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTranspositionCompositeSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の主張を、必要十分版から導いたもの。 -/
theorem ambientComposite_sign_from_necSuf {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) :
    ∀ k : ℕ, k < rowShiftMinimalPeriod L τ₀ →
      orbitPermSign L O (ambientComposite L τ₀ k) = (-1) ^ k := by
  refine NecSuf.AlgebraicEigenvalue.value_of_iterated_step
    (fun k => orbitPermSign L O (ambientComposite L τ₀ k)) (-1)
    (rowShiftMinimalPeriod L τ₀) ?_ ?_
  · -- 出発点。Ψ₀ = id_O の符号は +1 である。
    exact orbitPermSign_id O
  · -- 一歩。乗法性を当て、互換の符号が -1 であることを使う。
    intro k hk
    have hmemk := rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ (k + 1)
    have hne : τ₀ ≠ rowShiftIterate L (k + 1) τ₀ :=
      rowShiftIterate_ne_self_of_lt_period (by omega) hk
    have hinj₁ : ∀ τ ∈ O, ∀ τ' ∈ O,
        orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀) τ
          = orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀) τ' → τ = τ' :=
      injOn_of_leftInverse (g' := orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀))
        (fun τ _ => orbitTransposition_involutive _ _ τ)
    show orbitPermSign L O (ambientComposite L τ₀ (k + 1))
      = (-1) * orbitPermSign L O (ambientComposite L τ₀ k)
    calc orbitPermSign L O (ambientComposite L τ₀ (k + 1))
        = orbitPermSign L O (fun τ =>
            orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀)
              (ambientComposite L τ₀ k τ)) := rfl
      _ = orbitPermSign L O (orbitTransposition L τ₀ (rowShiftIterate L (k + 1) τ₀))
            * orbitPermSign L O (ambientComposite L τ₀ k) :=
          orbitPermSign_comp (ambientComposite_mem hO hτ₀ k)
            (ambientCompositeInv_mem hO hτ₀ k)
            (ambientCompositeInv_left hO hτ₀ k) (ambientCompositeInv_right hO hτ₀ k)
            hinj₁
      _ = (-1) * orbitPermSign L O (ambientComposite L τ₀ k) := by
          rw [orbitTransposition_sign_of_ne hτ₀ hmemk hne]

end Ising2DLambda.AlgebraicEigenvalue
