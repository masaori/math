/-
`claim_real_closed_subfield_exists` の具体版が必要十分版の特殊化であることの導出。
`K := Qbar`、`T := Subfield Qbar`、正錐の述語を `IsSubfieldPositiveCone`、極大性を延長が元の部分体に
一致すること、`OddRoots` を奇数次の部分体係数の多項式が根を持つことと置き、部品は各主張の導出版で与える。
-/
import Ising2DLambda.FisherZero.RealClosedSubfieldExists
import Ising2DLambda.FisherZero.EnumeratedOrderedSubfieldIsMaximalFromNecSuf
import Ising2DLambda.FisherZero.MaximalOrderedSubfieldPositiveIsSquareFromNecSuf
import Ising2DLambda.FisherZero.MaximalOrderedSubfieldSquareTrichotomyFromNecSuf
import Ising2DLambda.FisherZero.MaximalOrderedSubfieldOddDegreeRootFromNecSuf
import Ising2DLambda.FisherZero.ImaginaryUnitExistsFromNecSuf
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionUniqueRepresentationFromNecSuf
import Ising2DLambda.FisherZero.AdjoinImaginaryUnitGivesAlgebraicNumbersFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.RealClosedSubfieldExists

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_real_closed_subfield_exists` の具体版を必要十分版から導く。 -/
theorem realClosedSubfield_exists_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    Nonempty (RealClosedSubfieldSqrtTwoData s) := by
  obtain ⟨R, omega, htri, homega, hall, huniq, hsq⟩ :=
    Ising2DLambda.NecSuf.FisherZero.realClosedSubfield_exists_necSuf
      (K := Qbar) (T := Subfield Qbar)
      (fun E : Subfield Qbar => (E : Set Qbar))
      IsSubfieldPositiveCone
      (fun R C => ∀ (E : Subfield Qbar) (D : Set Qbar), ExtendsPositiveCone R E C D → E = R)
      (fun R => ∀ (n : ℕ) (p : QbarPoly), p ∈ subfieldCoefficientPolynomials R → Odd n →
        p.coeff n ≠ 0 → (∀ k : ℕ, n < k → p.coeff k = 0) →
        ∃ z : Qbar, z ∈ R ∧ qbarPolyEval z p = 0)
      s
      (by
        obtain ⟨R, C, hbase, hmax⟩ := enumeratedOrderedSubfield_isMaximal_from_necSuf s hs
        have hsQs : s ∈ quadraticFieldSet s := by
          change ∃ a b : ℚ, s = algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s
          refine ⟨0, 1, ?_⟩
          simp
        have hsP : s ∈ quadraticPositiveConeAmbient s :=
          ⟨hsQs, quadraticGenerator_mem_positiveCone s hs⟩
        exact ⟨R, C, hbase.cone_E, hmax, ((hbase.inter_eq s).2 hsP).1⟩)
      imaginaryUnit_exists_from_necSuf
      (fun R C hC hmax a ha => maximalOrderedSubfield_positive_isSquare_from_necSuf R C hC hmax a ha)
      (fun R C hC hmax z hz => by
        have h := maximalOrderedSubfield_squareTrichotomy_from_necSuf R C hC hmax z hz
        exact h)
      (fun R C hC hmax n p hp hn hpn hpz =>
        maximalOrderedSubfield_oddDegreeRoot_from_necSuf R C hC hmax n p hp hn hpn hpz)
      (fun R C hC hpositive hodd omega homega xi =>
        adjoinImaginaryUnit_gives_algebraicNumbers_from_necSuf R C hC hpositive hodd omega homega xi)
      (fun R C hC omega homega a a' b b' ha ha' hb hb' h =>
        imaginaryUnitExtension_unique_representation_from_necSuf R C hC omega homega
          a a' b b' ha ha' hb hb' h)
  refine ⟨{
    carrier := R
    omega := omega
    squareTrichotomy := ?_
    omega_sq := homega
    unique_decomposition := ?_
    sqrtTwo_square := ?_ }⟩
  · intro z
    obtain ⟨hcases, h12, h13, h23⟩ := htri (z : Qbar) z.2
    have e2 : (∃ w : R, w ≠ 0 ∧ z = w * w) ↔
        (∃ w : Qbar, w ∈ R ∧ w ≠ 0 ∧ (z : Qbar) = w * w) := by
      constructor
      · rintro ⟨w, hw0, hw⟩
        exact ⟨w, w.2, fun h => hw0 (Subtype.ext h), by rw [hw]; rfl⟩
      · rintro ⟨w, hwR, hw0, hw⟩
        exact ⟨⟨w, hwR⟩, fun h => hw0 (congrArg Subtype.val h), Subtype.ext hw⟩
    have e3 : (∃ w : R, w ≠ 0 ∧ -z = w * w) ↔
        (∃ w : Qbar, w ∈ R ∧ w ≠ 0 ∧ -(z : Qbar) = w * w) := by
      constructor
      · rintro ⟨w, hw0, hw⟩
        exact ⟨w, w.2, fun h => hw0 (Subtype.ext h), by
          rw [show -(z : Qbar) = ((-z : R) : Qbar) from rfl, hw]; rfl⟩
      · rintro ⟨w, hwR, hw0, hw⟩
        exact ⟨⟨w, hwR⟩, fun h => hw0 (congrArg Subtype.val h), Subtype.ext hw⟩
    have e1 : z = 0 ↔ (z : Qbar) = 0 :=
      ⟨fun h => by rw [h]; rfl, fun h => Subtype.ext h⟩
    refine ⟨?_, ?_, ?_, ?_⟩
    · rcases hcases with h | h | h
      · exact Or.inl (e1.2 h)
      · exact Or.inr (Or.inl (e2.2 h))
      · exact Or.inr (Or.inr (e3.2 h))
    · exact fun ⟨a, b⟩ => h12 ⟨e1.1 a, e2.1 b⟩
    · exact fun ⟨a, b⟩ => h13 ⟨e1.1 a, e3.1 b⟩
    · exact fun ⟨a, b⟩ => h23 ⟨e2.1 a, e3.1 b⟩
  · intro xi
    obtain ⟨u, v, huR, hvR, hxi⟩ := hall xi
    refine ⟨(⟨u, huR⟩, ⟨v, hvR⟩), hxi, ?_⟩
    rintro ⟨a, b⟩ hab
    obtain ⟨hua, hvb⟩ := huniq a u b v a.2 huR b.2 hvR (hab.symm.trans hxi)
    exact Prod.ext (Subtype.ext hua) (Subtype.ext hvb)
  · obtain ⟨b, hbR, hb0, hb⟩ := hsq
    exact ⟨⟨b, hbR⟩, fun h => hb0 (congrArg Subtype.val h), hb⟩

end Ising2DLambda.FisherZero
