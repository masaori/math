/-
章「同型の証明」のうち、生成作用素の行列の定義とその成分・反交換関係の部分の、非負整数の偶奇による符号の具体版が、必要十分版の K := ℂ、n := -1_ℂ への特殊化として
得られることを示す導出版。具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引く。
部分集合のうち番号より小さい元を数える個数 N_i(T)（`CountAndSign.lean`）は ℂ を含まないので、必要十分版も導出版も置かない。

  具体版            必要十分版の特殊化
  sign              sign_eq_necSuf（帰納法の各段が rfl）
  （ℂ の性質）       signLaws_complex : NecSuf.Isomorphism.SignLaws ℂ (-1)
  sign_mul_self     sign_mul_self_of_necSuf
-/
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.Sign
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.Sign

namespace CliffordMatrixIsomorphism.Isomorphism

/-! ### 定義の対応 -/

/-- 具体版の ς は、必要十分版の ς の n := -1_ℂ の場合と同じ。 -/
theorem sign_eq_necSuf (k : ℕ) : sign k = NecSuf.Isomorphism.sign (-1 : ℂ) k := by
  induction k with
  | zero => rfl
  | succ k ih =>
    show (-1) * sign k = (-1) * NecSuf.Isomorphism.sign (-1 : ℂ) k
    rw [ih]

/-- ℂ と -1_ℂ は、必要十分版の主張が使う性質を満たす。 -/
theorem signLaws_complex : NecSuf.Isomorphism.SignLaws ℂ (-1) where
  one_add_n := add_neg_cancel (1 : ℂ)
  n_mul_one := mul_one (-1 : ℂ)
  mul_add_n := mul_add (-1 : ℂ) (-1) 1
  n_add_one := add_comm (-1 : ℂ) 1
  n_mul_zero := mul_zero (-1 : ℂ)
  add_zero_nn := add_zero ((-1 : ℂ) * (-1))
  add_assoc_nn := (add_assoc ((-1 : ℂ) * (-1)) (-1) 1).symm
  zero_add_one := zero_add (1 : ℂ)
  one_mul_one := mul_one (1 : ℂ)
  mul_assoc := mul_assoc
  mul_n_comm := fun x => mul_comm x (-1)

/-! ### 主張 -/

/-- 本文 `claim_sign_of_nonnegative_integer_squares_to_one` を必要十分版から得る。 -/
theorem sign_mul_self_of_necSuf (k : ℕ) : sign k * sign k = 1 := by
  rw [sign_eq_necSuf]
  exact NecSuf.Isomorphism.sign_mul_self signLaws_complex k

end CliffordMatrixIsomorphism.Isomorphism
