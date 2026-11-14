/-
章「同型の証明」の、非負整数の偶奇による符号とその自分自身との積が 1 であることの必要十分版。
具体版 `Isomorphism/CreationOperatorMatrices/Sign.lean` と同じ def と同じ calc の行のまま、係数 ℂ を型の変数 K に、
-1_ℂ を K の元 n に替える。K には演算の記号 +・·・0・1 だけを与え、使う性質は `SignLaws K n` の欄として渡す。

  本文のラベル                                         このファイル
  def_sign_of_nonnegative_integer                      sign・sign_zero・sign_succ
  claim_sign_of_nonnegative_integer_squares_to_one     SignLaws・n_mul_n_add_n・n_mul_n・sign_mul_self

主張ごとに使う K の性質:
  sign（定義）              なし（n を一つ与えるだけ。n が 1 の加法の逆元であることは定義に使わない）
  n_mul_n_add_n（準備一）   n · 1 = n、n · (n + 1) = n · n + n · 1、n + 1 = 1 + n、1 + n = 0、n · 0 = 0
  n_mul_n（準備二）         n · n + 0 = n · n、1 + n = 0、n + 1 = 1 + n、n · n + (n + 1) = (n · n + n) + 1、0 + 1 = 1、準備一
  sign_mul_self             1 · 1 = 1、乗法の結合法則、n と ς(k) の交換、準備二
準備の二つは定数 n・0・1 だけの式なので、使う性質も定数についての等式の形で置く。
帰納法の段は ς(k) について結合法則と交換を使うので、その二つは任意の元についての形で置く。
-/
import Mathlib.Data.Nat.Notation

namespace CliffordMatrixIsomorphism.NecSuf.Isomorphism

universe uK

variable {K : Type uK} [Mul K] [One K]

/-- 本文 `def_sign_of_nonnegative_integer` の必要十分版：ς(0) := 1、ς(k + 1) := n · ς(k)。 -/
def sign (n : K) : ℕ → K
  | 0 => 1
  | k + 1 => n * sign n k

/-- 本文 `def_sign_of_nonnegative_integer` の必要十分版：ς(0) = 1。 -/
theorem sign_zero (n : K) : sign n 0 = 1 := rfl

/-- 本文 `def_sign_of_nonnegative_integer` の必要十分版：ς(k + 1) = n · ς(k)。 -/
theorem sign_succ (n : K) (k : ℕ) : sign n (k + 1) = n * sign n k := rfl

/-- 本文 `claim_sign_of_nonnegative_integer_squares_to_one` の証明が使う K と n の性質。 -/
structure SignLaws (K : Type uK) [Add K] [Mul K] [Zero K] [One K] (n : K) : Prop where
  /-- n は 1 の加法の逆元（本文の -1_ℂ の定義。準備の一つ目と二つ目） -/
  one_add_n : 1 + n = 0
  /-- 1 は乗法の単位元を n に（準備の一つ目の最初の行） -/
  n_mul_one : n * 1 = n
  /-- 分配法則を n · (n + 1) に（準備の一つ目） -/
  mul_add_n : n * (n + 1) = n * n + n * 1
  /-- 加法の交換法則を n と 1 に（準備の一つ目と二つ目） -/
  n_add_one : n + 1 = 1 + n
  /-- 0 との積は 0 を n に（準備の一つ目の最後の行） -/
  n_mul_zero : n * 0 = 0
  /-- 0 は加法の単位元を n · n に（準備の二つ目の最初の行） -/
  add_zero_nn : n * n + 0 = n * n
  /-- 加法の結合法則を n · n、n、1 に（準備の二つ目） -/
  add_assoc_nn : n * n + (n + 1) = (n * n + n) + 1
  /-- 0 は加法の単位元を 1 に（準備の二つ目の最後の行） -/
  zero_add_one : (0 : K) + 1 = 1
  /-- 1 は乗法の単位元を 1 に（帰納法の n = 0 の段と、各段の最後の行） -/
  one_mul_one : (1 : K) * 1 = 1
  /-- 乗法の結合法則（帰納法の段で、n と ς(k) の積の括弧を付け替える四つの行） -/
  mul_assoc : ∀ a b c : K, a * b * c = a * (b * c)
  /-- n との交換（帰納法の段で ς(k) · n を n · ς(k) に替える行。使うのは x = ς(k) だけである）。
  K の乗法が可換でなくても、n が中心にあれば足りる。 -/
  mul_n_comm : ∀ x : K, x * n = n * x

/-- 本文 `claim_sign_of_nonnegative_integer_squares_to_one` の準備の一つ目の必要十分版：n · n + n = 0。 -/
theorem n_mul_n_add_n [Add K] [Zero K] {n : K} (L : SignLaws K n) : n * n + n = 0 :=
  calc n * n + n
      = n * n + n * 1 := by rw [L.n_mul_one]
    _ = n * (n + 1) := L.mul_add_n.symm
    _ = n * (1 + n) := by rw [L.n_add_one]
    _ = n * 0 := by rw [L.one_add_n]
    _ = 0 := L.n_mul_zero

/-- 本文 `claim_sign_of_nonnegative_integer_squares_to_one` の準備の二つ目の必要十分版：n · n = 1。 -/
theorem n_mul_n [Add K] [Zero K] {n : K} (L : SignLaws K n) : n * n = 1 :=
  calc n * n
      = n * n + 0 := L.add_zero_nn.symm
    _ = n * n + (1 + n) := by rw [L.one_add_n]
    _ = n * n + (n + 1) := by rw [L.n_add_one]
    _ = (n * n + n) + 1 := L.add_assoc_nn
    _ = 0 + 1 := by rw [n_mul_n_add_n L]
    _ = 1 := L.zero_add_one

/-- 本文 `claim_sign_of_nonnegative_integer_squares_to_one` の必要十分版：すべての k で ς(k) · ς(k) = 1。 -/
theorem sign_mul_self [Add K] [Zero K] {n : K} (L : SignLaws K n) (k : ℕ) : sign n k * sign n k = 1 := by
  induction k with
  | zero =>
    calc sign n 0 * sign n 0
        = 1 * 1 := rfl
      _ = 1 := L.one_mul_one
  | succ k ih =>
    calc sign n (k + 1) * sign n (k + 1)
        = (n * sign n k) * (n * sign n k) := rfl
      _ = n * (sign n k * (n * sign n k)) := L.mul_assoc n (sign n k) (n * sign n k)
      _ = n * ((sign n k * n) * sign n k) := by rw [← L.mul_assoc (sign n k) n (sign n k)]
      _ = n * ((n * sign n k) * sign n k) := by rw [L.mul_n_comm (sign n k)]
      _ = n * (n * (sign n k * sign n k)) := by rw [L.mul_assoc n (sign n k) (sign n k)]
      _ = (n * n) * (sign n k * sign n k) := (L.mul_assoc n n (sign n k * sign n k)).symm
      _ = 1 * (sign n k * sign n k) := by rw [n_mul_n L]
      _ = 1 * 1 := by rw [ih]
      _ = 1 := L.one_mul_one

end CliffordMatrixIsomorphism.NecSuf.Isomorphism
