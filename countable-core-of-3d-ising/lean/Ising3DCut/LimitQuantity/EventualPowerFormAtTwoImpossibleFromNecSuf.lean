/-
「有理点 2 では点数乗表示は末尾で成り立たない」の具体版が、必要十分版の特殊化として
得られることの明示。素数を 2 に、法を `2 ^ 2 = 4` に、値の列を有理点 2 での有限箱値に、
指数の列を箱の点数に取る。

必要十分版には底の正値性の仮定が無い。具体版が置いていた `0 < c` は、この論法では
使っていない（底が 0 でも `0 ^ n % 4 = 0 ≠ 2` で同じ結論が出る）ことがここで分かる。
-/
import Ising3DCut.LimitQuantity.EventualPowerFormAtTwoImpossible
import Ising3DCut.NecSuf.EventualPowerFormAtTwoImpossible

namespace Ising3DCut.LimitQuantity

open NullModel

/-- `claim_eventual_power_form_at_two_is_impossible` を必要十分版から導いたもの。 -/
theorem eventual_power_form_at_two_is_impossible_fromNecSuf :
    ¬ ∃ L₀ c : ℕ, 0 < L₀ ∧ 0 < c ∧
      ∀ L, L₀ ≤ L → partitionValueAtTwoNat L = c ^ Fintype.card (Site L) := by
  rintro ⟨L₀, c, hL₀, hc, hpower⟩
  refine NecSuf.no_eventual_power_form_of_prime_sq_residue Nat.prime_two
    partitionValueAtTwoNat (fun L => Fintype.card (Site L)) L₀ c ?_ ?_ hpower
  · intro L hL
    have hmod := partitionValueAtTwoNat_mod_four hL
    simpa using hmod
  · intro L hL
    have hcount : Fintype.card (Site L) = L ^ 3 := card_site L
    rw [hcount]
    calc
      2 ≤ 2 ^ 3 := by norm_num
      _ ≤ L ^ 3 := Nat.pow_le_pow_left hL 3

end Ising3DCut.LimitQuantity
