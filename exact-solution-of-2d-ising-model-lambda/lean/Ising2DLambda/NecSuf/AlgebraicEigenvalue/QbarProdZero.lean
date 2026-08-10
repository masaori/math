/-
主張「代数的数の有限積が 0 ならば、0 である因子がある」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarProdZero`）と同じである
（元の個数についての帰納法。出発点は空の積が 1 ≠ 0 であること、一歩は因子を 1 つ括り出し、
`c a ≠ 0` の場合に逆元を掛けて残りの積が 0 であることを出す 5 段の鎖）。

  使っている性質            なぜ削れないか
  `CommMonoidWithZero M`    有限積 `∏ i ∈ s, c i` が定義されるのに要る（積の可換性と
                            結合則、単位元、零元との積 `mul_zero`）。
  零元でない元の逆元        鎖の第 2 段で `(c a)⁻¹ * c a = 1` を使う。
  `1 ≠ 0`（Nontrivial）     出発点で「空の積が 0 になることはない」と言うのに要る。
  以上をまとめた `GroupWithZero` を可換にしたもの＝`CommGroupWithZero M`。

削れたもの: 加法・分配則・体であること・代数閉であること・値が代数的数であること
（すなわち `Qbar` であること）・添字の型の有限性・標数。
すなわちこの段は**足し算を一度も使っていない**。零因子が無いことを仮定として置く代わりに、
逆元から導いている（具体版と同じ手順にするため。`NoZeroDivisors` を仮定に置くと
手順が変わる）。

住処: ここに ℝ / ℂ は現れない（値は一般の可換群に零元を添えたもの）。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.GroupWithZero.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版の本体。可換群に零元を添えた構造で、有限積が零元ならば零元である因子がある。 -/
theorem exists_eq_zero_of_prod_eq_zero_necSuf {M : Type*} [CommGroupWithZero M]
    {β : Type*} [DecidableEq β] (c : β → M) :
    ∀ s : Finset β, (∏ i ∈ s, c i) = 0 → ∃ i ∈ s, c i = 0 := by
  intro s
  induction s using Finset.cons_induction with
  | empty =>
      intro h
      rw [Finset.prod_empty] at h
      exact absurd h one_ne_zero
  | cons a s ha ih =>
      intro h
      rw [Finset.prod_cons] at h
      by_cases hca : c a = 0
      · exact ⟨a, Finset.mem_cons_self a s, hca⟩
      · have hs : (∏ i ∈ s, c i) = 0 :=
          calc (∏ i ∈ s, c i)
              = 1 * ∏ i ∈ s, c i := by rw [one_mul]
            _ = ((c a)⁻¹ * c a) * ∏ i ∈ s, c i := by rw [inv_mul_cancel₀ hca]
            _ = (c a)⁻¹ * (c a * ∏ i ∈ s, c i) := by rw [mul_assoc]
            _ = (c a)⁻¹ * 0 := by rw [h]
            _ = 0 := by rw [mul_zero]
        obtain ⟨i, hi, hci⟩ := ih hs
        exact ⟨i, Finset.mem_cons_of_mem hi, hci⟩

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
