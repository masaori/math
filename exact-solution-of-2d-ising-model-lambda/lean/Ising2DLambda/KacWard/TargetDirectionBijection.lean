/- 本文 `claim_target_direction_bijection` の具体版。
反転の端点・方向の等式と始点・方向の全単射を合成する。 -/
import Ising2DLambda.KacWard.ShortPairRotationPhaseNonzero

namespace Ising2DLambda.KacWard

theorem targetDirection_bijective {L : ℕ} [NeZero L] :
    Function.Bijective (fun e : OrientedEdge L => (orientedTarget e, directionNumber e)) := by
  constructor
  · intro e f h
    have ht : orientedTarget e = orientedTarget f := congrArg Prod.fst h
    have hd : directionNumber e = directionNumber f := congrArg Prod.snd h
    have hs : orientedSource (reversal e) = orientedSource (reversal f) := by
      rw [← orientedTarget_reversal (reversal e), ← orientedTarget_reversal (reversal f)]
      simpa only [reversal_involutive] using ht
    have hr : directionNumber (reversal e) = directionNumber (reversal f) := by
      rw [directionNumber_reversal, directionNumber_reversal, hd]
    have heq := sourceDirection_bijective.1 (Prod.ext hs hr)
    have := congrArg reversal heq
    simpa only [reversal_involutive] using this
  · rintro ⟨v, d⟩
    obtain ⟨f, hf⟩ := sourceDirection_bijective.2 (v, d + 2)
    refine ⟨reversal f, ?_⟩
    have hs : orientedSource f = v := congrArg Prod.fst hf
    have hd : directionNumber f = d + 2 := congrArg Prod.snd hf
    apply Prod.ext
    · simpa only [orientedTarget_reversal] using hs
    · change directionNumber (reversal f) = d
      rw [directionNumber_reversal, hd]
      fin_cases d <;> decide

end Ising2DLambda.KacWard
