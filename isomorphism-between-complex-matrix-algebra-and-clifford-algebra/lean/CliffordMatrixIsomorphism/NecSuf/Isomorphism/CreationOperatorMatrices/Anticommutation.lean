/-
章「同型の証明」の、生成作用素の行列・消滅作用素の行列の反交換関係の必要十分版。具体版
`Isomorphism/CreationOperatorMatrices/Anticommutation.lean` と同じ calc の行のまま、係数 ℂ を型の変数 K に、-1_ℂ を K の元 n に替える。
条件の同値（集合の操作）は ℂ を含まないので、具体版と同じ `IndexSetOperations.lean` を引く。

  本文のラベル                                                    このファイル
  （ς の値どうしの交換）                                          sign_mul_sign_eq_sign_add・sign_mul_sign_comm
  claim_creation_operator_matrices_anticommute                    entry_creationMatrix_mul_creationMatrix・creationMatrices_anticommute
  claim_annihilation_operator_matrices_anticommute                creationMatrix_entries_comm・
                                                                  entry_annihilationMatrix_mul_annihilationMatrix・
                                                                  annihilationMatrices_anticommute
  claim_creation_and_annihilation_operator_matrices_anticommute   entry_smul_one・entry_creationMatrix_mul_annihilationMatrix・
                                                                  entry_annihilationMatrix_mul_creationMatrix・
                                                                  creationMatrix_annihilationMatrix_anticommute

主張ごとに使う K の性質（L : `ValuedMapsLaws K` は積を定めるのに要る八つ。行の中で使うのは結合法則・1 · a = a・右分配法則・
加法の交換法則・a + 0 = a だけ）:
  ς の値どうしの交換                     乗法の結合法則・1 · a = a（三つの反交換関係では L の欄から渡す）
  （⋆）c_k · c_l の成分                 L・a · 1 = a・a · 0 = 0・0 · a = 0（右から掛ける主張から）
  生成作用素どうし                       （⋆）の性質・1 + n = 0・n + 1 = 1 + n
  （⋆）c_k^T · c_l^T の成分             L・a · 0 = 0・0 · a = 0
  消滅作用素どうし                       生成作用素どうしの性質（L の加法の交換法則を足す）
  （⋆_1）c_i · c_j^T の成分             L・a · 0 = 0・0 · a = 0（左から掛ける主張から）
  （⋆_2）c_j^T · c_i の成分             L・a · 1 = a・a · 0 = 0・0 · a = 0（右から掛ける主張から）
  生成と消滅                             （⋆_1）（⋆_2）の性質・`SignLaws K n`（ς(k) · ς(k) = 1 と 1 + n = 0・0 + 1 = 1）

ς の値どうしの交換 ς(a) · ς(b) = ς(b) · ς(a) は仮定に置かない。具体版の ℂ の乗法の交換法則の行のうち、
ς(N_j(U)) · ς(N_i(U)) を ς(N_i(U)) · ς(N_j(U)) に入れ替える行（生成作用素どうし、生成と消滅）と、
成分 (c_k)_{T,S}・(c_l)_{U,T} を入れ替える行（消滅作用素どうし。成分の値は ς の値か 0 なので、a · 0 = 0 = 0 · a と合わせて
`creationMatrix_entries_comm` で得る）は、ς の値がどれも n の累乗であることから、ς(a) · ς(b) = ς(a + b) を
a についての帰納法で示して（`sign_mul_sign_eq_sign_add`。乗法の結合法則と 1 · a = a だけを使う）引く（`sign_mul_sign_comm`）。
乗法の交換法則は要らない。

削れなかった仮定:
- 1 + n = 0（三つの反交換関係）: (1 + n) · x = 0 · x の行（本文の -1_ℂ は 1_ℂ の加法の逆元）。
- n + 1 = 1 + n（生成作用素どうし・消滅作用素どうし）: j < i の場合の (n + 1) · x を (1 + n) · x に替える行。
  生成と消滅の反交換関係は二つの場合とも 1 + n の順で現れるので使わない（`SignLaws` の欄としては持つ）。
- `SignLaws K n`（生成と消滅）: ς(k) · ς(k) = 1（本文 claim_sign_of_nonnegative_integer_squares_to_one）を引くため。
  0 + 1 = 1 の行もその欄 `zero_add_one` を使う。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.CreationMatrices

namespace CliffordMatrixIsomorphism.NecSuf.Isomorphism

open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet)
open CliffordMatrixIsomorphism.Isomorphism
  (countBelow countBelow_unionSingleton unionSingleton removeIndex creationCond creationCond_comm
    notMem_removeIndex unionSingleton_removeIndex cond1_iff_of_eq cond2_iff_of_eq cond1_iff_of_ne cond2_iff_of_ne
    mem_unionSingleton_iff)

universe uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K]

/-! ### ς の値どうしの交換 -/

