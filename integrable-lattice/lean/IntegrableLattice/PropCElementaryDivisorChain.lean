/-
# 命題 C′ の $w^*$ を、本文が書いている単因子の鎖の言葉と一致させる段 — cycle 49 step 2

対応する人手証明: 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement——
「Gram 行列 $G=(\operatorname{Tr}T^{i+j})$ の最大単因子（Smith 標準形の最後の対角成分）を $e_r$、
$w^*=v_p(e_r)$ とおく」。

## この段が塞ぐ穴

`wStarOfCoeffs` は適合基底の係数の $p$ 進付値の最大値であり、
**整除の鎖を経由していない。** 本文はそれを最大単因子の付値として書いている。
**2 つが同じ数であることは、cycle 48 step 1 まで書かれていなかった**
（`TracePeriodWStarLift.lean` が cycle 37 から残りとして挙げていたのに、
台帳の欄は 1 度も残り項目として数えていなかった。cycle 48 step 1 が 完了 と書いた瞬間に機械が捕まえた）。

## 鎖を経由せずに言えるか（cycle 49 の焦点 1 の測定）

**焦点は「鎖の存在は整数行列の Smith 標準形であり mathlib に無い側なので、
まず鎖を経由せずに $w^*=v_p(e_r)$ を言えるかを測ること」だった。測った。答えは次のとおりである。**

**鎖の存在を構成する必要は無い。鎖を仮定として受け取れば足りる。**
理由は、既に在る `isLeast_isPLevel` が
$w^*$ を**内在的な集合の最小元**として与えているからである——
$\{j:\ p^jM\subseteq N\ (\text{$p$ の外で})\}$ は $G$ だけで決まり、基底の取り方にも鎖にも依らない。
最小元は一意なので、**同じ集合の最小元として書けるものはすべて等しい。**

したがってこの段は次の形になる。$U,V$ を単模行列、$UGV=\operatorname{diag}(e)$ とし、
$e$ が整除の鎖をなすなら、$v_p(e_{\text{最後}})$ はその内在的な最小元に等しい。
**Smith 標準形の存在（そのような $U,V,e$ が取れること）は使わない。**
本文が $e_r$ と書いている以上、鎖は本文が仮定として置いているものであり、
この段が示すべきなのは「本文の $e_r$ の付値が $w^*$ に一致すること」だからである。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも 1 度も出ない。** 扱うのは $\mathbb{Z}$ の整除と
$\mathbb{N}$ の付値だけである。$p$ の素数性は 1 箇所で効く——
$p$ と素な整数の積がまた $p$ と素であること（`exists_dvd_mul_pow_iff`）。

## 書いたこと（4 段）

1. 対角行列の像は成分ごとの整除で書ける（`mem_range_diagonal_iff`）。
2. 対角行列の像のレベルは、対角成分の付値の最大値である（`isLeast_isPLevel_diagonal`）。
3. 単模行列を左右から掛けてもレベルは変わらない（`isPLevel_mul_left_iff` / `isPLevel_mul_right_iff`）。
4. 鎖の頂点の付値が最大値である（`sup_factorization_eq_last_of_chain`）。
   これを合わせて `isLeast_isPLevel_of_smith` と、適合基底の側との一致 `wStarOfCoeffs_eq_factorization_last`。

## 形式化しなかったもの

* **Smith 標準形の鎖の存在そのもの**（任意の整数行列に対して単模行列 $U,V$ と整除の鎖 $e$ が取れること）は
  mathlib に無い。**これは参照であって、この段の残りではない**——本文が $e_r$ と書くとき、
  鎖は本文が仮定として置いているものだからである。実測は
  `mathlib-gap-survey-cycle49-smith-chain.log`（適合基底そのものは在るが、`smithCoeffs` を含む行のうち
  整除を述べているものは 0 件、`elementary divisor` も `invariant factor` も 3 段とも 0 件）。
-/
import Mathlib
import IntegrableLattice.WStarElementaryDivisors

namespace IntegrableLattice
namespace PropCElementaryDivisorChain

open Finset Matrix Module

/-! ## 1. 対角行列の像 -/

/-- 対角行列の像は、成分ごとの整除で書ける。 -/
theorem mem_range_diagonal_iff {r : ℕ} (e : Fin r → ℤ) (x : Fin r → ℤ) :
    x ∈ LinearMap.range (Matrix.diagonal e).mulVecLin ↔ ∀ i, e i ∣ x i := by
  constructor
  · rintro ⟨y, rfl⟩ i
    exact ⟨y i, by simp [Matrix.mulVec_diagonal]⟩
  · intro h
    choose c hc using h
    refine ⟨c, ?_⟩
    ext i
    simp [Matrix.mulVec_diagonal, ← hc i]

/-! ## 2. 対角行列の像のレベル -/

/-- **対角行列の像のレベルは、対角成分の $p$ 進付値の最大値である。**

