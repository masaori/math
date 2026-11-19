/-
節「基本対称式への代入」（末尾の変数への零代入との入れ替えの部分）の主張の必要十分版。

具体版（`Ising2DLambda.FisherZero.lastVariableZero_elementarySymmetricSubst`）と同じ段
（代入の合成、値の写像の一致、代入の合成の逆向き）で示し、各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい。体であること・零因子が無いこと・符号反転はどの段でも使わない。
- 変数の集合 `σ`（`Q` の変数）だけが有限であればよい。代入の合成（`mvSubst_comp_necSuf`）が
  内側の代入を全変数にわたる有限積で書くのに使う。代入先の `τ`・`ρ`・`υ` は有限でなくてよい。
- 二つの代入の順序を入れ替えられることは、値の写像の一致
  `ms_y(e(k)) = ms_{e'}(z(k))`（全ての `k`）だけから従う。具体版ではこの一致が準備であり、
  そこで基本対称式であること（`lz_n(es_{n+1,j}) = es_{n,j}`）と零代入の値を使う。
-/
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionSymmetric

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

/-- `claim_elementary_symmetric_substitution_last_variable_zero` の必要十分版（具体版と同じ段）。
値の写像が一致すれば、二つの代入の順序を入れ替えられる。 -/
theorem mvSubst_comm_of_values_comm_necSuf {σ τ ρ υ : Type} [Fintype σ]
    (e : σ → MvPolynomial τ K) (y : τ → MvPolynomial υ K)
    (z : σ → MvPolynomial ρ K) (e' : ρ → MvPolynomial υ K)
    (hcomm : ∀ k : σ, aeval y (e k) = aeval e' (z k)) (Q : MvPolynomial σ K) :
    aeval y (aeval e Q) = aeval e' (aeval z Q) := by
  calc aeval y (aeval e Q)
      = aeval (fun k => aeval y (e k)) Q := mvSubst_comp_necSuf e y Q
    _ = aeval (fun k => aeval e' (z k)) Q := by rw [show (fun k => aeval y (e k)) =
          (fun k => aeval e' (z k)) from funext hcomm]
    _ = aeval e' (aeval z Q) := (mvSubst_comp_necSuf z e' Q).symm

end Ising2DLambda.NecSuf.FisherZero
