/-
正本: content/finite-submultiplicative-count-bounds.ts の具体版。

def_finite_submultiplicative_count_certificate
  → FiniteCountIndex, FinitePositiveCountTable, FiniteSubmultiplicativeCertificate
claim_finite_submultiplicative_count_certificate_decidable
  → finiteSubmultiplicativeCertificate_decidable
def_finite_count_density_comparison → FiniteDensityComparison
claim_finite_submultiplicative_count_multiple_index_density_bound
  → finiteSubmultiplicative_multipleIndexBound,
    finiteSubmultiplicative_multipleIndexDensityComparison
def_finite_submultiplicative_count_cutoff_extensions
  → cutoffConstantSequence, cutoffSpikeSequence, finiteTableOfSequence
claim_finite_submultiplicative_count_cutoff_not_global
  → cutoffSequences_agree_on_table,
    cutoffConstantTable_hasCertificate, cutoffSpikeTable_hasCertificate,
    cutoffConstantSequence_nextInequality, cutoffSpikeSequence_nextInequality_fails

正整数値有限表と打ち切り反例に固定し、本文と同じ順序で示す。
自然数の加法・乗法・冪・順序比較だけを使い、対数、除算、極限値、
完備化、実数体、複素数体は使わない。
-/
import CellularAutomata.CyclicStageLocalAgreement
import Mathlib

namespace CellularAutomata.FiniteSubmultiplicativeCountBounds

open CellularAutomata.CyclicStageLocalAgreement
attribute [local instance] Fintype.decidableForallFintype

/-! ## 正整数値有限表と劣乗法証明書 -/

/-- 正の打ち切り `K` 以下の正整数添字。値は `n.val + 1` と読む。 -/
abbrev FiniteCountIndex (K : PositiveStage) := Fin K.val

def finiteCountIndexValue {K : PositiveStage} (n : FiniteCountIndex K) : ℕ := n.val + 1

/-- 正整数値の有限表。 -/
abbrev FinitePositiveCountTable (K : PositiveStage) := FiniteCountIndex K → PositiveStage

/-- 有限表の定義域外を値一で補う。証明では常に定義域内だけを読む。 -/
def finitePositiveCountValue
    (K : PositiveStage) (z : FinitePositiveCountTable K) (n : ℕ) : ℕ :=
  if h : 1 ≤ n ∧ n ≤ K.val then (z ⟨n - 1, by omega⟩).val else 1

theorem finitePositiveCountValue_pos
    (K : PositiveStage) (z : FinitePositiveCountTable K) (n : ℕ) :
    0 < finitePositiveCountValue K z n := by
  unfold finitePositiveCountValue
  split
  · exact (z _).property
  · omega

/-- 有限表内の全ての可加添字対に対する劣乗法不等式。 -/
def FiniteSubmultiplicativeCertificate
    (K : PositiveStage) (z : FinitePositiveCountTable K) : Prop :=
  ∀ m n : FiniteCountIndex K,
    finiteCountIndexValue m + finiteCountIndexValue n ≤ K.val →
      finitePositiveCountValue K z (finiteCountIndexValue m + finiteCountIndexValue n) ≤
        finitePositiveCountValue K z (finiteCountIndexValue m) *
          finitePositiveCountValue K z (finiteCountIndexValue n)

def finiteCountIndexOf
    (K : PositiveStage) (n : ℕ) (hpos : 0 < n) (hle : n ≤ K.val) :
    FiniteCountIndex K := ⟨n - 1, by omega⟩

theorem finiteCountIndexValue_of
    (K : PositiveStage) (n : ℕ) (hpos : 0 < n) (hle : n ≤ K.val) :
    finiteCountIndexValue (finiteCountIndexOf K n hpos hle) = n := by
  change n - 1 + 1 = n
  omega

/-- 有限劣乗法証明書の真偽は有限個の自然数比較で決定できる。 -/
instance finiteSubmultiplicativeCertificate_decidable
    (K : PositiveStage) (z : FinitePositiveCountTable K) :
    Decidable (FiniteSubmultiplicativeCertificate K z) := by
  unfold FiniteSubmultiplicativeCertificate
  infer_instance

/-! ## 対数と除算を使わない密度比較 -/

