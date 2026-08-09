/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

3 つの主張それぞれについて代入する。

1. `map_prod_of_mul` に M := ℤ、N := ℤ[x][t]、h := ι∘κ を代入すると
   「ι∘κ は有限積を有限積へ写す」が得られる。要るのは `h 1 = 1` と `h (a b) = h a · h b` だけである。
2. `prod_eq_prod_of_partition` に α := R_L、M := ℤ[x][t]、s := 𝒪_L を代入すると
   「有限積は軌道ごとの積の積である」が得られる。要るのは分割の 3 条件のうち
   互いに素であることと合併が全体であることの 2 つだけである。
3. `mul_prod_eq_prod_mul_of_decomp` に c := ι(κ(sgn φ))、cf := O ↦ ι(κ(sgn_O(φ↾_O)))、
   f := τ ↦ B_{τ,φ(τ)} を代入すると「軌道を保つ置換の項は軌道ごとの因子の積である」が得られる。
   2 つの分解（1 と 2、および前セクションの符号の積表示）を仮定として渡すだけであり、
   **軌道であることも順序 `≺` もこの代入には現れない。**
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTermFactorization
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTermFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L] {φ : Equiv.Perm (RowConfig L)}

/-- 主張「ι∘κ は有限積を有限積へ写す」を、必要十分版から導いたもの。 -/
theorem constSecond_constPoly_prod_from_necSuf {β : Type*} [DecidableEq β]
    (s : Finset β) (f : β → ℤ) :
    constSecond (constPoly (∏ i ∈ s, f i)) = ∏ i ∈ s, constSecond (constPoly (f i)) :=
  NecSuf.AlgebraicEigenvalue.map_prod_of_mul
    (fun n => constSecond (constPoly n)) constSecond_constPoly_one
    (fun a b => by rw [constPoly_mul, constSecond_mul]) s f

/-- 主張「有限積は軌道ごとの積の積である」を、必要十分版から導いたもの。 -/
theorem prod_eq_prod_orbit_from_necSuf (L : ℕ) [NeZero L] (f : RowConfig L → SecondPoly) :
    ∏ τ : RowConfig L, f τ
      = ∏ O ∈ (rowShiftOrbitSet L).attach, ∏ τ ∈ O.1, f τ := by
  classical
  obtain ⟨-, hdisj, hunion⟩ := rowShiftOrbitSet_partition L
  exact NecSuf.AlgebraicEigenvalue.prod_eq_prod_of_partition
    (rowShiftOrbitSet L) hdisj hunion f

/-- 主張「軌道を保つ置換の項は、軌道ごとの因子の積である」を、必要十分版から導いたもの。 -/
theorem term_eq_prod_orbitFactor_from_necSuf (B : SecondRowMatrix L)
    (hφ : OrbitPreserving L φ) :
    constSecond (constPoly (permSign L φ)) * ∏ τ : RowConfig L, B τ (φ τ)
      = ∏ O ∈ (rowShiftOrbitSet L).attach,
          orbitFactor L B O.1 (orbitRestrictionAmbient hφ O.2) := by
  classical
  have hc : constSecond (constPoly (permSign L φ))
      = ∏ O ∈ (rowShiftOrbitSet L).attach,
          constSecond (constPoly (orbitPermSign L O.1 (orbitRestrictionAmbient hφ O.2))) := by
    rw [permSign_eq_prod_orbitPermSign hφ, constSecond_constPoly_prod]
  have hf : ∏ τ : RowConfig L, B τ (φ τ)
      = ∏ O ∈ (rowShiftOrbitSet L).attach, ∏ τ ∈ O.1, B τ (φ τ) :=
    prod_eq_prod_orbit L (fun τ => B τ (φ τ))
  have hmain := NecSuf.AlgebraicEigenvalue.mul_prod_eq_prod_mul_of_decomp
    (rowShiftOrbitSet L) (constSecond (constPoly (permSign L φ)))
    (fun O => constSecond (constPoly (orbitPermSign L O.1 (orbitRestrictionAmbient hφ O.2))))
    (fun τ => B τ (φ τ)) hc hf
  rw [hmain]
  refine Finset.prod_congr rfl ?_
  intro O _
  unfold orbitFactor
  refine congrArg _ ?_
  refine Finset.prod_congr rfl ?_
  intro τ hτ
  rw [orbitRestrictionAmbient_eq hφ O.2 hτ]

end Ising2DLambda.AlgebraicEigenvalue