`isLeast_isPLevel` の対角版で、基底を経由せずに直接書いた。 -/
theorem isLeast_isPLevel_diagonal {r p : ℕ} (hp : p.Prime) (e : Fin r → ℤ)
    (he : ∀ i, e i ≠ 0) :
    IsLeast {j | IsPLevel p (LinearMap.range (Matrix.diagonal e).mulVecLin) j}
      (univ.sup fun i => (e i).natAbs.factorization p) := by
  classical
  set w : ℕ := univ.sup fun i => (e i).natAbs.factorization p with hw
  constructor
  · -- `w` が実際に条件を満たす。各成分ごとに `p` と素な倍数を取り、その積を使う。
    intro x
    have hcoeff : ∀ i : Fin r, ∃ m : ℤ, ¬ (p : ℤ) ∣ m ∧ e i ∣ m * (p : ℤ) ^ w := by
      intro i
      refine (exists_dvd_mul_pow_iff hp (he i) _).mpr ?_
      exact Finset.le_sup (f := fun i => (e i).natAbs.factorization p) (mem_univ i)
    choose m hm hdvd using hcoeff
    refine ⟨∏ i, m i, ?_, ?_⟩
    · intro h
      obtain ⟨i, _, hi⟩ :=
        (Prime.dvd_finsetProd_iff (Nat.prime_iff_prime_int.mp hp) m).mp h
      exact hm i hi
    · rw [mem_range_diagonal_iff]
      intro i
      obtain ⟨d, hd⟩ := hdvd i
      obtain ⟨c, hc⟩ : m i ∣ ∏ i, m i := Finset.dvd_prod_of_mem _ (mem_univ i)
      refine ⟨d * c * x i, ?_⟩
      have : ((∏ i, m i) • ((p : ℤ) ^ w • x)) i
          = (m i * (p : ℤ) ^ w) * c * x i := by
        simp only [Pi.smul_apply, smul_eq_mul]
        rw [hc]; ring
      rw [this, hd]; ring
  · -- 最小性: 条件を満たす `j` は各 `v_p(e i)` 以上。標準基底ベクトルへ当てる。
    intro j hj
    refine Finset.sup_le ?_
    intro i _
    refine (exists_dvd_mul_pow_iff hp (he i) j).mp ?_
    obtain ⟨m, hm, hmem⟩ := hj (Pi.single i 1)
    refine ⟨m, hm, ?_⟩
    have := (mem_range_diagonal_iff e _).mp hmem i
    simpa [Pi.single_eq_same, mul_comm] using this

/-! ## 3. 単模行列を掛けてもレベルは変わらない -/

/-- 単模行列が与える同型（逆行列を書き下すだけである）。 -/
noncomputable def unimodularEquiv {r : ℕ} (U : Matrix (Fin r) (Fin r) ℤ) (hU : IsUnit U.det) :
    (Fin r → ℤ) ≃ₗ[ℤ] (Fin r → ℤ) :=
  LinearEquiv.ofLinear U.mulVecLin U⁻¹.mulVecLin
    (by rw [← Matrix.mulVecLin_mul, Matrix.mul_nonsing_inv U hU, Matrix.mulVecLin_one])
    (by rw [← Matrix.mulVecLin_mul, Matrix.nonsing_inv_mul U hU, Matrix.mulVecLin_one])

@[simp]
theorem unimodularEquiv_toLinearMap {r : ℕ} (U : Matrix (Fin r) (Fin r) ℤ) (hU : IsUnit U.det) :
    ((unimodularEquiv U hU : (Fin r → ℤ) ≃ₗ[ℤ] (Fin r → ℤ)) : (Fin r → ℤ) →ₗ[ℤ] (Fin r → ℤ))
      = U.mulVecLin := rfl

/-- 左から単模行列を掛けてもレベルは変わらない（像が同型で移るだけである）。 -/
theorem isPLevel_mul_left_iff {r p j : ℕ} (U G : Matrix (Fin r) (Fin r) ℤ)
    (hU : IsUnit U.det) :
    IsPLevel p (LinearMap.range (U * G).mulVecLin) j ↔
      IsPLevel p (LinearMap.range G.mulVecLin) j := by
  have hcomp : (U * G).mulVecLin
      = ((unimodularEquiv U hU : (Fin r → ℤ) ≃ₗ[ℤ] (Fin r → ℤ)) :
          (Fin r → ℤ) →ₗ[ℤ] (Fin r → ℤ)).comp G.mulVecLin := by
    rw [unimodularEquiv_toLinearMap, Matrix.mulVecLin_mul]
  rw [hcomp]
  exact isPLevel_range_comp (unimodularEquiv U hU) G.mulVecLin p j

