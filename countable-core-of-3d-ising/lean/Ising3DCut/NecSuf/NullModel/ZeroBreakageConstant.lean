/-
人手証明の主張「破れ数ゼロの配位は全上と全下の二つに限る」
（ラベル `claim_zero_breakage_multiplicity_is_two`）の必要十分版。

第一段の強い帰納法は `value_eq_root_of_rank_predecessor` へ落とし、第三段の
数え上げは `card_eq_of_injective_of_le` へ落とす。

具体版の証明で実際に使う性質だけを残す。

  使っている性質                    なぜ削れないか
  `Fintype α`, `Fintype β`          個数を数える両側。
  `Function.Injective f`            上界を与える唯一の道具。具体版では
                                    「破れ数 0 の配位は原点での値で決まる」にあたる。
  `Fintype.card β = n`              上界の値。具体版では `Fintype.card Spin = 2`。
  `n ≤ Fintype.card α`              下界。具体版では全上・全下の二配位。

削った仮定: 有限箱・辺・端点写像・破れ数・スピン値 ±1・次元 3。
具体版の第三段はこれらを一切使わない——使うのは単射性の証人を作る段と、
下界を与える段だけであり、どちらも仮定として外から受け取れる。

住処: 任意の有限型と自然数のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NecSuf.NullModel.MultiplicityPalindrome

namespace Ising3DCut.NecSuf.NullModel

/-- A value is constant when every non-root rank admits a strictly lower predecessor
with the same value, and rank zero contains only the root.  This is exactly the
strong-induction step used by the concrete lattice proof. -/
theorem value_eq_root_of_rank_predecessor
    {α β : Type*} (rank : α → ℕ) (root : α) (value : α → β)
    (hrankZero : ∀ a, rank a = 0 → a = root)
    (hpredecessor : ∀ a, 0 < rank a →
      ∃ b, rank b < rank a ∧ value b = value a)
    (a : α) :
    value a = value root := by
  induction hrank : rank a using Nat.strong_induction_on generalizing a with
  | _ n ih =>
    subst hrank
    by_cases hzero : rank a = 0
    · rw [hrankZero a hzero]
    · obtain ⟨b, hlower, hvalue⟩ :=
        hpredecessor a (Nat.pos_of_ne_zero hzero)
      rw [← hvalue]
      exact ih (rank b) hlower b rfl

/-- 単射で上から `n` に押さえられ、かつ下から `n` で押さえられる有限型の元の個数は `n` である。 -/
theorem card_eq_of_injective_of_le
    {α β : Type*} [Fintype α] [Fintype β]
    (f : α → β) (hf : Function.Injective f)
    (n : ℕ) (hcard : Fintype.card β = n) (hlow : n ≤ Fintype.card α) :
    Fintype.card α = n := by
  have hupper : Fintype.card α ≤ Fintype.card β := Fintype.card_le_of_injective f hf
  omega

end Ising3DCut.NecSuf.NullModel
