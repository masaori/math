/-
# 必要十分版: 接頭積で定めた元の二乗

対応する人手証明のラベル: `<epsilon_square_identity>`。

具体版は `Ising2D/Part004/Definition000_TransferMatrixSymbols.lean` の
`Ising2D.epsilon_mul_self`、本必要十分版から同じ主張を導く特殊化は
`Ising2D/Part004/ClaimEpsilonSquareFromNecSuf.lean` に置く。

## 本文との段対応

* 本文の有限帰納法は `prefix_eq_of_same_recursion`。二つの接頭積が同じ初項と
  同じ一因子追加則を持つことだけを使う。
* 本文のクロネッカー積の積の規則は `prefix_terminal_mul_self` の `map_mul`。
* 各 Pauli 因子の二乗と単位因子のクロネッカー積は、それぞれ `hfactor` と
  `map_one` に当たる。

## 効いているもの / 効いていないもの

効いているのは、接頭積を作る対象と終端の対象がモノイドであること、二つの接頭積が
同じ漸化式を持つこと、因子族から終端へ送る写像が積と単位元を保つこと、各因子が
二乗して単位元になることだけである。行列、複素数、加法、クロネッカー積、Pauli 行列、
因子間の可換性は使わない。
-/
import Mathlib.Algebra.Group.Hom.Defs
import Mathlib.Algebra.Group.Pi.Basic

namespace Ising2D.NecSuf

/-- 本文の有限帰納法の必要十分版。同じ初項と同じ一因子追加則を持つ二つの接頭積は一致する。 -/
theorem prefix_eq_of_same_recursion
    {B : Type*} [Monoid B] (N : ℕ) (p q stepFactor : ℕ → B)
    (hpZero : p 0 = 1) (hqZero : q 0 = 1)
    (hpSucc : ∀ m, m < N → p (m + 1) = p m * stepFactor m)
    (hqSucc : ∀ m, m < N → q (m + 1) = q m * stepFactor m) :
    p N = q N := by
  have hprefix : ∀ m, m ≤ N → p m = q m := by
    intro m hm
    induction m with
    | zero => rw [hpZero, hqZero]
    | succ m ih =>
        have hlt : m < N := Nat.lt_of_succ_le hm
        rw [hpSucc m hlt, hqSucc m hlt, ih (Nat.le_of_lt hlt)]
  exact hprefix N (Nat.le_refl N)

/-- `<epsilon_square_identity>` 全体の必要十分版。

有限帰納法で `p N = q N` を得て、`q N` を因子族の像へ直し、写像の乗法性、
各因子の二乗、写像の単位元保存を本文と同じ順に適用する。 -/
theorem prefix_terminal_mul_self
    {ι A B : Type*} [Monoid A] [Monoid B]
    (lift : MonoidHom (ι → A) B) (factor : ι → A)
    (N : ℕ) (p q stepFactor : ℕ → B)
    (hpZero : p 0 = 1) (hqZero : q 0 = 1)
    (hpSucc : ∀ m, m < N → p (m + 1) = p m * stepFactor m)
    (hqSucc : ∀ m, m < N → q (m + 1) = q m * stepFactor m)
    (hqTerminal : q N = lift factor)
    (hfactor : ∀ i, factor i * factor i = 1) :
    p N * p N = 1 := by
  have hpq : p N = q N :=
    prefix_eq_of_same_recursion N p q stepFactor hpZero hqZero hpSucc hqSucc
  rw [hpq, hqTerminal, ← map_mul]
  have hfamily : factor * factor = 1 := by
    funext i
    exact hfactor i
  rw [hfamily, map_one]

end Ising2D.NecSuf
