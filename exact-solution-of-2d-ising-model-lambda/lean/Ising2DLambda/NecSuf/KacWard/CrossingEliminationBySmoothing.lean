/-
「横断数の整礎帰納は閉歩道を横断のない有限族へ分ける」の必要十分版。
辺・格子・横断は使わず、対象の型、自然数の測度、整数の量、二つの自然数の量と、
「測度が正なら二つに分けられ、測度の和が真に減り、整数の量は和で、
二つの自然数の量は法 2 で保存される」という一歩の分割だけを仮定する。
測度の狭義減少は帰納の整礎性そのものであり、削ると帰納が回らないため必要である。
保存則の三つは結論の三つの等式に一対一に対応し、どれを削っても対応する結論が立たない。
-/
import Mathlib.Data.Int.Basic
import Mathlib.Data.List.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 測度が正である限り、和が真に減り三つの量を保存する二分割を繰り返すと、
測度が零の元だけからなる空でない有限列に達し、整数の量の総和と
二つの自然数の量の総和の法 2 が保たれる。 -/
theorem crossing_elimination_by_smoothing_necSuf {α : Type}
    (measure : α → ℕ) (turning : α → ℤ) (hor ver : α → ℕ)
    (step : ∀ a : α, 0 < measure a → ∃ b c : α,
      measure b + measure c < measure a ∧
      turning b + turning c = turning a ∧
      (hor b + hor c) % 2 = hor a % 2 ∧
      (ver b + ver c) % 2 = ver a % 2) :
    ∀ a : α, ∃ family : List α,
      family ≠ [] ∧
      (∀ x ∈ family, measure x = 0) ∧
      (family.map turning).sum = turning a ∧
      (family.map hor).sum % 2 = hor a % 2 ∧
      (family.map ver).sum % 2 = ver a % 2 := by
  -- 人手証明の累積帰納を、測度の上界 n についての帰納として実装する。
  have main : ∀ n : ℕ, ∀ a : α, measure a ≤ n →
      ∃ family : List α,
        family ≠ [] ∧
        (∀ x ∈ family, measure x = 0) ∧
        (family.map turning).sum = turning a ∧
        (family.map hor).sum % 2 = hor a % 2 ∧
        (family.map ver).sum % 2 = ver a % 2 := by
    intro n
    induction n with
    | zero =>
      -- 場合分け「measure a = 0」: 族を一本 (a) とする。
      intro a ha
      refine ⟨[a], by simp, ?_, by simp, by simp, by simp⟩
      intro x hx
      rw [List.mem_singleton.mp hx]
      omega
    | succ n ih =>
      intro a ha
      by_cases h0 : measure a = 0
      · -- 場合分け「measure a = 0」: 族を一本 (a) とする。
        refine ⟨[a], by simp, ?_, by simp, by simp, by simp⟩
        intro x hx
        rw [List.mem_singleton.mp hx]
        exact h0
      · -- 場合分け「0 < measure a」: 一歩の分割で b, c を取り、
        -- 測度が真に減るのでそれぞれへ帰納法の仮定を適用し、族を連結する。
        obtain ⟨b, c, hlt, ht, hh, hv⟩ := step a (Nat.pos_of_ne_zero h0)
        obtain ⟨fb, hfbne, hfb0, hfbt, hfbh, hfbv⟩ := ih b (by omega)
        obtain ⟨fc, _, hfc0, hfct, hfch, hfcv⟩ := ih c (by omega)
        refine ⟨fb ++ fc, by simp [hfbne], ?_, ?_, ?_, ?_⟩
        · intro x hx
          rcases List.mem_append.mp hx with h | h
          exacts [hfb0 x h, hfc0 x h]
        · -- 回転数: 有限和の分割 → 帰納法の仮定の二式 → 一歩の保存則。
          rw [List.map_append, List.sum_append, hfbt, hfct, ht]
        · -- 横の偶奇: 有限和の分割 → 法 2 の加法の合同 → 帰納法の仮定 → 一歩の保存則。
          rw [List.map_append, List.sum_append, Nat.add_mod, hfbh, hfch, ← Nat.add_mod, hh]
        · -- 縦の偶奇: 同上。
          rw [List.map_append, List.sum_append, Nat.add_mod, hfbv, hfcv, ← Nat.add_mod, hv]
  intro a
  exact main (measure a) a le_rfl

end Ising2DLambda.NecSuf.KacWard
