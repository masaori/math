/-
# 必要十分版: 2 次元を保つ交換子の `n` 重の入れ子（偶奇の閉じた形）

対応する人手証明のラベル: **`nesting_of_commutator_of_H_and_check_Z`**。
具体版は `EigenvalueProblem/ReductionToATheta/ClaimNestedCommutator.lean` の `nesting_*_even` / `_odd`、
具体版をこのファイルの特殊化として得る定理は `EigenvalueProblem/ReductionToATheta/ClaimNestedCommutatorFromNecSuf.lean` の
`nesting_*_of_necSuf` である。

## 手順の対応

`h, z, y ∈ A` が `[h, z] = 2p y`、`[h, y] = -2q z`、`pq = 1` を満たすとし、`X := K h` の入れ子交換子を考える。
具体版の (h1.z)(h1.y) は `(h, z, y, p, q) = (H_1^{(+)}, check(Z)_μ, check(Y)_μ, e^{-iθ~_μ}, e^{iθ~_μ})`、
(h2.z)(h2.y) は `(H_2, check(Z)_μ, check(Y)_μ, -1, -1)` の場合である。

| 具体版 | 必要十分版 |
| --- | --- |
| 交換子の双線型性 `comm_smul_smul` | `comm_smul_smul_necSuf` |
| 帰納段階 1（`n` 偶数 → `n+1` 奇数）`nesting_*_step_even_to_odd` | `nested_z_step_even_to_odd` / `nested_y_step_even_to_odd` |
| 帰納段階 2（`n` 奇数 → `n+1` 偶数）`nesting_*_step_odd_to_even` | `nested_z_step_odd_to_even` / `nested_y_step_odd_to_even` |
| 偶数側（基底段階と `k` の帰納法）・奇数側 | `nested_z_even` / `nested_z_odd` / `nested_y_even` / `nested_y_odd` |

各帰納段階は具体版と同じく「`ad_X^{n+1} = [X, ad_X^n]` と帰納法の仮定 → 双線型性 → `[h, ·]` の公式 → スカラーの整理」で、
具体版の `e^{-iθ~}e^{iθ~} = 1` は `pq = 1` に当たる。

## 何が効いているか / 効いていないか

- 効いているのは、`[h, z]`・`[h, y]` が互いの定数倍であること、その定数の積が `pq = 1` になること、
  交換子の双線型性（スカラーの作用が積と両立し、引き算と分配すること）だけである。
- スカラーは可換環であればよい（双線型性の `αβ = βα` と、符号・`2` の冪の整理に使う）。体であること・ℂ であること・
  `p, q` が位相因子 `e^{∓iθ~}` であることは効いていない。とくに `θ~_μ` の値は効いていない。
- 台は引き算（加法群）と積があればよく、積の結合則・単位元・分配則は効いていない。
  行列であること・ノルム・完備性・`check(Z), check(Y)` の具体形も効いていない。
-/
import Mathlib.Algebra.Ring.Basic
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring
import Ising2D.NecSuf.IteratedCommutatorSmul

namespace Ising2D.NecSuf

variable {R A : Type*} [CommRing R] [AddGroup A] [Mul A] [DistribMulAction R A]
  [IsScalarTower R A A] [SMulCommClass R A A]

/-- 交換子の双線型性 `[αx, βw] = αβ[x, w]`。具体版 `comm_smul_smul` に当たる。 -/
theorem comm_smul_smul_necSuf (α β : R) (x w : A) :
    (α • x) * (β • w) - (β • w) * (α • x) = (α * β) • (x * w - w * x) := by
  rw [smul_mul_smul_comm, smul_mul_smul_comm, mul_comm β α, smul_sub]

variable {h z y : A} {p q : R}

section
variable (hz : h * z - z * h = (2 * p) • y) (hy : h * y - y * h = (-2 * q) • z)
  (hpq : p * q = 1) (K : R)

include hz in
/-- `z` 始点の帰納段階 1（`n = 2k` 偶数 → `n+1` 奇数）。 -/
theorem nested_z_step_even_to_odd (k : ℕ)
    (ih : iterComm (K • h) (2 * k) z = ((-1 : R) ^ k * (2 * K) ^ (2 * k)) • z) :
    iterComm (K • h) (2 * k + 1) z = ((-1 : R) ^ k * (2 * K) ^ (2 * k + 1) * p) • y := by
  rw [iterComm_succ, ih, comm_smul_smul_necSuf, hz, smul_smul]
  congr 1
  ring

