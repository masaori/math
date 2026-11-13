/-
「分散因子の最小値は自己双対点で零になる」（`claim_dispersion_minimum_self_dual_point`）の必要十分版。

具体版と同じ手順（第一の事実 `0 < r < 1`、第二の事実 `c > 0`、第三の事実 `ρ(p) = 1−2r−r²` の七行、
第四の事実 `s ≠ 0` と `−1−s <_R −2 <_R 0` の推移律、第五の事実 `ξ ≠ −1−s`、`B − (1−2r−r²)²` の六行、
`B(x₀)` の四行、零条件の七行の同値、`1 + x_c = s ≠ 0` からの双対性）を、次の仮定だけで行う。

- `R`: 体（実閉部分体にあたる）。順序は「差が零でない元の平方」で定める関係 `squareDifferenceLt`。
  - 推移律のために、平方の和が平方であること `sum_is_square` と、平方の和が零なら両方が零であること
    `sum_zero` を仮定する（具体版は `claim_real_algebraic_order_transitive` でこの二つを使う）。
  - `2 ≠ 0` を仮定する（`s ≠ 0` を出すため。具体版は `ℚ ⊂ Qbar` で得る）。
  - 体であることは、零因子が無いこと（第五の事実と二次方程式の二根）と `1 + x_c` の逆元（双対性）で使う。
    乗法の可換性は推移律の補題と二次方程式・双対性の補題が使う。
- `K`: 線型順序を持つ狭義順序可換環（実数体にあたる）。正の元の積が正であることと零因子が無いことだけを使う。
  体であること・完備性は使わない。
- `ρ : R → K` は加法・乗法を保ち、`ρ 0 = 0`・`ρ 1 = 1`・`ρ 2 = 2`（具体版は有理数上の一致から得る）、
  `squareDifferenceLt` を `K` の狭義順序へ送り、単射である。他の有理数での一致は使わない。
- `s ∈ R` は `s·s = 2` と `0 <_R −1+s`（`claim_critical_point_positive` にあたる前提）を満たす。
- 角の集合 `D ⊂ X` と点 `x₀ ∈ D`、関数 `c₁, c₂ : X → K` は `cⱼ ≤ 1` と `cⱼ(x₀) = 1` を満たす
  （実余弦にあたる）。連続性・`−1 ≤ cⱼ`・周期性は使わない。
-/
import Ising2DLambda.NecSuf.FisherZero.RealAlgebraicOrderTransitive
import Ising2DLambda.NecSuf.FisherZero.SelfDualQuadraticRoots
import Ising2DLambda.NecSuf.FisherZero.KwSelfDualQuadraticEquivalence
import Mathlib.Algebra.Order.Ring.Defs
import Mathlib.Order.Bounds.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.LinearCombination

namespace Ising2DLambda.NecSuf.RealEscape

variable {R K X : Type*} [Field R] [CommRing K] [LinearOrder K] [IsStrictOrderedRing K]

/-- 差が零でない元の平方であることで定める狭義順序（`def_real_algebraic_strict_order` にあたる）。 -/
def squareDifferenceLt (a b : R) : Prop := ∃ w : R, w ≠ 0 ∧ b - a = w * w

/-- `B(x) := (1+r²)² − 2r(1−r²)(c₁(x)+c₂(x))`。 -/
def dispersionMinimumArgumentNecSuf (r : K) (c₁ c₂ : X → K) (x : X) : K :=
  (1 + r ^ 2) ^ 2 - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x)

omit [LinearOrder K] [IsStrictOrderedRing K] in
/-- 六行: `B − (1−2r−r²)² = c((1−c₁)+(1−c₂))`。可換環の等式だけを使う。 -/
theorem dispersionMinimumArgument_sub_gap_necSuf (r : K) (c₁ c₂ : X → K) (x : X) :
    dispersionMinimumArgumentNecSuf r c₁ c₂ x - (1 - 2 * r - r ^ 2) ^ 2 =
      2 * r * (1 - r ^ 2) * ((1 - c₁ x) + (1 - c₂ x)) := by
  calc dispersionMinimumArgumentNecSuf r c₁ c₂ x - (1 - 2 * r - r ^ 2) ^ 2
      = (1 + r ^ 2) ^ 2 - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x) - (1 - 2 * r - r ^ 2) ^ 2 := rfl
    _ = ((1 + r ^ 2) - (1 - 2 * r - r ^ 2)) * ((1 + r ^ 2) + (1 - 2 * r - r ^ 2))
          - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x) := by ring
    _ = (2 * r + 2 * r ^ 2) * (2 - 2 * r) - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x) := by ring
    _ = 4 * r * (1 - r ^ 2) - 2 * r * (1 - r ^ 2) * (c₁ x + c₂ x) := by ring
    _ = 2 * r * (1 - r ^ 2) * ((1 - c₁ x) + (1 - c₂ x)) := by ring

