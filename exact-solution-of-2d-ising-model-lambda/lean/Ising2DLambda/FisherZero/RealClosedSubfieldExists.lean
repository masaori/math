/-
人手証明の主張「実閉部分体と虚数単位の組は存在する」（ラベル `claim_real_closed_subfield_exists`）の具体版。

  人手証明                                                          このファイル
  準備: 極大な正錐付き部分体 (R, C_R)（`claim_enumerated_ordered_subfield_is_maximal`）
                                                                    `enumeratedOrderedSubfield_isMaximal`
  準備: ω·ω = -1 を満たす ω（`claim_imaginary_unit_exists`）          `imaginaryUnit_exists`
  第一条件: R は部分体                                                `Subfield Qbar` の値
  第二条件: 平方の三分法（`claim_maximal_ordered_subfield_square_trichotomy`）
                                                                    `maximalOrderedSubfield_squareTrichotomy`
  第三条件: ω·ω = -1                                                  準備の ω
  第四条件の存在（`claim_adjoin_imaginary_unit_gives_algebraic_numbers`。仮定は
    `claim_maximal_ordered_subfield_positive_is_square` と `claim_maximal_ordered_subfield_odd_degree_root`）
                                                                    `adjoinImaginaryUnit_gives_algebraicNumbers`
  第四条件の一意性（`claim_imaginary_unit_extension_unique_representation`）
                                                                    `imaginaryUnitExtension_unique_representation`
  第五条件: s ∈ P_s（`def_quadratic_positive_cone`）、延長の等号で s ∈ C_R、
    正の元の平方根（`claim_maximal_ordered_subfield_positive_is_square`）
                                                                    `quadraticGenerator_mem_positiveCone` ほか

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.RealClosedSubfield
import Ising2DLambda.FisherZero.MaximalOrderedSubfieldSquareTrichotomy
import Ising2DLambda.FisherZero.MaximalOrderedSubfieldOddDegreeRoot
import Ising2DLambda.FisherZero.ImaginaryUnitExists
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionUniqueRepresentation
import Ising2DLambda.FisherZero.AdjoinImaginaryUnitGivesAlgebraicNumbers

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_real_closed_subfield_exists` の具体版。`s * s = 2` を満たす `s` について、
`def_real_closed_subfield` の五条件を満たす組 `(R, ω)` のデータがある。 -/
theorem realClosedSubfield_exists
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    Nonempty (RealClosedSubfieldSqrtTwoData s) := by
  -- 準備: 極大な正錐付き部分体 (R, C_R) と虚数単位 ω。
  obtain ⟨R, C, hbase, hmax⟩ := enumeratedOrderedSubfield_isMaximal s hs
  have hC : IsSubfieldPositiveCone R C := hbase.cone_E
  obtain ⟨omega, homega⟩ := imaginaryUnit_exists
  -- 第二条件: 平方の三分法を部分体の元の言葉へ移す。
  have htri : ∀ z : R,
      ExactlyOneOfThree (z = 0)
        (∃ w : R, w ≠ 0 ∧ z = w * w)
        (∃ w : R, w ≠ 0 ∧ -z = w * w) := by
    intro z
    have h := maximalOrderedSubfield_squareTrichotomy R C hC hmax (z : Qbar) z.2
    have e1 : (z = 0) = ((z : Qbar) = 0) :=
      propext ⟨fun h => by rw [h]; rfl, fun h => Subtype.ext h⟩
    have e2 : (∃ w : R, w ≠ 0 ∧ z = w * w) =
        (∃ w : Qbar, w ∈ R ∧ w ≠ 0 ∧ (z : Qbar) = w * w) := by
      apply propext
      constructor
      · rintro ⟨w, hw0, hw⟩
        exact ⟨w, w.2, fun h => hw0 (Subtype.ext h), by rw [hw]; rfl⟩
      · rintro ⟨w, hwR, hw0, hw⟩
        exact ⟨⟨w, hwR⟩, fun h => hw0 (congrArg Subtype.val h), Subtype.ext hw⟩
    have e3 : (∃ w : R, w ≠ 0 ∧ -z = w * w) =
        (∃ w : Qbar, w ∈ R ∧ w ≠ 0 ∧ -(z : Qbar) = w * w) := by
      apply propext
      constructor
      · rintro ⟨w, hw0, hw⟩
        exact ⟨w, w.2, fun h => hw0 (Subtype.ext h), by
          rw [show -(z : Qbar) = ((-z : R) : Qbar) from rfl, hw]; rfl⟩
      · rintro ⟨w, hwR, hw0, hw⟩
        exact ⟨⟨w, hwR⟩, fun h => hw0 (congrArg Subtype.val h), Subtype.ext hw⟩
    rw [e1, e2, e3]
    exact h
  -- 第四条件の存在の仮定: 正の元の平方根と奇数次の多項式の根。
  have hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ R ∧ w * w = z := by
    intro z hz
    obtain ⟨w, hwR, _, hw⟩ := maximalOrderedSubfield_positive_isSquare R C hC hmax z hz
    exact ⟨w, hwR, hw⟩
  have hodd : ∀ (n : ℕ) (p : QbarPoly), p ∈ subfieldCoefficientPolynomials R → Odd n →
      p.coeff n ≠ 0 → (∀ k : ℕ, n < k → p.coeff k = 0) →
      ∃ z : Qbar, z ∈ R ∧ qbarPolyEval z p = 0 :=
    fun n p hp hn hpn hpz => maximalOrderedSubfield_oddDegreeRoot R C hC hmax n p hp hn hpn hpz
  -- 第四条件: 存在は代数的数の全体になること、一意性は表示の一意性。
  have huniq : ∀ xi : Qbar, ∃! ab : R × R,
      xi = (ab.1 : Qbar) + (ab.2 : Qbar) * omega := by
    intro xi
    obtain ⟨u, v, huR, hvR, hxi⟩ :=
      adjoinImaginaryUnit_gives_algebraicNumbers R C hC hpositive hodd omega homega xi
    refine ⟨(⟨u, huR⟩, ⟨v, hvR⟩), hxi, ?_⟩
    rintro ⟨a, b⟩ hab
    obtain ⟨hua, hvb⟩ := imaginaryUnitExtension_unique_representation R C hC omega homega
      a u b v a.2 huR b.2 hvR (hab.symm.trans hxi)
    exact Prod.ext (Subtype.ext hua) (Subtype.ext hvb)
  -- 第五条件: s ∈ P_s、延長の等号 C_R ∩ Q_s = P_s で s ∈ C_R、正の元の平方根。
  have hsQs : s ∈ quadraticFieldSet s := by
    change ∃ a b : ℚ, s = algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s
    refine ⟨0, 1, ?_⟩
    simp
  have hsP : s ∈ quadraticPositiveConeAmbient s :=
    ⟨hsQs, quadraticGenerator_mem_positiveCone s hs⟩
  have hsC : s ∈ C := ((hbase.inter_eq s).2 hsP).1
  obtain ⟨b, hbR, hb0, hb⟩ := maximalOrderedSubfield_positive_isSquare R C hC hmax s hsC
  exact ⟨{
    carrier := R
    omega := omega
    squareTrichotomy := htri
    omega_sq := homega
    unique_decomposition := huniq
    sqrtTwo_square := ⟨⟨b, hbR⟩, fun h => hb0 (congrArg Subtype.val h), hb.symm⟩ }⟩

end Ising2DLambda.FisherZero
