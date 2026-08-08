/-
人手証明の主張「多重度の総和は配位の総数に等しい」（ラベル `claim_coefficient_sum`）の具体版。

人手証明の Step とこのファイルの対応:

  Step 1（多重度の定義を配位の類別として読む）  brokenFiber / multiplicity_eq_card_brokenFiber
  Step 2（類別であること）                      biUnion_brokenFiber（被覆）
                                                brokenFiber_pairwise_disjoint（互いに素）
  Step 3（有限集合の分割の元の個数）            card_univ_eq_sum_multiplicity
  Step 4（配位の総数）                          Basic.card_config
  Step 5（結論）                                multiplicity_sum_eq_two_pow

Step 3 が使う「互いに素な有限個の有限集合の合併の元の個数は各集合の元の個数の和」は
人手証明が明示的に適用している定理そのものなので、mathlib の `Finset.card_biUnion` を引く。
一方、Step 2（各配位がちょうど 1 つの類に属すること）を一般論へ委ねてはならないので、
被覆と互いに素であることは自分で示す（`Finset.card_eq_sum_card_fiberwise` は
Step 2 と Step 3 を一度に済ませてしまうため使わない）。

住処: 人手証明のこのブロックは ℕ を宣言している。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.PartitionPolynomial.Basic

namespace Ising2DLambda.PartitionPolynomial

open Finset

variable (L : ℕ) [NeZero L]

/-- Step 1。人手証明の `A_m = {σ ∈ Σ_L | b(σ) = m}`。 -/
def brokenFiber (m : ℕ) : Finset (Config L) :=
  univ.filter fun σ => brokenBondCount L σ = m

/-- Step 1。多重度は `A_m` の元の個数である（多重度の定義そのもの）。 -/
lemma multiplicity_eq_card_brokenFiber (m : ℕ) :
    multiplicity L m = (brokenFiber L m).card := rfl

/-- Step 2（被覆）。各配位 `σ` は `b(σ)` の類に属し、`b(σ) ≤ 2L²` なので
添字は `{0,1,…,2L²}` の中に収まる。 -/
lemma biUnion_brokenFiber :
    (range (2 * L ^ 2 + 1)).biUnion (brokenFiber L) = (univ : Finset (Config L)) := by
  apply eq_univ_of_forall
  intro σ
  simp only [mem_biUnion, mem_range, brokenFiber, mem_filter, mem_univ, true_and]
  exact ⟨brokenBondCount L σ, Nat.lt_succ_of_le (brokenBondCount_le L σ), rfl⟩

/-- Step 2（互いに素）。`b(σ)` は写像なのでただ 1 つの値をとる。
したがって異なる `m` の類は共通の配位を持たない。 -/
lemma brokenFiber_pairwise_disjoint :
    ∀ m ∈ range (2 * L ^ 2 + 1), ∀ m' ∈ range (2 * L ^ 2 + 1), m ≠ m' →
      Disjoint (brokenFiber L m) (brokenFiber L m') := by
  intro m _ m' _ hne
  refine disjoint_left.mpr ?_
  intro σ hm hm'
  simp only [brokenFiber, mem_filter] at hm hm'
  exact hne (hm.2.symm.trans hm'.2)

/-- Step 3。互いに素な有限個の有限集合の合併の元の個数は、各集合の元の個数の和である。 -/
lemma card_univ_eq_sum_multiplicity :
    (univ : Finset (Config L)).card = ∑ m ∈ range (2 * L ^ 2 + 1), multiplicity L m := by
  rw [← biUnion_brokenFiber L, card_biUnion (brokenFiber_pairwise_disjoint L)]
  -- 各項は Step 1 により多重度そのものである。
  exact Finset.sum_congr rfl fun m _ => (multiplicity_eq_card_brokenFiber L m).symm

/-- Step 5（結論）。Step 3 の左辺へ Step 4（`Basic.card_config`）を代入する。 -/
theorem multiplicity_sum_eq_two_pow :
    ∑ m ∈ range (2 * L ^ 2 + 1), multiplicity L m = 2 ^ L ^ 2 := by
  rw [← card_univ_eq_sum_multiplicity L, card_univ, card_config]

end Ising2DLambda.PartitionPolynomial
