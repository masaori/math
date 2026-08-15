/-
「既約分解の型が零点の最小多項式次数を決める」の具体版が必要十分版の特殊化であることの導出。
-/
import Ising3DCut.NullModel.IrreducibleFactorRootDegrees
import Ising3DCut.NecSuf.NullModel.IrreducibleFactorRootDegrees

open Polynomial

namespace Ising3DCut.NullModel

/-- 具体版は必要十分版の特殊化である（零点集合の濃度と最小多項式次数の書き換えを渡す）。 -/
theorem irreducibleFactorizationType_determines_rootMinimalPolynomialDegrees_from_necSuf
    {J K L : Type} [Fintype J] [DecidableEq J]
    [Field K] [CharZero K] [Field L] [IsAlgClosed L]
    [Algebra K L] [FaithfulSMul K L]
    (P : J → K[X]) (exponent : J → ℕ)
    (hIrreducible : ∀ j, Irreducible (P j)) (hMonic : ∀ j, (P j).Monic)
    (n : ℕ) :
    Fintype.card {r : RepeatedPolynomialRoot L P exponent //
      repeatedPolynomialRootMinpolyDegree r = n} =
      ∑ j : {j : J // (P j).natDegree = n}, exponent j * (P j).natDegree :=
  Ising3DCut.NecSuf.NullModel.factorizationType_determines_rootDegrees
    (fun j => (P j).rootSet L) (fun j => (P j).natDegree) exponent
    (fun j => irreducible_rootSet_card_eq_natDegree (P j) (hIrreducible j))
    (fun x => (minpoly K (x.2 : L)).natDegree)
    (fun x => minpoly_natDegree_eq_of_irreducible_monic (P x.1) (hIrreducible x.1) (hMonic x.1)
      (x.2 : L) ((Polynomial.mem_rootSet_of_ne (hIrreducible x.1).ne_zero).mp x.2.2))
    n

/-- 積多項式の零点多重集合についての具体版は、必要十分版の多重集合結合定理の特殊化である。 -/
theorem irreducibleFactorProduct_count_rootMinimalPolynomialDegree_from_necSuf
    {J K L : Type} [Fintype J] [DecidableEq J]
    [Field K] [CharZero K] [Field L] [IsAlgClosed L]
    [Algebra K L] [FaithfulSMul K L] [DecidableEq L]
    (P : J → K[X]) (exponent : J → ℕ)
    (hIrreducible : ∀ j, Irreducible (P j)) (hMonic : ∀ j, (P j).Monic)
    (n : ℕ) :
    Multiset.count n
      ((∏ j : J, (Polynomial.map (algebraMap K L) (P j)) ^ exponent j).roots.map
        fun x ↦ (minpoly K x).natDegree) =
      ∑ j : J, if (P j).natDegree = n then exponent j * (P j).natDegree else 0 := by
  rw [irreducibleFactorProduct_roots_eq_bind P exponent hIrreducible]
  apply Ising3DCut.NecSuf.NullModel.count_rootDegree_in_repeatedRootMultiset
      (fun j => (Polynomial.map (algebraMap K L) (P j)).roots)
      (fun j => (P j).natDegree) exponent (fun x => (minpoly K x).natDegree)
  · intro j
    simpa using
      (IsAlgClosed.splits (Polynomial.map (algebraMap K L) (P j))).natDegree_eq_card_roots.symm
  · intro j x hx
    have hxRoot : Polynomial.IsRoot (Polynomial.map (algebraMap K L) (P j)) x :=
      (Polynomial.mem_roots (Polynomial.map_ne_zero (hIrreducible j).ne_zero)).mp hx
    exact minpoly_natDegree_eq_of_irreducible_monic
      (P j) (hIrreducible j) (hMonic j) x (by simpa [Polynomial.IsRoot] using hxRoot)

end Ising3DCut.NullModel