/-- 必要十分版の本体。最小値・達成点・零条件・双対性。 -/
theorem dispersion_minimum_self_dual_point_necSuf
    (sum_is_square : ∀ u v : R, ∃ w : R, u * u + v * v = w * w)
    (sum_zero : ∀ u v : R, u * u + v * v = 0 → u = 0 ∧ v = 0)
    (htwo : (2 : R) ≠ 0)
    (ρ : R → K) (hρadd : ∀ a b, ρ (a + b) = ρ a + ρ b) (hρmul : ∀ a b, ρ (a * b) = ρ a * ρ b)
    (hρ0 : ρ 0 = 0) (hρ1 : ρ 1 = 1) (hρ2 : ρ 2 = 2)
    (hρlt : ∀ a b, squareDifferenceLt a b → ρ a < ρ b) (hρinj : Function.Injective ρ)
    (s : R) (hs : s * s = 2) (hpos : squareDifferenceLt 0 (-1 + s))
    (ξ : R) (hξ0 : squareDifferenceLt 0 ξ) (hξ1 : squareDifferenceLt ξ 1)
    (D : Set X) (x₀ : X) (hx₀ : x₀ ∈ D) (c₁ c₂ : X → K)
    (hc₁ : ∀ x, c₁ x ≤ 1) (hc₂ : ∀ x, c₂ x ≤ 1) (hc₁0 : c₁ x₀ = 1) (hc₂0 : c₂ x₀ = 1) :
    IsLeast (dispersionMinimumArgumentNecSuf (ρ ξ) c₁ c₂ '' D)
        ((1 - 2 * ρ ξ - ρ ξ ^ 2) ^ 2) ∧
      dispersionMinimumArgumentNecSuf (ρ ξ) c₁ c₂ x₀ = (1 - 2 * ρ ξ - ρ ξ ^ 2) ^ 2 ∧
      ((1 - 2 * ρ ξ - ρ ξ ^ 2) ^ 2 = 0 ↔ ξ = -1 + s) ∧
      (1 - (-1 + s)) * (1 + (-1 + s))⁻¹ = -1 + s := by
  set r : K := ρ ξ
  -- 推移律（`claim_real_algebraic_order_transitive`）。平方の和の二つの性質がここで要る。
  have htrans : ∀ a b c : R, squareDifferenceLt a b → squareDifferenceLt b c →
      squareDifferenceLt a c := fun a b c hab hbc =>
    Ising2DLambda.NecSuf.FisherZero.lt_of_difference_trans_necSuf sum_is_square sum_zero a b c hab hbc
  -- 第一の事実。
  have hr0 : 0 < r := by
    calc (0 : K) = ρ 0 := hρ0.symm
      _ < ρ ξ := hρlt 0 ξ hξ0
  have hr1 : r < 1 := by
    calc r = ρ ξ := rfl
      _ < ρ 1 := hρlt ξ 1 hξ1
      _ = 1 := hρ1
  -- 第二の事実。
  have hc : 0 < 2 * r * (1 - r ^ 2) := by
    calc (0 : K)
        < 2 * r * ((1 - r) * (1 + r)) :=
          mul_pos (mul_pos two_pos hr0) (mul_pos (by linarith) (by linarith))
      _ = 2 * r * (1 - r ^ 2) := by ring
  -- 第三の事実（七行）。
  set p : R := 1 - 2 * ξ - ξ * ξ
  have hρp : ρ p = 1 - 2 * r - r ^ 2 := by
    calc ρ p
        = ρ p + (2 * r + r * r) - (2 * r + r * r) := by ring
      _ = ρ p + (ρ 2 * ρ ξ + ρ ξ * ρ ξ) - (2 * r + r * r) := by rw [hρ2]
      _ = ρ p + (ρ (2 * ξ) + ρ (ξ * ξ)) - (2 * r + r * r) := by rw [hρmul, hρmul]
      _ = ρ p + ρ (2 * ξ + ξ * ξ) - (2 * r + r * r) := by rw [hρadd (2 * ξ) (ξ * ξ)]
      _ = ρ (p + (2 * ξ + ξ * ξ)) - (2 * r + r * r) := by rw [hρadd p (2 * ξ + ξ * ξ)]
      _ = ρ 1 - (2 * r + r * r) := by congr 2; simp only [p]; ring
      _ = 1 - 2 * r - r ^ 2 := by rw [hρ1]; ring
  -- 第四の事実: s ≠ 0、−1 − s <_R −2、−2 <_R 0、−1 − s <_R 0。
  have hs0 : s ≠ 0 := by
    intro h0
    apply htwo
    calc (2 : R) = s * s := hs.symm
      _ = 0 * 0 := by rw [h0]
      _ = 0 := zero_mul 0
  obtain ⟨w, hw0, hw⟩ := hpos
  have h1 : squareDifferenceLt (-1 - s) (-2) := by
    refine ⟨w, hw0, ?_⟩
    calc (-2 : R) - (-1 - s)
        = -1 + s := by ring
      _ = (-1 + s) - 0 := (sub_zero _).symm
      _ = w * w := hw
  have h2 : squareDifferenceLt (-2 : R) 0 := by
    refine ⟨s, hs0, ?_⟩
    calc (0 : R) - (-2) = 2 := by ring
      _ = s * s := hs.symm
  have hneg : squareDifferenceLt (-1 - s) 0 := htrans _ _ _ h1 h2
  -- 第五の事実。零因子が無いことを使う。
  have hne : ξ ≠ -1 - s := by
    intro hξ
    have hξneg : squareDifferenceLt ξ 0 := hξ ▸ hneg
    obtain ⟨v, hv0, hv⟩ := htrans 0 ξ 0 hξ0 hξneg
    have hvv : v * v = 0 :=
      calc v * v = 0 - 0 := hv.symm
        _ = 0 := sub_self 0
    exact hv0 (mul_self_eq_zero.mp hvv)
  -- 最小値。
  have hlow : ∀ x, (1 - 2 * r - r ^ 2) ^ 2 ≤ dispersionMinimumArgumentNecSuf r c₁ c₂ x := by
    intro x
    have hcos : 0 ≤ (1 - c₁ x) + (1 - c₂ x) :=
      add_nonneg (sub_nonneg.2 (hc₁ x)) (sub_nonneg.2 (hc₂ x))
    have hdiff : 0 ≤ dispersionMinimumArgumentNecSuf r c₁ c₂ x - (1 - 2 * r - r ^ 2) ^ 2 := by
      rw [dispersionMinimumArgument_sub_gap_necSuf]; exact mul_nonneg hc.le hcos
    linarith
  have hzero : dispersionMinimumArgumentNecSuf r c₁ c₂ x₀ = (1 - 2 * r - r ^ 2) ^ 2 := by
    calc dispersionMinimumArgumentNecSuf r c₁ c₂ x₀
        = (dispersionMinimumArgumentNecSuf r c₁ c₂ x₀ - (1 - 2 * r - r ^ 2) ^ 2)
            + (1 - 2 * r - r ^ 2) ^ 2 := by ring
      _ = 2 * r * (1 - r ^ 2) * ((1 - c₁ x₀) + (1 - c₂ x₀)) + (1 - 2 * r - r ^ 2) ^ 2 := by
          rw [dispersionMinimumArgument_sub_gap_necSuf]
      _ = 2 * r * (1 - r ^ 2) * ((1 - 1) + (1 - 1)) + (1 - 2 * r - r ^ 2) ^ 2 := by
          rw [hc₁0, hc₂0]
      _ = (1 - 2 * r - r ^ 2) ^ 2 := by ring
  -- 二次方程式の二根（`claim_self_dual_quadratic_roots`）。
  have hroots : ∀ y : R, y * y + (1 + 1) * y - 1 = 0 ↔ y = -1 + s ∨ y = -1 - s := fun y =>
    Ising2DLambda.NecSuf.FisherZero.self_dual_quadratic_roots_necSuf
      (by rw [hs]; norm_num) (mul_comm _ _)
      (fun {a b} ha hab => (mul_eq_zero.mp hab).resolve_left ha)
  -- 零条件の七行の同値。
  have hiff : (1 - 2 * r - r ^ 2) ^ 2 = 0 ↔ ξ = -1 + s := by
    calc (1 - 2 * r - r ^ 2) ^ 2 = 0
        ↔ 1 - 2 * r - r ^ 2 = 0 := pow_eq_zero_iff two_ne_zero
      _ ↔ ρ p = ρ 0 := by rw [hρp, hρ0]
      _ ↔ p = 0 := hρinj.eq_iff
      _ ↔ ξ * ξ + (1 + 1) * ξ - 1 = 0 := by
          constructor
          · intro h; simp only [p] at h; linear_combination -h
          · intro h; simp only [p]; linear_combination -h
      _ ↔ (ξ = -1 + s ∨ ξ = -1 - s) := hroots ξ
      _ ↔ ξ = -1 + s := by
          constructor
          · rintro (h | h)
            · exact h
            · exact absurd h hne
          · exact Or.inl
  -- 双対性（`claim_kw_self_dual_quadratic_equivalence`）。
  have hDomain : 1 + (-1 + s) ≠ 0 := by
    calc 1 + (-1 + s) = s := by ring
      _ ≠ 0 := hs0
  have hquad : (-1 + s) * (-1 + s) + (1 + 1) * (-1 + s) - 1 = 0 := (hroots _).mpr (Or.inl rfl)
  have hkw : (1 - (-1 + s)) * (1 + (-1 + s))⁻¹ = -1 + s :=
    (Ising2DLambda.NecSuf.FisherZero.kw_self_dual_quadratic_equivalence_necSuf (-1 + s)
      (1 + (-1 + s))⁻¹ ((1 - (-1 + s)) * (1 + (-1 + s))⁻¹) rfl
      (mul_inv_cancel₀ hDomain)).mpr (by rw [pow_two]; exact hquad)
  refine ⟨⟨⟨x₀, hx₀, hzero⟩, ?_⟩, hzero, hiff, hkw⟩
  rintro y ⟨x, -, rfl⟩
  exact hlow x

end Ising2DLambda.NecSuf.RealEscape