omit [Add K] [Zero K] in
/-- ς(a) ·_K ς(b) = ς(a + b)（a についての帰納法。乗法の結合法則と 1 ·_K x = x による）。 -/
theorem sign_mul_sign_eq_sign_add (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c))
    (hone_mul : ∀ a : K, 1 * a = a) (n : K) (b : ℕ) : ∀ a : ℕ, sign n a * sign n b = sign n (a + b)
  | 0 => calc sign n 0 * sign n b
        = 1 * sign n b := rfl
      _ = sign n b := hone_mul (sign n b)
      _ = sign n (0 + b) := by rw [Nat.zero_add b]
  | a + 1 => calc sign n (a + 1) * sign n b
        = (n * sign n a) * sign n b := rfl
      _ = n * (sign n a * sign n b) := hmassoc n (sign n a) (sign n b)
      _ = n * sign n (a + b) := by rw [sign_mul_sign_eq_sign_add hmassoc hone_mul n b a]
      _ = sign n (a + b + 1) := rfl
      _ = sign n (a + 1 + b) := by rw [Nat.add_right_comm a b 1]

omit [Add K] [Zero K] in
/-- 具体版が ℂ の乗法の交換法則を ς の値どうしに当てる行の根拠：ς(a) ·_K ς(b) = ς(b) ·_K ς(a)。
ς の値はどれも n の累乗なので、乗法の結合法則と 1 ·_K x = x から従う（乗法の交換法則は要らない）。 -/
theorem sign_mul_sign_comm (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c))
    (hone_mul : ∀ a : K, 1 * a = a) (n : K) (a b : ℕ) : sign n a * sign n b = sign n b * sign n a := calc
  sign n a * sign n b = sign n (a + b) := sign_mul_sign_eq_sign_add hmassoc hone_mul n b a
  _ = sign n (b + a) := by rw [Nat.add_comm a b]
  _ = sign n b * sign n a := (sign_mul_sign_eq_sign_add hmassoc hone_mul n a b).symm

/-! ### 生成作用素の行列どうしの反交換関係 -/

/-- 本文 `claim_creation_operator_matrices_anticommute` の必要十分版の（⋆）：
(c_k · c_l)_{S,U} = ς(N_k(U ∪ {l})) ·_K ς(N_l(U))（C_{k,l}(S,U)）、0_K（成り立たない）。 -/
theorem entry_creationMatrix_mul_creationMatrix (L : ValuedMapsLaws K) (hmul1 : ∀ a : K, a * 1 = a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) (n : K)
    {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M)
    (hl : 1 ≤ l ∧ l ≤ M) (S U : PowerSet M) :
    (creationCond hk hl S U →
        Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M k hk) (creationMatrix n M l hl)) S U
          = sign n (countBelow (unionSingleton U l hl) k) * sign n (countBelow U l))
      ∧ (¬creationCond hk hl S U →
        Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M k hk) (creationMatrix n M l hl)) S U
          = 0) := by
  let hX := isFiniteSet_powerSet M
  by_cases hlU : l ∈ U.1
  · -- l ∈ U のとき。C_{k,l}(S,U) は成り立たない。
    exact ⟨fun hC => absurd hlU hC.2.1,
      fun _ => (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hl (creationMatrix n M k hk) S U).2 hlU⟩
  · -- l ∉ U のとき。列の添字を U ∪ {l} としたときの c_k の条件は C_{k,l}(S,U) と同値。
    have hiff : (k ∉ (unionSingleton U l hl).1 ∧ S = unionSingleton (unionSingleton U l hl) k hk)
        ↔ creationCond hk hl S U := by
      constructor
      · rintro ⟨hkUl, hS⟩
        refine ⟨fun h => hkUl ((mem_unionSingleton_iff U l hl k).2 (Or.inl h)), hlU,
          fun h => hkUl ((mem_unionSingleton_iff U l hl k).2 (Or.inr h)), hS⟩
      · rintro ⟨hkU, _, hkl, hS⟩
        refine ⟨fun h => ?_, hS⟩
        rcases (mem_unionSingleton_iff U l hl k).1 h with h' | h'
        · exact hkU h'
        · exact hkl h'
    constructor
    · intro hC
      calc Mat.entry (Mat.mul L hX (creationMatrix n M k hk) (creationMatrix n M l hl)) S U
          = Mat.entry (creationMatrix n M k hk) S (unionSingleton U l hl) * sign n (countBelow U l) :=
            (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hl (creationMatrix n M k hk) S U).1 hlU
        _ = sign n (countBelow (unionSingleton U l hl) k) * sign n (countBelow U l) := by
            rw [creationMatrix_entry_of_cond n hk (hiff.2 hC)]
    · intro hC
      calc Mat.entry (Mat.mul L hX (creationMatrix n M k hk) (creationMatrix n M l hl)) S U
          = Mat.entry (creationMatrix n M k hk) S (unionSingleton U l hl) * sign n (countBelow U l) :=
            (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hl (creationMatrix n M k hk) S U).1 hlU
        _ = 0 * sign n (countBelow U l) := by
            rw [creationMatrix_entry_of_not_cond n hk (fun h => hC (hiff.1 h))]
        _ = 0 := hzero_mul (sign n (countBelow U l))