/-- 段階と正整数値の交差冪による密度比較。 -/
def FiniteDensityComparison (m a n b : PositiveStage) : Prop :=
  a.val ^ n.val ≤ b.val ^ m.val

/-- 有限劣乗法証明書から、打ち切り内の倍数段階上界が従う。 -/
theorem finiteSubmultiplicative_multipleIndexBound
    (K : PositiveStage) (z : FinitePositiveCountTable K)
    (hcertificate : FiniteSubmultiplicativeCertificate K z)
    (m q : PositiveStage) (hqm : q.val * m.val ≤ K.val) :
    finitePositiveCountValue K z (q.val * m.val) ≤
      finitePositiveCountValue K z m.val ^ q.val := by
  have hmK : m.val ≤ K.val := by
    calc
      m.val = 1 * m.val := by simp
      _ ≤ q.val * m.val := Nat.mul_le_mul_right m.val q.property
      _ ≤ K.val := hqm
  have hbound : ∀ r : ℕ, r + 1 ≤ q.val →
      finitePositiveCountValue K z ((r + 1) * m.val) ≤
        finitePositiveCountValue K z m.val ^ (r + 1) := by
    intro r
    induction r with
    | zero =>
        intro hr
        simp
    | succ r ih =>
        intro hr
        have hrPrevious : r + 1 ≤ q.val := by omega
        have hprevious := ih hrPrevious
        have hpreviousPos : 0 < (r + 1) * m.val :=
          Nat.mul_pos (by omega) m.property
        have hpreviousK : (r + 1) * m.val ≤ K.val :=
          le_trans (Nat.mul_le_mul_right m.val hrPrevious) hqm
        have hmPos : 0 < m.val := m.property
        have hsumK : (r + 1) * m.val + m.val ≤ K.val := by
          calc
            (r + 1) * m.val + m.val = (r + 2) * m.val := by ring
            _ ≤ q.val * m.val := Nat.mul_le_mul_right m.val hr
            _ ≤ K.val := hqm
        have hstep := hcertificate
          (finiteCountIndexOf K ((r + 1) * m.val) hpreviousPos hpreviousK)
          (finiteCountIndexOf K m.val hmPos hmK) (by
            simpa [finiteCountIndexValue_of] using hsumK)
        calc
          finitePositiveCountValue K z ((r + 1 + 1) * m.val) =
              finitePositiveCountValue K z ((r + 1) * m.val + m.val) := by
                congr 1 <;> ring
          _ ≤ finitePositiveCountValue K z ((r + 1) * m.val) *
              finitePositiveCountValue K z m.val := by
                simpa only [finiteCountIndexValue_of] using hstep
          _ ≤ finitePositiveCountValue K z m.val ^ (r + 1) *
              finitePositiveCountValue K z m.val := by
                exact Nat.mul_le_mul_right _ hprevious
          _ = finitePositiveCountValue K z m.val ^ (r + 1 + 1) := by
                simp [pow_succ, Nat.mul_assoc]
  have hfinal := hbound (q.val - 1) (by omega)
  have hq : q.val - 1 + 1 = q.val := by omega
  simpa [hq] using hfinal

/-- 倍数段階上界を正整数乗すると、交差冪による密度比較が得られる。 -/
theorem finiteSubmultiplicative_multipleIndexDensityComparison
    (K : PositiveStage) (z : FinitePositiveCountTable K)
    (hcertificate : FiniteSubmultiplicativeCertificate K z)
    (m q : PositiveStage) (hqm : q.val * m.val ≤ K.val) :
    FiniteDensityComparison
      ⟨q.val * m.val, Nat.mul_pos q.property m.property⟩
      ⟨finitePositiveCountValue K z (q.val * m.val), finitePositiveCountValue_pos K z _⟩
      m ⟨finitePositiveCountValue K z m.val, finitePositiveCountValue_pos K z _⟩ := by
  unfold FiniteDensityComparison
  calc
    finitePositiveCountValue K z (q.val * m.val) ^ m.val ≤
        (finitePositiveCountValue K z m.val ^ q.val) ^ m.val :=
      Nat.pow_le_pow_left
        (finiteSubmultiplicative_multipleIndexBound K z hcertificate m q hqm) m.val
    _ = finitePositiveCountValue K z m.val ^ (q.val * m.val) := by
      rw [pow_mul]

