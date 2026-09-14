/-
正本: content/finite-submultiplicative-count-bounds.ts の必要十分版。

具体版から次の不要な構造を取り除く。

* 有限証明書の決定には、有限な添字型、判定可能な候補対、判定可能な順序比較だけを要る。
* 倍数添字上界には、正整数値列の初項上界と各段の乗法上界だけを要る。
* 交差冪比較には、自然数冪の単調性と冪の冪の法則だけを要る。
* 有限表から後続命題を決められないことには、同じ有限像を持ちながら命題の真偽が異なる
  二つの入力だけを要る。

対数、除算、極限値、下限、完備化、実数体、複素数体は使わない。
-/
import CellularAutomata.FiniteSubmultiplicativeCountBounds
import Mathlib

namespace CellularAutomata.NecSuf.FiniteSubmultiplicativeCountBounds

open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.FiniteSubmultiplicativeCountBounds
attribute [local instance] Fintype.decidableForallFintype

/-! ## 有限証明書の決定に必要な構造 -/

/-- 有限な候補対のそれぞれについて、指定した二値を順序比較する証明書。 -/
def FiniteComparisonCertificate
    {Index Value : Type}
    (required : Index → Index → Prop)
    (left right : Index → Index → Value) [LE Value] : Prop :=
  ∀ first second : Index, required first second →
    left first second ≤ right first second

/-- 候補対と値の順序が判定可能なら、有限比較証明書も決定可能である。 -/
instance finiteComparisonCertificate_decidable
    {Index Value : Type} [Fintype Index]
    (required : Index → Index → Prop) [DecidableRel required]
    (left right : Index → Index → Value) [LE Value] [DecidableLE Value] :
    Decidable (FiniteComparisonCertificate required left right) := by
  unfold FiniteComparisonCertificate
  infer_instance

/-- 具体版の有限劣乗法証明書は、有限比較証明書の特殊化である。 -/
theorem finiteSubmultiplicativeCertificate_iff_finiteComparison
    (K : PositiveStage) (z : FinitePositiveCountTable K) :
    FiniteSubmultiplicativeCertificate K z ↔
      FiniteComparisonCertificate
        (fun m n : FiniteCountIndex K =>
          finiteCountIndexValue m + finiteCountIndexValue n ≤ K.val)
        (fun m n : FiniteCountIndex K =>
          finitePositiveCountValue K z
            (finiteCountIndexValue m + finiteCountIndexValue n))
        (fun m n : FiniteCountIndex K =>
          finitePositiveCountValue K z (finiteCountIndexValue m) *
            finitePositiveCountValue K z (finiteCountIndexValue n)) := by
  rfl

/-! ## 倍数添字上界に必要な構造 -/

/--
正整数値列の初項が `a` 以下で、各後続項が直前項と `a` の積以下なら、
正の有限段階 `q` の値は `a^q` 以下である。
-/
theorem naturalPowerBound_of_initial_and_step
    (sequence : ℕ → ℕ) (a q : ℕ) (hq : 0 < q)
    (hinitial : sequence 1 ≤ a)
    (hstep : ∀ r : ℕ, 0 < r → r < q →
      sequence (r + 1) ≤ sequence r * a) :
    sequence q ≤ a ^ q := by
  induction q with
  | zero => omega
  | succ q ih =>
    cases q with
    | zero => simpa using hinitial
    | succ k =>
      have hprevious : sequence (k + 1) ≤ a ^ (k + 1) :=
        ih (by omega) (fun r hr hrk => hstep r hr (by omega))
      calc
        sequence (k + 1 + 1) ≤ sequence (k + 1) * a :=
          hstep (k + 1) (by omega) (by omega)
        _ ≤ a ^ (k + 1) * a := Nat.mul_le_mul_right a hprevious
        _ = a ^ (k + 1 + 1) := by simp [pow_succ, Nat.mul_assoc]

/-- 一つの上界を正整数乗すれば、交差冪比較が得られる。 -/
theorem naturalCrossPowerComparison_of_bound
    (left right exponent multiplier : ℕ)
    (hbound : left ≤ right ^ multiplier) :
    left ^ exponent ≤ right ^ (multiplier * exponent) := by
  calc
    left ^ exponent ≤ (right ^ multiplier) ^ exponent :=
      Nat.pow_le_pow_left hbound exponent
    _ = right ^ (multiplier * exponent) := by rw [pow_mul]

/-! ## 有限像が後続命題を決定しないために必要な構造 -/

/--
同じ有限像を持つ二入力で命題の真偽が異なれば、その有限像だけに依存する判定器は存在しない。
-/
theorem noClassifier_of_same_finite_view
    {Source View : Type}
    (finiteView : Source → View) (property : Source → Prop)
    (left right : Source)
    (hsame : finiteView left = finiteView right)
    (hleft : property left) (hright : ¬ property right) :
    ¬ ∃ classifier : View → Prop,
      ∀ source : Source, classifier (finiteView source) ↔ property source := by
  rintro ⟨classifier, hclassifier⟩
  have hclassifiedLeft := (hclassifier left).2 hleft
  have hclassifiedRight : classifier (finiteView right) := by
    rw [← hsame]
    exact hclassifiedLeft
  exact hright ((hclassifier right).1 hclassifiedRight)

