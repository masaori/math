/-
「有理係数の対数順序群の順序」の必要十分版。

定義の形「ある良い添字 `i` で `P i`」が「すべての良い添字 `i` で `P i`」と一致するために使うのは、
良い添字が少なくとも一つ在ること（`claim_common_common_denominator_exists`）と、
二つの良い添字の間で `P` の真偽が一致すること（`claim_common_denominator_order_independent`）だけである。
順序・対数順序群・共通分母の中身は本質でない。
具体版は添字を `(N, λ_N, μ_N)`、良さを「`N ≥ 1` かつ両方の共通分母」、`P` を `λ_N ≤_Λ μ_N` とした特殊化である。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

theorem exists_iff_forall_of_independent_necSuf {I : Type*} (Good P : I → Prop)
    (hex : ∃ i, Good i)
    (hind : ∀ i j, Good i → Good j → (P i ↔ P j)) :
    (∃ i, Good i ∧ P i) ↔ (∀ i, Good i → P i) := by
  constructor
  · rintro ⟨i, hi, hPi⟩ j hj
    exact (hind i j hi hj).mp hPi          -- 独立性
  · intro h
    obtain ⟨i, hi⟩ := hex                   -- 良い添字の存在
    exact ⟨i, hi, h i hi⟩

end Ising2DLambda.NecSuf.ThermodynamicLimit
