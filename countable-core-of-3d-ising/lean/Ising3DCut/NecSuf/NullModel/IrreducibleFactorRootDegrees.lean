/-
「既約分解の型が零点の最小多項式次数を決める」の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質                              なぜ削れないか
  有限な添字型 `J` と次数・指数 `degree`, `exponent`   分解の型そのもの。
  各 `j` の零点を表す有限型 `R j` とその濃度が `degree j` であること   「相異なる零点数 = 次数」だけを使う。
  各零点に付ける次数が属する因子の次数に等しいこと     最小多項式次数の書き換えを写像で表す。

多項式・体・既約性・モニック性・代数閉性は仮定しない。それらは濃度の等式と
次数写像の等式を与えるためにだけ使われる。因子間の零点非共有は具体版でも使われないので現れない。
-/
import Mathlib

namespace Ising3DCut.NecSuf.NullModel

/-- 各 `j` の零点 `R j` を指数だけ反復した有限型。 -/
abbrev RepeatedRoot {J : Type} (R : J → Type) (exponent : J → ℕ) :=
  Σ x : (Σ j, R j), Fin (exponent x.1)

theorem factorizationType_determines_rootDegrees
    {J : Type} [Fintype J] [DecidableEq J]
    (R : J → Type) [∀ j, Fintype (R j)]
    (degree exponent : J → ℕ) (hcard : ∀ j, Fintype.card (R j) = degree j)
    (rootDegree : (Σ j, R j) → ℕ) (hdeg : ∀ x : Σ j, R j, rootDegree x = degree x.1)
    (n : ℕ) :
    Fintype.card { r : RepeatedRoot R exponent // rootDegree r.1 = n } =
      ∑ j : {j : J // degree j = n}, exponent j * degree j := by
  classical
  let e : { r : RepeatedRoot R exponent // rootDegree r.1 = n } ≃
      Σ j : {j : J // degree j = n}, R j × Fin (exponent j) :=
    { toFun := fun r => ⟨⟨r.1.1.1, (hdeg r.1.1) ▸ r.2⟩, r.1.1.2, r.1.2⟩
      invFun := fun r => ⟨⟨⟨r.1.1, r.2.1⟩, r.2.2⟩, (hdeg ⟨r.1.1, r.2.1⟩).trans r.1.2⟩
      left_inv := by intro r; cases r; rfl
      right_inv := by intro r; cases r; rfl }
  rw [Fintype.card_congr e, Fintype.card_sigma]
  simp [hcard, Nat.mul_comm]

end Ising3DCut.NecSuf.NullModel