/-! ## 具体版の導出 -/

/-- 具体版の有限劣乗法証明書の決定は、有限比較証明書の決定の特殊化である。 -/
def finiteSubmultiplicativeCertificate_decidable_of_necSuf
    (K : PositiveStage) (z : FinitePositiveCountTable K) :
    Decidable (FiniteSubmultiplicativeCertificate K z) := by
  rw [finiteSubmultiplicativeCertificate_iff_finiteComparison]
  infer_instance

/-- 具体版の倍数添字上界は、初項上界と各段の乗法上界だけを使う一般定理から得られる。 -/
theorem finiteSubmultiplicative_multipleIndexBound_of_necSuf
    (K : PositiveStage) (z : FinitePositiveCountTable K)
    (hcertificate : FiniteSubmultiplicativeCertificate K z)
    (m q : PositiveStage) (hqm : q.val * m.val ≤ K.val) :
    finitePositiveCountValue K z (q.val * m.val) ≤
      finitePositiveCountValue K z m.val ^ q.val := by
  let sequence : ℕ → ℕ := fun r => finitePositiveCountValue K z (r * m.val)
  apply naturalPowerBound_of_initial_and_step sequence
    (finitePositiveCountValue K z m.val) q.val q.property
  · simp [sequence]
  · intro r hr hrq
    have hmK : m.val ≤ K.val := by
      calc
        m.val = 1 * m.val := by simp
        _ ≤ q.val * m.val := Nat.mul_le_mul_right m.val q.property
        _ ≤ K.val := hqm
    have hrmPos : 0 < r * m.val := Nat.mul_pos hr m.property
    have hrmK : r * m.val ≤ K.val := by
      exact le_trans (Nat.mul_le_mul_right m.val (Nat.le_of_lt hrq)) hqm
    have hsumK : r * m.val + m.val ≤ K.val := by
      calc
        r * m.val + m.val = (r + 1) * m.val := by ring
        _ ≤ q.val * m.val := Nat.mul_le_mul_right m.val hrq
        _ ≤ K.val := hqm
    have hbound := hcertificate
      (finiteCountIndexOf K (r * m.val) hrmPos hrmK)
      (finiteCountIndexOf K m.val m.property hmK) (by
        simpa only [finiteCountIndexValue_of] using hsumK)
    simpa only [sequence, finiteCountIndexValue_of, add_mul, one_mul] using hbound

/-- 具体版の交差冪比較は、一般の冪単調性の特殊化である。 -/
theorem finiteSubmultiplicative_multipleIndexDensityComparison_of_necSuf
    (K : PositiveStage) (z : FinitePositiveCountTable K)
    (hcertificate : FiniteSubmultiplicativeCertificate K z)
    (m q : PositiveStage) (hqm : q.val * m.val ≤ K.val) :
    FiniteDensityComparison
      ⟨q.val * m.val, Nat.mul_pos q.property m.property⟩
      ⟨finitePositiveCountValue K z (q.val * m.val), finitePositiveCountValue_pos K z _⟩
      m ⟨finitePositiveCountValue K z m.val, finitePositiveCountValue_pos K z _⟩ := by
  unfold FiniteDensityComparison
  exact naturalCrossPowerComparison_of_bound _ _ m.val q.val
    (finiteSubmultiplicative_multipleIndexBound_of_necSuf
      K z hcertificate m q hqm)

/--
具体版の二つの後続列により、有限表だけから次段階の劣乗法不等式を判定することはできない。
-/
theorem cutoffTable_has_no_nextInequalityClassifier_of_necSuf
    (K : PositiveStage) :
    ¬ ∃ classifier : FinitePositiveCountTable K → Prop,
      ∀ sequence : PositiveStage → PositiveStage,
        classifier (finiteTableOfSequence K sequence) ↔
          (sequence ⟨K.val + 1, by omega⟩).val ≤
            (sequence K).val * (sequence ⟨1, by omega⟩).val := by
  apply noClassifier_of_same_finite_view
    (finiteTableOfSequence K)
    (fun sequence : PositiveStage → PositiveStage =>
      (sequence ⟨K.val + 1, by omega⟩).val ≤
        (sequence K).val * (sequence ⟨1, by omega⟩).val)
    (cutoffConstantSequence K) (cutoffSpikeSequence K)
  · exact cutoffSequences_agree_on_table K
  · exact cutoffConstantSequence_nextInequality K
  · exact Nat.not_le_of_lt (cutoffSpikeSequence_nextInequality_fails K)

end CellularAutomata.NecSuf.FiniteSubmultiplicativeCountBounds
