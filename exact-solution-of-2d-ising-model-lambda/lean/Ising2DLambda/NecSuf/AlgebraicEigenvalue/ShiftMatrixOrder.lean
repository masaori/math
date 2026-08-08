/-
主張「反復した平行移動は剰余類を足す操作である」「平行移動を L 回施すと恒等写像になる」
「反復した巡回シフトは反復した平行移動による引き戻しである」「巡回シフトを L 回施すと
恒等写像になる」「シフト行列の冪は反復したシフトの行列である」と定理
「シフト行列の L 乗は単位行列である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.ShiftMatrixOrder`）の証明が実際に使っているのは
次だけである。証明手順は具体版と同じ（どれも同じ向きの帰納法で、同じ段を踏む）。

  主張                        使っている性質
  iterRight_add_apply         `AddMonoid G` だけ。すなわち加法の結合則と零元だけであり、
                              **可換性も逆元も有限性も使っていない**。とくに G が
                              ℤ/Lℤ であることも、剰余類であることも使っていない。
  iterRight_add_period        上に加えて `n • g = 0` という仮定だけ。人手証明の
                              π(L) = 0 がこれにあたる。L が「格子の大きさ」であることも、
                              g が生成元であることも使っていない。
  precompIterate_apply        **値の型にも添字の型にも何も要求しない。** 写像 f : ι → ι が
                              1 つあればよく、全単射である必要すらない。すなわち
                              スピンの値が 2 つであることも、シフトが巡回であることも
                              使っていない。
  precompIterate_period       上に加えて反復が恒等写像であることだけ。
  permMatrix_pow_apply        `Fintype ι` / `DecidableEq ι` / `e : ι ≃ ι` と、値の側の
                              2 つの規則 `a * 1 = a`、`a * 0 = 0`。**分配則も積の結合則も
                              積の可換性も使っていない**（`ShiftMatrix.lean` と同じく、
                              代数構造としては `AddCommMonoid` と法則を持たない
                              `Mul` / `One` しか仮定していないので、これらの法則は
                              そもそも述べることができない）。
                              左から掛ける主張は使わないので、その 2 規則
                              （`1 * a = a`、`0 * a = 0`）は仮定に入っていない。
  permMatrix_pow_eq_identity  上に加えて反復が恒等写像であることだけ。すなわち
                              **e の位数がちょうど n+1 であることは要らず、n+1 回で
                              恒等写像に戻りさえすればよい**。

削れなかった仮定。`e` が全単射であることは、右から掛ける主張（`mul_permMatrix_apply`）が
`k = e j ⟺ e.symm k = j` を使うので落とせない（`ShiftMatrix.lean` に理由を書いた）。
`DecidableEq ι` は `if j = e i then 1 else 0` の場合分けが定まるために要る。

反復の順について。人手証明は γ^[k+1] = γ^[k] ∘ γ（右から施す）と
S^[k+1] = S ∘ S^[k]（左から施す）を別々に定めている。ここでもその 2 つを
`iterRight` と `precompIterate` として別々に置き、噛み合わせを
`precompIterate_apply` として示す。mathlib の `Function.iterate` は引いていない。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、値は一般の代数構造）。
-/
import Mathlib.Algebra.BigOperators.Finprod
import Mathlib.Data.Fintype.BigOperators
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftMatrix

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 人手証明の `γ^[k]` にあたる反復。写像を**右から**施す
（`iterRight f (k+1) = iterRight f k ∘ f`）。 -/
def iterRight {ι : Type*} (f : ι → ι) : ℕ → ι → ι
  | 0 => id
  | k + 1 => fun y => iterRight f k (f y)

/-- 人手証明の主張「反復した平行移動は剰余類を足す操作である」。

加法モノイドであることしか使っていない（可換性も逆元も有限性も不要）。 -/
theorem iterRight_add_apply {G : Type*} [AddMonoid G] (g : G) (k : ℕ) (y : G) :
    iterRight (fun z => z + g) k y = y + k • g := by
  induction k generalizing y with
  | zero =>
    show y = y + (0 : ℕ) • g
    rw [zero_smul, add_zero]
  | succ k ih =>
    show iterRight (fun z => z + g) k (y + g) = y + (k + 1) • g
    rw [ih, succ_nsmul', add_assoc]

/-- 人手証明の主張「平行移動を L 回施すと恒等写像になる」。

要るのは `n • g = 0` だけである（人手証明の `π(L) = 0`）。 -/
theorem iterRight_add_period {G : Type*} [AddMonoid G] (g : G) (n : ℕ) (h : n • g = 0)
    (y : G) : iterRight (fun z => z + g) n y = y := by
  rw [iterRight_add_apply, h, add_zero]

/-- 写像を**左から**施す反復（`iterLeft f (k+1) = f ∘ iterLeft f k`）。
人手証明の `S^[k+1] = S ∘ S^[k]` の順にあたる。 -/
def iterLeft {ι : Type*} (f : ι → ι) : ℕ → ι → ι
  | 0 => id
  | k + 1 => fun y => f (iterLeft f k y)

/-- 人手証明の `S^[k]` にあたる反復。引き戻しを**左から**施す
（`precompIterate f (k+1) τ = (precompIterate f k τ) ∘ f`）。 -/
def precompIterate {ι V : Type*} (f : ι → ι) : ℕ → (ι → V) → (ι → V)
  | 0 => id
  | k + 1 => fun τ => (fun y => precompIterate f k τ (f y))

/-- 人手証明の主張「反復した巡回シフトは反復した平行移動による引き戻しである」。

値の型にも添字の型にも何も要求しない。`f` が全単射である必要すらない。 -/
theorem precompIterate_apply {ι V : Type*} (f : ι → ι) (k : ℕ) (τ : ι → V) (y : ι) :
    precompIterate f k τ y = τ (iterRight f k y) := by
  induction k generalizing y with
  | zero => rfl
  | succ k ih => exact ih (f y)

/-- 人手証明の主張「巡回シフトを L 回施すと恒等写像になる」。 -/
theorem precompIterate_period {ι V : Type*} (f : ι → ι) (n : ℕ)
    (h : ∀ y : ι, iterRight f n y = y) (τ : ι → V) : precompIterate f n τ = τ := by
  funext y
  rw [precompIterate_apply, h]

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : Type*} [AddCommMonoid S] [Mul S] [One S]

/-- 人手証明の行列の積。 -/
def matProduct (A B : ι → ι → S) : ι → ι → S :=
  fun i k => ∑ j : ι, A i j * B j k

/-- 人手証明の行列の冪。人手証明が `A¹ = A`、`A^{k+1} = A^k A` で定めていることに合わせ、
引数を 1 つずらして `matPow A k` が `A^{k+1}` を表すものとする（具体版と同じ約束）。 -/
def matPow (A : ι → ι → S) : ℕ → (ι → ι → S)
  | 0 => A
  | k + 1 => matProduct (matPow A k) A

/-- 人手証明の単位行列。 -/
def identityMat : ι → ι → S := fun i j => if i = j then (1 : S) else (0 : S)

/-- 人手証明の主張「シフト行列の冪は反復したシフトの行列である」。

要るのは `a * 1 = a` と `a * 0 = 0` の 2 つだけである
（左から掛ける主張を使わないので `1 * a = a`、`0 * a = 0` は要らない）。 -/
theorem permMatrix_pow_apply (hone' : ∀ a : S, a * (1 : S) = a)
    (hzero' : ∀ a : S, a * (0 : S) = 0)
    (e : ι ≃ ι) (k : ℕ) (i j : ι) :
    matPow (permMatrix (S := S) e) k i j
      = if j = iterLeft (fun y => e y) (k + 1) i then (1 : S) else (0 : S) := by
  classical
  induction k generalizing j with
  | zero => rfl
  | succ k ih =>
    show matProduct (matPow (permMatrix (S := S) e) k) (permMatrix (S := S) e) i j = _
    rw [matProduct, mul_permMatrix_apply hone' hzero', ih]
    by_cases h : j = iterLeft (fun y => e y) (k + 1 + 1) i
    · rw [if_pos h, if_pos]
      exact (eq_apply_iff e (iterLeft (fun y => e y) (k + 1) i) j).mp h
    · rw [if_neg h, if_neg]
      intro hcontra
      exact h ((eq_apply_iff e (iterLeft (fun y => e y) (k + 1) i) j).mpr hcontra)

/-- 人手証明の定理「シフト行列の L 乗は単位行列である」。

要るのは「`n+1` 回の反復が恒等写像であること」だけで、`e` の位数がちょうど `n+1` で
あることは使っていない。 -/
theorem permMatrix_pow_eq_identity (hone' : ∀ a : S, a * (1 : S) = a)
    (hzero' : ∀ a : S, a * (0 : S) = 0)
    (e : ι ≃ ι) (n : ℕ) (h : ∀ i : ι, iterLeft (fun y => e y) (n + 1) i = i) :
    matPow (permMatrix (S := S) e) n = (identityMat : ι → ι → S) := by
  classical
  funext i j
  rw [permMatrix_pow_apply hone' hzero', h, identityMat]
  by_cases hij : i = j
  · rw [if_pos hij.symm, if_pos hij]
  · rw [if_neg (fun hc : j = i => hij hc.symm), if_neg hij]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