/-- 本文 `claim_creation_operator_matrices_anticommute` の必要十分版：c_i · c_j + c_j · c_i = 0（i = j も含む）。 -/
theorem creationMatrices_anticommute (L : ValuedMapsLaws K) (hmul1 : ∀ a : K, a * 1 = a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) (n : K)
    (hone_add_n : 1 + n = 0) (hn_add_one : n + 1 = 1 + n)
    {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (hj : 1 ≤ j ∧ j ≤ M) :
    Mat.add (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M i hi) (creationMatrix n M j hj))
        (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M j hj) (creationMatrix n M i hi))
      = Mat.zero := Mat.ext fun S U => by
  let hX := isFiniteSet_powerSet M
  by_cases hC : creationCond hi hj S U
  · -- C_{i,j}(S,U) が成り立つとき。
    have hC' : creationCond hj hi S U := (creationCond_comm hi hj S U).1 hC
    obtain ⟨hiU, hjU, hij, _⟩ := id hC
    rcases Nat.lt_or_gt_of_ne hij with hlt | hgt
    · -- i < j のとき。
      calc Mat.entry (Mat.add (Mat.mul L hX (creationMatrix n M i hi) (creationMatrix n M j hj))
              (Mat.mul L hX (creationMatrix n M j hj) (creationMatrix n M i hi))) S U
          = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (creationMatrix n M j hj)) S U
              + Mat.entry (Mat.mul L hX (creationMatrix n M j hj) (creationMatrix n M i hi)) S U := rfl
        _ = sign n (countBelow (unionSingleton U j hj) i) * sign n (countBelow U j)
              + sign n (countBelow (unionSingleton U i hi) j) * sign n (countBelow U i) := by
            rw [(entry_creationMatrix_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi hj S U).1 hC,
              (entry_creationMatrix_mul_creationMatrix L hmul1 hmul0 hzero_mul n hj hi S U).1 hC']
        _ = sign n (countBelow U i) * sign n (countBelow U j)
              + sign n (countBelow (unionSingleton U i hi) j) * sign n (countBelow U i) := by
            rw [(countBelow_unionSingleton U j hj hjU i hi.1 hi.2).2 (Nat.le_of_lt hlt)]
        _ = sign n (countBelow U i) * sign n (countBelow U j)
              + sign n (countBelow U j + 1) * sign n (countBelow U i) := by
            rw [(countBelow_unionSingleton U i hi hiU j hj.1 hj.2).1 hlt]
        _ = sign n (countBelow U i) * sign n (countBelow U j)
              + (n * sign n (countBelow U j)) * sign n (countBelow U i) := rfl
        _ = sign n (countBelow U i) * sign n (countBelow U j)
              + n * (sign n (countBelow U j) * sign n (countBelow U i)) := by
            rw [L.mul_assoc n (sign n (countBelow U j)) (sign n (countBelow U i))]
        _ = sign n (countBelow U i) * sign n (countBelow U j)
              + n * (sign n (countBelow U i) * sign n (countBelow U j)) := by
            rw [sign_mul_sign_comm L.mul_assoc L.one_mul n (countBelow U j) (countBelow U i)]
        _ = 1 * (sign n (countBelow U i) * sign n (countBelow U j))
              + n * (sign n (countBelow U i) * sign n (countBelow U j)) := by
            rw [L.one_mul (sign n (countBelow U i) * sign n (countBelow U j))]
        _ = (1 + n) * (sign n (countBelow U i) * sign n (countBelow U j)) :=
            (L.right_distrib 1 n (sign n (countBelow U i) * sign n (countBelow U j))).symm
        _ = 0 * (sign n (countBelow U i) * sign n (countBelow U j)) := by rw [hone_add_n]
        _ = 0 := hzero_mul (sign n (countBelow U i) * sign n (countBelow U j))
        _ = Mat.entry (Mat.zero : Mat K (PowerSet M)) S U := rfl
    · -- j < i のとき。
      calc Mat.entry (Mat.add (Mat.mul L hX (creationMatrix n M i hi) (creationMatrix n M j hj))
              (Mat.mul L hX (creationMatrix n M j hj) (creationMatrix n M i hi))) S U
          = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (creationMatrix n M j hj)) S U
              + Mat.entry (Mat.mul L hX (creationMatrix n M j hj) (creationMatrix n M i hi)) S U := rfl
        _ = sign n (countBelow (unionSingleton U j hj) i) * sign n (countBelow U j)
              + sign n (countBelow (unionSingleton U i hi) j) * sign n (countBelow U i) := by
            rw [(entry_creationMatrix_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi hj S U).1 hC,
              (entry_creationMatrix_mul_creationMatrix L hmul1 hmul0 hzero_mul n hj hi S U).1 hC']
        _ = sign n (countBelow U i + 1) * sign n (countBelow U j)
              + sign n (countBelow (unionSingleton U i hi) j) * sign n (countBelow U i) := by
            rw [(countBelow_unionSingleton U j hj hjU i hi.1 hi.2).1 hgt]
        _ = sign n (countBelow U i + 1) * sign n (countBelow U j)
              + sign n (countBelow U j) * sign n (countBelow U i) := by
            rw [(countBelow_unionSingleton U i hi hiU j hj.1 hj.2).2 (Nat.le_of_lt hgt)]
        _ = (n * sign n (countBelow U i)) * sign n (countBelow U j)
              + sign n (countBelow U j) * sign n (countBelow U i) := rfl
        _ = n * (sign n (countBelow U i) * sign n (countBelow U j))
              + sign n (countBelow U j) * sign n (countBelow U i) := by
            rw [L.mul_assoc n (sign n (countBelow U i)) (sign n (countBelow U j))]
        _ = n * (sign n (countBelow U i) * sign n (countBelow U j))
              + sign n (countBelow U i) * sign n (countBelow U j) := by
            rw [sign_mul_sign_comm L.mul_assoc L.one_mul n (countBelow U j) (countBelow U i)]
        _ = n * (sign n (countBelow U i) * sign n (countBelow U j))
              + 1 * (sign n (countBelow U i) * sign n (countBelow U j)) := by
            rw [L.one_mul (sign n (countBelow U i) * sign n (countBelow U j))]
        _ = (n + 1) * (sign n (countBelow U i) * sign n (countBelow U j)) :=
            (L.right_distrib n 1 (sign n (countBelow U i) * sign n (countBelow U j))).symm
        _ = (1 + n) * (sign n (countBelow U i) * sign n (countBelow U j)) := by
            rw [hn_add_one]
        _ = 0 * (sign n (countBelow U i) * sign n (countBelow U j)) := by rw [hone_add_n]
        _ = 0 := hzero_mul (sign n (countBelow U i) * sign n (countBelow U j))
        _ = Mat.entry (Mat.zero : Mat K (PowerSet M)) S U := rfl
  · -- C_{i,j}(S,U) が成り立たないとき。C_{j,i}(S,U) も成り立たない。
    have hC' : ¬creationCond hj hi S U := fun h => hC ((creationCond_comm hi hj S U).2 h)
    calc Mat.entry (Mat.add (Mat.mul L hX (creationMatrix n M i hi) (creationMatrix n M j hj))
            (Mat.mul L hX (creationMatrix n M j hj) (creationMatrix n M i hi))) S U
        = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (creationMatrix n M j hj)) S U
            + Mat.entry (Mat.mul L hX (creationMatrix n M j hj) (creationMatrix n M i hi)) S U := rfl
      _ = 0 + 0 := by
          rw [(entry_creationMatrix_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi hj S U).2 hC,
            (entry_creationMatrix_mul_creationMatrix L hmul1 hmul0 hzero_mul n hj hi S U).2 hC']
      _ = 0 := L.add_zero 0
      _ = Mat.entry (Mat.zero : Mat K (PowerSet M)) S U := rfl

/-! ### 消滅作用素の行列どうしの反交換関係 -/

omit [Add K] in
/-- 具体版の (c_k)_{T,S} ·_ℂ (c_l)_{U,T} = (c_l)_{U,T} ·_ℂ (c_k)_{T,S}（ℂ の乗法の交換法則）の行に要る交換：
生成作用素の行列の成分の値は ς の値か 0 なので、ς の値どうしの交換と a · 0 = 0 = 0 · a から従う。 -/
theorem creationMatrix_entries_comm (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0)
    (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c)) (hone_mul : ∀ a : K, 1 * a = a) (n : K)
    {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M) (hl : 1 ≤ l ∧ l ≤ M) (T S U : PowerSet M) :
    Mat.entry (creationMatrix n M k hk) T S * Mat.entry (creationMatrix n M l hl) U T
      = Mat.entry (creationMatrix n M l hl) U T * Mat.entry (creationMatrix n M k hk) T S := by
  by_cases hkTS : k ∉ S.1 ∧ T = unionSingleton S k hk
  · by_cases hlUT : l ∉ T.1 ∧ U = unionSingleton T l hl
    · rw [creationMatrix_entry_of_cond n hk hkTS, creationMatrix_entry_of_cond n hl hlUT]
      exact sign_mul_sign_comm hmassoc hone_mul n (countBelow S k) (countBelow T l)
    · rw [creationMatrix_entry_of_not_cond n hl hlUT, hmul0, hzero_mul]
  · rw [creationMatrix_entry_of_not_cond n hk hkTS, hmul0, hzero_mul]

