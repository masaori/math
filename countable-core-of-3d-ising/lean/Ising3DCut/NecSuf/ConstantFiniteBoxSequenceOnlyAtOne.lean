/-
「有限箱の量が定数列になる正の有理点は 1 に限る」の Lean 必要十分版。

具体版の証明が実際に使っているのは次の四つだけである。
族が定数族であること、一方の添字での値が `c` に定まること、
もう一方の添字での値の `n` 乗が比較対象の写像の値であること、
そしてその比較対象の写像が考えている範囲で狭義単調であること。
Ising 分配多項式・正の実数乗根・有理数の具体的な演算は、これらの仮定を用意する
具体版の段にだけ属するので落とす。冪だけが残るのでモノイドで足り、
添字の型と定義域の型は一般の型でよい。値の側は狭義単調性を述べるための順序だけを持つ。
箱の大きさの極限は使わない。
-/
import Mathlib.Order.Monotone.Basic
import Mathlib.Algebra.Group.Defs

namespace Ising3DCut.NecSuf

/-- 族 `f` が定数族で、添字 `i` での値が `c`、添字 `j` での値の `n` 乗が `g q` であり、
`c ^ n = g p` かつ `g` が `s` 上で狭義単調ならば、`q = p` である。 -/
theorem eq_of_constant_of_strictMonoOn
    {M : Type*} [Monoid M] [Preorder M] {ι α : Type*} [LinearOrder α]
    (f : ι → M) (i j : ι) (n : ℕ) (c : M)
    (g : α → M) (s : Set α) (hg : StrictMonoOn g s)
    (q p : α) (hqs : q ∈ s) (hps : p ∈ s)
    (hConstant : ∃ d : M, f = fun _ => d)
    (hi : f i = c) (hp : c ^ n = g p) (hj : f j ^ n = g q) :
    q = p := by
  rcases hConstant with ⟨d, hd⟩
  have hfi : f i = d := congrFun hd i
  have hfj : f j = d := congrFun hd j
  have h : g q = g p := by
    rw [← hj, ← hp, ← hi, hfi, hfj]
  exact hg.injOn hqs hps h

end Ising3DCut.NecSuf
