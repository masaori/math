/-
「実閉部分体と虚数単位の組は存在する」（ラベル `claim_real_closed_subfield_exists`）の必要十分版。

具体版と同じ手順（極大な組と虚数単位を取り、三分法・全体になること・一意性・正の元の平方根を当てる）を、
次だけを仮定して述べる。
- 元の型 `K` の乗法・加法・符号反転・零・負の単位元と、部分集合の型 `T` の台 `carrier`。
- 正錐であること `IsCone` と極大であること `IsMax` は述語のまま扱う（中身を使わない）。
- 極大な組の存在と、その正錐が固定した元 `s` を含むこと（具体版では二次体の正錐の延長から従う）。
- 部品の主張の結論: 正の元の平方根、平方の三分法、奇数次の根を持つこと（述語 `OddRoots` のまま）、
  全体になること、表示の一意性、虚数単位の存在。
体の公理、正錐の三条件、多項式、代数閉性は使わない。
-/
import Ising2DLambda.NecSuf.FisherZero.RealAlgebraicOrder

namespace Ising2DLambda.NecSuf.FisherZero

/-- `claim_real_closed_subfield_exists` の必要十分版。 -/
theorem realClosedSubfield_exists_necSuf
    {K T : Type} [Zero K] [One K] [Add K] [Mul K] [Neg K]
    (carrier : T → Set K) (IsCone : T → Set K → Prop) (IsMax : T → Set K → Prop)
    (OddRoots : T → Prop) (s : K)
    -- 極大な組の存在（`claim_enumerated_ordered_subfield_is_maximal` と延長の等号から s ∈ C）
    (hmaxExists : ∃ (R : T) (C : Set K), IsCone R C ∧ IsMax R C ∧ s ∈ C)
    -- `claim_imaginary_unit_exists`
    (himag : ∃ omega : K, omega * omega = -1)
    -- `claim_maximal_ordered_subfield_positive_is_square`
    (hsquare : ∀ (R : T) (C : Set K), IsCone R C → IsMax R C →
      ∀ a ∈ C, ∃ b : K, b ∈ carrier R ∧ b ≠ 0 ∧ b * b = a)
    -- `claim_maximal_ordered_subfield_square_trichotomy`
    (htri : ∀ (R : T) (C : Set K), IsCone R C → IsMax R C →
      ∀ z ∈ carrier R, ExactlyOneOfThree (z = 0)
        (∃ w : K, w ∈ carrier R ∧ w ≠ 0 ∧ z = w * w)
        (∃ w : K, w ∈ carrier R ∧ w ≠ 0 ∧ -z = w * w))
    -- `claim_maximal_ordered_subfield_odd_degree_root`
    (hodd : ∀ (R : T) (C : Set K), IsCone R C → IsMax R C → OddRoots R)
    -- `claim_adjoin_imaginary_unit_gives_algebraic_numbers`
    (hall : ∀ (R : T) (C : Set K), IsCone R C →
      (∀ a ∈ C, ∃ w : K, w ∈ carrier R ∧ w * w = a) → OddRoots R →
      ∀ omega : K, omega * omega = -1 →
      ∀ xi : K, ∃ u v : K, u ∈ carrier R ∧ v ∈ carrier R ∧ xi = u + v * omega)
    -- `claim_imaginary_unit_extension_unique_representation`
    (hunique : ∀ (R : T) (C : Set K), IsCone R C →
      ∀ omega : K, omega * omega = -1 →
      ∀ a a' b b' : K, a ∈ carrier R → a' ∈ carrier R → b ∈ carrier R → b' ∈ carrier R →
      a + b * omega = a' + b' * omega → a = a' ∧ b = b') :
    ∃ (R : T) (omega : K),
      (∀ z ∈ carrier R, ExactlyOneOfThree (z = 0)
        (∃ w : K, w ∈ carrier R ∧ w ≠ 0 ∧ z = w * w)
        (∃ w : K, w ∈ carrier R ∧ w ≠ 0 ∧ -z = w * w)) ∧
      omega * omega = -1 ∧
      (∀ xi : K, ∃ u v : K, u ∈ carrier R ∧ v ∈ carrier R ∧ xi = u + v * omega) ∧
      (∀ a a' b b' : K, a ∈ carrier R → a' ∈ carrier R → b ∈ carrier R → b' ∈ carrier R →
        a + b * omega = a' + b' * omega → a = a' ∧ b = b') ∧
      (∃ w : K, w ∈ carrier R ∧ w ≠ 0 ∧ s = w * w) := by
  obtain ⟨R, C, hC, hmax, hsC⟩ := hmaxExists
  obtain ⟨omega, homega⟩ := himag
  have hpositive : ∀ a ∈ C, ∃ w : K, w ∈ carrier R ∧ w * w = a := by
    intro a ha
    obtain ⟨w, hwR, _, hw⟩ := hsquare R C hC hmax a ha
    exact ⟨w, hwR, hw⟩
  obtain ⟨b, hbR, hb0, hb⟩ := hsquare R C hC hmax s hsC
  exact ⟨R, omega, htri R C hC hmax, homega,
    hall R C hC hpositive (hodd R C hC hmax) omega homega,
    hunique R C hC omega homega, ⟨b, hbR, hb0, hb.symm⟩⟩

end Ising2DLambda.NecSuf.FisherZero
