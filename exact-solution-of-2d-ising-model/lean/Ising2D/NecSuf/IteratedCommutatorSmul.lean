/-
# 必要十分版: 生成子のスカラー倍と `n` 重交換子 `ad_{αx}^n = α^n ad_x^n`

対応する人手証明のラベル: **`cosh_sinh_coefficient_conversion_for_check`** の補題 1（生成子のスカラー倍）。
具体版は `EigenvalueProblem/ReductionToATheta/ClaimCoefficientConversion.lean` の `adPow_smul_left`、
具体版をこのファイルの特殊化として得る定理は `EigenvalueProblem/ReductionToATheta/ClaimCoefficientConversionFromNecSuf.lean` の
`adPow_smul_left_of_necSuf` である。

## 手順の対応

具体版と同じく、(i) `ad_{αx} = α ad_x`（`iterComm_smul_left_one`。具体版 `ad_smul_left`）、
(ii) `ad_x` の線型性（`iterComm_smul_right_one`。具体版 `ad_smul_right`）、
(iii) `n` についての帰納法で `ad_{αx}^n = α^n ad_x^n`（`iterComm_smul_left`。具体版 `adPow_smul_left`）の 3 段で示す。

## 何が効いているか / 効いていないか

- 効いているのは、台 `A` に引き算（加法群）と積があること、スカラーの作用が積と両立すること
  （`IsScalarTower R A A`: `(αx)w = α(xw)`、`SMulCommClass R A A`: `x(αw) = α(xw)`）、
  作用が引き算と分配すること（`DistribMulAction`）だけである。
- 積の結合則・単位元・積の加法に対する分配則・加法の可換性は効いていない。
- スカラーの集合 `R` はモノイドで足りる。`α · α^n = α^{n+1}` は可換性を使わない。
  ℂ であること・体であること・スカラーの加法は効いていない。
- 行列であること・ノルム・完備性・`check(Z), check(Y)` の具体形・(A)〜(D) は効いていない。
-/
import Mathlib.Algebra.Group.Action.Defs
import Mathlib.Algebra.GroupWithZero.Action.Defs

namespace Ising2D.NecSuf

/-- `n` 重の入れ子交換子 `ad_x^n(w)`（引き算と積があれば定まる）。具体版の `Ising2D.adPow` と同じ再帰。 -/
def iterComm {A : Type*} [Sub A] [Mul A] (x : A) : ℕ → A → A
  | 0, w => w
  | n + 1, w => x * iterComm x n w - iterComm x n w * x

@[simp] theorem iterComm_zero {A : Type*} [Sub A] [Mul A] (x w : A) : iterComm x 0 w = w := rfl

@[simp] theorem iterComm_succ {A : Type*} [Sub A] [Mul A] (x w : A) (n : ℕ) :
    iterComm x (n + 1) w = x * iterComm x n w - iterComm x n w * x := rfl

variable {R A : Type*} [Monoid R] [AddGroup A] [Mul A] [DistribMulAction R A]
  [IsScalarTower R A A] [SMulCommClass R A A]

/-- (i) `ad_{αx}(w) = α ad_x(w)`（交換子の第 1 引数についての線型性）。 -/
theorem iterComm_smul_left_one (α : R) (x w : A) :
    (α • x) * w - w * (α • x) = α • (x * w - w * x) := by
  rw [smul_mul_assoc, mul_smul_comm, smul_sub]

/-- (ii) `ad_x(αw) = α ad_x(w)`（`ad_x` の線型性）。 -/
theorem iterComm_smul_right_one (α : R) (x w : A) :
    x * (α • w) - (α • w) * x = α • (x * w - w * x) := by
  rw [mul_smul_comm, smul_mul_assoc, smul_sub]

/-- (iii) `ad_{αx}^n(w) = α^n ad_x^n(w)`。 -/
theorem iterComm_smul_left (α : R) (x w : A) :
    ∀ n : ℕ, iterComm (α • x) n w = α ^ n • iterComm x n w
  | 0 => by rw [iterComm_zero, iterComm_zero, pow_zero, one_smul]
  | n + 1 => by
      rw [iterComm_succ, iterComm_smul_left_one, iterComm_smul_left α x w n,
        iterComm_smul_right_one, smul_smul, ← pow_succ', iterComm_succ]

end Ising2D.NecSuf
