/-
人手証明の主張「多重度の総和は配位の総数に等しい」（ラベル `claim_coefficient_sum`）の具体版。

人手証明は 3 つの等号からなる一続きの式である。その各等号とこのファイルの対応:

  第 1 の等号（多重度の定義）        brokenFiber / multiplicity_eq_card_brokenFiber
  第 2 の等号（配位全体の類別）      card_univ_eq_sum_multiplicity
                                     （その根拠が biUnion_brokenFiber と
                                       brokenFiber_pairwise_disjoint）
  第 3 の等号（配位の定義）          Basic.card_config
  式全体（主張そのもの）             multiplicity_sum_eq_two_pow

第 2 の等号が引く被覆と互いに素性は、人手証明では独立した主張
「配位全体は破れボンド数の値ごとに類別される」（ラベル `claim_configuration_partition`）である。
Lean 側でもこの 2 つの補題（`biUnion_brokenFiber` / `brokenFiber_pairwise_disjoint`）が
その主張の具体版にあたり、主張「分配多項式の係数は多重度である」の具体版からも引いている。

第 2 の等号が使う「互いに素な有限個の有限集合の合併の元の個数は各集合の元の個数の和」は
人手証明が明示的に適用している定理そのものなので、mathlib の `Finset.card_biUnion` を引く。
一方、各配位がちょうど 1 つの類に属することを一般論へ委ねてはならないので、
被覆と互いに素であることは自分で示す（`Finset.card_eq_sum_card_fiberwise` は
この 2 つを一度に済ませてしまうため使わない）。

住処: 人手証明のこのブロックは ℕ を宣言している。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.PartitionPolynomial.Basic

namespace Ising2DLambda.PartitionPolynomial

open Finset

variable (L : ℕ) [NeZero L]

/-- 第 1 の等号。人手証明の `A_{L,m} = {σ ∈ Σ_L | b(σ) = m}`。 -/
def brokenFiber (m : ℕ) : Finset (Config L) :=
  univ.filter fun σ => brokenBondCount L σ = m

/-- 第 1 の等号。多重度は `A_{L,m}` の元の個数である（多重度の定義そのもの）。 -/
lemma multiplicity_eq_card_brokenFiber (m : ℕ) :
    multiplicity L m = (brokenFiber L m).card := rfl

/-- 類別（被覆）。各配位 `σ` は `b(σ)` の類に属し、`b(σ) ≤ 2L²` なので
添字は `{0,1,…,2L²}` の中に収まる。 -/
lemma biUnion_brokenFiber :
    (range (2 * L ^ 2 + 1)).biUnion (brokenFiber L) = (univ : Finset (Config L)) := by
  apply eq_univ_of_forall
  intro σ
  simp only [mem_biUnion, mem_range, brokenFiber, mem_filter, mem_univ, true_and]
  exact ⟨brokenBondCount L σ, Nat.lt_succ_of_le (brokenBondCount_le L σ), rfl⟩

/-- 類別（互いに素）。`b(σ)` は写像なのでただ 1 つの値をとる。
したがって異なる `m` の類は共通の配位を持たない。 -/
lemma brokenFiber_pairwise_disjoint :
    ∀ m ∈ range (2 * L ^ 2 + 1), ∀ m' ∈ range (2 * L ^ 2 + 1), m ≠ m' →
      Disjoint (brokenFiber L m) (brokenFiber L m') := by
  intro m _ m' _ hne
  refine disjoint_left.mpr ?_
  intro σ hm hm'
  simp only [brokenFiber, mem_filter] at hm hm'
  exact hne (hm.2.symm.trans hm'.2)

/-- 第 2 の等号。互いに素な有限個の有限集合の合併の元の個数は、各集合の元の個数の和である。 -/
lemma card_univ_eq_sum_multiplicity :
    (univ : Finset (Config L)).card = ∑ m ∈ range (2 * L ^ 2 + 1), multiplicity L m := by
  rw [← biUnion_brokenFiber L, card_biUnion (brokenFiber_pairwise_disjoint L)]
  -- 各項は第 1 の等号により多重度そのものである。
  exact Finset.sum_congr rfl fun m _ => (multiplicity_eq_card_brokenFiber L m).symm

/-- 主張そのもの。第 2 の等号の左辺へ第 3 の等号（`Basic.card_config`）を代入する。 -/
theorem multiplicity_sum_eq_two_pow :
    ∑ m ∈ range (2 * L ^ 2 + 1), multiplicity L m = 2 ^ L ^ 2 := by
  rw [← card_univ_eq_sum_multiplicity L, card_univ, card_config]

end Ising2DLambda.PartitionPolynomial