/-! ## 有限表が区別できない二つの後続列 -/

/-- 全ての正段階で値一を取る列。 -/
def cutoffConstantSequence (_K n : PositiveStage) : PositiveStage := ⟨1, by omega⟩

/-- 打ち切りの次の段階だけ値二を取る列。 -/
def cutoffSpikeSequence (K n : PositiveStage) : PositiveStage :=
  if n.val = K.val + 1 then ⟨2, by omega⟩ else ⟨1, by omega⟩

/-- 正整数列を指定した打ち切りの有限表へ制限する。 -/
def finiteTableOfSequence
    (K : PositiveStage) (u : PositiveStage → PositiveStage) :
    FinitePositiveCountTable K :=
  fun n => u ⟨finiteCountIndexValue n, by
    unfold finiteCountIndexValue
    omega⟩

/-- 二列は打ち切り以下の有限表上で一致する。 -/
theorem cutoffSequences_agree_on_table (K : PositiveStage) :
    finiteTableOfSequence K (cutoffConstantSequence K) =
      finiteTableOfSequence K (cutoffSpikeSequence K) := by
  funext n
  apply Subtype.ext
  have hne : finiteCountIndexValue n ≠ K.val + 1 := by
    unfold finiteCountIndexValue
    omega
  simp [finiteTableOfSequence, cutoffConstantSequence, cutoffSpikeSequence, hne]

/-- 定数列の有限表は有限劣乗法証明書を持つ。 -/
theorem cutoffConstantTable_hasCertificate (K : PositiveStage) :
    FiniteSubmultiplicativeCertificate K
      (finiteTableOfSequence K (cutoffConstantSequence K)) := by
  intro m n hsum
  have hmDomain : 1 ≤ finiteCountIndexValue m ∧
      finiteCountIndexValue m ≤ K.val := by
    unfold finiteCountIndexValue
    omega
  have hnDomain : 1 ≤ finiteCountIndexValue n ∧
      finiteCountIndexValue n ≤ K.val := by
    unfold finiteCountIndexValue
    omega
  have hsumDomain : 1 ≤ finiteCountIndexValue m + finiteCountIndexValue n ∧
      finiteCountIndexValue m + finiteCountIndexValue n ≤ K.val := ⟨by omega, hsum⟩
  simp [finitePositiveCountValue, hmDomain, hnDomain, hsumDomain,
    finiteTableOfSequence, cutoffConstantSequence]
  change (1 : ℕ) ≤ 1 * 1
  omega

/-- 尖り列の有限表も、定数列と同じ有限劣乗法証明書を持つ。 -/
theorem cutoffSpikeTable_hasCertificate (K : PositiveStage) :
    FiniteSubmultiplicativeCertificate K
      (finiteTableOfSequence K (cutoffSpikeSequence K)) := by
  rw [← cutoffSequences_agree_on_table K]
  exact cutoffConstantTable_hasCertificate K

/-- 定数列は打ち切りの次の劣乗法不等式を満たす。 -/
theorem cutoffConstantSequence_nextInequality (K : PositiveStage) :
    (cutoffConstantSequence K ⟨K.val + 1, by omega⟩).val ≤
      (cutoffConstantSequence K K).val *
        (cutoffConstantSequence K ⟨1, by omega⟩).val := by
  change 1 ≤ 1 * 1
  omega

/-- 尖り列は打ち切りの次の劣乗法不等式を満たさない。 -/
theorem cutoffSpikeSequence_nextInequality_fails (K : PositiveStage) :
    (cutoffSpikeSequence K ⟨K.val + 1, by omega⟩).val >
      (cutoffSpikeSequence K K).val *
        (cutoffSpikeSequence K ⟨1, by omega⟩).val := by
  have hcurrent : K.val ≠ K.val + 1 := by omega
  have hone : 1 ≠ K.val + 1 := by omega
  have hzero : K.val ≠ 0 := by omega
  simp [cutoffSpikeSequence, hcurrent, hone, hzero]
  change (1 : ℕ) * 1 < 2
  omega

end CellularAutomata.FiniteSubmultiplicativeCountBounds
