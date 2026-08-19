/-
「有限接頭部を忘れた尾部一致は極限量に対して十分である」の
Lean 具体版・有限箱量の列への特殊化と束ね
（`claim_tail_agreement_is_sufficient_for_limit_quantity` に対応）。

二つの有理点の有限箱の値の列がある添字以降で項ごとに一致するなら、
乗根の列も同じ添字以降で項ごとに一致し（乗根は各項だけの関数であるから）、
一般補題 `tailAgreement_tendsto` により一方の極限量の存在から他方の存在が従い、
Hausdorff 空間での極限の一意性により値も一致する。
-/
import Ising3DCut.LimitQuantity.FiniteBoxEqualitiesTransfer
import Ising3DCut.LimitQuantity.TailAgreementLimit

namespace Ising3DCut.LimitQuantity

open NullModel Filter Topology

/-- 有限箱の値の列が尾部一致すれば、乗根の列も同じ添字以降で尾部一致する
（`rootSeq` の第 `n` 項は `Z n` と `N n` だけの関数であるから）。 -/
theorem rootSeq_tailAgreement_of_tailAgreement (Z Z' : ℕ → ℝ) (N : ℕ → ℕ)
    (hTail : ∃ N₀ : ℕ, ∀ n : ℕ, N₀ ≤ n → Z n = Z' n) :
    ∃ N₀ : ℕ, ∀ n : ℕ, N₀ ≤ n → rootSeq Z N n = rootSeq Z' N n := by
  obtain ⟨N₀, hN₀⟩ := hTail
  exact ⟨N₀, fun n hn => posRoot_congr (Z n) (Z' n) (hN₀ n hn) (N n)⟩

/-- 十分性（収束の移送）：二つの有理点の有限箱の値の列が尾部一致すれば、
`q` 側の乗根列が `ℓ` へ収束するとき `q'` 側も同じ `ℓ` へ収束する。 -/
theorem tailAgreement_limitQuantity_tendsto {q q' : ℚ} (N : ℕ → ℕ)
    (hTail : ∃ N₀ : ℕ, ∀ n : ℕ, N₀ ≤ n →
      finiteBoxValueSeq q n = finiteBoxValueSeq q' n)
    (ℓ : ℝ) (hq : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 ℓ)) :
    Tendsto (rootSeq (finiteBoxValueSeq q') N) atTop (𝓝 ℓ) :=
  tailAgreement_tendsto _ _
    (rootSeq_tailAgreement_of_tailAgreement _ _ N hTail) ℓ hq

/-- 十分性（値の一致）：尾部一致した二列の乗根列が両方とも極限を持てば、その極限は等しい。 -/
theorem tailAgreement_limitQuantity_eq {q q' : ℚ} (N : ℕ → ℕ)
    (hTail : ∃ N₀ : ℕ, ∀ n : ℕ, N₀ ≤ n →
      finiteBoxValueSeq q n = finiteBoxValueSeq q' n)
    (ℓ ℓ' : ℝ) (hq : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 ℓ))
    (hq' : Tendsto (rootSeq (finiteBoxValueSeq q') N) atTop (𝓝 ℓ')) : ℓ = ℓ' :=
  tendsto_nhds_unique (tailAgreement_limitQuantity_tendsto N hTail ℓ hq) hq'

end Ising3DCut.LimitQuantity
