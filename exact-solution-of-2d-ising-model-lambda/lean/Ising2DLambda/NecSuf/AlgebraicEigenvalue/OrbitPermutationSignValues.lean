/-
主張「軌道の上の全単射の符号は +1 か -1 であり、恒等写像の符号は +1 である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSignValues`）の証明が実際に
使っているのは次だけである。証明手順は具体版と同じ（同じ 3 主張、同じ順序の等式変形）。

  主張                          使っている性質
  signOn_eq_or                    何も要らない（`(-1)^n` が ±1 であることだけ）
  signOn_mul_self                 何も要らない（指数法則と `(-1)^2 = 1` だけ）
  inversionCountOn_id           台の各対 `(a,b)` について `lt a b` から `¬ lt b a` が出ること
  signOn_id                       同上

削れなかった仮定と、その理由は次のとおりである。

1. 台 `s : Finset (α × α)` に「属する対が `lt` で順序づけられていること」（`hsupport`）。
   恒等写像の転倒数が 0 であることは、これと非対称性からしか出ない。
   **台が `F(O,O)` であることも、`α` の有限性も、`lt` が推移的であることも使っていない。**
   人手証明が引いているのは三分律のうち「`τ ≺ τ'` ならば `τ' ≺ τ` でない」だけである
   （三分律の他の 2 つの結論——相異なることと、逆向きが成り立つこと——は使っていない）。
2. 非対称性 `hasymm`。上のとおり、三分律より弱い。
   三分律を仮定に足しても証明は変わらない。足さずに通ることが「使っていない」ことの検査である。

値の側は `ℤ` に固定してある（具体版と同じ理由。人手証明が `ℤ` の中の等式として述べている）。
`Finset` の `card` も現れない——転倒数を数える集合が空であることだけを使うので、
`Finset.card_eq_zero` で個数へ移すのは最後の 1 段である。

mathlib の `Equiv.Perm.sign` は引かない（引くと転倒数で定めるという定義そのものが消える）。

住処: ここに ℝ / ℂ は現れない（数え上げは ℕ、符号は ℤ）。
-/
import Mathlib.Data.Finset.Card
import Mathlib.Tactic.Common
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {α : Type*} (lt : α → α → Prop) [DecidableRel lt]

/-- 人手証明の `inv_O(ψ)` を、台を勝手な `Finset` に取り替えたもの。 -/
noncomputable def inversionCountOn (s : Finset (α × α)) (g : α → α) : ℕ :=
  (s.filter fun p => lt (g p.2) (g p.1)).card

/-- 人手証明の `sgn_O(ψ) = (-1)^{inv_O(ψ)}` を、台を勝手な `Finset` に取り替えたもの。 -/
noncomputable def signOn (s : Finset (α × α)) (g : α → α) : ℤ :=
  (-1) ^ inversionCountOn lt s g

/-- 第一の主張の必要十分版。`(-1)` の冪であることしか使わない。 -/
theorem signOn_eq_or (s : Finset (α × α)) (g : α → α) :
    signOn lt s g = 1 ∨ signOn lt s g = -1 :=
  neg_one_pow_eq_or ℤ _

/-- 第二の主張の必要十分版。指数法則と `(-1)^2 = 1` しか使わない。 -/
theorem signOn_mul_self (s : Finset (α × α)) (g : α → α) :
    signOn lt s g * signOn lt s g = 1 := by
  unfold signOn
  rw [← pow_add, ← two_mul, pow_mul, neg_one_sq, one_pow]

/-- 第三の主張の前半の必要十分版。恒等写像の転倒数は 0 である。

要るのは、台の対が `lt` で順序づけられていること（`hsupport`）と、`lt` の非対称性
（`hasymm`）だけである。台が軌道から作られていることは使っていない。 -/
theorem inversionCountOn_id {s : Finset (α × α)}
    (hsupport : ∀ p ∈ s, lt p.1 p.2)
    (hasymm : ∀ a b : α, lt a b → ¬ lt b a) :
    inversionCountOn lt s (fun a => a) = 0 := by
  rw [inversionCountOn, card_eq_zero, filter_eq_empty_iff]
  intro p hp
  exact hasymm p.1 p.2 (hsupport p hp)

/-- 第三の主張の必要十分版。恒等写像の符号は +1 である。 -/
theorem signOn_id {s : Finset (α × α)}
    (hsupport : ∀ p ∈ s, lt p.1 p.2)
    (hasymm : ∀ a b : α, lt a b → ¬ lt b a) :
    signOn lt s (fun a => a) = 1 := by
  rw [signOn, inversionCountOn_id lt hsupport hasymm, pow_zero]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
