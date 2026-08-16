/-
「埋め込んだ対数の順序は正の有理数の順序と一致する」の必要十分版。

具体版が使うのは、(1) 一段目の写像 `f : A → B`（`log`）が関係を保ち反映すること、
(2) 二段目の写像 `e : B → C`（`ι`）について、係数 `s`（`1/1^2`）を掛けた形 `s • e b` で
関係を保ち反映すること、(3) `s = 1` と `1 • x = x`（`MulAction` の `one_smul`）だけである。
`Λ_ℚ`・共通分母・`rat_Λ` の中身、順序の推移律・反射律は使わない。
`(2)` を「係数を掛けた形」で受け取るのは、具体版が引く `claim_scaled_embedding_order_transfer`
がその形で述べられているからで、`s = 1` に潰す一段（三段目・四段目）が証明の中身である。
-/
import Mathlib.Algebra.Group.Action.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {A B C M : Type*} [Monoid M] [MulAction M C]

/-- `f` が `leA`・`leB` を移し合い、`s • e ·` が `leB`・`leC` を移し合い、`s = 1` なら、
`e ∘ f` が `leA`・`leC` を移し合う。 -/
theorem iff_comp_of_iff_of_scaled_iff_necSuf (leA : A → A → Prop) (leB : B → B → Prop)
    (leC : C → C → Prop) (f : A → B) (e : B → C) (s : M)
    (hf : ∀ a a', leA a a' ↔ leB (f a) (f a'))
    (he : ∀ b b', leB b b' ↔ leC (s • e b) (s • e b'))
    (hs : s = 1) (a a' : A) :
    leA a a' ↔ leC (e (f a)) (e (f a')) := by
  -- 二段目: he を b := f a、b' := f a' で読む
  have h := he (f a) (f a')
  -- 三段目: s = 1。四段目: 1 • x = x を両辺へ
  rw [hs, one_smul, one_smul] at h
  -- 一段目: hf、そのあと二〜四段目
  exact (hf a a').trans h

end Ising2DLambda.NecSuf.ThermodynamicLimit
