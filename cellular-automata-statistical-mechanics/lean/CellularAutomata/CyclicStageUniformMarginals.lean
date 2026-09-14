/-
正本: structured-latex/content/cyclic-stage-uniform-marginals.ts の具体版。

人手証明のブロックとこのファイルの対応:
  def_cyclic_stage_uniform_distribution_family
    `oddStage`, `windowEmbedding`, `windowPullback`, `uniformWeight`, `marginalWeight`
  claim_cyclic_stage_uniform_distribution_normalized
    `uniformWeight_normalized`
  claim_cyclic_stage_window_embeddings_compatible
    `windowEmbedding_compatible`, `windowPullback_compatible`
  claim_cyclic_stage_uniform_marginal_formula
    `windowPullback_fiber_card`, `marginalWeight_formula`
  theorem_cyclic_stage_uniform_marginals_consistent
    `marginalWeight_consistent`

奇数位数 2m+1 の有限巡回舞台、半径 s 以下の整数窓、演算を持たない
二元状態、一様有理分布を固定し、人手証明と同じ有限個数計算を形式化する。
除算は正の二冪を分母とする有理数内だけで使う。対数、全配位の逆極限、
極限、Gibbs 仕様、実数体、複素数体は使わない。
-/
import CellularAutomata.CyclicStageLocalAgreement
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.EquivFin
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Rat.Cast.Order
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum

namespace CellularAutomata.CyclicStageUniformMarginals

open CellularAutomata.CyclicRuleRestriction
open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.EssentialDependency
open scoped BigOperators

noncomputable section

/-- 奇数位数 `2m+1` を正の周期として持つ。 -/
def oddPeriod (m : ℕ) : PositiveStage := ⟨2 * m + 1, by omega⟩

/-- 奇数位数 `2m+1` の有限巡回舞台。 -/
abbrev OddStage (m : ℕ) := Stage (oddPeriod m)

/-- 半径 `s` の整数窓を奇数位数の巡回舞台へ送る余り写像の制限。 -/
def windowEmbedding (m s : ℕ) : Offset s → OddStage m :=
  fun j => projection (oddPeriod m) (signedOffset s j)

/-- `s ≤ m` なら有限窓埋め込みは単射である。 -/
theorem windowEmbedding_injective (m s : ℕ) (hsm : s ≤ m) :
    Function.Injective (windowEmbedding m s) := by
  intro j k hjk
  change (signedOffset s j : ZMod (2 * m + 1)) = signedOffset s k at hjk
  apply cyclicProjection_injective_of_width_le (2 * m + 1) s (0 : ZMod (2 * m + 1)) (by omega)
  simpa [cyclicProjection] using hjk

/-- 舞台上の二元配位を有限窓へ引き戻す。 -/
def windowPullback (m s : ℕ) (x : OddStage m → State) : Offset s → State :=
  fun j => x (windowEmbedding m s j)

/-- 有限巡回舞台上の一様有理重み。 -/
def uniformWeight (m : ℕ) (_x : OddStage m → State) : ℚ :=
  1 / (2 ^ (2 * m + 1) : ℕ)

/-- 有限窓配位の周辺重みを、引き戻しの繊維上の有限和として定める。 -/
def marginalWeight (m s : ℕ) (a : Offset s → State) : ℚ :=
  ∑ x : OddStage m → State, if windowPullback m s x = a then uniformWeight m x else 0

/-- 奇数位数の有限巡回舞台は `2m+1` 個のセルを持つ。 -/
theorem oddStage_card (m : ℕ) : Fintype.card (OddStage m) = 2 * m + 1 := by
  exact ZMod.card (2 * m + 1)

/-- 一様重みの分母は正であり、有理数内の除算が定義される。 -/
theorem uniformWeight_denominator_positive (m : ℕ) :
    0 < (2 ^ (2 * m + 1) : ℕ) := by
  positivity

/-- 有限巡回舞台の一様有理重みは確率分布である。 -/
theorem uniformWeight_normalized (m : ℕ) :
    ∑ x : OddStage m → State, uniformWeight m x = 1 := by
  simp [uniformWeight, oddPeriod, card_state]

/-- 小窓の添字を、同じ整数オフセットを表す大窓の添字へ送る。 -/
def windowInclusion (s t : ℕ) (hst : s ≤ t) : Offset s → Offset t :=
  fun j => ⟨j.val + (t - s), by omega⟩

/-- 窓包含写像は整数オフセットを変えない。 -/
theorem signedOffset_windowInclusion (s t : ℕ) (hst : s ≤ t) (j : Offset s) :
    signedOffset t (windowInclusion s t hst j) = signedOffset s j := by
  simp [signedOffset, windowInclusion]
  omega

