/-
正本: structured-latex/content/cyclic-stage-uniform-conditional-kernel.ts の具体版。

人手証明のブロックとこのファイルの対応:
  def_cyclic_stage_window_image
    `WindowImage`
  claim_cyclic_stage_window_image_cardinality
    `windowImage_card`
  def_cyclic_stage_outside_agreement
    `outsideAgrees`
  def_cyclic_stage_uniform_conditional_kernel
    `conditionalKernel`
  claim_cyclic_stage_uniform_conditional_kernel_normalized
    `outsideAgreementClass_card`, `conditionalKernel_normalized`
  theorem_cyclic_stage_uniform_conditional_kernel_invariance
    `uniformWeight_conditionalKernel_invariant`

奇数位数の有限巡回舞台、半径 s の整数窓、二元状態、一様有理分布に
固定し、人手証明と同じ順序で窓外一致類の元数、核の正規化、一様分布の
固定点等式を形式化する。除算は正の二冪を分母とする有理数内だけで使う。
無限舞台の全配位、Gibbs 仕様、条件付き期待値、極限、実数体、複素数体は使わない。
-/
import CellularAutomata.CyclicStageUniformMarginals
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Pi
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum

namespace CellularAutomata.CyclicStageUniformConditionalKernel

open CellularAutomata.CyclicRuleRestriction
open CellularAutomata.CyclicStageUniformMarginals
open CellularAutomata.EssentialDependency
open scoped BigOperators

noncomputable section

