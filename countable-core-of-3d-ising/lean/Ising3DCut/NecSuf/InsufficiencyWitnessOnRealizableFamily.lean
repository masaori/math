/-
「実現可能な列の族の上での粗視化の非十分性が、証人の存在と同値である」の必要十分版。

具体版（`Ising3DCut.LimitQuantity.not_sufficient_on_ising_realizable_family_iff_exists_witness`）
は、有限箱の値に Ising 分配多項式の有理点での値を、極限量に実数値を、箱の添字に正の自然数を
使っていた。この主張が実際に必要としているのは次だけである。

* 点の型 `Q` と、点に述語 `Domain : Q → Prop` が与えられていること
* 箱の添字の型 `ι` と、そのうち比較に使うものを選ぶ述語 `Index : ι → Prop`
* 各点・各添字に定まるデータ `data : Q → ι → V` と、その粗視化 `π : V → S`
* 極限量 `α : Q → A`（順序も位相も代数構造も要らない。等号があればよい）

分配多項式・有理数・実数・自然数の順序はいずれも本質的でない。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 実現可能な点の族の上で、粗視化 `π` が極限量 `α` に対して十分であること。 -/
def SufficientOnRealizableFamily {Q ι V S A : Type*}
    (Domain : Q → Prop) (Index : ι → Prop) (data : Q → ι → V)
    (π : V → S) (α : Q → A) : Prop :=
  ∀ q q' : Q, Domain q → Domain q' →
    (∀ i : ι, Index i → π (data q i) = π (data q' i)) → α q = α q'

/-- 非十分性は、極限量が異なる二つの実現可能な点が、選ばれたすべての添字で
同じ粗視化値を持つことと同値である。 -/
theorem not_sufficient_on_realizable_family_iff_exists_witness
    {Q ι V S A : Type*}
    (Domain : Q → Prop) (Index : ι → Prop) (data : Q → ι → V)
    (π : V → S) (α : Q → A) :
    ¬ SufficientOnRealizableFamily Domain Index data π α ↔
      ∃ q q' : Q, Domain q ∧ Domain q' ∧ α q ≠ α q' ∧
        ∀ i : ι, Index i → π (data q i) = π (data q' i) := by
  constructor
  · intro hNotSufficient
    -- 証人が一つも無いと仮定すると、十分性そのものが従って矛盾する。
    by_contra hNoWitness
    apply hNotSufficient
    intro q q' hq hq' hagree
    by_contra hne
    exact hNoWitness ⟨q, q', hq, hq', hne, hagree⟩
  · rintro ⟨q, q', hq, hq', hne, hagree⟩ hSufficient
    -- 証人の全添字一致を十分性へ入れると、極限量の不一致に反する。
    exact hne (hSufficient q q' hq hq' hagree)

end Ising3DCut.NecSuf