/-- 本文 `claim_annihilation_operator_matrices_anticommute` の必要十分版の（⋆）：(c_k^T · c_l^T)_{S,U} = (c_l · c_k)_{U,S}。 -/
theorem entry_annihilationMatrix_mul_annihilationMatrix (L : ValuedMapsLaws K)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) (n : K)
    {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M)
    (hl : 1 ≤ l ∧ l ≤ M) (S U : PowerSet M) :
    Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (annihilationMatrix n M k hk) (annihilationMatrix n M l hl)) S U
      = Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M l hl) (creationMatrix n M k hk)) U S := by
  let V := coefficientsVec L
  let hX := isFiniteSet_powerSet M
  -- 準備：(c_k^T)_{S,T} ·_{K^vec} (c_l^T)_{T,U} = (c_l)_{U,T} ·_{K^vec} (c_k)_{T,S}
  have hterm : ∀ T : PowerSet M,
      V.smul (Mat.entry (annihilationMatrix n M k hk) S T) (Mat.entry (annihilationMatrix n M l hl) T U)
        = V.smul (Mat.entry (creationMatrix n M l hl) U T) (Mat.entry (creationMatrix n M k hk) T S) :=
    fun T => calc
    V.smul (Mat.entry (annihilationMatrix n M k hk) S T) (Mat.entry (annihilationMatrix n M l hl) T U)
        = Mat.entry (annihilationMatrix n M k hk) S T * Mat.entry (annihilationMatrix n M l hl) T U := rfl
    _ = Mat.entry (creationMatrix n M k hk) T S * Mat.entry (creationMatrix n M l hl) U T := rfl
    _ = Mat.entry (creationMatrix n M l hl) U T * Mat.entry (creationMatrix n M k hk) T S :=
        creationMatrix_entries_comm hmul0 hzero_mul L.mul_assoc L.one_mul n hk hl T S U
    _ = V.smul (Mat.entry (creationMatrix n M l hl) U T) (Mat.entry (creationMatrix n M k hk) T S) := rfl
  calc Mat.entry (Mat.mul L hX (annihilationMatrix n M k hk) (annihilationMatrix n M l hl)) S U
      = sumOverFiniteSet V hX (fun T => Mat.entry (annihilationMatrix n M k hk) S T)
          (fun T => Mat.entry (annihilationMatrix n M l hl) T U) := rfl
    _ = sumOverFiniteSet V hX (fun T => Mat.entry (creationMatrix n M l hl) U T)
          (fun T => Mat.entry (creationMatrix n M k hk) T S) :=
        sumOverFiniteSet_congr V hX _ _ _ _ hterm
    _ = Mat.entry (Mat.mul L hX (creationMatrix n M l hl) (creationMatrix n M k hk)) U S := rfl

