/-
章「固有値の代数性」の「代数的数の有限積が 0 ならば、0 である因子がある」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_prod_eq_zero`）に対応する。

  人手証明                                   このファイル
  空の積は単位元、1 ≠ 0                      Finset.prod_empty と one_ne_zero
  有限積から因子を 1 つ括り出す              Finset.prod_cons
  c_a ≠ 0 のとき逆元を取る                   inv_mul_cancel₀
  5 段の鎖（1 を掛ける → 逆元を差し込む      calc の 5 段
    → 結合則 → 仮定を代入 → 零元との積）
  帰納法の仮定                               ih

mathlib の `Finset.prod_eq_zero_iff`（有限積が零になるための必要十分条件）へは
委ねていない。使ったのは空の積・因子の括り出し・逆元・結合則・零元との積だけである。

住処: 人手証明のこのブロックは Qbar を宣言している。ここに ℝ / ℂ は現れない
（値は ℚ の代数閉包の元）。
-/
import Ising2DLambda.AlgebraicEigenvalue.SecondEvaluationProd

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の主張（`claim_qbar_prod_eq_zero`）。`s` の元の個数についての帰納法。 -/
theorem exists_eq_zero_of_prod_eq_zero {β : Type*} [DecidableEq β] (c : β → Qbar) :
    ∀ s : Finset β, (∏ i ∈ s, c i) = 0 → ∃ i ∈ s, c i = 0 := by
  intro s
  induction s using Finset.cons_induction with
  | empty =>
      -- 出発点。空の積は単位元 1 であり、Qbar は体なので 1 ≠ 0。仮定を満たす写像が無い。
      intro h
      rw [Finset.prod_empty] at h
      exact absurd h one_ne_zero
  | cons a s ha ih =>
      intro h
      -- 有限積から因子を 1 つ括り出す（人手証明の第 1 の鎖）。
      rw [Finset.prod_cons] at h
      by_cases hca : c a = 0
      · -- c_a = 0 の場合。i_0 = a と取る。
        exact ⟨a, Finset.mem_cons_self a s, hca⟩
      · -- c_a ≠ 0 の場合。逆元を掛けて残りの積が 0 であることを出す（人手証明の第 2 の鎖）。
        have hs : (∏ i ∈ s, c i) = 0 :=
          calc (∏ i ∈ s, c i)
              = 1 * ∏ i ∈ s, c i := by rw [one_mul]
            _ = ((c a)⁻¹ * c a) * ∏ i ∈ s, c i := by rw [inv_mul_cancel₀ hca]
            _ = (c a)⁻¹ * (c a * ∏ i ∈ s, c i) := by rw [mul_assoc]
            _ = (c a)⁻¹ * 0 := by rw [h]
            _ = 0 := by rw [mul_zero]
        obtain ⟨i, hi, hci⟩ := ih hs
        exact ⟨i, Finset.mem_cons_of_mem hi, hci⟩

end Ising2DLambda.AlgebraicEigenvalue