/-- 有限窓埋め込みは窓の包含に沿って整合する。 -/
theorem windowEmbedding_compatible (m s t : ℕ) (hst : s ≤ t) (j : Offset s) :
    windowEmbedding m t (windowInclusion s t hst j) = windowEmbedding m s j := by
  simp [windowEmbedding, signedOffset_windowInclusion]

/-- 大窓配位を小窓へ制限する。 -/
def restrictWindow (s t : ℕ) (hst : s ≤ t) (c : Offset t → State) : Offset s → State :=
  fun j => c (windowInclusion s t hst j)

/-- 舞台配位の大窓への引き戻しを小窓へ制限すると、小窓への引き戻しになる。 -/
theorem windowPullback_compatible (m s t : ℕ) (hst : s ≤ t)
    (x : OddStage m → State) :
    restrictWindow s t hst (windowPullback m t x) = windowPullback m s x := by
  funext j
  simp [restrictWindow, windowPullback, windowEmbedding_compatible]

/-- 指定した窓配位を持つ舞台配位の有限繊維。 -/
def WindowFiber (m s : ℕ) (a : Offset s → State) :=
  {x : OddStage m → State // windowPullback m s x = a}

/-- 窓埋め込みの像に入らない舞台セル。 -/
def UnusedCell (m s : ℕ) :=
  {v : OddStage m // v ∉ Set.range (windowEmbedding m s)}

noncomputable instance (m s : ℕ) : DecidableEq (UnusedCell m s) := Classical.decEq _
noncomputable instance (m s : ℕ) : Fintype (UnusedCell m s) := by
  classical
  exact Fintype.ofFinset (p := {v : OddStage m | v ∉ Set.range (windowEmbedding m s)})
    (Finset.univ.filter fun v : OddStage m => v ∉ Set.range (windowEmbedding m s))
    (by simp)
noncomputable instance (m s : ℕ) (a : Offset s → State) : Fintype (WindowFiber m s a) :=
  by
    classical
    exact Fintype.ofFinset (p := {x : OddStage m → State | windowPullback m s x = a})
      (Finset.univ.filter fun x : OddStage m → State => windowPullback m s x = a)
      (by simp)

/-- 窓上では指定値、窓外では自由な指定値を持つ舞台配位。 -/
noncomputable def outsideConfiguration (m s : ℕ) (a : Offset s → State)
    (y : UnusedCell m s → State) (v : OddStage m) : State :=
  if hv : v ∈ Set.range (windowEmbedding m s) then
    a (Classical.choose hv)
  else
    y ⟨v, hv⟩

/-- 窓外の状態指定から、指定した窓配位を持つ舞台配位を復元する。 -/
noncomputable def extendOutsideWindow (m s : ℕ) (hsm : s ≤ m)
    (a : Offset s → State) (y : UnusedCell m s → State) : WindowFiber m s a := by
  refine ⟨outsideConfiguration m s a y, ?_⟩
  funext j
  have hj : windowEmbedding m s j ∈ Set.range (windowEmbedding m s) := ⟨j, rfl⟩
  have hchosen : Classical.choose hj = j :=
    windowEmbedding_injective m s hsm (Classical.choose_spec hj)
  change outsideConfiguration m s a y (windowEmbedding m s j) = a j
  rw [outsideConfiguration, dif_pos hj, hchosen]

/-- 指定した窓配位を持つ舞台配位は、窓外セルへの状態指定と全単射で対応する。 -/
noncomputable def windowFiberEquivOutside (m s : ℕ) (hsm : s ≤ m)
    (a : Offset s → State) : WindowFiber m s a ≃ (UnusedCell m s → State) where
  toFun x v := x.val v.val
  invFun := extendOutsideWindow m s hsm a
  left_inv x := by
    apply Subtype.ext
    funext v
    by_cases hv : v ∈ Set.range (windowEmbedding m s)
    · have hchosen : windowEmbedding m s (Classical.choose hv) = v := Classical.choose_spec hv
      have hx := congrFun x.property (Classical.choose hv)
      simp only [windowPullback] at hx
      change outsideConfiguration m s a (fun u => x.val u.val) v = x.val v
      rw [outsideConfiguration, dif_pos hv]
      exact hx.symm.trans (congrArg x.val hchosen)
    · change outsideConfiguration m s a (fun u => x.val u.val) v = x.val v
      rw [outsideConfiguration, dif_neg hv]
  right_inv y := by
    funext v
    change outsideConfiguration m s a y v.val = y v
    rw [outsideConfiguration, dif_neg v.property]
    exact congrArg y (Subtype.ext rfl)

/-- 窓外セルの個数は舞台セル数から窓セル数を引いた `2(m-s)` である。 -/
theorem unusedCell_card (m s : ℕ) (hsm : s ≤ m) :
    Fintype.card (UnusedCell m s) = 2 * (m - s) := by
  have hf : Function.Injective (windowEmbedding m s) := windowEmbedding_injective m s hsm
  have hrange : Fintype.card {v : OddStage m // v ∈ Set.range (windowEmbedding m s)} =
      Fintype.card (Offset s) := by
    exact (Fintype.card_congr (Equiv.ofInjective (windowEmbedding m s) hf)).symm
  unfold UnusedCell
  rw [Fintype.card_subtype_compl, hrange, oddStage_card, Fintype.card_fin]
  omega

/-- 窓配位を固定した引き戻しの繊維は `2^(2(m-s))` 個である。 -/
theorem windowPullback_fiber_card (m s : ℕ) (hsm : s ≤ m)
    (a : Offset s → State) :
    Fintype.card (WindowFiber m s a) = 2 ^ (2 * (m - s)) := by
  rw [Fintype.card_congr (windowFiberEquivOutside m s hsm a), Fintype.card_fun,
    card_state, unusedCell_card m s hsm]

/-- 一様分布の有限窓周辺確率は舞台の大きさに依らず `1/2^(2s+1)` である。 -/
theorem marginalWeight_formula (m s : ℕ) (hsm : s ≤ m) (a : Offset s → State) :
    marginalWeight m s a = 1 / (2 ^ (2 * s + 1) : ℕ) := by
  classical
  simp only [marginalWeight, uniformWeight]
  rw [← Finset.sum_filter]
  simp only [Finset.sum_const, nsmul_eq_mul, Finset.card_filter]
  have hcount : (∑ x : OddStage m → State, if windowPullback m s x = a then 1 else 0) =
      Fintype.card (WindowFiber m s a) := by
    let fiberTable := Finset.univ.filter fun x : OddStage m → State => windowPullback m s x = a
    have hfcard : Fintype.card (WindowFiber m s a) = fiberTable.card := by
      exact Fintype.card_ofFinset
        (p := {x : OddStage m → State | windowPullback m s x = a}) fiberTable (by
          simp [fiberTable])
    rw [hfcard]
    simp [fiberTable]
  rw [hcount]
  rw [windowPullback_fiber_card m s hsm a]
  rw [show 2 * m + 1 = 2 * (m - s) + (2 * s + 1) by omega, pow_add]
  field_simp
  norm_num

/-- 大窓周辺分布を小窓へ再周辺化すると、小窓周辺分布に一致する。 -/
theorem marginalWeight_consistent (m s t : ℕ) (hst : s ≤ t) (_htm : t ≤ m)
    (a : Offset s → State) :
    marginalWeight m s a =
      ∑ c : Offset t → State,
        if restrictWindow s t hst c = a then marginalWeight m t c else 0 := by
  classical
  unfold marginalWeight
  symm
  calc
    (∑ c : Offset t → State,
        if restrictWindow s t hst c = a then
          ∑ x : OddStage m → State,
            if windowPullback m t x = c then uniformWeight m x else 0
        else 0) =
        ∑ c : Offset t → State, ∑ x : OddStage m → State,
          if restrictWindow s t hst c = a then
            (if windowPullback m t x = c then uniformWeight m x else 0)
          else 0 := by
      apply Finset.sum_congr rfl
      intro c _hc
      rw [Finset.sum_ite_irrel]
      simp
    _ = ∑ x : OddStage m → State, ∑ c : Offset t → State,
          if restrictWindow s t hst c = a then
            (if windowPullback m t x = c then uniformWeight m x else 0)
          else 0 := by
      rw [Finset.sum_comm]
    _ = ∑ x : OddStage m → State,
          if windowPullback m s x = a then uniformWeight m x else 0 := by
      apply Finset.sum_congr rfl
      intro x _hx
      have hcompat := windowPullback_compatible m s t hst x
      have hsingle :
          (∑ c : Offset t → State,
            if restrictWindow s t hst c = a then
              (if windowPullback m t x = c then uniformWeight m x else 0)
            else 0) =
            if restrictWindow s t hst (windowPullback m t x) = a then
              uniformWeight m x
            else 0 := by
        rw [Finset.sum_eq_single (windowPullback m t x)]
        · simp
        · intro c _hc hne
          have hne' : windowPullback m t x ≠ c := Ne.symm hne
          simp [hne']
        · simp
      rw [hsingle, hcompat]

end

end CellularAutomata.CyclicStageUniformMarginals
