import Ising2DLambda.FisherZero.PositiveConeNatMul
import Ising2DLambda.FisherZero.PositiveRationalInPositiveConeFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveConeMulClosedFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.PositiveConeNatMul

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 正錐の像を使って、部分型の所属と Qbar の値の所属を明示的に対応させる。 -/
theorem quadraticNatMulValue_spec_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (c : ℕ) (xi : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s) :
    algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) ∈ quadraticFieldSet s ∧
      (c = 0 → algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) = 0) ∧
      (1 ≤ c → quadraticNatMulElement s hs c xi ∈ quadraticPositiveCone s) := by
  let P : Set Qbar := Subtype.val '' quadraticPositiveCone s
  have h := Ising2DLambda.NecSuf.FisherZero.natIndexed_mul_zero_or_mem_necSuf
    (fun n : ℕ => (n : ℚ)) Nat.cast_zero
    (algebraMap ℚ Qbar) (map_zero (algebraMap ℚ Qbar))
    (add_zero (0 : Qbar)) (fun x : Qbar => zero_mul x)
    (fun q : ℚ => 0 < q) (fun _ hn => Nat.cast_pos.mpr hn)
    (quadraticFieldSet s) P s
    (fun a b => ⟨a, b, rfl⟩)
    (fun a _ => positiveRational_mem_quadraticFieldSet s a)
    (fun a ha => ⟨positiveRationalElement s a,
      positiveRational_mem_positiveCone_from_necSuf s hs a ha, rfl⟩)
    (fun x y hx hy => quadraticMul_mem_from_necSuf s hs ⟨x, hx⟩ ⟨y, hy⟩)
    (fun x y hx hy => by
      obtain ⟨u, hu, rfl⟩ := hx
      obtain ⟨v, hv, rfl⟩ := hy
      exact ⟨quadraticMulElement s hs u v,
        quadraticPositiveCone_mul_mem_from_necSuf s hs u v hu hv, rfl⟩)
    c (xi : Qbar) xi.property ⟨xi, hxi, rfl⟩
  refine ⟨h.1, h.2.1, ?_⟩
  intro hc
  obtain ⟨eta, heta, heq⟩ := h.2.2 hc
  have hSame : eta = quadraticNatMulElement s hs c xi :=
    Subtype.ext (heq.trans (quadraticNatMulElement_coe s hs c xi).symm)
  rw [← hSame]
  exact heta

/-- 値の橋は具体版と同じ定義で、証明本体は必要十分版から得る。 -/
theorem quadraticNatMulElement_zero_or_mem_positiveCone_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (c : ℕ) (xi : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s) :
    (c = 0 → (quadraticNatMulElement s hs c xi : Qbar) = 0) ∧
      (1 ≤ c → quadraticNatMulElement s hs c xi ∈ quadraticPositiveCone s) := by
  have h := quadraticNatMulValue_spec_from_necSuf s hs c xi hxi
  refine ⟨?_, h.2.2⟩
  intro hc
  calc
    (quadraticNatMulElement s hs c xi : Qbar) =
        algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) := quadraticNatMulElement_coe s hs c xi
    _ = 0 := h.2.1 hc

end Ising2DLambda.FisherZero