/-- 本文 `claim_annihilation_operator_matrices_anticommute` の必要十分版：c_i^T · c_j^T + c_j^T · c_i^T = 0（i = j も含む）。 -/
theorem annihilationMatrices_anticommute (L : ValuedMapsLaws K) (hmul1 : ∀ a : K, a * 1 = a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) (n : K)
    (hone_add_n : 1 + n = 0) (hn_add_one : n + 1 = 1 + n)
    {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (hj : 1 ≤ j ∧ j ≤ M) :
    Mat.add (Mat.mul L (isFiniteSet_powerSet M) (annihilationMatrix n M i hi) (annihilationMatrix n M j hj))
        (Mat.mul L (isFiniteSet_powerSet M) (annihilationMatrix n M j hj) (annihilationMatrix n M i hi))
      = Mat.zero := Mat.ext fun S U => by
  let hX := isFiniteSet_powerSet M
  calc Mat.entry (Mat.add (Mat.mul L hX (annihilationMatrix n M i hi) (annihilationMatrix n M j hj))
          (Mat.mul L hX (annihilationMatrix n M j hj) (annihilationMatrix n M i hi))) S U
      = Mat.entry (Mat.mul L hX (annihilationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
          + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (annihilationMatrix n M i hi)) S U := rfl
    _ = Mat.entry (Mat.mul L hX (creationMatrix n M j hj) (creationMatrix n M i hi)) U S
          + Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (creationMatrix n M j hj)) U S := by
        rw [entry_annihilationMatrix_mul_annihilationMatrix L hmul0 hzero_mul n hi hj S U,
          entry_annihilationMatrix_mul_annihilationMatrix L hmul0 hzero_mul n hj hi S U]
    _ = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (creationMatrix n M j hj)) U S
          + Mat.entry (Mat.mul L hX (creationMatrix n M j hj) (creationMatrix n M i hi)) U S :=
        L.add_comm _ _
    _ = Mat.entry (Mat.add (Mat.mul L hX (creationMatrix n M i hi) (creationMatrix n M j hj))
          (Mat.mul L hX (creationMatrix n M j hj) (creationMatrix n M i hi))) U S := rfl
    _ = Mat.entry (Mat.zero : Mat K (PowerSet M)) U S := by rw [creationMatrices_anticommute L hmul1 hmul0 hzero_mul n hone_add_n hn_add_one hi hj]
    _ = 0 := rfl
    _ = Mat.entry (Mat.zero : Mat K (PowerSet M)) S U := rfl

/-! ### 生成作用素の行列と消滅作用素の行列の反交換関係 -/

