/-
正本: content/finite-power-bound-certificate.ts の具体版。

def_finite_power_bound_certificate
  → FinitePowerBoundCertificate
claim_finite_power_bound_certificate_decidable
  → finitePowerBoundCertificate_decidable
def_finite_power_bound_cutoff_extensions
  → cutoffPowerConstantSequence, cutoffPowerSpikeSequence,
    finitePowerTableOfSequence
claim_finite_power_bound_cutoff_not_global
  → cutoffPowerSequences_agree_on_table,
    cutoffPowerConstantTable_hasCertificate,
    cutoffPowerSpikeTable_hasCertificate,
    cutoffPowerConstantSequence_nextBound,
    cutoffPowerSpikeSequence_nextBound_fails

正整数値有限表、正整数の指数候補、自然数の乗法・冪・順序比較に
固定し、本文と同じ順序で示す。商、根、対数、漸近的な指数、
スケーリング極限、実数体、複素数体は使わない。
-/
import CellularAutomata.FiniteSubmultiplicativeCountBounds
import Mathlib

namespace CellularAutomata.FinitePowerBoundCertificate

open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.FiniteSubmultiplicativeCountBounds
attribute [local instance] Fintype.decidableForallFintype

/-! ## 正整数値有限表の交差冪上界証明書 -/

/-- 有限表の全値が、指数候補 `(p, q)` の交差冪上界を満たす。 -/
def FinitePowerBoundCertificate
    (K : PositiveStage) (z : FinitePositiveCountTable K)
    (p q : PositiveStage) : Prop :=
  ∀ n : FiniteCountIndex K,
    (z n).val ^ q.val ≤ finiteCountIndexValue n ^ p.val

/-- 交差冪上界証明書の真偽は有限個の自然数比較で決定できる。 -/
instance finitePowerBoundCertificate_decidable
    (K : PositiveStage) (z : FinitePositiveCountTable K)
    (p q : PositiveStage) :
    Decidable (FinitePowerBoundCertificate K z p q) := by
  unfold FinitePowerBoundCertificate
  infer_instance

/-! ## 有限表が区別できない二つの後続列 -/

/-- 全ての正段階で値一を取る列。 -/
def cutoffPowerConstantSequence (_K n : PositiveStage) : PositiveStage := ⟨1, by omega⟩

/-- 打ち切りの次の段階だけ `(K + 1)^p + 1` を取る列。 -/
def cutoffPowerSpikeSequence (K p n : PositiveStage) : PositiveStage :=
  if n.val = K.val + 1 then ⟨(K.val + 1) ^ p.val + 1, by omega⟩ else ⟨1, by omega⟩

/-- 正整数列を指定した打ち切りの有限表へ制限する。 -/
def finitePowerTableOfSequence
    (K : PositiveStage) (u : PositiveStage → PositiveStage) :
    FinitePositiveCountTable K :=
  fun n => u ⟨finiteCountIndexValue n, by
    unfold finiteCountIndexValue
    omega⟩

/-- 二列は打ち切り以下の有限表上で一致する。 -/
theorem cutoffPowerSequences_agree_on_table (K p : PositiveStage) :
    finitePowerTableOfSequence K (cutoffPowerConstantSequence K) =
      finitePowerTableOfSequence K (cutoffPowerSpikeSequence K p) := by
  funext n
  apply Subtype.ext
  have hne : finiteCountIndexValue n ≠ K.val + 1 := by
    unfold finiteCountIndexValue
    omega
  simp [finitePowerTableOfSequence, cutoffPowerConstantSequence,
    cutoffPowerSpikeSequence, hne]

/-- 定数列の有限表は任意の正整数指数候補に対する証明書を持つ。 -/
theorem cutoffPowerConstantTable_hasCertificate
    (K p q : PositiveStage) :
    FinitePowerBoundCertificate K
      (finitePowerTableOfSequence K (cutoffPowerConstantSequence K)) p q := by
  intro n
  change 1 ^ q.val ≤ finiteCountIndexValue n ^ p.val
  rw [one_pow]
  apply Nat.one_le_pow
  change 0 < n.val + 1
  omega

/-- 尖り列の有限表も、定数列と同じ証明書を持つ。 -/
theorem cutoffPowerSpikeTable_hasCertificate
    (K p q : PositiveStage) :
    FinitePowerBoundCertificate K
      (finitePowerTableOfSequence K (cutoffPowerSpikeSequence K p)) p q := by
  rw [← cutoffPowerSequences_agree_on_table K p]
  exact cutoffPowerConstantTable_hasCertificate K p q

/-- 定数列は打ち切りの次の交差冪上界を満たす。 -/
theorem cutoffPowerConstantSequence_nextBound
    (K p q : PositiveStage) :
    (cutoffPowerConstantSequence K ⟨K.val + 1, by omega⟩).val ^ q.val ≤
      (K.val + 1) ^ p.val := by
  change 1 ^ q.val ≤ (K.val + 1) ^ p.val
  rw [one_pow]
  exact Nat.one_le_pow p.val (K.val + 1) (by omega)

/-- 尖り列は打ち切りの次の交差冪上界を満たさない。 -/
theorem cutoffPowerSpikeSequence_nextBound_fails
    (K p q : PositiveStage) :
    (cutoffPowerSpikeSequence K p ⟨K.val + 1, by omega⟩).val ^ q.val >
      (K.val + 1) ^ p.val := by
  have hbase : (K.val + 1) ^ p.val < (K.val + 1) ^ p.val + 1 := by omega
  have hpower : (K.val + 1) ^ p.val + 1 ≤
      ((K.val + 1) ^ p.val + 1) ^ q.val :=
    Nat.le_pow q.property
  simpa [cutoffPowerSpikeSequence] using lt_of_lt_of_le hbase hpower

end CellularAutomata.FinitePowerBoundCertificate
