/-
「虚数単位を足した体の根で割った商の係数は虚数単位を足した体に入る」の必要十分版。

具体版の証明が使うのは次だけである。
- 係数環が可換環であること。多項式環の和・積の係数の定義と分配法則を使う。逆元は使わない。
- `ω·ω = -1`。一次式の値の全体の積の閉性（準備 (一)。`a := -1`、`b := ω`）でだけ使う。
- 部分集合 `S` が零元・単位元を含み、和・符号反転・積で閉じること。準備 (一) へ渡す
  （`-1 ∈ S` は単位元と符号反転から得る）。
正錐・共役・`ω ∉ F`・根の条件 `aev_w(f) = 0`・次数の条件は使わない。

`K_k(w)`（`K_0 = 0`、`K_{k+1} = K_k ŵ + t^k`）は係数環 `R` の上で同じ約束で置く。
-/
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionConjugateEvaluation
import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Algebra.BigOperators.NatAntidiagonal

namespace Ising2DLambda.NecSuf.FisherZero

open Polynomial

/-- `K_k(w)` を可換環 `R` の上で置く（具体版の `qbarPolyPowDiffSum` と同じ約束）。 -/
noncomputable def powDiffSumOn {R : Type*} [CommRing R] (w : R) : ℕ → Polynomial R
  | 0 => 0
  | k + 1 => powDiffSumOn w k * Polynomial.C w + Polynomial.X ^ k

/-- 具体版と同じ段（準備 (一)〜(八) と主張）で示す。 -/
theorem imaginaryUnitExtension_factor_quotient_coefficient_necSuf
    {R : Type*} [CommRing R] (S : Set R)
    (hzero : (0 : R) ∈ S) (hone : (1 : R) ∈ S)
    (hadd : ∀ x y : R, x ∈ S → y ∈ S → x + y ∈ S)
    (hneg : ∀ x : R, x ∈ S → -x ∈ S)
    (hmulS : ∀ x y : R, x ∈ S → y ∈ S → x * y ∈ S)
    (omega : R) (homega : omega * omega = -1)
    (f : Polynomial R) (hf : ∀ k, f.coeff k ∈ linearValuesOn S omega)
    (w : R) (hw : w ∈ linearValuesOn S omega) (n j : ℕ) :
    (∑ k ∈ Finset.range (n + 1), Polynomial.C (f.coeff k) * powDiffSumOn w k).coeff j
      ∈ linearValuesOn S omega := by
  -- 準備 (一): 一次式の値の全体は 0・1・和・積で閉じる。
  obtain ⟨h0, h1, haddL, _, hmulL⟩ :=
    quadraticLinearValues_ringClosed_necSuf S hzero hone hadd hneg hmulS (-1) omega
      (hneg 1 hone) homega
  -- 準備 (二): 有限和の所属。
  have lsum : ∀ (x : ℕ → R), (∀ i, x i ∈ linearValuesOn S omega) → ∀ m : ℕ,
      (∑ i ∈ Finset.range m, x i) ∈ linearValuesOn S omega := by
    intro x hx m
    induction m with
    | zero => rw [Finset.sum_range_zero]; exact h0
    | succ m ih => rw [Finset.sum_range_succ]; exact haddL _ _ ih (hx m)
  -- 集合 𝒫。
  let P : Set (Polynomial R) := {h | ∀ i : ℕ, h.coeff i ∈ linearValuesOn S omega}
  -- 準備 (三): 和。
  have padd : ∀ h₁ h₂, h₁ ∈ P → h₂ ∈ P → h₁ + h₂ ∈ P := by
    intro h₁ h₂ p₁ p₂ i
    rw [Polynomial.coeff_add]; exact haddL _ _ (p₁ i) (p₂ i)
  -- 準備 (四): 積。
  have pmul : ∀ h₁ h₂, h₁ ∈ P → h₂ ∈ P → h₁ * h₂ ∈ P := by
    intro h₁ h₂ p₁ p₂ i
    rw [Polynomial.coeff_mul,
      Finset.Nat.sum_antidiagonal_eq_sum_range_succ (fun a b => h₁.coeff a * h₂.coeff b) i]
    exact lsum (fun a => h₁.coeff a * h₂.coeff (i - a)) (fun a => hmulL _ _ (p₁ a) (p₂ (i - a)))
      (i + 1)
  -- 準備 (五): 定数多項式。
  have pconst : ∀ a, a ∈ linearValuesOn S omega → Polynomial.C a ∈ P := by
    intro a ha i
    rw [Polynomial.coeff_C]
    split_ifs
    · exact ha
    · exact h0
  -- 準備 (六): 不定元の冪。
  have pX : ∀ k : ℕ, (Polynomial.X : Polynomial R) ^ k ∈ P := by
    intro k i
    rw [Polynomial.coeff_X_pow]
    split_ifs
    · exact h1
    · exact h0
  -- 準備 (七): `K_k(w)`（`k` の帰納法）。
  have pK : ∀ k : ℕ, powDiffSumOn w k ∈ P := by
    intro k
    induction k with
    | zero => intro i; rw [powDiffSumOn, Polynomial.coeff_zero]; exact h0
    | succ k ih =>
        rw [powDiffSumOn]
        exact padd _ _ (pmul _ _ ih (pconst w hw)) (pX k)
  -- 準備 (八): 有限和（項の個数の帰納法）。
  have psum : ∀ (y : ℕ → Polynomial R), (∀ k, y k ∈ P) → ∀ m : ℕ,
      (∑ k ∈ Finset.range m, y k) ∈ P := by
    intro y hy m
    induction m with
    | zero => intro i; rw [Finset.sum_range_zero, Polynomial.coeff_zero]; exact h0
    | succ m ih => rw [Finset.sum_range_succ]; exact padd _ _ ih (hy m)
  -- 主張。
  exact psum _ (fun k => pmul _ _ (pconst _ (hf k)) (pK k)) (n + 1) j

end Ising2DLambda.NecSuf.FisherZero
