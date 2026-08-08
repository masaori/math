/-
主張「配位の重みは、行に沿った転送行列の成分の積である」（ラベル
`claim_transfer_weight_product`）の必要十分版、および主張
「配位全体と行配位の族全体は 1 対 1 に対応する」（ラベル `claim_rows_bijection`）の必要十分版。

手順は具体版と同じで、仮定だけを必要十分まで削ってある。

1. 重みの積（人手証明の Step 1–4）が実際に使っているのは次の 2 つだけである。
   ・値の側が可換モノイドであること（積の順序を入れ替えられること。`Finset.prod_pow_eq_pow_sum`
     が可換性を要求する）
   ・添字の側が有限型であること（有限個の積と有限個の和が確定すること）
   使っていないのは、値が多項式であること、掛ける量が不定元の冪であること、係数が ℤ であること、
   添字が `ZMod L` であること、指数が破れの本数であることである。
   そこで、可換モノイド `M` の元 `a`、有限型 `ι`、写像 `f g : ι → ℕ` について述べる。
   指数の側は `∑ f + ∑ g = n` という仮定に押し込んである（具体版ではこれが
   `claim_broken_bond_row_decomposition` にあたる）。

2. 1 対 1 対応（人手証明の Step 1–3）が実際に使っているのは
   「2 変数の写像と、1 変数ずつ与える写像が同じものであること」だけである。
   有限性も、値が `{+1,-1}` であることも、添字が `ZMod L` であることも使っていない。
   そこで任意の 3 つの型について述べる。両側の逆であることは `rfl` で出る
   （mathlib の `Equiv.curry` は引かない。引くと人手証明の Step 1・Step 2 に対応する
   計算が消えてしまうためである）。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace Ising2DLambda.NecSuf.TransferMatrix

open Finset

/-- 重みの積の必要十分版。人手証明の Step 1（各因子を書き下す）は仮定 `hT` に、
Step 2（指数法則で積をまとめる）は `Finset.prod_pow_eq_pow_sum` に、
Step 3（指数の和を 2 つに分ける）は `Finset.sum_add_distrib` に、
Step 4（分解を使う）は仮定 `hn` に対応する。

仮定について。可換モノイドを可換でないモノイドへ弱めると Step 2 が通らない
（積の順序を入れ替えられないため）。有限型を外すと積と和が確定しない。 -/
theorem prod_pow_add_eq_pow {M : Type*} [CommMonoid M] {ι : Type*} [Fintype ι]
    (a : M) (f g : ι → ℕ) (T : ι → M) (n : ℕ)
    (hT : ∀ i, T i = a ^ (f i + g i))
    (hn : (∑ i, f i) + (∑ i, g i) = n) :
    ∏ i, T i = a ^ n := by
  -- Step 1。各因子を `a` の冪として書き下す。
  have h1 : ∏ i, T i = ∏ i, a ^ (f i + g i) := prod_congr rfl fun i _ => hT i
  -- Step 2。指数法則で積をまとめる。
  have h2 : ∏ i, a ^ (f i + g i) = a ^ ∑ i, (f i + g i) := prod_pow_eq_pow_sum univ _ a
  -- Step 3。指数の和を 2 つに分ける。
  have h3 : ∑ i, (f i + g i) = (∑ i, f i) + ∑ i, g i := sum_add_distrib
  -- Step 4。仮定 `hn` を使う。
  rw [h1, h2, h3, hn]

/-- 1 対 1 対応の必要十分版。2 変数の写像 `α × β → γ` と、1 変数ずつ与える写像
`α → β → γ` は 1 対 1 に対応する。人手証明の Step 1・Step 2 がそれぞれ
`left_inv`・`right_inv` にあたり、どちらも値を書き下すと同じ式になる（`rfl`）。
Step 3（逆写像を持つ写像は全単射）は `Equiv` を作ること自体にあたる。

仮定について。3 つの型に何も仮定していない。有限性・相等の決定可能性・値が 2 元であることは
いずれも証明に使っていないので置かない。 -/
def uncurryEquiv (α β γ : Type*) : (α × β → γ) ≃ (α → β → γ) where
  toFun σ := fun i j => σ (i, j)
  invFun c := fun v => c v.1 v.2
  left_inv _ := rfl
  right_inv _ := rfl

end Ising2DLambda.NecSuf.TransferMatrix
