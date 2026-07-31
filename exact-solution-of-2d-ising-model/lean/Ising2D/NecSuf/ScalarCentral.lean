/-
# 必要十分版: スカラー元の可換性と、行列環の中心

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明（具体版はそれぞれ下記のファイルにあり、本ファイルの必要十分版からの
特殊化として導出される）:

| 人手証明のラベル | 具体版（複素行列） |
| --- | --- |
| `<scalar_identity_commutes>` | `Ising2D/Part002/Lemma001_ScalarIdentityCommutes.lean` |
| `<centralizer_is_scalar>` | `Ising2D/Part002/Lemma003_CentralizerIsScalar.lean` |

## 必要十分版が何を明らかにするか

* `<scalar_identity_commutes>`（`[c · I, A] = 0`）に効いているのは
  **スカラー作用と積の両立則だけ**である（`Algebra.smul_mul_assoc` と
  `Algebra.mul_smul_comm`）。行列であること・係数が体であること・次数 `n` は一切効かない。
  さらに、可換性そのものは**引き算を持たない半環でも成り立つ**（引き算を使うのは
  「差が `0`」という**述べ方**のためだけ）。
* `<centralizer_is_scalar>`（全元と可換なら定数倍の単位元）に効いているのは
  **添字集合が有限で等号判定可能なこと**だけである。係数環は ℂ である必要も、
  可換である必要も、体である必要もない。ただし係数が非可換な場合には、
  得られるスカラー `c` は**係数環の中心に属する**という条件が付く。
  ℂ は可換なのでこの条件が消え、人手証明の形（`c ∈ ℂ` が任意）になる。
-/
import Mathlib.Algebra.Algebra.Basic
import Mathlib.Data.Matrix.Basis

namespace Ising2D
namespace NecSuf

/-! ## `<scalar_identity_commutes>` の必要十分版 -/

section ScalarCommutes

variable {S : Type*} [CommSemiring S]

/-- **`<scalar_identity_commutes>` の必要十分版（半環）**。

`S`-代数 `R` において、`c • 1`（`c ∈ S`）は `R` のすべての元と可換である。
使うのは `Algebra` の両立則だけで、行列であることは効いていない。 -/
theorem smul_one_commute {R : Type*} [Semiring R] [Algebra S R] (c : S) (a : R) :
    Commute (c • (1 : R)) a := by
  unfold Commute SemiconjBy
  rw [Algebra.smul_mul_assoc, Algebra.mul_smul_comm, one_mul, mul_one]

/-- **`<scalar_identity_commutes>` の必要十分版（環・差の形）**。

原文の `[c · I, A] = 0` と同じ「差が `0`」の形。引き算を使うのはこの述べ方のためだけで、
中身は `smul_one_commute` である。 -/
theorem smul_one_sub_comm {R : Type*} [Ring R] [Algebra S R] (c : S) (a : R) :
    (c • (1 : R)) * a - a * (c • (1 : R)) = 0 :=
  sub_eq_zero_of_eq (smul_one_commute c a).eq

end ScalarCommutes

/-! ## `<centralizer_is_scalar>` の必要十分版 -/

section Center

variable {n : Type*} [Fintype n] [DecidableEq n]
variable {α : Type*} [Semiring α]

/-- `Matrix.scalar n c`（対角にスカラーを並べた行列）は `c • 1` に等しい。
以下で人手証明の記法 `c · I` に合わせるために使う。 -/
theorem scalar_eq_smul_one (c : α) : Matrix.scalar n c = c • (1 : Matrix n n α) := by
  ext i j
  by_cases hij : i = j <;> simp [Matrix.scalar_apply, hij]

/-- **`<centralizer_is_scalar>` の必要十分版（係数は任意の半環）**。

`Matrix n n α` の全元と可換な `W` は `c • 1` の形をしており、しかも `c` は
**係数環 `α` の中心**に属する。添字型 `n` は有限で等号判定可能でありさえすればよい
（空でもよい。空なら行列環が自明環になり、主張も自明に成り立つ）。 -/
theorem centralizer_is_scalar_semiring (W : Matrix n n α)
    (h : ∀ x : Matrix n n α, W * x = x * W) :
    ∃ c ∈ Set.center α, W = c • (1 : Matrix n n α) := by
  have hW : W ∈ Set.center (Matrix n n α) :=
    Subsemigroup.mem_center_iff.mpr fun g => (h g).symm
  rw [Matrix.center_eq_scalar_image] at hW
  obtain ⟨c, hc, hcW⟩ := hW
  exact ⟨c, hc, by rw [← hcW, scalar_eq_smul_one]⟩

/-- **`<centralizer_is_scalar>` の必要十分版（係数が可換な場合）**。

係数環が可換なら「`c` が中心に属する」という条件は自動的に満たされるので、
人手証明と同じ「ある `c` が存在して `W = c · I`」の形になる。 -/
theorem centralizer_is_scalar_commSemiring {α : Type*} [CommSemiring α] (W : Matrix n n α)
    (h : ∀ x : Matrix n n α, W * x = x * W) :
    ∃ c : α, W = c • (1 : Matrix n n α) := by
  obtain ⟨c, -, hc⟩ := centralizer_is_scalar_semiring W h
  exact ⟨c, hc⟩

end Center

end NecSuf
end Ising2D
