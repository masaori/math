/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

`prod_sum_eq_sum_prod_family` に `ι := 𝒪_L の添字型`、`B := O ↦ 𝔅_O`、`R := ℤ[x][t]` を
代入すると、具体版の分配則が得られる。

代入して分かるのは、この段が要求するのが次だけだということである。

  添字の相等が判定できること          `ins` の場合分け
  各成分の型が有限であること          和の添字にすること
  値の側が可換半環であること          分配則・積の可換性と結合則・単位元

すなわち、添字が軌道であることも、成分が全単射であることも、順序 `≺` も、
値が多項式であることも使っていない。引き算も零因子が無いことも使っていない
（人手証明が末尾で述べているとおりである）。

型の同一性について。具体版の `OrbitPermFamilyOn s` と必要十分版の
`FamilyOn (fun O => OrbitBij O.1) s` は定義を展開すると同じ型である。
ただし和の添字に使う `Fintype` インスタンスは、具体版と必要十分版で別々に置いてある
（前者は `orbitPermFamilyOnFintype`、後者は `familyOnFintype`）。
同じ型の上の `Fintype` は一意なので（`Fintype` は `Subsingleton`）、
`Subsingleton.elim` で突き合わせる。ここだけが代入以外にすることである。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFamilyDistributive
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitFamilyDistributive

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の分配則を、必要十分版から導いたもの。 -/
theorem prod_sum_eq_sum_prod_orbitFamily_from_necSuf
    (g : (O : OrbitIndex L) → OrbitBij O.1 → SecondPoly) (s : Finset (OrbitIndex L)) :
    (∏ O ∈ s, ∑ ψ : OrbitBij O.1, g O ψ)
      = ∑ α : OrbitPermFamilyOn s, ∏ O ∈ s.attach, g O.1 (α O.1 O.2) := by
  classical
  have h := NecSuf.AlgebraicEigenvalue.prod_sum_eq_sum_prod_family
    (B := fun O : OrbitIndex L => OrbitBij O.1) (R := SecondPoly) g s
  refine h.trans (Finset.sum_congr ?_ (fun α _ => rfl))
  exact congrArg (fun inst : Fintype (OrbitPermFamilyOn s) => @Finset.univ _ inst)
    (Subsingleton.elim _ _)

end Ising2DLambda.AlgebraicEigenvalue
