/-
「値の衝突を持つ粗視化は箱サイズ極限の一致に十分でない」の Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち衝突する二つの値 `u ≠ w`（`π u = π w`）を
そのまま定数列に取り、`M L = 1`, `A L = u`, `B L = w` と置いて、
すべての添字で粗視化の値が一致すること、両方の乗根列がそれぞれ定数列として
収束すること、そして二つの極限値 `u` と `w` が異なることを示す。
粗視化の作り方には何の仮定も置かない。
-/
import Ising3DCut.LimitQuantity.PositiveRealRootUnique
import Mathlib.Topology.Instances.Real.Lemmas

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 人手証明の「定数列の乗根列は定数列である」の段（`M L = 1` なので乗根を取らずに済む）。 -/
theorem posRoot_one_const (v : ℚ) (hv : (0 : ℚ) < v) :
    (fun _ : ℕ => posRoot ((v : ℝ)) 1) = fun _ : ℕ => ((v : ℝ)) := by
  funext _
  have hvR : (0 : ℝ) < (v : ℝ) := by exact_mod_cast hv
  exact (eq_posRoot_of_pow_eq ((v : ℝ)) ((v : ℝ)) hvR hvR 1 one_ne_zero (by ring)).symm

/-- 値の衝突を持つ粗視化については、すべての添字で粗視化の値が一致するのに
二つの乗根列の箱サイズ極限が異なる例がある。 -/
theorem colliding_coarse_graining_is_not_sufficient_for_limit_quantity
    {S : Type*} (π : ℚ → S) (u w : ℚ)
    (hu : (0 : ℚ) < u) (hw : (0 : ℚ) < w) (hne : u ≠ w) (hcol : π u = π w) :
    ∃ (A B : ℕ → ℚ) (M : ℕ → ℕ) (ℓ ℓ' : ℝ),
      (∀ L, 0 < A L) ∧ (∀ L, 0 < B L) ∧ (∀ L, M L ≠ 0) ∧
      (∀ L, π (A L) = π (B L)) ∧
      Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 ℓ') ∧ ℓ ≠ ℓ' := by
  refine ⟨fun _ => u, fun _ => w, fun _ => 1, ((u : ℝ)), ((w : ℝ)),
    fun _ => hu, fun _ => hw, fun _ => one_ne_zero, fun _ => hcol, ?_, ?_, ?_⟩
  · -- 人手証明の「`a` は定数列 `u` なので箱サイズ極限は `u`」の段。
    rw [posRoot_one_const u hu]
    exact tendsto_const_nhds
  · -- 人手証明の「`b` は定数列 `w` なので箱サイズ極限は `w`」の段。
    rw [posRoot_one_const w hw]
    exact tendsto_const_nhds
  · -- 人手証明の「`u ≠ w` なので二つの箱サイズ極限は一致しない」の段。
    exact_mod_cast hne

end Ising3DCut.LimitQuantity
