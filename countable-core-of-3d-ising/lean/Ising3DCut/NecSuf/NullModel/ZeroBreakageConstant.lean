/-
人手証明の主張「破れ数ゼロの配位は全上と全下の二つに限る」
（ラベル `claim_zero_breakage_multiplicity_is_two`）の必要十分版のうち、
数える段（第三段）にあたる部分。

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

/-- 単射で上から `n` に押さえられ、かつ下から `n` で押さえられる有限型の元の個数は `n` である。 -/
theorem card_eq_of_injective_of_le
    {α β : Type*} [Fintype α] [Fintype β]
    (f : α → β) (hf : Function.Injective f)
    (n : ℕ) (hcard : Fintype.card β = n) (hlow : n ≤ Fintype.card α) :
    Fintype.card α = n := by
  have hupper : Fintype.card α ≤ Fintype.card β := Fintype.card_le_of_injective f hf
  omega

end Ising3DCut.NecSuf.NullModel