/-- 右から単模行列を掛けてもレベルは変わらない（像そのものが等しい）。 -/
theorem isPLevel_mul_right_iff {r p j : ℕ} (G V : Matrix (Fin r) (Fin r) ℤ)
    (hV : IsUnit V.det) :
    IsPLevel p (LinearMap.range (G * V).mulVecLin) j ↔
      IsPLevel p (LinearMap.range G.mulVecLin) j := by
  have htop : LinearMap.range V.mulVecLin = ⊤ :=
    LinearMap.range_eq_top.mpr (unimodularEquiv V hV).surjective
  have hrange : LinearMap.range (G * V).mulVecLin = LinearMap.range G.mulVecLin := by
    rw [Matrix.mulVecLin_mul]
    exact LinearMap.range_comp_of_range_eq_top _ htop
  rw [hrange]

/-! ## 4. 整除の鎖の頂点 -/

/-- **整除の鎖をなす族では、付値の最大値は鎖の頂点の付値である。**
使うのは整除が付値を単調にすることだけで、Smith 標準形は使わない。 -/
theorem sup_factorization_eq_last_of_chain {n p : ℕ} (e : Fin (n + 1) → ℤ)
    (he : ∀ i, e i ≠ 0) (hchain : ∀ i j : Fin (n + 1), i ≤ j → e i ∣ e j) :
    (univ.sup fun i => (e i).natAbs.factorization p)
      = (e (Fin.last n)).natAbs.factorization p := by
  refine le_antisymm (Finset.sup_le ?_) (Finset.le_sup (f := fun i => (e i).natAbs.factorization p) (mem_univ (Fin.last n)))
  intro i _
  have hdvd : (e i).natAbs ∣ (e (Fin.last n)).natAbs :=
    Int.natAbs_dvd_natAbs.mpr (hchain i (Fin.last n) (Fin.le_last i))
  have := (Nat.factorization_le_iff_dvd (Int.natAbs_ne_zero.mpr (he i))
    (Int.natAbs_ne_zero.mpr (he (Fin.last n)))).mpr hdvd
  exact this p

/-! ## 5. 本文の言い方との一致 -/

/-- **本文の $w^*=v_p(e_r)$ が、内在的な最小元として書けること。**

$U,V$ が単模で $UGV=\operatorname{diag}(e)$、$e$ が整除の鎖をなすとき、
鎖の頂点の $p$ 進付値は $\{j:\ p^j\mathbb{Z}^r\subseteq G\mathbb{Z}^r\ (p\ \text{の外で})\}$ の最小元である。

**Smith 標準形の存在は使っていない**——$U,V,e$ は仮定として受け取っている。 -/
theorem isLeast_isPLevel_of_smith {n p : ℕ} (hp : p.Prime)
    (G U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℤ) (e : Fin (n + 1) → ℤ)
    (hU : IsUnit U.det) (hV : IsUnit V.det) (hUGV : U * G * V = Matrix.diagonal e)
    (he : ∀ i, e i ≠ 0) (hchain : ∀ i j : Fin (n + 1), i ≤ j → e i ∣ e j) :
    IsLeast {j | IsPLevel p (LinearMap.range G.mulVecLin) j}
      ((e (Fin.last n)).natAbs.factorization p) := by
  have hset : {j | IsPLevel p (LinearMap.range (Matrix.diagonal e).mulVecLin) j}
      = {j | IsPLevel p (LinearMap.range G.mulVecLin) j} := by
    ext j
    rw [← hUGV]
    simp only [Set.mem_setOf_eq]
    rw [isPLevel_mul_right_iff (U * G) V hV, isPLevel_mul_left_iff U G hU]
  rw [← sup_factorization_eq_last_of_chain e he hchain, ← hset]
  exact isLeast_isPLevel_diagonal hp e he

/-- **この段の結論**。適合基底の係数から作った $w^*$（Lean 側の定義）と、
本文の最大単因子の $p$ 進付値は同じ数である。

証明は最小元の一意性ひとつである——どちらも同じ集合
$\{j:\ p^j\mathbb{Z}^r\subseteq G\mathbb{Z}^r\ (p\ \text{の外で})\}$ の最小元だからである。 -/
theorem wStarOfCoeffs_eq_factorization_last {n p : ℕ} (hp : p.Prime)
    (G U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℤ) (e : Fin (n + 1) → ℤ)
    (hU : IsUnit U.det) (hV : IsUnit V.det) (hUGV : U * G * V = Matrix.diagonal e)
    (he : ∀ i, e i ≠ 0) (hchain : ∀ i j : Fin (n + 1), i ≤ j → e i ∣ e j)
    {ι : Type*} [Fintype ι]
    (bM : Basis ι ℤ (Fin (n + 1) → ℤ))
    (bN : Basis ι ℤ (LinearMap.range G.mulVecLin)) (a : ι → ℤ)
    (hb : ∀ i, (bN i : Fin (n + 1) → ℤ) = a i • bM i) (ha : ∀ i, a i ≠ 0) :
    wStarOfCoeffs p a = (e (Fin.last n)).natAbs.factorization p :=
  IsLeast.unique
    (isLeast_isPLevel bM (LinearMap.range G.mulVecLin) bN a hp hb ha)
    (isLeast_isPLevel_of_smith hp G U V e hU hV hUGV he hchain)

end PropCElementaryDivisorChain
end IntegrableLattice