omit [Add K] in
/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の必要十分版の（♭）：
(δ_{i,j} ∗ 1)_{S,U} = δ_{i,j} ·_K δ_{S,U}。 -/
theorem entry_smul_one {M : ℕ} (d : K) (S U : PowerSet M) :
    Mat.entry (Mat.smul d (Mat.one : Mat K (PowerSet M))) S U = d * kroneckerDelta S U :=
  calc Mat.entry (Mat.smul d (Mat.one : Mat K (PowerSet M))) S U
      = d * Mat.entry (Mat.one : Mat K (PowerSet M)) S U := rfl
    _ = d * kroneckerDelta S U := rfl

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の必要十分版の（⋆_1）：条件 D_1 を
「i ∈ S かつ j ∉ S' かつ U = S' ∪ {j}」として、(c_i · c_j^T)_{S,U} = ς(N_i(S')) ·_K ς(N_j(S'))（D_1）、0_K（成り立たない）。 -/
theorem entry_creationMatrix_mul_annihilationMatrix (L : ValuedMapsLaws K)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) (n : K)
    {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M)
    (hj : 1 ≤ j ∧ j ≤ M) (S U : PowerSet M) :
    ((i ∈ S.1 ∧ j ∉ (removeIndex S i).1 ∧ U = unionSingleton (removeIndex S i) j hj) →
        Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
          = sign n (countBelow (removeIndex S i) i) * sign n (countBelow (removeIndex S i) j))
      ∧ (¬(i ∈ S.1 ∧ j ∉ (removeIndex S i).1 ∧ U = unionSingleton (removeIndex S i) j hj) →
        Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
          = 0) := by
  let hX := isFiniteSet_powerSet M
  let S' := removeIndex S i
  by_cases hiS : i ∈ S.1
  · -- i ∈ S のとき。行の添字 U・列の添字 S' の c_j の条件は、i ∈ S のもとで D_1 と同値。
    constructor
    · intro hD
      calc Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
          = sign n (countBelow S' i) * Mat.entry (annihilationMatrix n M j hj) S' U :=
            (entry_creationMatrix_mul L hmul0 hzero_mul n hi (annihilationMatrix n M j hj) S U).1 hiS
        _ = sign n (countBelow S' i) * Mat.entry (creationMatrix n M j hj) U S' := rfl
        _ = sign n (countBelow S' i) * sign n (countBelow S' j) := by
            rw [creationMatrix_entry_of_cond n hj ⟨hD.2.1, hD.2.2⟩]
    · intro hD
      calc Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
          = sign n (countBelow S' i) * Mat.entry (annihilationMatrix n M j hj) S' U :=
            (entry_creationMatrix_mul L hmul0 hzero_mul n hi (annihilationMatrix n M j hj) S U).1 hiS
        _ = sign n (countBelow S' i) * Mat.entry (creationMatrix n M j hj) U S' := rfl
        _ = sign n (countBelow S' i) * 0 := by
            rw [creationMatrix_entry_of_not_cond n hj (fun h => hD ⟨hiS, h.1, h.2⟩)]
        _ = 0 := hmul0 (sign n (countBelow S' i))
  · -- i ∉ S のとき。D_1 は成り立たない。
    exact ⟨fun hD => absurd hD.1 hiS,
      fun _ => (entry_creationMatrix_mul L hmul0 hzero_mul n hi (annihilationMatrix n M j hj) S U).2 hiS⟩

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の必要十分版の（⋆_2）：条件 D_2 を
「i ∉ U かつ j ∉ S かつ U ∪ {i} = S ∪ {j}」として、(c_j^T · c_i)_{S,U} = ς(N_j(S)) ·_K ς(N_i(U))（D_2）、0_K（成り立たない）。 -/
theorem entry_annihilationMatrix_mul_creationMatrix (L : ValuedMapsLaws K) (hmul1 : ∀ a : K, a * 1 = a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) (n : K)
    {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M)
    (hj : 1 ≤ j ∧ j ≤ M) (S U : PowerSet M) :
    ((i ∉ U.1 ∧ j ∉ S.1 ∧ unionSingleton U i hi = unionSingleton S j hj) →
        Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U
          = sign n (countBelow S j) * sign n (countBelow U i))
      ∧ (¬(i ∉ U.1 ∧ j ∉ S.1 ∧ unionSingleton U i hi = unionSingleton S j hj) →
        Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U
          = 0) := by
  let hX := isFiniteSet_powerSet M
  by_cases hiU : i ∈ U.1
  · -- i ∈ U のとき。D_2 は成り立たない。
    exact ⟨fun hD => absurd hiU hD.1,
      fun _ => (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi (annihilationMatrix n M j hj) S U).2 hiU⟩
  · -- i ∉ U のとき。行の添字 U ∪ {i}・列の添字 S の c_j の条件は、i ∉ U のもとで D_2 と同値。
    constructor
    · intro hD
      calc Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U
          = Mat.entry (annihilationMatrix n M j hj) S (unionSingleton U i hi) * sign n (countBelow U i) :=
            (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi (annihilationMatrix n M j hj) S U).1 hiU
        _ = Mat.entry (creationMatrix n M j hj) (unionSingleton U i hi) S * sign n (countBelow U i) := rfl
        _ = sign n (countBelow S j) * sign n (countBelow U i) := by
            rw [creationMatrix_entry_of_cond n hj ⟨hD.2.1, hD.2.2⟩]
    · intro hD
      calc Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U
          = Mat.entry (annihilationMatrix n M j hj) S (unionSingleton U i hi) * sign n (countBelow U i) :=
            (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi (annihilationMatrix n M j hj) S U).1 hiU
        _ = Mat.entry (creationMatrix n M j hj) (unionSingleton U i hi) S * sign n (countBelow U i) := rfl
        _ = 0 * sign n (countBelow U i) := by
            rw [creationMatrix_entry_of_not_cond n hj (fun h => hD ⟨hiU, h.1, h.2⟩)]
        _ = 0 := hzero_mul (sign n (countBelow U i))

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の必要十分版：
c_i · c_j^T + c_j^T · c_i = δ_{i,j} ∗ 1。 -/
theorem creationMatrix_annihilationMatrix_anticommute (L : ValuedMapsLaws K) (hmul1 : ∀ a : K, a * 1 = a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) (n : K)
    (SL : SignLaws K n)
    {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M)
    (hj : 1 ≤ j ∧ j ≤ M) :
    Mat.add (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M i hi) (annihilationMatrix n M j hj))
        (Mat.mul L (isFiniteSet_powerSet M) (annihilationMatrix n M j hj) (creationMatrix n M i hi))
      = Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M)) Mat.one := Mat.ext fun S U => by
  let hX := isFiniteSet_powerSet M
  let S' := removeIndex S i
  have hstar1 := entry_creationMatrix_mul_annihilationMatrix L hmul0 hzero_mul n hi hj S U
  have hstar2 := entry_annihilationMatrix_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi hj S U
  by_cases hij : i = j
  · -- i = j のとき。δ_{i,j} = 1_K。
    have hδ : kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) = (1 : K) := if_pos (Subtype.ext hij)
    -- D_1・D_2 の言い換え（本文の「j = i ∉ S' はつねに成り立ち」「j = i なので i ∉ S」の段）。
    -- 集合の条件の同値は j = i を代入した形で `IndexSetOperations.lean` に置いてあるので、ここでだけ j を i に置き換えて引く。
    have hD1 : (i ∈ S.1 ∧ j ∉ (removeIndex S i).1 ∧ U = unionSingleton (removeIndex S i) j hj)
        ↔ (i ∈ S.1 ∧ U = S) := by
      subst hij
      exact cond1_iff_of_eq hj S U
    have hD2 : (i ∉ U.1 ∧ j ∉ S.1 ∧ unionSingleton U i hi = unionSingleton S j hj) ↔ (i ∉ S.1 ∧ U = S) := by
      subst hij
      exact cond2_iff_of_eq hi hj S U
    by_cases hUS : U = S
    · by_cases hiS : i ∈ S.1
      · -- U = S かつ i ∈ S。D_1 は成り立ち、D_2 は成り立たない。
        calc Mat.entry (Mat.add (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj))
                (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi))) S U
            = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
                + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := rfl
          _ = sign n (countBelow S' i) * sign n (countBelow S' j)
                + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := by
              rw [hstar1.1 (hD1.2 ⟨hiS, hUS⟩)]
          _ = sign n (countBelow S' i) * sign n (countBelow S' j) + 0 := by
              rw [hstar2.2 (fun h => (hD2.1 h).1 hiS)]
          _ = sign n (countBelow S' i) * sign n (countBelow S' i) + 0 := by rw [← hij]
          _ = 1 + 0 := by rw [sign_mul_self SL (countBelow S' i)]
          _ = 1 := L.add_zero 1
          _ = 1 * 1 := (L.one_mul 1).symm
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * 1 := by rw [hδ]
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by
              rw [show kroneckerDelta S U = (1 : K) from if_pos hUS.symm]
          _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
                (Mat.one : Mat K (PowerSet M))) S U := (entry_smul_one _ S U).symm
      · -- U = S かつ i ∉ S。D_1 は成り立たず、D_2 は成り立つ。
        calc Mat.entry (Mat.add (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj))
                (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi))) S U
            = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
                + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := rfl
          _ = 0 + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := by
              rw [hstar1.2 (fun h => hiS (hD1.1 h).1)]
          _ = 0 + sign n (countBelow S j) * sign n (countBelow U i) := by
              rw [hstar2.1 (hD2.2 ⟨hiS, hUS⟩)]
          _ = 0 + sign n (countBelow S i) * sign n (countBelow U i) := by rw [← hij]
          _ = 0 + sign n (countBelow S i) * sign n (countBelow S i) := by rw [hUS]
          _ = 0 + 1 := by rw [sign_mul_self SL (countBelow S i)]
          _ = 1 := SL.zero_add_one
          _ = 1 * 1 := (L.one_mul 1).symm
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * 1 := by rw [hδ]
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by
              rw [show kroneckerDelta S U = (1 : K) from if_pos hUS.symm]
          _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
                (Mat.one : Mat K (PowerSet M))) S U := (entry_smul_one _ S U).symm
    · -- U ≠ S。D_1 も D_2 も成り立たない。
      calc Mat.entry (Mat.add (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj))
              (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi))) S U
          = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
              + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := rfl
        _ = 0 + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := by
            rw [hstar1.2 (fun h => hUS (hD1.1 h).2)]
        _ = 0 + 0 := by rw [hstar2.2 (fun h => hUS (hD2.1 h).2)]
        _ = 0 := L.add_zero 0
        _ = 1 * 0 := (hmul0 1).symm
        _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * 0 := by rw [hδ]
        _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by
            rw [show kroneckerDelta S U = (0 : K) from if_neg (fun h => hUS h.symm)]
        _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
              (Mat.one : Mat K (PowerSet M))) S U := (entry_smul_one _ S U).symm
  · -- i ≠ j のとき。δ_{i,j} = 0_K。
    have hδ : kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) = (0 : K) :=
      if_neg (fun h => hij (congrArg Subtype.val h))
    have hD1 := cond1_iff_of_ne hj hij S U
    have hD2 := cond2_iff_of_ne hi hj hij S U
    by_cases hD : i ∈ S.1 ∧ j ∉ S.1 ∧ U = unionSingleton S' j hj
    · -- D が成り立つとき。D_1 も D_2 も成り立つ。
      obtain ⟨hiS, _, hU⟩ := id hD
      have hsharp : S = unionSingleton S' i hi := (unionSingleton_removeIndex hi hiS).symm
      have hiS' : i ∉ S'.1 := notMem_removeIndex S i
      have hjS' : j ∉ S'.1 := (hD1.2 hD).2.1
      let α := sign n (countBelow S' i)
      let β := sign n (countBelow S' j)
      rcases Nat.lt_or_gt_of_ne hij with hlt | hgt
      · -- i < j のとき。
        calc Mat.entry (Mat.add (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj))
                (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi))) S U
            = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
                + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := rfl
          _ = sign n (countBelow S' i) * sign n (countBelow S' j)
                + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := by
              rw [hstar1.1 (hD1.2 hD)]
          _ = sign n (countBelow S' i) * sign n (countBelow S' j)
                + sign n (countBelow S j) * sign n (countBelow U i) := by
              rw [hstar2.1 (hD2.2 hD)]
          _ = α * β + sign n (countBelow S j) * sign n (countBelow U i) := rfl
          _ = α * β + sign n (countBelow (unionSingleton S' i hi) j) * sign n (countBelow U i) := by
              rw [show countBelow S j = countBelow (unionSingleton S' i hi) j from by rw [← hsharp]]
          _ = α * β + sign n (countBelow (unionSingleton S' i hi) j)
                * sign n (countBelow (unionSingleton S' j hj) i) := by
              rw [show countBelow U i = countBelow (unionSingleton S' j hj) i from by rw [hU]]
          _ = α * β + sign n (countBelow S' j + 1) * sign n (countBelow (unionSingleton S' j hj) i) := by
              rw [(countBelow_unionSingleton S' i hi hiS' j hj.1 hj.2).1 hlt]
          _ = α * β + sign n (countBelow S' j + 1) * sign n (countBelow S' i) := by
              rw [(countBelow_unionSingleton S' j hj hjS' i hi.1 hi.2).2 (Nat.le_of_lt hlt)]
          _ = α * β + (n * sign n (countBelow S' j)) * sign n (countBelow S' i) := rfl
          _ = α * β + (n * β) * α := rfl
          _ = α * β + n * (β * α) := by rw [L.mul_assoc n β α]
          _ = α * β + n * (α * β) :=
              congrArg (fun x => α * β + n * x) (sign_mul_sign_comm L.mul_assoc L.one_mul n (countBelow S' j) (countBelow S' i))
          _ = 1 * (α * β) + n * (α * β) := by rw [L.one_mul (α * β)]
          _ = (1 + n) * (α * β) := (L.right_distrib 1 n (α * β)).symm
          _ = 0 * (α * β) := by rw [SL.one_add_n]
          _ = 0 := hzero_mul (α * β)
          _ = 0 * kroneckerDelta S U := (hzero_mul (kroneckerDelta S U)).symm
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by rw [hδ]
          _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
                (Mat.one : Mat K (PowerSet M))) S U := (entry_smul_one _ S U).symm
      · -- j < i のとき。
        calc Mat.entry (Mat.add (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj))
                (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi))) S U
            = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
                + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := rfl
          _ = sign n (countBelow S' i) * sign n (countBelow S' j)
                + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := by
              rw [hstar1.1 (hD1.2 hD)]
          _ = sign n (countBelow S' i) * sign n (countBelow S' j)
                + sign n (countBelow S j) * sign n (countBelow U i) := by
              rw [hstar2.1 (hD2.2 hD)]
          _ = α * β + sign n (countBelow S j) * sign n (countBelow U i) := rfl
          _ = α * β + sign n (countBelow (unionSingleton S' i hi) j) * sign n (countBelow U i) := by
              rw [show countBelow S j = countBelow (unionSingleton S' i hi) j from by rw [← hsharp]]
          _ = α * β + sign n (countBelow (unionSingleton S' i hi) j)
                * sign n (countBelow (unionSingleton S' j hj) i) := by
              rw [show countBelow U i = countBelow (unionSingleton S' j hj) i from by rw [hU]]
          _ = α * β + sign n (countBelow S' j) * sign n (countBelow (unionSingleton S' j hj) i) := by
              rw [(countBelow_unionSingleton S' i hi hiS' j hj.1 hj.2).2 (Nat.le_of_lt hgt)]
          _ = α * β + sign n (countBelow S' j) * sign n (countBelow S' i + 1) := by
              rw [(countBelow_unionSingleton S' j hj hjS' i hi.1 hi.2).1 hgt]
          _ = α * β + sign n (countBelow S' j) * (n * sign n (countBelow S' i)) := rfl
          _ = α * β + β * (n * α) := rfl
          _ = α * β + (n * α) * β :=
              congrArg (fun x => α * β + x)
                (sign_mul_sign_comm L.mul_assoc L.one_mul n (countBelow S' j) (countBelow S' i + 1))
          _ = α * β + n * (α * β) := by rw [L.mul_assoc n α β]
          _ = 1 * (α * β) + n * (α * β) := by rw [L.one_mul (α * β)]
          _ = (1 + n) * (α * β) := (L.right_distrib 1 n (α * β)).symm
          _ = 0 * (α * β) := by rw [SL.one_add_n]
          _ = 0 := hzero_mul (α * β)
          _ = 0 * kroneckerDelta S U := (hzero_mul (kroneckerDelta S U)).symm
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by rw [hδ]
          _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
                (Mat.one : Mat K (PowerSet M))) S U := (entry_smul_one _ S U).symm
    · -- D が成り立たないとき。D_1 も D_2 も成り立たない。
      calc Mat.entry (Mat.add (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj))
              (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi))) S U
          = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (annihilationMatrix n M j hj)) S U
              + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := rfl
        _ = 0 + Mat.entry (Mat.mul L hX (annihilationMatrix n M j hj) (creationMatrix n M i hi)) S U := by
            rw [hstar1.2 (fun h => hD (hD1.1 h))]
        _ = 0 + 0 := by rw [hstar2.2 (fun h => hD (hD2.1 h))]
        _ = 0 := L.add_zero 0
        _ = 0 * kroneckerDelta S U := (hzero_mul (kroneckerDelta S U)).symm
        _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by rw [hδ]
        _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
              (Mat.one : Mat K (PowerSet M))) S U := (entry_smul_one _ S U).symm

end CliffordMatrixIsomorphism.NecSuf.Isomorphism
