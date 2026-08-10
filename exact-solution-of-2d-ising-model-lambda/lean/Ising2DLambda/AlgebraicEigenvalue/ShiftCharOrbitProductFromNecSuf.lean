/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

`prod_sum_eq_sum_prod_pi` に `ι := 軌道の全体の添字型`、`B := O ↦ 𝔅_O`、`R := ℤ[x][t]` を
代入すると、具体版の「分配則を s = O_L と取った段」が得られる。

代入して分かるのは、この段が新しく要求するのが**添字の型が有限であること**だけだという
ことである（軌道の全体は有限集合なので満たされる）。添字が軌道であることも、
成分が全単射であることも、順序 `≺` も、値が多項式であることも使っていない。

型の同一性について。具体版の `OrbitPermFamily L` と必要十分版の `∀ O, OrbitBij O.1` は
定義を展開すると同じ型である。ただし和の添字に使う `Fintype` インスタンスは
具体版と必要十分版で別々に置いてあるので、`Subsingleton.elim` で突き合わせる
（同じ型の上の `Fintype` は一意である）。ここだけが代入以外にすることである。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharOrbitProduct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharOrbitProduct

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の「分配則を `s = O_L` と取った段」を、必要十分版から導いたもの。 -/
theorem prod_sum_eq_sum_prod_orbitFamilyAll_from_necSuf
    (g : (O : OrbitIndex L) → OrbitBij O.1 → SecondPoly) :
    (∏ O : OrbitIndex L, ∑ ψ : OrbitBij O.1, g O ψ)
      = ∑ α : OrbitPermFamily L, ∏ O : OrbitIndex L, g O (α O) := by
  classical
  have h := NecSuf.AlgebraicEigenvalue.prod_sum_eq_sum_prod_pi
    (B := fun O : OrbitIndex L => OrbitBij O.1) (R := SecondPoly) g
  refine h.trans (Finset.sum_congr ?_ (fun α _ => rfl))
  exact congrArg (fun inst : Fintype (OrbitPermFamily L) => @Finset.univ _ inst)
    (Subsingleton.elim _ _)

end Ising2DLambda.AlgebraicEigenvalue
