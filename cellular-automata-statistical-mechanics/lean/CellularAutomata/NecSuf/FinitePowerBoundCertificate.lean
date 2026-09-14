/-
正本: content/finite-power-bound-certificate.ts の必要十分版。

具体版から次の不要な構造を取り除く。

* 交差冪上界証明書の決定には、有限な添字型と自然数の冪・順序比較だけを要る。
* 値一の有限表の証明書には、右辺の底が正であることだけを要る。
* 打ち切り反例には、自然数添字と正の指数だけを要る。

商、根、対数、漸近的な指数、スケーリング極限、実数体、複素数体は使わない。
-/
import CellularAutomata.FinitePowerBoundCertificate
import Mathlib

namespace CellularAutomata.NecSuf.FinitePowerBoundCertificate

open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.FiniteSubmultiplicativeCountBounds
open CellularAutomata.FinitePowerBoundCertificate
attribute [local instance] Fintype.decidableForallFintype

/-! ## 有限交差冪比較に必要な構造 -/

/-- 有限添字上の二つの自然数値表に対する交差冪上界証明書。 -/
def FinitePowerComparisonCertificate
    {Index : Type} (left right : Index → ℕ) (p q : ℕ) : Prop :=
  ∀ index : Index, left index ^ q ≤ right index ^ p

/-- 添字が有限なら、交差冪上界証明書は自然数比較だけで決定できる。 -/
instance finitePowerComparisonCertificate_decidable
    {Index : Type} [Fintype Index]
    (left right : Index → ℕ) (p q : ℕ) :
    Decidable (FinitePowerComparisonCertificate left right p q) := by
  unfold FinitePowerComparisonCertificate
  infer_instance

/-- 具体版の証明書は、有限交差冪比較証明書の特殊化である。 -/
theorem finitePowerBoundCertificate_iff_finitePowerComparison
    (K : PositiveStage) (z : FinitePositiveCountTable K)
    (p q : PositiveStage) :
    CellularAutomata.FinitePowerBoundCertificate.FinitePowerBoundCertificate K z p q ↔
      FinitePowerComparisonCertificate
        (fun n : FiniteCountIndex K => (z n).val)
        finiteCountIndexValue p.val q.val := by
  rfl

/-! ## 値一の表と尖り値に必要な構造 -/

/-- 右辺の底が正なら、値一の表は任意の自然数指数候補に対する証明書を持つ。 -/
theorem oneTable_hasCertificate
    {Index : Type} (right : Index → ℕ) (p q : ℕ)
    (hright : ∀ index, 0 < right index) :
    FinitePowerComparisonCertificate (fun _ => 1) right p q := by
  intro index
  change 1 ^ q ≤ right index ^ p
  rw [one_pow]
  exact Nat.one_le_pow p (right index) (hright index)

/-- 正の指数で尖り値を冪乗すると、尖り前の自然数冪を真に上回る。 -/
theorem spikePower_exceeds
    (base p q : ℕ) (hq : 0 < q) :
    base ^ p < (base ^ p + 1) ^ q := by
  have hsuccessor : base ^ p < base ^ p + 1 := by omega
  have hpower : base ^ p + 1 ≤ (base ^ p + 1) ^ q :=
    Nat.le_pow hq
  exact lt_of_lt_of_le hsuccessor hpower

/-- 打ち切り以下の添字では、値一の列と次段階だけ尖らせた列は一致する。 -/
theorem constant_eq_spike_below_cutoff
    (cutoff p index : ℕ) (hindex : index ≤ cutoff) :
    1 = (if index = cutoff + 1 then cutoff.succ ^ p + 1 else 1) := by
  have hne : index ≠ cutoff + 1 := by omega
  simp [hne]

/-! ## 具体版の導出 -/

/-- 具体版の有限決定は、有限添字上の一般証明書の決定の特殊化である。 -/
def finitePowerBoundCertificate_decidable_of_necSuf
    (K : PositiveStage) (z : FinitePositiveCountTable K)
    (p q : PositiveStage) :
    Decidable
      (CellularAutomata.FinitePowerBoundCertificate.FinitePowerBoundCertificate K z p q) := by
  rw [finitePowerBoundCertificate_iff_finitePowerComparison]
  infer_instance

/-- 具体版の二列の有限表一致は、打ち切り以下での一般の一致から得られる。 -/
theorem cutoffPowerSequences_agree_on_table_of_necSuf (K p : PositiveStage) :
    finitePowerTableOfSequence K (cutoffPowerConstantSequence K) =
      finitePowerTableOfSequence K (cutoffPowerSpikeSequence K p) := by
  funext n
  apply Subtype.ext
  have hindex : finiteCountIndexValue n ≤ K.val := by
    unfold finiteCountIndexValue
    omega
  have hagree := constant_eq_spike_below_cutoff
    K.val p.val (finiteCountIndexValue n) hindex
  have hne : finiteCountIndexValue n ≠ K.val + 1 := by omega
  simpa [finitePowerTableOfSequence, cutoffPowerConstantSequence,
    cutoffPowerSpikeSequence, hne] using hagree

/-- 具体版の定数列の証明書は、値一の一般定理の特殊化である。 -/
theorem cutoffPowerConstantTable_hasCertificate_of_necSuf
    (K p q : PositiveStage) :
    CellularAutomata.FinitePowerBoundCertificate.FinitePowerBoundCertificate K
      (finitePowerTableOfSequence K (cutoffPowerConstantSequence K)) p q := by
  rw [finitePowerBoundCertificate_iff_finitePowerComparison]
  apply oneTable_hasCertificate
  intro n
  unfold finiteCountIndexValue
  omega

/-- 具体版の尖り列の有限表も、一般の有限表一致と値一の証明書から得られる。 -/
theorem cutoffPowerSpikeTable_hasCertificate_of_necSuf
    (K p q : PositiveStage) :
    CellularAutomata.FinitePowerBoundCertificate.FinitePowerBoundCertificate K
      (finitePowerTableOfSequence K (cutoffPowerSpikeSequence K p)) p q := by
  rw [← cutoffPowerSequences_agree_on_table_of_necSuf K p]
  exact cutoffPowerConstantTable_hasCertificate_of_necSuf K p q

/-- 具体版の定数列の次段階上界は、値一の一般定理の特殊化である。 -/
theorem cutoffPowerConstantSequence_nextBound_of_necSuf
    (K p q : PositiveStage) :
    (cutoffPowerConstantSequence K ⟨K.val + 1, by omega⟩).val ^ q.val ≤
      (K.val + 1) ^ p.val := by
  change 1 ^ q.val ≤ (K.val + 1) ^ p.val
  exact oneTable_hasCertificate (Index := Unit)
    (fun _ => K.val + 1) p.val q.val (fun _ => by omega) ()

/-- 具体版の尖り列の次段階での失敗は、尖り値の一般定理の特殊化である。 -/
theorem cutoffPowerSpikeSequence_nextBound_fails_of_necSuf
    (K p q : PositiveStage) :
    (cutoffPowerSpikeSequence K p ⟨K.val + 1, by omega⟩).val ^ q.val >
      (K.val + 1) ^ p.val := by
  simpa [cutoffPowerSpikeSequence] using
    spikePower_exceeds (K.val + 1) p.val q.val q.property

end CellularAutomata.NecSuf.FinitePowerBoundCertificate
