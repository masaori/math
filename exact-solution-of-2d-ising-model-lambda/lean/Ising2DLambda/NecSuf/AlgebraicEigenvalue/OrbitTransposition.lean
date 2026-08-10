/-
主張「互換は 2 回合成すると恒等写像であり、その軌道への制限は軌道の上の全単射である」の
必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitTransposition`）の証明が実際に
使っているのは、**台の型の元どうしの相等が決定できること（`DecidableEq`）だけ**である。
証明手順は具体版と同じ（同じ 3 つの場合分け、第 1 の場合での `b = a` か否かの再分割）。

削れなかった仮定と、その理由は次のとおりである。

1. `DecidableEq α`。互換の定義そのものが「`τ = a` か否か」で分岐するので、これを削ると
   定義が書けない（古典論理で `Classical.dec` を使えば書けるが、それは仮定を削ったのではなく
   選択公理へ移しただけなので、削れたとは言わない）。
2. 台 `s : Finset α` については、`a ∈ s` と `b ∈ s` だけを使う。
   **`s` が軌道であることも、`α` が有限であることも、`α` の上の順序も使っていない。**
   人手証明が「軌道の 2 点」と言っているが、証明が使っているのは 2 点が同じ有限集合に
   属することだけである。

住処: ここに ℝ / ℂ は現れない（現れるのは型の元と有限集合、その上の写像と相等だけ）。
-/
import Mathlib.Data.Finset.Basic
import Mathlib.Logic.Equiv.Defs
import Mathlib.Tactic.Common

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {α : Type*} [DecidableEq α]

/-- 人手証明の `t_{τa,τb}` を、行配位の型を勝手な型へ取り替えたもの。 -/
def transpositionOn (a b : α) : α → α :=
  fun x => if x = a then b else if x = b then a else x

/-- 第一の主張の必要十分版。相等が決定できること以外に何も要らない。 -/
theorem transpositionOn_involutive (a b : α) (x : α) :
    transpositionOn a b (transpositionOn a b x) = x := by
  simp only [transpositionOn]
  by_cases hxa : x = a
  · by_cases hba : b = a
    · simp [hxa, hba]
    · simp [hxa, hba]
  · by_cases hxb : x = b
    · have hba : b ≠ a := hxb ▸ hxa
      simp [hxa, hxb, hba]
    · simp [hxa, hxb]

/-- 第二の主張の必要十分版。台については `a ∈ s` と `b ∈ s` しか使わない。 -/
theorem transpositionOn_mem {s : Finset α} {a b : α} (ha : a ∈ s) (hb : b ∈ s)
    {x : α} (hx : x ∈ s) : transpositionOn a b x ∈ s := by
  simp only [transpositionOn]
  by_cases hxa : x = a
  · rw [if_pos hxa]
    exact hb
  · rw [if_neg hxa]
    by_cases hxb : x = b
    · rw [if_pos hxb]
      exact ha
    · rw [if_neg hxb]
      exact hx

/-- 第三の主張の必要十分版。台への制限が台の上の全単射であること。 -/
def transpositionOnRestriction {s : Finset α} {a b : α} (ha : a ∈ s) (hb : b ∈ s) :
    {x : α // x ∈ s} ≃ {x : α // x ∈ s} where
  toFun x := ⟨transpositionOn a b x.1, transpositionOn_mem ha hb x.2⟩
  invFun x := ⟨transpositionOn a b x.1, transpositionOn_mem ha hb x.2⟩
  left_inv x := Subtype.ext (transpositionOn_involutive a b x.1)
  right_inv x := Subtype.ext (transpositionOn_involutive a b x.1)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
