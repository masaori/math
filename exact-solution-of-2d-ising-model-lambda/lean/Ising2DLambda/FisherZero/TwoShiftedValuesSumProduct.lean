/-
人手証明の主張「有限集合の元の個数より一つ多い自然数を写すと、二つの自然数が同じ元へ行く」
（ラベル `claim_pigeonhole_one_more_than_cardinality`）、
「二つの整数倍のずらしの値が部分体に入れば積も入る」（ラベル `claim_two_shifted_values_determine_product`）、
「二つの整数倍のずらしの値が部分体に入れば和と積も入る」（ラベル `claim_two_shifted_values_determine_sum_and_product`）
の具体版。

住処: 鳩の巣は N。和と積は Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SubfieldCoefficientPolynomials

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_pigeonhole_one_more_than_cardinality` の具体版。`ℕ_{<|P|+1}` を `Fin (Fintype.card P + 1)` で表す。
人手証明: 結論が成り立たないと仮定すると `φ` は単射（相異なる二元は大小のどちらかで並ぶ）。
単射写像は有限集合の元の個数を保つので像の元の個数は `|P|+1`。像は `P` の部分集合なので `|P|` 以下。矛盾。 -/
theorem pigeonhole_one_more_than_cardinality {P : Type*} [Fintype P] [DecidableEq P]
    (φ : Fin (Fintype.card P + 1) → P) :
    ∃ c c' : Fin (Fintype.card P + 1), c < c' ∧ φ c = φ c' := by
  by_contra hno
  simp only [not_exists, not_and] at hno
  -- 相異なる二元は大小のどちらかで並ぶので、φ は単射
  have hinj : Function.Injective φ := by
    intro c c' hcc'
    by_contra hne
    rcases lt_or_gt_of_ne hne with hlt | hgt
    · exact hno c c' hlt hcc'
    · exact hno c' c hgt hcc'.symm
  -- 像の元の個数 = 定義域の元の個数 = |P| + 1
  have himage : (Finset.univ.image φ).card = Fintype.card P + 1 := by
    rw [Finset.card_image_of_injective _ hinj, Finset.card_univ, Fintype.card_fin]
  -- 像は P の部分集合なので元の個数は |P| 以下
  have hsub : (Finset.univ.image φ).card ≤ Fintype.card P := by
    exact (Finset.card_le_card (Finset.subset_univ _)).trans_eq Finset.card_univ
  omega

/-- `claim_two_shifted_values_determine_product` の具体版。
人手証明の式鎖: `αβ = ((c-c')αβ)/(c-c') = (u-u')/(c-c') ∈ F`。 -/
theorem mul_mem_of_two_shifted_mem (F : Subfield Qbar) (α β : Qbar) (c c' : ℤ) (hcc' : c ≠ c')
    (hu : α + β + (c : Qbar) * (α * β) ∈ F) (hu' : α + β + (c' : Qbar) * (α * β) ∈ F) :
    α * β ∈ F := by
  -- 準備: 整数 c - c' は零でなく、その像も零でない（有理数の包含は単射）
  have hne : ((c - c' : ℤ) : Qbar) ≠ 0 := by
    exact_mod_cast sub_ne_zero.mpr hcc'
  -- 式鎖
  have hchain : α * β
      = ((α + β + (c : Qbar) * (α * β)) - (α + β + (c' : Qbar) * (α * β))) / ((c - c' : ℤ) : Qbar) := by
    calc α * β = ((c - c' : ℤ) : Qbar) * (α * β) / ((c - c' : ℤ) : Qbar) := by
            rw [mul_div_cancel_left₀ _ hne]
      _ = ((α + β + (c : Qbar) * (α * β)) - (α + β + (c' : Qbar) * (α * β))) / ((c - c' : ℤ) : Qbar) := by
            push_cast; ring
  rw [hchain]
  -- 所属: u, u' ∈ F、c - c' ∈ F（`claim_subfield_contains_rationals`）、差と商で閉じる
  exact F.div_mem (F.sub_mem hu hu') (intCast_mem_subfield F (c - c'))

/-- `claim_two_shifted_values_determine_sum_and_product` の具体版。
積は `mul_mem_of_two_shifted_mem`、和は `α+β = u - c·αβ ∈ F`。 -/
theorem add_mem_and_mul_mem_of_two_shifted_mem (F : Subfield Qbar) (α β : Qbar) (c c' : ℤ)
    (hcc' : c ≠ c')
    (hu : α + β + (c : Qbar) * (α * β) ∈ F) (hu' : α + β + (c' : Qbar) * (α * β) ∈ F) :
    α + β ∈ F ∧ α * β ∈ F := by
  have hmul : α * β ∈ F := mul_mem_of_two_shifted_mem F α β c c' hcc' hu hu'
  have hchain : α + β = (α + β + (c : Qbar) * (α * β)) - (c : Qbar) * (α * β) := by ring
  refine ⟨?_, hmul⟩
  rw [hchain]
  exact F.sub_mem hu (F.mul_mem (intCast_mem_subfield F c) hmul)

end Ising2DLambda.FisherZero
