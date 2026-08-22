/-
必要十分版（`Ising3DCut/NecSuf/CollidingMapNotSufficient.lean`）から、
「値の衝突を持つ粗視化は箱サイズ極限の一致に十分でない」の具体版と同じ形の主張を取り出す。

特殊化の置き方は、入力の型を有理数、粗視化の行き先を型変数のまま、
極限が住む空間を実数、入力から極限への写像を `fun v => posRoot (v : ℝ) 1` と取ることである。
具体版の定理はここで呼び直していない。使うのは具体版の証明が使う算術の段、
すなわち定数列の乗根が値そのものであること（`posRoot_one_const`）だけである。
-/
import Ising3DCut.LimitQuantity.CollidingCoarseGrainingNotSufficient
import Ising3DCut.NecSuf.CollidingMapNotSufficient

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `M = 1` のときの乗根は値そのものである（`posRoot_one_const` の各点版）。 -/
theorem posRoot_one_eq (v : ℚ) (hv : (0 : ℚ) < v) : posRoot ((v : ℝ)) 1 = ((v : ℝ)) :=
  congrFun (posRoot_one_const v hv) 0

/-- 具体版と同じ形の主張を、必要十分版の特殊化として取り出したもの。 -/
theorem colliding_coarse_graining_is_not_sufficient_for_limit_quantity_viaNecSuf
    {S : Type*} (π : ℚ → S) (u w : ℚ)
    (hu : (0 : ℚ) < u) (hw : (0 : ℚ) < w) (hne : u ≠ w) (hcol : π u = π w) :
    ∃ (A B : ℕ → ℚ) (M : ℕ → ℕ) (ℓ ℓ' : ℝ),
      (∀ L, 0 < A L) ∧ (∀ L, 0 < B L) ∧ (∀ L, M L ≠ 0) ∧
      (∀ L, π (A L) = π (B L)) ∧
      Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 ℓ') ∧ ℓ ≠ ℓ' := by
  -- 必要十分版へ渡す二つ目の仮定「二つの値に対応する極限値が異なる」を、
  -- 乗根の段（`posRoot_one_eq`）と有理数の相違から作る。
  have hval : posRoot ((u : ℝ)) 1 ≠ posRoot ((w : ℝ)) 1 := by
    rw [posRoot_one_eq u hu, posRoot_one_eq w hw]
    exact_mod_cast hne
  obtain ⟨hagree, hA, hB, hlim⟩ :=
    Ising3DCut.NecSuf.colliding_map_not_sufficient π (fun v => posRoot ((v : ℝ)) 1) u w hcol hval
  -- 必要十分版が与える定数列を、具体版の形（正値性・`M L ≠ 0`・乗根列）へ載せ替える。
  exact ⟨fun _ => u, fun _ => w, fun _ => 1, posRoot ((u : ℝ)) 1, posRoot ((w : ℝ)) 1,
    fun _ => hu, fun _ => hw, fun _ => one_ne_zero, fun L => hagree L, hA, hB, hlim⟩

end Ising3DCut.LimitQuantity
