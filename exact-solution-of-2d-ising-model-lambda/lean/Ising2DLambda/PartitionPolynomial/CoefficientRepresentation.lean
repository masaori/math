/-
人手証明の主張「分配多項式の係数は多重度である」（ラベル `claim_coefficient_representation`）の具体版。

人手証明の Step とこのファイルの対応:

  Step 1（多重度の定義を配位の類別として読む）  CoefficientSum.brokenFiber
                                                CoefficientSum.multiplicity_eq_card_brokenFiber
  Step 2（類別であること）                      CoefficientSum.biUnion_brokenFiber（被覆）
                                                brokenFiber_pairwiseDisjoint（互いに素）
  Step 3（和を類ごとに束ねる）                  Finset.sum_biUnion
  Step 4（1 つの類の中では単項式が共通）        sum_brokenFiber_monomial
  Step 5（結論）                                partitionPolynomial_eq_sum_multiplicity

Step 2 は主張「多重度の総和は配位の総数に等しい」の具体版で既に自分で示してある
（被覆と互いに素性）。同じ類別を使うので引き写さずにそれを引く。
Step 3 が使う「互いに素な有限個の有限集合の合併の上の和は、各集合の上の和の和」は
人手証明が明示的に適用している定理そのものなので、mathlib の `Finset.sum_biUnion` を引く。

住処: 人手証明のこのブロックは ℤ[x] を宣言している。ここに ℝ / ℂ は現れない
（係数は `ℤ`、多項式は `Polynomial ℤ`、指数は `ℕ`）。
-/
import Ising2DLambda.PartitionPolynomial.CoefficientSum

namespace Ising2DLambda.PartitionPolynomial

open Finset

variable (L : ℕ) [NeZero L]

/-- Step 2（互いに素）を `Finset.sum_biUnion` が要求する形へ言い換えたもの。
中身は主張「多重度の総和は配位の総数に等しい」で示した `brokenFiber_pairwise_disjoint`
そのものであり、新しい数学は入っていない。 -/
lemma brokenFiber_pairwiseDisjoint :
    (↑(range (2 * L ^ 2 + 1)) : Set ℕ).PairwiseDisjoint (brokenFiber L) := by
  intro m hm m' hm' hne
  exact brokenFiber_pairwise_disjoint L m (by simpa using hm) m' (by simpa using hm') hne

/-- Step 4。1 つの類 `A_m` の中では `b(σ) = m` なので、足し合わせる単項式はどれも `x^m` に等しい。
したがって類の上の和は `x^m` を `|A_m| = Ω_L(m)` 個足したものになる。 -/
lemma sum_brokenFiber_monomial (m : ℕ) :
    ∑ σ ∈ brokenFiber L m, (Polynomial.X : Polynomial ℤ) ^ brokenBondCount L σ
      = Polynomial.C (multiplicity L m : ℤ) * Polynomial.X ^ m := by
  -- 類の元 σ は b(σ) = m を満たすので、各項を x^m へ書き換える。
  have hterm : ∀ σ ∈ brokenFiber L m,
      (Polynomial.X : Polynomial ℤ) ^ brokenBondCount L σ = Polynomial.X ^ m := by
    intro σ hσ
    simp only [brokenFiber, mem_filter] at hσ
    rw [hσ.2]
  rw [sum_congr rfl hterm, sum_const]
  -- 同じ元を `|A_m|` 個足したものは `|A_m| • x^m`。Step 1 によりこの個数が多重度である。
  rw [multiplicity_eq_card_brokenFiber, nsmul_eq_mul]
  simp

/-- Step 5（結論）。分配多項式の `x^m` の係数は多重度 `Ω_L(m)` である。 -/
theorem partitionPolynomial_eq_sum_multiplicity :
    partitionPolynomial L
      = ∑ m ∈ range (2 * L ^ 2 + 1),
          Polynomial.C (multiplicity L m : ℤ) * Polynomial.X ^ m := by
  -- Step 2（被覆）: 配位全体を破れボンド数の値ごとの類の合併として書き直す。
  rw [partitionPolynomial, ← biUnion_brokenFiber L]
  -- Step 3: 互いに素なので、合併の上の和は各類の上の和の和になる。
  rw [sum_biUnion (brokenFiber_pairwiseDisjoint L)]
  -- Step 4: 各類の上の和を計算する。
  exact sum_congr rfl fun m _ => sum_brokenFiber_monomial L m

end Ising2DLambda.PartitionPolynomial