include hy hpq in
/-- `z` 始点の帰納段階 2（`n = 2k+1` 奇数 → `n+1` 偶数）。`pq = 1` をここで使う。 -/
theorem nested_z_step_odd_to_even (k : ℕ)
    (ih : iterComm (K • h) (2 * k + 1) z = ((-1 : R) ^ k * (2 * K) ^ (2 * k + 1) * p) • y) :
    iterComm (K • h) (2 * (k + 1)) z = ((-1 : R) ^ (k + 1) * (2 * K) ^ (2 * (k + 1))) • z := by
  rw [show 2 * (k + 1) = 2 * k + 1 + 1 by ring, iterComm_succ, ih, comm_smul_smul_necSuf, hy,
    smul_smul]
  congr 1
  linear_combination (-(-1 : R) ^ k * (2 * K) ^ (2 * k + 2)) * hpq

include hz hy hpq in
/-- `z` 始点の偶数側: `ad_{Kh}^{2k} z = (-1)^k (2K)^{2k} z`。 -/
theorem nested_z_even (k : ℕ) :
    iterComm (K • h) (2 * k) z = ((-1 : R) ^ k * (2 * K) ^ (2 * k)) • z := by
  induction k with
  | zero => rw [Nat.mul_zero, iterComm_zero, pow_zero, pow_zero, mul_one, one_smul]
  | succ k ih =>
    exact nested_z_step_odd_to_even hy hpq K k (nested_z_step_even_to_odd hz K k ih)

include hz hy hpq in
/-- `z` 始点の奇数側: `ad_{Kh}^{2k+1} z = (-1)^k (2K)^{2k+1} p y`。 -/
theorem nested_z_odd (k : ℕ) :
    iterComm (K • h) (2 * k + 1) z = ((-1 : R) ^ k * (2 * K) ^ (2 * k + 1) * p) • y :=
  nested_z_step_even_to_odd hz K k (nested_z_even hz hy hpq K k)

end

section
variable (hz : h * z - z * h = (2 * p) • y) (hy : h * y - y * h = (-2 * q) • z)
  (hpq : p * q = 1) (K : R)

include hy in
/-- `y` 始点の帰納段階 1（`n = 2k` 偶数 → `n+1` 奇数）。 -/
theorem nested_y_step_even_to_odd (k : ℕ)
    (ih : iterComm (K • h) (2 * k) y = ((-1 : R) ^ k * (2 * K) ^ (2 * k)) • y) :
    iterComm (K • h) (2 * k + 1) y = ((-1 : R) ^ (k + 1) * (2 * K) ^ (2 * k + 1) * q) • z := by
  rw [iterComm_succ, ih, comm_smul_smul_necSuf, hy, smul_smul]
  congr 1
  ring

include hz hpq in
/-- `y` 始点の帰納段階 2（`n = 2k+1` 奇数 → `n+1` 偶数）。`pq = 1` をここで使う。 -/
theorem nested_y_step_odd_to_even (k : ℕ)
    (ih : iterComm (K • h) (2 * k + 1) y
      = ((-1 : R) ^ (k + 1) * (2 * K) ^ (2 * k + 1) * q) • z) :
    iterComm (K • h) (2 * (k + 1)) y = ((-1 : R) ^ (k + 1) * (2 * K) ^ (2 * (k + 1))) • y := by
  rw [show 2 * (k + 1) = 2 * k + 1 + 1 by ring, iterComm_succ, ih, comm_smul_smul_necSuf, hz,
    smul_smul]
  congr 1
  linear_combination ((-1 : R) ^ (k + 1) * (2 * K) ^ (2 * k + 2)) * hpq

include hz hy hpq in
/-- `y` 始点の偶数側: `ad_{Kh}^{2k} y = (-1)^k (2K)^{2k} y`。 -/
theorem nested_y_even (k : ℕ) :
    iterComm (K • h) (2 * k) y = ((-1 : R) ^ k * (2 * K) ^ (2 * k)) • y := by
  induction k with
  | zero => rw [Nat.mul_zero, iterComm_zero, pow_zero, pow_zero, mul_one, one_smul]
  | succ k ih =>
    exact nested_y_step_odd_to_even hz hpq K k (nested_y_step_even_to_odd hy K k ih)

include hz hy hpq in
/-- `y` 始点の奇数側: `ad_{Kh}^{2k+1} y = (-1)^{k+1} (2K)^{2k+1} q z`。 -/
theorem nested_y_odd (k : ℕ) :
    iterComm (K • h) (2 * k + 1) y = ((-1 : R) ^ (k + 1) * (2 * K) ^ (2 * k + 1) * q) • z :=
  nested_y_step_even_to_odd hy K k (nested_y_even hz hy hpq K k)

end

end Ising2D.NecSuf