/-- 有限巡回舞台内の有限窓の像。 -/
def WindowImage (m s : ℕ) :=
  {v : OddStage m // v ∈ Set.range (windowEmbedding m s)}

noncomputable instance (m s : ℕ) : Fintype (WindowImage m s) := by
  classical
  exact Fintype.ofFinset (p := {v : OddStage m | v ∈ Set.range (windowEmbedding m s)})
    (Finset.univ.filter fun v : OddStage m => v ∈ Set.range (windowEmbedding m s))
    (by simp)

/-- `s ≤ m` なら窓の像は `2s+1` 個のセルを持つ。 -/
theorem windowImage_card (m s : ℕ) (hsm : s ≤ m) :
    Fintype.card (WindowImage m s) = 2 * s + 1 := by
  let imageEquiv : WindowImage m s ≃ Offset s :=
    {
      toFun := fun v => Classical.choose v.property
      invFun := fun j => ⟨windowEmbedding m s j, ⟨j, rfl⟩⟩
      left_inv := by
        intro v
        exact Subtype.ext (Classical.choose_spec v.property)
      right_inv := by
        intro j
        have hj : windowEmbedding m s j ∈ Set.range (windowEmbedding m s) := ⟨j, rfl⟩
        exact windowEmbedding_injective m s hsm (Classical.choose_spec hj)
    }
  rw [Fintype.card_congr imageEquiv, Fintype.card_fin]

/-- 二つの舞台配位が有限窓の外側で一致する有限述語。 -/
def outsideAgrees (m s : ℕ) (source target : OddStage m → State) : Prop :=
  ∀ v : UnusedCell m s, source v.val = target v.val

noncomputable instance (m s : ℕ) (source target : OddStage m → State) :
    Decidable (outsideAgrees m s source target) := Classical.propDecidable _

/-- 固定した入力配位と窓外で一致する配位の有限型。 -/
def OutsideAgreementClass (m s : ℕ) (source : OddStage m → State) :=
  {target : OddStage m → State // outsideAgrees m s source target}

noncomputable instance (m s : ℕ) (source : OddStage m → State) :
    Fintype (OutsideAgreementClass m s source) := by
  classical
  exact Fintype.ofFinset
    (p := {target : OddStage m → State | outsideAgrees m s source target})
    (Finset.univ.filter fun target : OddStage m → State => outsideAgrees m s source target)
    (by simp)

/-- 窓上では指定値、窓外では入力配位の値を持つ舞台配位。 -/
noncomputable def replaceInside (m s : ℕ) (source : OddStage m → State)
    (a : Offset s → State) (v : OddStage m) : State :=
  if hv : v ∈ Set.range (windowEmbedding m s) then
    a (Classical.choose hv)
  else
    source v

/-- 窓配位から、入力と窓外で一致する舞台配位を復元する。 -/
noncomputable def extendInside (m s : ℕ) (_hsm : s ≤ m)
    (source : OddStage m → State) (a : Offset s → State) :
    OutsideAgreementClass m s source := by
  refine ⟨replaceInside m s source a, ?_⟩
  intro v
  rw [replaceInside, dif_neg v.property]

/-- 窓外一致類は、窓内の二元配位と全単射で対応する。 -/
noncomputable def outsideAgreementClassEquiv (m s : ℕ) (hsm : s ≤ m)
    (source : OddStage m → State) :
    OutsideAgreementClass m s source ≃ (Offset s → State) where
  toFun target := windowPullback m s target.val
  invFun := extendInside m s hsm source
  left_inv target := by
    apply Subtype.ext
    funext v
    by_cases hv : v ∈ Set.range (windowEmbedding m s)
    · have hchosen : windowEmbedding m s (Classical.choose hv) = v := Classical.choose_spec hv
      change replaceInside m s source (windowPullback m s target.val) v = target.val v
      rw [replaceInside, dif_pos hv]
      exact congrArg target.val hchosen
    · change replaceInside m s source (windowPullback m s target.val) v = target.val v
      rw [replaceInside, dif_neg hv]
      exact target.property ⟨v, hv⟩
  right_inv a := by
    funext j
    have hj : windowEmbedding m s j ∈ Set.range (windowEmbedding m s) := ⟨j, rfl⟩
    have hchosen : Classical.choose hj = j :=
      windowEmbedding_injective m s hsm (Classical.choose_spec hj)
    change replaceInside m s source a (windowEmbedding m s j) = a j
    rw [replaceInside, dif_pos hj, hchosen]

/-- 固定した入力配位の窓外一致類は `2^(2s+1)` 個である。 -/
theorem outsideAgreementClass_card (m s : ℕ) (hsm : s ≤ m)
    (source : OddStage m → State) :
    Fintype.card (OutsideAgreementClass m s source) = 2 ^ (2 * s + 1) := by
  rw [Fintype.card_congr (outsideAgreementClassEquiv m s hsm source), Fintype.card_fun,
    card_state, Fintype.card_fin]

/-- 有限窓内だけを一様に再標本化する有理遷移核。 -/
noncomputable def conditionalKernel (m s : ℕ) (source target : OddStage m → State) : ℚ := by
  classical
  exact if outsideAgrees m s source target then 1 / (2 ^ (2 * s + 1) : ℕ) else 0

/-- 窓外一致類を数えるフィルタの元数。 -/
theorem outsideAgrees_filter_card (m s : ℕ) (hsm : s ≤ m)
    (source : OddStage m → State) :
    (Finset.univ.filter fun target : OddStage m → State =>
      outsideAgrees m s source target).card = 2 ^ (2 * s + 1) := by
  classical
  let agreementTable := Finset.univ.filter fun target : OddStage m → State =>
    outsideAgrees m s source target
  have hcard : Fintype.card (OutsideAgreementClass m s source) = agreementTable.card := by
    exact Fintype.card_ofFinset
      (p := {target : OddStage m → State | outsideAgrees m s source target})
      agreementTable (by simp [agreementTable])
  rw [← hcard, outsideAgreementClass_card m s hsm source]

/-- 有限窓内の一様条件付き再標本化核の各行は一に和を取る。 -/
theorem conditionalKernel_normalized (m s : ℕ) (hsm : s ≤ m)
    (source : OddStage m → State) :
    ∑ target : OddStage m → State, conditionalKernel m s source target = 1 := by
  classical
  simp only [conditionalKernel]
  rw [← Finset.sum_filter]
  simp only [Finset.sum_const, nsmul_eq_mul]
  rw [outsideAgrees_filter_card m s hsm source]
  field_simp

/-- 窓外一致は二つの配位の交換で保たれる。 -/
theorem outsideAgrees_comm (m s : ℕ) (source target : OddStage m → State) :
    outsideAgrees m s source target ↔ outsideAgrees m s target source := by
  constructor <;> intro h v <;> exact (h v).symm

/-- 有限舞台の一様有理分布は、条件付き再標本化核の作用で不変である。 -/
theorem uniformWeight_conditionalKernel_invariant (m s : ℕ) (hsm : s ≤ m)
    (target : OddStage m → State) :
    ∑ source : OddStage m → State,
        uniformWeight m source * conditionalKernel m s source target = uniformWeight m target := by
  classical
  have hcolumn :
      (∑ source : OddStage m → State, conditionalKernel m s source target) = 1 := by
    calc
      (∑ source : OddStage m → State, conditionalKernel m s source target) =
          ∑ source : OddStage m → State, conditionalKernel m s target source := by
            apply Finset.sum_congr rfl
            intro source _hsource
            by_cases h : outsideAgrees m s source target
            · have h' : outsideAgrees m s target source :=
                (outsideAgrees_comm m s source target).mp h
              simp [conditionalKernel, h, h']
            · have h' : ¬ outsideAgrees m s target source := by
                intro htarget
                exact h ((outsideAgrees_comm m s source target).mpr htarget)
              simp [conditionalKernel, h, h']
      _ = 1 := conditionalKernel_normalized m s hsm target
  simp only [uniformWeight]
  rw [← Finset.mul_sum, hcolumn, mul_one]

end

end CellularAutomata.CyclicStageUniformConditionalKernel
