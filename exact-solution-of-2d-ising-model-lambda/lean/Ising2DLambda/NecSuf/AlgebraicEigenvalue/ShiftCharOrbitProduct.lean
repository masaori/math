/-
主張「シフト行列の特性多項式は、軌道ごとの和の積である」の必要十分版のうち、
**分配則を添字の全体で取る段**。

人手証明はここで、任意の $s\subset\mathcal{O}_L$ について示した分配則を $s=\mathcal{O}_L$ と
取って使う。人手証明では $\mathfrak{A}(\mathcal{O}_L)=\mathfrak{A}_L$ は等号だが、
Lean では所属の証明を受け取る形と受け取らない形が別の型なので、行き来する全単射を置いて
和の添字を取り替える。

この段が新しく要求するのは**添字の型 `ι` が有限であること**ただ 1 つである。
部分集合版（`prod_sum_eq_sum_prod_family`）は `s : Finset ι` がもとから有限なので
`ι` の有限性を要求しなかった。全体で取ると添字の型そのものを走るので、ここで初めて要る。
値の側への要求は部分集合版と同じ（可換半環）で、増えていない。

住処: ここに ℝ / ℂ は現れない（現れるのは添字の型 `ι`、成分の型 `B i`、値の型 `R` だけである）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitFamilyDistributive

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [DecidableEq ι] {B : ι → Type*}

/-- 人手証明の `A(O_L) = A_L` に当たる橋渡し。

左は所属の証明 `i ∈ univ` を余分に受け取る形、右は受け取らない形であり、
引数の受け渡しが違うだけで同じ組を表す（往復はどちらも `rfl`）。 -/
def familyOnUnivEquiv (B : ι → Type*) [Fintype ι] :
    FamilyOn B (univ : Finset ι) ≃ ∀ i, B i where
  toFun α := fun i => α i (Finset.mem_univ i)
  invFun α := fun i _ => α i
  left_inv _ := rfl
  right_inv _ := rfl

variable {R : Type*} [CommSemiring R]

/-- 分配則を添字の全体で取ったもの（必要十分版）。

部分集合版に `s = univ` を入れ、和の添字を「所属の証明を受け取らない組」へ取り替え、
積の添字を `univ.attach` から `univ` へ移しただけである。

新しく要るのは `Fintype ι` だけであり、値の側への要求は部分集合版と同じである。 -/
theorem prod_sum_eq_sum_prod_pi [Fintype ι] [∀ i, Fintype (B i)]
    (g : (i : ι) → B i → R) :
    (∏ i : ι, ∑ x : B i, g i x) = ∑ α : (∀ i, B i), ∏ i : ι, g i (α i) := by
  classical
  calc (∏ i : ι, ∑ x : B i, g i x)
      = ∑ α : FamilyOn B (univ : Finset ι),
          ∏ i ∈ (univ : Finset ι).attach, g i.1 (α i.1 i.2) :=
        prod_sum_eq_sum_prod_family g univ
    -- 和の添字を、所属の証明を受け取らない形へ取り替える。
    _ = ∑ α : (∀ i, B i), ∏ i ∈ (univ : Finset ι).attach, g i.1 (α i.1) :=
        Equiv.sum_comp (familyOnUnivEquiv B)
          (fun α => ∏ i ∈ (univ : Finset ι).attach, g i.1 (α i.1))
    -- 積の添字を `univ.attach` から `univ` へ移す。
    _ = ∑ α : (∀ i, B i), ∏ i : ι, g i (α i) := by
        refine Finset.sum_congr rfl ?_
        intro α _
        exact Finset.prod_attach (univ : Finset ι) (fun i => g i (α i))

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
